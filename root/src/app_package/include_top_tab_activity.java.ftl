
import android.os.Bundle;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;

import java.util.ArrayList;
import java.util.List;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.RelativeLayout;

import android.view.LayoutInflater;
import android.widget.ImageView;
import android.content.res.ColorStateList;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.graphics.Color;
import android.support.v4.content.ContextCompat;
import android.content.Context;


public class ${activityClass} extends AppCompatActivity {

  <#if isToolbar>
    private Toolbar toolbar;
  </#if>

  private TabLayout tablayout;
  private ViewPager viewpager;

    private String tabNames[] = {"${tab1}","${tab2}","${tab3}"};

    <#if tabstyle == 'icons' || tabstyle == 'iconswithtext' || tabstyle == 'badgewithicons'>

    private int[] tabIconsUnSelected = {
                R.drawable.YOUR_DRAWABLE,
                R.drawable.YOUR_DRAWABLE,
                R.drawable.YOUR_DRAWABLE };

    private int[] tabIconsSelected = {
                R.drawable.YOUR_DRAWABLE,
                R.drawable.YOUR_DRAWABLE,
                R.drawable.YOUR_DRAWABLE};
    </#if>

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutActivityName});

        initView();

        <#if isToolbar>
        initToolbar();
        </#if>

        setupViewPager(viewpager);

        setupTabLayout();

        initTab();


    }

    private void setupTabLayout() {
        tablayout.setupWithViewPager(viewpager);
    }

    <#if isToolbar>
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

         switch (item.getItemId()){
             case android.R.id.home:
                 finish();
                 return true;
         }

         return super.onOptionsItemSelected(item);
    }
    </#if>

    private void setupViewPager(ViewPager viewPager) {

        viewPager.setAdapter(new FragmentPagerAdapter(getSupportFragmentManager()) {
            @Override
            public Fragment getItem(int position) {

                switch (position) {

                    case 0:
                        return ${tabName1}.newInstance();

                    case 1:
                        return ${tabName2}.newInstance();

                    case 2:
                        return ${tabName3}.newInstance();

                }
                return null;
            }

            @Override
            public CharSequence getPageTitle(int position) {
              <#if tabstyle == 'icons'>
                return null;
              <#else>
                return tabNames[position];
              </#if>

            }

            @Override
            public int getCount() {
                return tabNames.length;
            }
        });
    }

    private void initView() {
      <#if isToolbar>
          toolbar = (Toolbar) findViewById(R.id.toolbar);
      </#if>
          tablayout = (TabLayout) findViewById(R.id.tablayout);
          viewpager = (ViewPager) findViewById(R.id.viewpager);
      }

    <#if isToolbar>

    private void initToolbar() {
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
    </#if>


    private void initTab() {
           tablayout.getTabAt(0).setCustomView(getTabView(0));
           tablayout.getTabAt(1).setCustomView(getTabView(1));
           tablayout.getTabAt(2).setCustomView(getTabView(2));


       }


       private View getTabView(int position) {
           View view = LayoutInflater.from(${activityClass}.this).inflate(R.layout.view_tabs, null);

           <#if tabstyle == 'icons' || tabstyle == 'iconswithtext' || tabstyle == 'badgewithicons'>
           ImageView icon = (ImageView) view.findViewById(R.id.tab_icon);
           icon.setImageDrawable(setDrawableSelector(${activityClass}.this, tabIconsUnSelected[position], tabIconsSelected[position]));
           </#if>

           <#if tabstyle == 'simple'|| tabstyle == 'iconswithtext'>
           TextView text = (TextView) view.findViewById(R.id.tab_text);
           text.setText(tabNames[position]);
           text.setTextColor(setTextselector(Color.parseColor("#F2F2F2"), Color.parseColor("#FFFFFF")));

           </#if>

           <#if tabstyle == 'badgewithicons'>

           // TODO: 24/08/17 Disabling badge for second tab. Play with your logics according to your use case.
            if(position != 1) {

                RelativeLayout rlBadge = (RelativeLayout) view.findViewById(R.id.rl_badge);
                rlBadge.setVisibility(View.VISIBLE);

                TextView txtBadge = (TextView) view.findViewById(R.id.txt_badge);
                txtBadge.setBackground(setDrawableSelector(${activityClass}.this, R.drawable.view_badge_un_selected, R.drawable.view_badge_selected));

                // TODO: 24/08/17  Hard coded color just for demo. Pass your own color from colors.xml
                txtBadge.setTextColor(setTextselector(Color.parseColor("#FFFFFF"), Color.parseColor("#5f8ee4")));
                txtBadge.setText("10");

            }
           </#if>

           return view;
       }


       public static Drawable setDrawableSelector(Context context, int normal, int selected) {

        Drawable state_normal = ContextCompat.getDrawable(context, normal);

        Drawable state_pressed = ContextCompat.getDrawable(context, selected);

        StateListDrawable drawable = new StateListDrawable();

        drawable.addState(new int[]{android.R.attr.state_selected},
                state_pressed);
        drawable.addState(new int[]{android.R.attr.state_enabled},
                state_normal);

        return drawable;
    }



    public static ColorStateList setTextselector(int normal, int pressed) {
        ColorStateList colorStates = new ColorStateList(
                new int[][]{
                        new int[]{android.R.attr.state_selected},
                        new int[]{}
                },
                new int[]{
                        pressed,
                        normal});
        return colorStates;
    }


}
