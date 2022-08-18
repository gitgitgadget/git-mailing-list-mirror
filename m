Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F396C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 22:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiHRWYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiHRWYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 18:24:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD0D51FD
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 15:24:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u5-20020a17090a1d4500b001fad7c5f685so850153pju.9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=fY4a92eUJkTK5ilpZCCcjIWZkLZfFbIukuWD7GGSYxA=;
        b=TApa2g5lchMBoGXa4JCPcnFGRwzRkWma5IU/u6yZ8yTEjqsc8PhIIzM4d1WvzQv7Rd
         zfUyJFVZ5GHJ4C4SFN/Gv+OHbeAkm8x39u75I+hT0wmYKiBB1GWm+PeLnprftpWxHQJh
         lVeX3cjyu9K5SxQwybsZT+3QtElWYS7o3VWnBJDsCB9UkoWxidjdgoWWlILIjYrTvd9D
         C6HC/TcRpgA/SnqAuoHEx8OJk0MSLZvZ3k6HtuxA2PEjHFaAeJlQ/O25pZaAMADzi0iL
         HtPTzWaUo/8+FzH+vMw1gaefWcBBn6vsCh1uYgegggRj/WXDsUMqXMI10/S3vKzNL0ET
         qm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=fY4a92eUJkTK5ilpZCCcjIWZkLZfFbIukuWD7GGSYxA=;
        b=wXuYP8d3e4vGgSBN5YhN+rHHM8w3n2QP48pRohZnPYj65Px3FNF+TGuwY/e5xRpkho
         x4I7zUqy/slHBmRgQCkeadNFo+XMvwi+encQnlZCo3k0zQe6YetNu7WsyCRkStRIp/sr
         WdFxADNeb4lRneC/kKSSEBe2B8q+U00LR2IAiwoWNVxn3rKixw87DcFVcOBwniaAWtdO
         XtouUQmhDx/lIsEm+WNTS7M/d2tNvvh9wH+/rnrqorxaMgrTbWkuxyEns8cwOQfQEida
         MDFWh29EaLFTizFlRK5Z+Id2e9SmtSQuQX+i6cMeidBT/8LnMlAwgikjaeo7AN25QRcp
         LrcA==
X-Gm-Message-State: ACgBeo0mIj1yHRL7qpLnfqtsRWFxrvqm4OeH2DRx0oNcuGSqugsAVhTO
        diJQY6rwVSYg7A5lVU8Yd3HI+O4CH9StA8jPRsTK
X-Google-Smtp-Source: AA6agR5c2JmEqTT6Yd191WGl9yjsdg3WU9Nqz40T7Xle/7U4y6yUT6dgUVp1eavx8jMLM16P/TfqqtUWFTpabqjZyVQF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7208:b0:172:a9d6:527 with
 SMTP id ba8-20020a170902720800b00172a9d60527mr4536208plb.32.1660861459638;
 Thu, 18 Aug 2022 15:24:19 -0700 (PDT)
Date:   Thu, 18 Aug 2022 15:24:16 -0700
In-Reply-To: <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
Message-Id: <20220818222416.3567602-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - overall this looks good. I only have some minor textual
comments and one small code comment.

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> We have long allowed users to run e.g.
>     git log --ancestry-path master..seen
> which shows all commits which satisfy all three of these criteria:
>   * are an ancestor of seen
>   * are not an ancestor master

are not an ancestor *of* master

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 2f85726745a..001e49cee55 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -389,12 +389,15 @@ Default mode::
>  	merges from the resulting history, as there are no selected
>  	commits contributing to this merge.
>  
> ---ancestry-path::
> +--ancestry-path[=<commit>]::
>  	When given a range of commits to display (e.g. 'commit1..commit2'
> -	or 'commit2 {caret}commit1'), only display commits that exist
> -	directly on the ancestry chain between the 'commit1' and
> -	'commit2', i.e. commits that are both descendants of 'commit1',
> -	and ancestors of 'commit2'.
> +	or 'commit2 {caret}commit1'), only display commits in that
> +	range where <commit> is part of the ancestry chain.  By "part of
> +	the ancestry chain", we mean including <commit> itself and
> +	commits that are either ancestors or descendants of <commit>.
> +	If no commit is specified, use 'commit1' (the excluded part of
> +	the range) as <commit>.  Can be passed multiple times to look for
> +	commits in the ancestry range of multiple commits.

"Ancestry chain" seems to be used multiple times in the Git codebase,
apparently with slightly different definitions, so probably best to
clear up at least this part by not reusing the term. It's also probably
not worth introducing a new term "ancestry range". Maybe rewrite to
say:

  When given a range of commits to display (e.g. 'commit1..commit2'
  or 'commit2 {caret}commit1'), only display commits in that
  range that are ancestors of <commit>, descendants of <commit>, or
  <commit> itself. If no commit is specified, use 'commit1' (the
  excluded part of the range) as <commit>. Can be passed multiple times;
  if so, a commit is included if it is any of the commits given or if it
  is an ancestor or descendant of one of them.

