Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC099C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B220784
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvlQIM9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgCaQ1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:27:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34084 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgCaQ1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 12:27:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so7918570otr.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCA8/J3gBHsZDFrOLCbfRNZ99wjZYxTDf+x4jw2C0/Y=;
        b=VvlQIM9c+DTSbmlmz2Qu5+2oSBnfZiVQZH+3M8xSIqOK1mOAlkF85L6xsIOVbcJek1
         u1ZbaMzv0YXDJLtlD6kD+R9io6zHq/ePqQTmxFsaxO5Zwow5Mg5R1QEKqsXrSczvt2XP
         GlPi706Y2Ngbo4COf9HTsFyCoffP+KznY8mVyKQEXkPWL6Puw+Gv0q2b5Q50ZHwyPwrQ
         i0SNFoyoS8+peCCuUI2NiG4lXqBqw41DkrsNAEJYTG8OV2MWZ+sYqzc4VQErMx73mmJn
         DlqjkegRvmAEJDbEg5gvz0sDWkPjSS7ZvziL/J4hjRdkldRgXNraMmli5Q+1SFXtWVmA
         SoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCA8/J3gBHsZDFrOLCbfRNZ99wjZYxTDf+x4jw2C0/Y=;
        b=njUzILKW5LQ95gAd5LNZP2PFUuwNTeuroBOLDXDkwAF1bfVnN2dv+/Sr3L8kymhuOw
         vOvhWnwAMwr+m78d+km/h/2JTPUkQz95veQV4HgPIGpDWGP0XFDKuIJw2yz6vixkp/5x
         XtKbEKD2O7B8e+cJsFOUlOD9F9ABxwQ8glIDJQFEelLIq2+gYONp0tLGmI19zoFw9ktf
         7hbPvMbOFZIOOzwhYKXEm8zvrhVNX6ybjvPM/IqhM3MI/iNsiP2Ff8HdJ9mF50yo/zzX
         3kvyWNmnSyGagBfNWvvEjyymEMLBSkardpeG0lsaTK4LOYeZF5VSGFvkZ9WnVTnmk3FX
         3qpQ==
X-Gm-Message-State: ANhLgQ2s/UUc3IZ9Nu4yWkIDi40FqebFL0yvNn/zfYIkQAAoSYsnftJR
        4MZj1OS4uYnb7d3ubxT4eHaBShn0Q9crellQCFc=
X-Google-Smtp-Source: ADFU+vskkkPaXpf448CXiVVwd/ue9mR8U9wbWLVKxihVXZK56GJY5oLZYu+6XpiaxHJj0cjPe8Gf2xPxji7qBXsFFxQ=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr9514221oti.162.1585672042665;
 Tue, 31 Mar 2020 09:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200309205523.121319-1-jonathantanmy@google.com> <20200330040621.13701-1-jonathantanmy@google.com>
In-Reply-To: <20200330040621.13701-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Mar 2020 09:27:11 -0700
Message-ID: <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, congdanhqx@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Sun, Mar 29, 2020 at 9:06 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0c4f038dd6..f4f8afeb9a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -318,6 +318,21 @@ See also INCOMPATIBLE OPTIONS below.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> +--keep-cherry-pick::
> +--no-keep-cherry-pick::

I like the plural form Derrick elsewhere in this thread suggested
(--keep-cherry-picks), but it's not a strong preference.  However,
with fresh eyes I'm slightly worried about "keep".  More on that
below...

> +       Control rebase's behavior towards commits in the working
> +       branch that are already present upstream, i.e. cherry-picks.
> ++
> +By default, these commits will be dropped. Because this necessitates
> +reading all upstream commits, this can be expensive in repos with a
> +large number of upstream commits that need to be read.
> ++
> +If `--keep-cherry-pick is given`, all commits (including these) will be
> +re-applied. This allows rebase to forgo reading all upstream commits,
> +potentially improving performance.

I'm slightly worried that "keep" is setting up an incorrect
expectation for users; in most cases, a reapplied cherry-pick will
result in the merge machinery applying no new changes (they were
already applied) and then rebase's default of dropping commits which
become empty will kick in and drop the commit.

Maybe the name is fine and we just need to be more clear in the text
on the expected behavior and advantages and disadvantages of this
option:

If `--keep-cherry-picks` is given, all commits (including these) will be
re-applied.  Note that cherry picks are likely to result in no changes
when being reapplied and thus are likely to be dropped anyway (assuming
the default --empty=drop behavior).  The advantage of this option, is it
allows rebase to forgo reading all upstream commits, potentially
improving performance.  The disadvantage of this option is that in some
cases, the code has drifted such that reapplying a cherry-pick is not
detectable as a no-op, and instead results in conflicts for the user to
manually resolve (usually via `git rebase --skip`).

It may also be helpful to prevent users from making a false inference
by renaming these options to --[no-]reapply-cherry-pick[s].  Sorry to
bring this up so late after earlier saying --[no-]keep-cherry-pick[s]
was fine; didn't occur to me then.  If you want to keep the name, the
extended paragraph should be good enough.

> ++
> +See also INCOMPATIBLE OPTIONS below.
> +
>  --rerere-autoupdate::
>  --no-rerere-autoupdate::
>         Allow the rerere mechanism to update the index with the
> @@ -568,6 +583,9 @@ In addition, the following pairs of options are incompatible:
>   * --keep-base and --onto
>   * --keep-base and --root
>
> +Also, the --keep-cherry-pick option requires the use of the merge backend
> +(e.g., through --merge).

Why not just list --keep-cherry-pick[s] in the list of options that
require use of the merge backend (i.e. the list containing '--merge')
instead of adding another sentence here?

> +
>  BEHAVIORAL DIFFERENCES
>  -----------------------
>
> @@ -866,7 +884,8 @@ Only works if the changes (patch IDs based on the diff contents) on
>  'subsystem' did.
>
>  In that case, the fix is easy because 'git rebase' knows to skip
> -changes that are already present in the new upstream.  So if you say
> +changes that are already present in the new upstream (unless
> +`--keep-cherry-pick` is given). So if you say
>  (assuming you're on 'topic')
>  ------------
>      $ git rebase subsystem
> diff --git a/builtin/rebase.c b/builtin/rebase.c
...
> @@ -1848,6 +1852,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                               "interactive or merge options"));
>         }
>
> +       if (options.keep_cherry_pick && !is_interactive(&options))

You're building on an old version of git.  Do you want to rebase and
make this use the new is_merge() instead so Junio has fewer conflicts
to handle?

> +               die(_("--keep-cherry-pick does not work with the 'apply' backend"));
> +
>         if (options.signoff) {
>                 if (options.type == REBASE_PRESERVE_MERGES)
>                         die("cannot combine '--signoff' with "
...

Thanks for working on this!
