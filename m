Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E51EE14D6
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbjIFUhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjIFUhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 16:37:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0096F4
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 13:37:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8cbf0a0dso24419357b3.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694032649; x=1694637449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tN64i/53oviCFw3hfC/mHywqIhRg4kYBNoZY7mFs5OY=;
        b=FJWEceIkqGN5aTYQjzhA1ala41xJKB98TFJ+o5v+jeFX//NSFG+DKRMCSdAqQrS7x4
         g4+WBsXebqm9/a8q2h24naBl/38dwEpvc21OmZzN8ccbCA0q29sYOldvGb21ZRdXmGpj
         WXWmnB5znUtvJEFElO+CPb9tKvIDeJQ3Pus+0IyqCr80C4HKDn+CsP+CICK39zKtFsEG
         5dEneeOkoIJD8sFOsjiSl+Fm/7fSm0ujeTLntgQlQ4V/ATk9lVsZVTWu1lPFeDZwgiuJ
         bAr8v7Y1cF4ECt3/Av5Tf/wTOMN+PU1QIo6Ulka6tUFQhIZvbw6ZxxFZ/RdixcuPwTm5
         cJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694032649; x=1694637449;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN64i/53oviCFw3hfC/mHywqIhRg4kYBNoZY7mFs5OY=;
        b=YzPc/erSpAewN5wE/cXDvjMIFQxcExB2TzKyqi8JXa6p0LSjWTyC1k8rO2r2X7xfZi
         YvWeg1slNAFYFLhRK85tjrMGhrdh4y8OUe42vKUaoX79s6bj/15Y7oJqA9lnkUnaFvNB
         8Li5ua3mQbnQPh1MjwRSo18W4iamqwZXV2QcsnX2+rnwnxDhOtMPwBUiHLs7lUcvnaOY
         awKQDhLa2DtfInUdaQI2DWkGm1KAWJ83pXVIzMAqfRDiFIHEL9MEKyvB1OfLEF43azCS
         OojNOqE68JYyOUPjI1tbktPrESty+FPL7axDqzsnbZBV+2BYWiKCmx5DZWoMCWUr98MI
         zz4w==
X-Gm-Message-State: AOJu0Yz/0sjpkC8RYxqX8vtmK8JopEGTDqnsTNo3nQ6fP8eCj9Sfncjz
        oHd70tsRdEZVCy6iAupFTF8HZD7zsxXiawJW5Cf/
X-Google-Smtp-Source: AGHT+IGjtOUyNtL+D7H+X+DSEPlDcxm5HseT+gkiZ1FLi6K/8RsGHPC5PXCFz7unCjCa7WZtzzMn3v9UT8iBHHFy1lc7
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a2f4:3d00:3379:1924])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1024:b0:d7e:c4af:22d2 with
 SMTP id x4-20020a056902102400b00d7ec4af22d2mr21089ybt.4.1694032649012; Wed,
 06 Sep 2023 13:37:29 -0700 (PDT)
Date:   Wed,  6 Sep 2023 13:37:26 -0700
In-Reply-To: <20230906060241.944886-2-sokcevic@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906203726.1526272-1-jonathantanmy@google.com>
Subject: Re: [PATCH] [diff-lib] Fix check_removed when fsmonitor is on
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:
> git-diff-index may return incorrect deleted entries when fsmonitor is used in a
> repository with git submodules. This can be observed on Mac machines, but it
> can affect all other supported platforms too.
> 
> If fsmonitor is used, `stat *st` may not be initialized. Since `lstat` calls
> aren't not desired when fsmonitor is on, skip the entire gitlink check using
> the same condition used to initialize `stat *st`.

Ah, that's a great catch. Thanks for narrowing it down to
check_removed(). 

I see from "git blame" that this was introduced in 4f3d6d0261
(fsmonitor: skip lstat deletion check during git diff-index, 2021-03-
17). In that commit, subsequent code in check_removed() already used
"st" when it was possibly uninitialized, so perhaps no one noticed it.
I don't think anyone discussed it either on the mailing list thread that
introduced this patch [1].

[1] https://lore.kernel.org/git/pull.903.git.1615760258.gitgitgadget@gmail.com/

Looking at this function in more detail, though, I see that the solution
in this patch set is incomplete - both before and after this patch,
there are code paths in which "st" is never initialized, but "st->mode"
is used (not in check_removed(), but in its callers).

I think a more complete solution needs to look something like this:

        diff --git a/diff-lib.c b/diff-lib.c
        index d8aa777a73..5637237003 100644
        --- a/diff-lib.c
        +++ b/diff-lib.c
        @@ -39,10 +39,20 @@
         static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
         {
                assert(is_fsmonitor_refreshed(istate));
        -       if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
        -               if (!is_missing_file_error(errno))
        -                       return -1;
        -               return 1;
        +       if (ce->ce_flags & CE_FSMONITOR_VALID) {
        +               /*
        +                * Both check_removed() and its callers expect lstat() to have
        +                * happened and, in particular, the st_mode field to be set.
        +                * Simulate this with the contents of ce.
        +                */
        +               memset(st, 0, sizeof(*st));
        +               st->st_mode = ce->ce_mode;
        +       } else {
        +               if (lstat(ce->name, st) < 0) {
        +                       if (!is_missing_file_error(errno))
        +                               return -1;
        +                       return 1;
        +               }
                }
                if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
                        return 1;

Also, regarding the commit message, the title should be formatted like:

  diff-lib: simulate stat when using fsmonitor

or something like that (file, then colon, then message).

You'll also need a sign-off. See the [[sign-off]] section in
Documentation/SubmittingPatches for more information.

> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 0c241d6c14..894a80fbe8 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -824,6 +824,10 @@ test_expect_success 'submodule always visited' '
>  
>  	create_super super &&
>  	create_sub sub &&
> +	git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
> +	git -C super --no-optional-locks -c core.fsmonitor=false \
> +	    diff-index --name-status HEAD >actual.without &&
> +	    test_cmp actual.with actual.without &&
>  
>  	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
>  	git -C super commit -m "add sub" &&

Any reason why these additions are here instead of where I put them (in
my_match_and_clean())? I think it makes more sense where I put them,
as then they would automatically apply to all tests.

> @@ -837,6 +841,8 @@ test_expect_success 'submodule always visited' '
>  	# some dirt in the submodule and confirm matching output.
>  
>  	# Completely clean status.
> +	echo Now running for clean status &&
> +
>  	my_match_and_clean &&
>  
>  	# .M S..U

You can remove this - I included this to show exactly where in the code
the test fails.
