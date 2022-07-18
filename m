Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E9C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiGRRDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGRRDm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:03:42 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D492BB3E
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:03:41 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id c203-20020a4a4fd4000000b0043566a4e265so2397697oob.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ye+fy5WTzGcAKLB4XaZEKMUUMnGpB3gacN1A6RYWd4Q=;
        b=inyUfj/1Vy769e0m4uBPY+g/31LEOKhLW2wgIOwMb+1h+mjWX3Fw+8thWRe2nwa06K
         TNecRPmPWaUScz/rQ79ajsVAcJfXEwg8MDsb6skk0m5LiX6RJzRajKuT/Q+KygoUgsw5
         3QpQ7pL/smNq7PrbkWS3OwibwWQA88JEOgSHK1sW8pgxq83qwpCMYhDWLyhpZR1k1YnP
         nlK01lqHHkuCNcXBh6iO2ssc6zvQwshpjGAQvafCsu1y2i0b4CBlX4Lpcs1wLcd44a6F
         fKxILHIjhEZ/92AYsb1zp4Gs8IZYB+FmyZmBM8Kb3UhhcaB/OMOU09AdrUd33Wc73iMi
         vU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye+fy5WTzGcAKLB4XaZEKMUUMnGpB3gacN1A6RYWd4Q=;
        b=wCPgmKVgED9n4Gowl9SvUyJcy4vp8+izNjNg+D9+D/F80GV89LM05gSj1Vqdd9kqEE
         kkZA9m8CVejh2kX35I8p9RHCiDedLUgLcZLSV6lPPvMT99b0FDy+rDnF/6eXZ9mDg6Y2
         b2WnXgXUNmqbc4VXy9KaUifCD2yduotlnxeYyZJt2mNwlFyOpQcJcEMi7xxYatsgzt5v
         Af6t5P957urvnJFyNkaJiv9ME8UAmYlrEmJ+8B0arH0r4qvv20aY6v8nGgHpd16VibcS
         36YTJDvKwdKRxdzakK+wjNfLub4nFOe+UBaQhs/+g3CipJmv+U/fUV22lBTNxC0w4eIQ
         F9Jw==
X-Gm-Message-State: AJIora+VD5EfEGMyO98iJH4ERfwdmvYrebaS8dRXvMYAd8to/5951YFU
        JOVHFpoLh45xS18pDGefYoYuXfrwsLoX5ZNttHi2Wm4sDPrTBg==
X-Google-Smtp-Source: AGRyM1vRp33YiRLgx32yo1dtG16VrC1MsFd7b3m2MwX9McA/EAdBQWuRalHyNq4LNlyO4YSGjfH5OEcEilZQCUaRbXA=
X-Received: by 2002:a4a:c702:0:b0:428:8037:e5a3 with SMTP id
 n2-20020a4ac702000000b004288037e5a3mr9806426ooq.71.1658163820610; Mon, 18 Jul
 2022 10:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com>
 <20220712231935.2979727-1-calvinwan@google.com> <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
In-Reply-To: <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 18 Jul 2022 10:03:29 -0700
Message-ID: <CAFySSZD-GRwXvaK4sPJUOzU78GiJLunP7tZtF4i7nZ+f8i8WAg@mail.gmail.com>
Subject: Re: [PATCH v4] submodule merge: update conflict error message
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> No matter how hard I tried to stare at the code, no matter whether I
> looked at `cw/submodule-merge-messages` or `seen`, I cannot see how this
> `grep` could ever succeed when `GIT_TEST_MERGE_ALGORITHM=recursive`: only
> the `ort` code has been taught this new trick.

I definitely overlooked this removing the merge-recursive section of
my code. Thanks
for catching this!

