Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE6C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 01:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638742076C
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 01:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DQimE386"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgHDBKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 21:10:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE633C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 18:10:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so29752070qtn.7
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d8VhqtKrlJtPbawynj147y8ZpQHIsnc+OWAohrzfXoU=;
        b=DQimE3864ad/9t8TuJ0ZOniiGRQANYBaNL8eRcQtdbLShhEb7oblvKW7NccEzy48Mo
         9dX/DLqj16JvFXYtsD3Q4zUOvmQ0z4oNKsrldQny/Z2MYZxSU2OgejzlXeaTyyj9vPBD
         6e5n0CuX8ZWBob8SgkqtLLwQ0sc7xMW25EIe3KLOcBcAG0SS7GqqoYLiqRug/jS88gYp
         2ld/NFcVh5cdhwUwDPrt1/P5oaCzzFqBjpzODTXzBhJIYBEOH4TcFv2cAl132QWgL22E
         jWcGLwWgvZNOA6FcZ6a2cjd18vAIWpZrB771mmI8Ky2MfgGC/KT7OhlgP7EeqL3ohYA1
         fXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8VhqtKrlJtPbawynj147y8ZpQHIsnc+OWAohrzfXoU=;
        b=hN4d3MMFL/qbICtiALNHOS+lDqE8c08UEvkG/YC5FnFrQgmgM9YPvCxjBp6GgHf4WJ
         SUCF8c6I+7RsRO21t6hl2btNFVF4qaF2iAQnY9qrYrBSyfK+dDkBBmoYLdUABQaOlVss
         +GkMwxXpODw+2RIIF/JMqBkfVzw6RSZHZlnYOOd7796pc8tC6lN1p5Lky8yk4fCaUbHZ
         f8J1OYMn5wIZ+H+QwVN2HXY19wtOmmyM29yHjCxZhNuWp08ii6vycuqHB6YtgW3psDHX
         hdkCYiGoPJkiAp/ex3RlD4Lm2Xz/3jBkjmjKfXncjbUcTk654U7wt9PhKYaadckpfO7g
         7brA==
X-Gm-Message-State: AOAM531mgrXzd/GomMwcMSz/owkURMmeUSAAeTzfKxP4qt0zz4SHSQH9
        mL/dqLKPn70qyO2YBxJ13LHA84pVCXDIAH5Q
X-Google-Smtp-Source: ABdhPJw6DVdbU8qDRNLcynBc2aKBpTbHj+q00RxTztzyJgmgCP/1KCS0V+xxSyImpjcwW7/qHVaFuw==
X-Received: by 2002:ac8:5149:: with SMTP id h9mr20096546qtn.357.1596503447787;
        Mon, 03 Aug 2020 18:10:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 22sm21158354qkd.64.2020.08.03.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:10:46 -0700 (PDT)
Date:   Mon, 3 Aug 2020 21:10:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 0/5] git-worktree documentation cleanups
Message-ID: <20200804011045.GB77538@syl.lan>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 08:55:30PM -0400, Eric Sunshine wrote:
> This is a re-roll of [1] which fixes some problems I ran across in the
> git-worktree documentation while working on another worktree-related
> topic.
>
> This version adds some `linkgit:` invocations, typesets `HEAD` as
> fixed-width, and covers a few additional places where backticks should
> have been applied in place of other quotes, as suggested by Martin[2],
> as well as a few more I noticed beyond those found by him. Although I
> had planned on adding backticks around `HEAD` in a separate patch, I
> ended up folding that change into patch 1 since there are relatively few
> such instances, and since, upon reflection, such a change didn't seem to
> warrant its own patch.
>
> I omitted Taylor's Reviewed-by:[4] since the patches have changed since
> he reviewed them, but he's welcome to give it again.

Thanks for dropping that. I looked at the inter-diff and skimmed the
re-rolled patches, and they all look good to me. You can add my

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

back to these patches (really Junio can when he queues them).

Thanks.

