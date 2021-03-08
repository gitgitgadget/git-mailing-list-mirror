Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2FFC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AA665272
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCHUSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHUSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:18:06 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:18:06 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e2so10078707ilu.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=djUwNXT+ZhYsODmKhQFV+RvsxXUcD/9flut9WuGfvNI=;
        b=jCpLCHFwtrC6KcRWfwwPlua6UgJ+2AJGeKDnn9rCxzxT8wwozl4kGCXwT+5he1TOzc
         d9fa4O1T/ShmrroZiSmuOuXUqDxmpMNEZCfKRpScmDBBrkcH2b2cHrI/oemw0RnlEpIb
         VJlduiobQOyHzlWcTIQV9QsDt/xoYjWkOd0YCiimN4U9inqvoalt6zlE7K7qK+ckQggG
         gQUReEioVeiPKzQF3pZc4LE7GgM0b2rQPQBGNnINp/sfme8ci44y+YSIKGST/+KtPvHH
         Q7W4xYTizX4rD96kO6el+4aoUscbpwHdPPHP4sM/1Dp5kPrb2BrxpzbqBwNfv81cZ0Mt
         C40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djUwNXT+ZhYsODmKhQFV+RvsxXUcD/9flut9WuGfvNI=;
        b=dCr1KGhv5RvPrjHyTKuqY9qrl4zYKDnNTMDaZVw8D/G7Vx8t4o58s8fGqoNT/iGBVJ
         S/9aMCngVt66YBd9qoSk/oP+ElZDXhocXAFqp4UeNxv/Nn7N105FslKjTCPP3xVTlGBN
         WCkx0Ron42jlWX57qQVTn5fUgvJNxrXq4j1Nrz8N2g98voPKzhW4hrJ2S5OeUtsxkL8c
         UQH7Z3SK2FFbhukrWBRoOd+fiyeQg4lfffTAtgc+4A5TBShGkdZqDuR+bDxAuF9OOU22
         CpnzjQWnlWLB+UyiXkkRH1qK/I2u0VLVDsgjalziPEGpoQhg62BmjqhrbT28DuPYGEH+
         3f9g==
X-Gm-Message-State: AOAM532MWEcACpnfpqBcU+ArGK1jL0ELmgKx5/jXKqwDPaJzVlm+QsrJ
        B2BjK2k+QEsPOPQDgc6T1WtqAQ==
X-Google-Smtp-Source: ABdhPJwmUEGdNoP+SWKTkFwFXJ07RyPWLRNGgmDcOXde7aoJ9GrOItfskeKbsGEp7CVwzU7JN0oAyw==
X-Received: by 2002:a92:2c0e:: with SMTP id t14mr21215323ile.104.1615234685698;
        Mon, 08 Mar 2021 12:18:05 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id w3sm6543628ill.80.2021.03.08.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:18:05 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Mon, 8 Mar 2021 15:18:04 -0500
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC][RFC] format-patch: pass --right-only to range-diff
Message-ID: <YEaGbn5rU3pU7/q5@nand.local>
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 07, 2021 at 06:57:19AM +0000, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
>
> In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> Taylor Blau proposing 'git format-patch --cover-letter
> --range-diff' may mistakenly place upstream commit in the
> range-diff output. Teach `format-patch` pass `--right-only`
> to range-diff, maybe can avoid this kind of mistake.
>
> Because `git rebase --apply` will internally call `git
> format-patch -k --stdout --full-index --cherry-pick --right-only
> --src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter
> --pretty=mboxrd --topo-order --no-base`, In order to avoid the
> ambiguity of `--right-only`, users can call `format-patch
> --range-diff --only-right` instead of `--right-only` to only emit
> output related to the second range.

A couple of times this new option is called "--right-only" and other
times it is "--only-right". This comment makes me think that you meant
to call it "--only-right", but...

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC][RFC] format-patch: pass --right-only to range-diff
>
>     Transfer parameters are relatively simple. But because I can' t
>     reproduce the situation, There's no big difference between adding
>     ---only-right and not adding ---only-right. So I haven't written the
>     test files for the time being.

