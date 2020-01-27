Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A487C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E690214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSSReVAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgA0M0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:26:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47022 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgA0M0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 07:26:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so11003292wrl.13
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJYRmiSFRDOyZ+fEjRD9A9Q/tTgN66BWUf8OjA/hPX4=;
        b=OSSReVAtSw6ezbfDrvlOvY40oxqON9SCVuvZ42whmpeksHbjD0+3W2llLtJQ+V+CEq
         OUOOWfOECGK4Ggw2kAkoaE/MVn5+uF3keZrTXxnBwzlG7QLKsJj9ZThUKX1bNZbOmfON
         urlt8RIQ/mqjvZdxLSG0MowTB++XB1//IS34Iw1cHbPfFDQX3uVtv+Wnp38HBrgorXkD
         deOaIBre7v26pgcGErKeKZkuj2f+jAKx6DVNCTJnsTHffWd0/eJZ9KDi5ID0m9k5MMd2
         cDMro8hoec9BvuUA24/9dTEbw7DR9MxFa+w5UcJ1wn7q4eqOdInVWYT4GYuyrZ9Dg2j/
         XSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJYRmiSFRDOyZ+fEjRD9A9Q/tTgN66BWUf8OjA/hPX4=;
        b=UQtnq0rHZHfIadiPIFwgVG5XA4CjFuZm9VsVjNj7dynjkEAaY/6bqY8BRl1XBD1pju
         Snv/JYbJH/59XDpkepuuKX2wQ82SAeIcmblbQPWSYJ7nQ1RWt1yhQ4eDyNSLyg6zdpDH
         y1MDG3uaHNOTSHzmnVkTbEUO7gHp2UQl9JPrWYJBNyutLfklAqdSmeG72o9THqBOYfO/
         M3ysau59yp5iB0DQC+zB4cwxxLL3xcB3SLqOS/dwPxW4Qx0lfr2IF731UeUry2Dz2sE/
         O8BS5/vxb/bGPsVVjJAhdwE/b9GZ1lik6sUcZEIDtCnzLMV6JSuxkGCjBubLywcpXQZ4
         D6Cw==
X-Gm-Message-State: APjAAAVBW+eN4OwA1PcSwcbRvnFpNaemtNjjPcYDURgQEGcX1++FlWLD
        zqAWTcATYcJAt+MkpC5/zdXXguCv
X-Google-Smtp-Source: APXvYqw5XBJZKw0GomsqoPyQeFnfhPUtA15yHJQ2b1qb0DwNWmeYumPEVQRrdGPY25pvPkvCWrTThg==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr21096386wrr.312.1580127973490;
        Mon, 27 Jan 2020 04:26:13 -0800 (PST)
Received: from szeder.dev (x4db36537.dyn.telefonica.de. [77.179.101.55])
        by smtp.gmail.com with ESMTPSA id y6sm20257847wrl.17.2020.01.27.04.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 04:26:12 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:26:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: add shorthand '-d' for detach
Message-ID: <20200127122610.GB10482@szeder.dev>
References: <20200125173744.4334-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125173744.4334-1-me@yadavpratyush.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 11:07:44PM +0530, Pratyush Yadav wrote:
> Often someone might want to checkout an older commit in a separate
> worktree to test it out without having any intention of making any
> changes. Simply using 'git worktree add' means that a branch will be
> created based on the name of the worktree folder. This branch will then
> have to be deleted by the user once they are done with the worktree.
> 
> An alternative to this is to create a detached worktree which doesn't
> lead to a branch being created. This can be done by the '--detach'
> option. Add the shorthand to make it more convenient to use it.

I don't really understand what this commit message is trying to say,
especially the first paragraph, or how it relates to adding short
options.

It could just say something along the lines of "'git worktree add' has
a couple of long --options without corresponding -o short options, you
wanted to type less, so let's add those missing short options."

But then why only '--detach', and not the other long --options as
well?


> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> For more context:
> https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/
> 
> I'll send a patch to add the config option as a follow up some time
> later.
> 
>  Documentation/git-worktree.txt | 7 ++++---
>  builtin/worktree.c             | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 85d92c9761..cc227dd382 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
>  SYNOPSIS
>  --------
>  [verse]
> -'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
> +'git worktree add' [-f] [-d] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]

'--detach' is still an accepted options, so please write it as
'[-d|--detach]' instead.

While at it, you might want to break this line, as it got too long.

>  'git worktree list' [--porcelain]
>  'git worktree lock' [--reason <string>] <worktree>
>  'git worktree move' <worktree> <new-path>
> @@ -52,7 +52,7 @@ directory specific files such as HEAD, index, etc. `-` may also be
>  specified as `<commit-ish>`; it is synonymous with `@{-1}`.
>  +
>  If <commit-ish> is a branch name (call it `<branch>`) and is not found,
> -and neither `-b` nor `-B` nor `--detach` are used, but there does
> +and neither `-b` nor `-B` nor `-d` are used, but there does

Here I would prefer to keep '--detach', because "detach" is a real
word with proper meaning, while 'd' is just an abbreviation.

>  exist a tracking branch in exactly one remote (call it `<remote>`)
>  with a matching name, treat as equivalent to:
>  +
> @@ -69,7 +69,7 @@ branches from there if `<branch>` is ambiguous but exists on the
>  'origin' remote. See also `checkout.defaultRemote` in
>  linkgit:git-config[1].
>  +
> -If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> +If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `-d` used,

Likewise.

>  then, as a convenience, the new worktree is associated with a branch
>  (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
>  doesn't exist, a new branch based on HEAD is automatically created as
> @@ -140,6 +140,7 @@ To remove a locked working tree, specify `--force` twice.
>  	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
>  	`<commit-ish>`.
> 
> +-d::
>  --detach::
>  	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
>  	in linkgit:git-checkout[1].
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d6bc5263f1..dab5f76788 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -500,7 +500,7 @@ static int add(int ac, const char **av, const char *prefix)
>  			   N_("create a new branch")),
>  		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>  			   N_("create or reset a branch")),
> -		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
> +		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
>  		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>  		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
>  		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
> --
> 2.24.1
> 