>
> [1]: https://lore.kernel.org/git/20200803053612.50095-1-sunshine@sunshineco.com/
> [2]: https://lore.kernel.org/git/20200803175717.7465-1-martin.agren@gmail.com/
> [3]: https://lore.kernel.org/git/CAPig+cQtcxqQDAQ5bO6ica+Z7dd2+r8B+kXm0RK7qhpsAiX_xg@mail.gmail.com/
> [4]: https://lore.kernel.org/git/20200803161102.GB50799@syl.lan/
>
> Eric Sunshine (5):
>   git-worktree.txt: employ fixed-width typeface consistently
>   git-worktree.txt: consistently use term "working tree"
>   git-worktree.txt: fix minor grammatical issues
>   git-worktree.txt: make start of new sentence more obvious
>   git-wortkree.txt: link to man pages when citing other Git commands
>
>  Documentation/git-worktree.txt | 123 +++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 61 deletions(-)
>
> Interdiff against v1:
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 260bfe9105..6ee6ec7982 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -25,8 +25,9 @@ Manage multiple working trees attached to the same repository.
>  A git repository can support multiple working trees, allowing you to check
>  out more than one branch at a time.  With `git worktree add` a new working
>  tree is associated with the repository.  This new working tree is called a
> -"linked working tree" as opposed to the "main working tree" prepared by "git
> -init" or "git clone".  A repository has one main working tree (if it's not a
> +"linked working tree" as opposed to the "main working tree" prepared by
> +linkgit:git-init[1] or linkgit:git-clone[1].
> +A repository has one main working tree (if it's not a
>  bare repository) and zero or more linked working trees. When you are done
>  with a linked working tree, remove it with `git worktree remove`.
>
> @@ -48,7 +49,7 @@ add <path> [<commit-ish>]::
>
>  Create `<path>` and checkout `<commit-ish>` into it. The new working directory
>  is linked to the current repository, sharing everything except working
> -directory specific files such as HEAD, index, etc. As a convenience,
> +directory specific files such as `HEAD`, `index`, etc. As a convenience,
>  `<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
>  +
>  If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
> @@ -66,13 +67,13 @@ one for the purposes of disambiguation, even if the `<branch>` isn't
>  unique across all remotes. Set it to
>  e.g. `checkout.defaultRemote=origin` to always checkout remote
>  branches from there if `<branch>` is ambiguous but exists on the
> -'origin' remote. See also `checkout.defaultRemote` in
> +`origin` remote. See also `checkout.defaultRemote` in
>  linkgit:git-config[1].
>  +
>  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
>  then, as a convenience, the new working tree is associated with a branch
>  (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
> -doesn't exist, a new branch based on HEAD is automatically created as
> +doesn't exist, a new branch based on `HEAD` is automatically created as
>  if `-b <branch>` was given.  If `<branch>` does exist, it will be
>  checked out in the new working tree, if it's not checked out anywhere
>  else, otherwise the command will refuse to create the working tree (unless
> @@ -137,13 +138,13 @@ To remove a locked working tree, specify `--force` twice.
>  -B <new-branch>::
>  	With `add`, create a new branch named `<new-branch>` starting at
>  	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
> -	If `<commit-ish>` is omitted, it defaults to HEAD.
> +	If `<commit-ish>` is omitted, it defaults to `HEAD`.
>  	By default, `-b` refuses to create a new branch if it already
>  	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
>  	`<commit-ish>`.
>
>  --detach::
> -	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
> +	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
>  	in linkgit:git-checkout[1].
>
>  --[no-]checkout::
> @@ -154,7 +155,7 @@ To remove a locked working tree, specify `--force` twice.
>
>  --[no-]guess-remote::
>  	With `worktree add <path>`, without `<commit-ish>`, instead
> -	of creating a new branch from HEAD, if there exists a tracking
> +	of creating a new branch from `HEAD`, if there exists a tracking
>  	branch in exactly one remote matching the basename of `<path>`,
>  	base the new branch on the remote-tracking branch, and mark
>  	the remote-tracking branch as "upstream" from the new branch.
> @@ -166,7 +167,7 @@ This can also be set up as the default behaviour by using the
>  	When creating a new branch, if `<commit-ish>` is a branch,
>  	mark it as "upstream" from the new branch.  This is the
>  	default if `<commit-ish>` is a remote-tracking branch.  See
> -	"--track" in linkgit:git-branch[1] for details.
> +	`--track` in linkgit:git-branch[1] for details.
>
>  --lock::
>  	Keep the working tree locked after creation. This is the
> @@ -185,14 +186,14 @@ This can also be set up as the default behaviour by using the
>
>  -q::
>  --quiet::
> -	With 'add', suppress feedback messages.
> +	With `add`, suppress feedback messages.
>
>  -v::
>  --verbose::
>  	With `prune`, report all removals.
>
>  --expire <time>::
> -	With `prune`, only expire unused working trees older than <time>.
> +	With `prune`, only expire unused working trees older than `<time>`.
>
>  --reason <string>::
>  	With `lock`, an explanation why the working tree is locked.
> @@ -209,12 +210,12 @@ then `ghi` or `def/ghi` is enough to point to the former working tree.
>  REFS
>  ----
>  In multiple working trees, some refs may be shared between all working
> -trees and some refs are local. One example is HEAD which is different for each
> +trees and some refs are local. One example is `HEAD` which is different for each
>  working tree. This section is about the sharing rules and how to access
>  refs of one working tree from another.
>
>  In general, all pseudo refs are per working tree and all refs starting
> -with `refs/` are shared. Pseudo refs are ones like HEAD which are
> +with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
>  directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
>  exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
>  shared.
> @@ -225,7 +226,7 @@ former gives access to per-working tree refs of the main working tree,
>  while the latter to all linked working trees.
>
>  For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
> -resolve to the same value as the main working tree's HEAD and
> +resolve to the same value as the main working tree's `HEAD` and
>  `refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
>  `worktrees/bar/refs/bisect/bad` are the same as
>  `$GIT_COMMON_DIR/worktrees/foo/HEAD` and
> @@ -237,13 +238,13 @@ which will handle refs correctly.
>
>  CONFIGURATION FILE
>  ------------------
> -By default, the repository "config" file is shared across all working
> +By default, the repository `config` file is shared across all working
>  trees. If the config variables `core.bare` or `core.worktree` are
>  already present in the config file, they will be applied to the main
>  working trees only.
>
>  In order to have configuration specific to working trees, you can turn
> -on "worktreeConfig" extension, e.g.:
> +on the `worktreeConfig` extension, e.g.:
>
>  ------------
>  $ git config extensions.worktreeConfig true
> --
> 2.28.0.236.gb10cc79966
>

Thanks,
Taylor