Note that I think (and Johannes--cc'd--could confirm) that what you want
is '--left-only' to discard rebased changes from the upstream branch:

In either case, this should help you reproduce it (and would be a good
starting point for adding a test case). Here, we're using '--left-only'
to discard changes from upstream (here, the 'main' branch) after
rebasing:

    #!/bin/sh

    set -e

    rm -fr repo
    git init repo
    cd repo

    git branch -M main

    echo "base" >base
    git add base
    git commit -m "base"

    git checkout -b my-feature
    echo "feature" >feature
    git add feature
    git commit -m "feature"

    base="$(git rev-parse main)"
    old="$(git rev-parse my-feature)"

    git checkout main
    echo "other" >>base
    git add base
    git commit -m "new"

    git checkout my-feature
    git rebase $base --onto main

    tip="$(git rev-parse my-feature)"

    git range-diff $base $old $tip
    git range-diff --left-only $base $old $tip

>     I may need to ask reviewers opinion first.
>
>     this want to fix #876 Thanks.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2Fadlternative%2Fformat-patch-range-diff-right-only-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlternative/format-patch-range-diff-right-only-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/898
>
>  Documentation/git-format-patch.txt |  5 ++++-
>  builtin/log.c                      | 15 ++++++++++-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 3e49bf221087..5dae34c3090b 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -27,7 +27,7 @@ SYNOPSIS
>  		   [--[no-]encode-email-headers]
>  		   [--no-notes | --notes[=<ref>]]
>  		   [--interdiff=<previous>]
> -		   [--range-diff=<previous> [--creation-factor=<percent>]]
> +		   [--range-diff=<previous> [--creation-factor=<percent>] [--right-only]]
>  		   [--filename-max-length=<n>]
>  		   [--progress]
>  		   [<common diff options>]
> @@ -301,6 +301,9 @@ material (this may change in the future).
>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
>  	for details.
>
> +--only-right:
> +	Used with `--range-diff`, only emit output related to the second range.
> +

s/--only-right/--right-only?

>  --notes[=<ref>]::
>  --no-notes::
>  	Append the notes (see linkgit:git-notes[1]) for the commit
> diff --git a/builtin/log.c b/builtin/log.c
> index f67b67d80ed1..5d2f39fd19a7 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1153,7 +1153,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
> -			      int quiet)
> +			      int quiet, int right_only)
>  {
>  	const char *committer;
>  	struct shortlog log;
> @@ -1228,7 +1228,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			.creation_factor = rev->creation_factor,
>  			.dual_color = 1,
>  			.diffopt = &opts,
> -			.other_arg = &other_arg
> +			.other_arg = &other_arg,
> +			.right_only = right_only
>  		};
>
>  		diff_setup(&opts);
> @@ -1732,7 +1733,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	struct strbuf rdiff2 = STRBUF_INIT;
>  	struct strbuf rdiff_title = STRBUF_INIT;
>  	int creation_factor = -1;
> -
> +	int right_only = 0;

Nit: the newline between creation_factor's declaration and
builtin_format_patch_options's is good to keep.

>  	const struct option builtin_format_patch_options[] = {
>  		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
>  			    N_("use [PATCH n/m] even with a single patch"),
> @@ -1814,6 +1815,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			     parse_opt_object_name),
>  		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
>  			   N_("show changes against <refspec> in cover letter or single patch")),
> +		OPT_BOOL(0, "only-right", &right_only,
> +			 N_("only emit output related to the second range")),
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("percentage by which creation is weighted")),
>  		OPT_END()
> @@ -2087,7 +2090,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
>  	else if (!rdiff_prev)
>  		die(_("--creation-factor requires --range-diff"));
> -
> +	if (right_only && !rdiff_prev)
> +		die(_("--right_only requires --range-diff"));

These may be good to combine into one big conditional that dies whenever
an option requiring --range-diff is set, but --range-diff is not:

  if (!rdiff_prev) {
    if (creation_factor)
      die(_("--creation-factor requires --range-diff"));
    if (right_only)
      die(_("--right-only requires --range-diff"));
  }

Thanks,
Taylor