> @@ -568,11 +571,10 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
>  
>  There is another simplification mode available:
>  
> ---ancestry-path::
> -	Limit the displayed commits to those directly on the ancestry
> -	chain between the ``from'' and ``to'' commits in the given commit
> -	range. I.e. only display commits that are ancestor of the ``to''
> -	commit and descendants of the ``from'' commit.
> +--ancestry-path[=<commit>]::
> +	Limit the displayed commits to those containing <commit> in their
> +	ancestry path.  I.e. only display <commit> and commits which have
> +	<commit> as either a direct ancestor or descendant.

Can we refer back to the documentation of --ancestry-path instead?

> @@ -1304,13 +1304,20 @@ static int still_interesting(struct commit_list *src, timestamp_t date, int slop
>  }
>  
>  /*
> - * "rev-list --ancestry-path A..B" computes commits that are ancestors
> + * "rev-list --ancestry-path=C A..B" computes commits that are ancestors
>   * of B but not ancestors of A but further limits the result to those
> - * that are descendants of A.  This takes the list of bottom commits and
> - * the result of "A..B" without --ancestry-path, and limits the latter
> - * further to the ones that can reach one of the commits in "bottom".
> + * that have C in their ancestry path (i.e. are either ancestors of C,
> + * descendants of C, or are C).  If multiple --ancestry-path=$COMMITTISH
> + * arguments are supplied, we limit the result to those that have at
> + * least one of those COMMITTISH in their ancestry path. If
> + * --ancestry-path is specified with no commit, we use all bottom
> + * commits for C.
> + *
> + * Before this function is called, ancestors of C will have already been
> + * marked with ANCESTRY_PATH previously, so we just need to also mark
> + * the descendants here, then collect both sets of commits.
>   */
> -static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
> +static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)

I thought the original description of this function ("This takes the
list...") to be clear and it would be nice to retain it. So, e.g.:

  "rev-list --ancestry-path=C_0 [--ancestry-path=C_1 ...] A..B" computes commits
  that are ancestors of B but not ancestors of A but further limits the
  result to those that have any of C in their ancestry path (i.e. are
  either ancestors of any of C, descendants of any of C, or are any of
  C). If --ancestry-path is specified with no commit, we use all bottom
  commits for C.
  
  Before this function is called, ancestors of C will have already been
  marked with ANCESTRY_PATH previously.

  This takes the list of bottom commits and the result of "A..B" without
  --ancestry-path, and limits the latter further to the ones that have
  any of C in their ancestry path. Since the ancestors of C have already
  been marked (a prerequisite of this function), we just need to mark
  the descendants, then exclude any commit that does not have any of
  these marks.

Optional: Besides that, from what I can tell, sometimes the C commits
themselves are marked with ANCESTRY_PATH (when they are explicitly
specified) and sometimes they are not (when they are not explicitly
specified). It's not a bug here, but it might be worth handling that in
the ancestry_path_need_bottoms codepath (instead of explicitly setting
TMP_MARK on the bottoms in limit_to_ancestry() - that way, I think we
can also use ANCESTRY_PATH instead of TMP_MARK throughout the ancestry
path codepaths, but I haven't tested it), at least to prevent possible
future bugs.

> @@ -2213,7 +2220,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  			       const struct setup_revision_opt* opt)
>  {
>  	const char *arg = argv[0];
> -	const char *optarg;
> +	const char *optarg = NULL;
>  	int argcount;
>  	const unsigned hexsz = the_hash_algo->hexsz;

[snip]

> @@ -2280,10 +2287,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->first_parent_only = 1;
>  	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
>  		revs->exclude_first_parent_only = 1;
> -	} else if (!strcmp(arg, "--ancestry-path")) {
> +	} else if (!strcmp(arg, "--ancestry-path") ||
> +		   skip_prefix(arg, "--ancestry-path=", &optarg)) {

This and the above hunk might cause bugs if --ancestry-path was first
specified with a commit and then specified without. Probably best to
break this up into separate "else if" branches, even though there is a
bit of code duplication (and also remove the "= NULL" addition in the
above hunk).

> @@ -164,6 +165,7 @@ struct rev_info {
>  			cherry_mark:1,
>  			bisect:1,
>  			ancestry_path:1,
> +			ancestry_path_need_bottoms:1,

Might be better named as ancestry_path_implicit_bottoms? And probably
worth documenting, e.g.

  True if --ancestry-path was specified without an argument. The bottom
  revisions are implicitly the arguments in this case.
