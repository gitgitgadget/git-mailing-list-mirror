Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9090BC43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 02:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiGQCok (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 22:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCoj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 22:44:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB037101CA
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 19:44:37 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m6so6476328qvq.10
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkkD4AEbrU1Dvx+sDKylNAjA1MFtUvX2k4kwmpxgouw=;
        b=cTCkzuUR0VO1e+9mg9Ci7gSu61xe6cOPhtSFzqUe6zSOANGelcHZYD3rlPU0gGiquw
         f3h0Kz8jW0Ce6Qhu2cObYOF3aR7yVIx6p1Hp5imuNcDn61Txv8bIdYzXDvhU8/gQbvvO
         4DOWWoR99izfehUosyqCgzhV3Dm9cjwkKmdJe3FdaEH5RW6SBfZyI8LmNewhJASKYfL+
         S9w/EfraDxccLBc52dpPAhFfoHZ9YfI8jCnU/VILF1GkqYFhqGJIESmb+tDEIdpSThqL
         T6izNGc9CaZRwnZtrL8XMvFGOE8/0yOOHyO2gT4iKtvYisjrkYP2ZnSCFXdap9dsnNY1
         /HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkkD4AEbrU1Dvx+sDKylNAjA1MFtUvX2k4kwmpxgouw=;
        b=13zY/tszOC3jlZXzdfVo5RvDqMC3xdjsSmzl+hUFWKLSfn1RjMs+Jk2G3frAS+BRhm
         duzTM7kf88KYv9ybB25zL/Sh7KdS1dUiLsVLCmESB78x6Iq7oTPijdZUPD3re5fpVqis
         BO3Utc55FohTi7qRi9tDpeA0hSRgDN+oS5fOc3oeOElkhLjm8hJW0FP91QZ1dknHZqkF
         XHlX/rx/1odOSwqPsYI2oqbjXDIXlKtJ4WlBHjeQCVbsqvK+gur1OinlrBftnq/DZ3dL
         7qrt58IlEy8zY9CBF9AYF2pzHSZiuEyMDoxW1iBQmW48ukBE2YQePAcDXYVxJppr/fMJ
         iXQg==
X-Gm-Message-State: AJIora8sxTEwvVs1Jdy8o6wAsGTaEf1FJNRIORwDu6ecKBAmdSGmPcnm
        vvvpIP7tMZSSXGyJzyzE9h+utsWHPjT7KPZ0Bys=
X-Google-Smtp-Source: AGRyM1tPrPIc2nX3PfFq0TL+C4DxMJ58fB+x3/4DI8Qnzo+aDejkJuhvcnyJTctIgbaZ5JrJvD2wJvejYX2llV3FKsw=
X-Received: by 2002:a05:6214:29e9:b0:473:63b:5c61 with SMTP id
 jv9-20020a05621429e900b00473063b5c61mr16930874qvb.99.1658025876808; Sat, 16
 Jul 2022 19:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com>
 <20220712231935.2979727-1-calvinwan@google.com> <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
In-Reply-To: <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 19:44:26 -0700
Message-ID: <CABPp-BFq1wPQP4nYRfPCzHg00+nYWeN66zzQ8wxc-TXtnKTW+g@mail.gmail.com>
Subject: Re: [PATCH v4] submodule merge: update conflict error message
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Calvin Wan <calvinwan@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Right, that's left over from an earlier version of the patch (which
did also modify merge-recursive).

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

Yeah, this looks good, thanks.