On Fri, Jul 15, 2022 at 5:57 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Calvin,
>
> On Tue, 12 Jul 2022, Calvin Wan wrote:
>
> > diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> > index 178413c22f..cc1a312661 100755
> > --- a/t/t6437-submodule-merge.sh
> > +++ b/t/t6437-submodule-merge.sh
> > @@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
> >        echo "file-c" > file-c &&
> >        git add file-c &&
> >        git commit -m "sub-c") &&
> > -     git commit -a -m "c" &&
> > +     git commit -a -m "c")
> > +'
> > +
> > +test_expect_success 'merging should conflict for non fast-forward' '
> > +     (cd merge-search &&
> > +      git checkout -b test-nonforward-a b &&
> > +       if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> > +       then
> > +             test_must_fail git merge c >actual
> > +       else
> > +             test_must_fail git merge c 2> actual
> > +       fi &&
> > +      sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> > +      grep "$sub_expect" actual &&
>
> No matter how hard I tried to stare at the code, no matter whether I
> looked at `cw/submodule-merge-messages` or `seen`, I cannot see how this
> `grep` could ever succeed when `GIT_TEST_MERGE_ALGORITHM=recursive`: only
> the `ort` code has been taught this new trick.
>
> In fact, when I run this locally with
> `GIT_TEST_MERGE_ALGORITHM=recursive`, it not only fails (as shown here:
> https://github.com/gitgitgadget/git/runs/7349612861?check_suite_focus=true#step:4:1833
> and here:
> https://github.com/gitgitgadget/git/runs/7326925485?check_suite_focus=true#step:4:1820),
> it also leaves no error message in `actual`.
>
> So you probably want to move the `sub_expect` assignment and the `grep`
> into the `ort` clause of the conditional above.
>
> With this fixup, things seem to work over here:
>
> -- snip --
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index cc1a3126619..3892d0bf742 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -111,12 +111,12 @@ test_expect_success 'merging should conflict for non fast-forward' '
>          git checkout -b test-nonforward-a b &&
>           if test "$GIT_TEST_MERGE_ALGORITHM" = ort
>           then
> -               test_must_fail git merge c >actual
> +               test_must_fail git merge c >actual &&
> +               sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
>           else
>                 test_must_fail git merge c 2> actual
>           fi &&
> -        sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> -        grep "$sub_expect" actual &&
>          git reset --hard)
>  '
>
> @@ -153,13 +153,13 @@ test_expect_success 'merging should conflict for non fast-forward (resolution ex
>           git rev-parse sub-d > ../expect) &&
>           if test "$GIT_TEST_MERGE_ALGORITHM" = ort
>           then
> -               test_must_fail git merge c >actual
> +               test_must_fail git merge c >actual &&
> +               sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
>           else
>                 test_must_fail git merge c 2> actual
>           fi &&
>          grep $(cat expect) actual > /dev/null &&
> -        sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> -        grep "$sub_expect" actual &&
>          git reset --hard)
>  '
>
> @@ -180,14 +180,14 @@ test_expect_success 'merging should fail for ambiguous common parent' '
>          ) &&
>          if test "$GIT_TEST_MERGE_ALGORITHM" = ort
>          then
> -               test_must_fail git merge c >actual
> +               test_must_fail git merge c >actual &&
> +               sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
>          else
>                 test_must_fail git merge c 2> actual
>          fi &&
>         grep $(cat expect1) actual > /dev/null &&
>         grep $(cat expect2) actual > /dev/null &&
> -       sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> -       grep "$sub_expect" actual &&
>         git reset --hard)
>  '
>
> @@ -227,8 +227,11 @@ test_expect_success 'merging should fail for changes that are backwards' '
>
>         git checkout -b test-backward e &&
>         test_must_fail git merge f >actual &&
> -       sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
> -       grep "$sub_expect" actual)
> +       if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +       then
> +               sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
> +               grep "$sub_expect" actual
> +       fi)
>  '
>
> -- snap --
>
> > +      git reset --hard)
>
> It would be better to move this before the subshell like this:
>
>         test_when_finished "git -C merge-search reset --hard" &&
>
> Ciao,
> Dscho
>
> > +'
> >
> > +test_expect_success 'finish setup for merge-search' '
> > +     (cd merge-search &&
> >       git checkout -b d a &&
> >       (cd sub &&
> >        git checkout -b sub-d sub-b &&
> > @@ -129,9 +146,9 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
> >        test_cmp expect actual)
> >  '
> >
> > -test_expect_success 'merging should conflict for non fast-forward' '
> > +test_expect_success 'merging should conflict for non fast-forward (resolution exists)' '
> >       (cd merge-search &&
> > -      git checkout -b test-nonforward b &&
> > +      git checkout -b test-nonforward-b b &&
> >        (cd sub &&
> >         git rev-parse sub-d > ../expect) &&
> >         if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> > @@ -141,6 +158,8 @@ test_expect_success 'merging should conflict for non fast-forward' '
> >               test_must_fail git merge c 2> actual
> >         fi &&
> >        grep $(cat expect) actual > /dev/null &&
> > +      sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> > +      grep "$sub_expect" actual &&
> >        git reset --hard)
> >  '
> >
> > @@ -167,6 +186,8 @@ test_expect_success 'merging should fail for ambiguous common parent' '
> >        fi &&
> >       grep $(cat expect1) actual > /dev/null &&
> >       grep $(cat expect2) actual > /dev/null &&
> > +     sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
> > +     grep "$sub_expect" actual &&
> >       git reset --hard)
> >  '
> >
> > @@ -205,7 +226,9 @@ test_expect_success 'merging should fail for changes that are backwards' '
> >       git commit -a -m "f" &&
> >
> >       git checkout -b test-backward e &&
> > -     test_must_fail git merge f)
> > +     test_must_fail git merge f >actual &&
> > +     sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
> > +     grep "$sub_expect" actual)
> >  '
> >
> >
> > diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> > index 8e32f19007..f1bb29681f 100755
> > --- a/t/t7402-submodule-rebase.sh
> > +++ b/t/t7402-submodule-rebase.sh
> > @@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should conflict' '
> >       test_tick &&
> >       git commit -m fourth &&
> >
> > -     test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
> > +     test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
> >       git ls-files -s submodule >actual &&
> >       (
> >               cd submodule &&
> > @@ -112,7 +112,9 @@ test_expect_success 'rebasing submodule that should conflict' '
> >               echo "160000 $(git rev-parse HEAD^^) 2  submodule" &&
> >               echo "160000 $(git rev-parse HEAD) 3    submodule"
> >       ) >expect &&
> > -     test_cmp expect actual
> > +     test_cmp expect actual &&
> > +     sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
> > +     grep "$sub_expect" actual_output
> >  '
> >
> >  test_done
> >
> > base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
> > --
> > 2.37.0.144.g8ac04bfd2-goog
> >
> >
> >
