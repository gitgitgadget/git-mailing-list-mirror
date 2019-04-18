Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A9120248
	for <e@80x24.org>; Thu, 18 Apr 2019 02:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbfDRCQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 22:16:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54228 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfDRCQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 22:16:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so862702wmj.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 19:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y0lNzHHb3SEi7S91nRYduZM3MCZX2OwGmLBu37+u2tE=;
        b=kh/2+6+xINycfTEzRETz3lKUN3uOh4TZRmh5sOmbzj+cAIE3Wgc5ZmedlfmcX73/OL
         OuiJx+ql2SwHbVXTYe2u5RjgU004oGDsTBMyexhQIcv+mNPZvPWDneF+Cf5/DDNPtRxW
         Z8N78Ys1JCnU8XTO18Npv1u5F//We0fEUPgMa6DGQP+oJX+zvbsPoalLjdbpy+S9UmMU
         2f2oYvECOcuJfcMlYOMq+IWeC597P2jxqP5mjMrurq0/iwm6W+AEFXwZCG3TCROgcTsF
         GH0nisYiNK3K9CXvfc+YOz05WuREi15jnGQCT97w0XgbC58bvZyr3uwgI9vO7QuEAmz0
         UIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y0lNzHHb3SEi7S91nRYduZM3MCZX2OwGmLBu37+u2tE=;
        b=pf58i5eK8CqhFbj/vlBYhM0eZdHmU8Jd+HTvTOYZck4rljpPQthYCqRGsArd+u6Vcr
         8iXqc73p9R/2DNFIsFJAxGCRf7i7bopbAt5mUDdn8KqkRlVWZuCV8exugcJswWaEgFAv
         wyxTGjTox69gv9RQ15CS3S5Vu/R3LyNiUrFvTEnZw/CekUjgL5Acx79u4lliL3dYssRw
         bolvqlqqBuopN6dNe8oWxFU2YCDCRF7GVaOw+utuaYuAl/Oth3kJc9qq4TZOxEHBRGxE
         dP1qHrk/OdDV2FsCH76zlLXXVOzMwrevcf9q8pHYVZ+ibEmJhsE40qPKICJPXXkt17PH
         0Tjw==
X-Gm-Message-State: APjAAAVorMpkdPvNPB+jQhuSsA7aboeqw8HmbzOu2UYwaUTRWkPkKiHJ
        rZ2WVcKEybrbAR0fNSiEuSc=
X-Google-Smtp-Source: APXvYqxgwVta/8gORyGSIWNTJu++CNs/yUbGFgYXRbeIOuUL/8y863UXVo0Kqsu63z6VY73LzA8Uag==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr1038558wmh.86.1555553802765;
        Wed, 17 Apr 2019 19:16:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g5sm521899wrw.40.2019.04.17.19.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 19:16:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        rappazzo@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] worktree: update is_bare heuristics
References: <20190417212128.52475-1-jonathantanmy@google.com>
Date:   Thu, 18 Apr 2019 11:16:41 +0900
In-Reply-To: <20190417212128.52475-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 17 Apr 2019 14:21:28 -0700")
Message-ID: <xmqqo954gira.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

[jc: pinging the current area expert for the multiple worktree setup
for sanity checking]

> When "git branch -D <name>" is run, Git usually first checks if that
> branch is currently checked out. But this check is not performed if the
> Git directory of that repository is not at "<repo>/.git", which is the
> case if that repository is a submodule that has its Git directory stored
> as "super/.git/modules/<repo>", for example.
>
> This is because get_main_worktree() in worktree.c sets is_bare on a
> worktree only using the heuristic that a repo is bare if the worktree's
> path ends in "/.git", and not bare otherwise. This is_bare code was
> introduced in 92718b7438 ("worktree: add details to the worktree
> struct", 2015-10-08), following a pre-core.bare heuristic. This patch
> does 2 things:
>
>  - Teach get_main_worktree() to use is_bare_repository() instead,
>    introduced in 7d1864ce67 ("Introduce is_bare_repository() and
>    core.bare configuration variable", 2007-01-07) and updated in
>    e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
>    the "git branch -D <name>" problem described above. However...
>
>  - If a repository has core.bare=1 but the "git" command is being run
>    from one of its added worktrees, is_bare_repository() returns false
>    (which is fine, since there is a worktree available). However,
>    commands like "git worktree list" currently distinguish between a
>    repository that has core.bare=1 but has a worktree available, and a
>    repository that is truly non-bare (core.bare=0). To preserve this
>    distinction, also check core.bare when setting is_bare. If
>    core.bare=1, trust it, and otherwise, use is_bare_repository().

I am not sure if the latter is worth keeping, but the former
definitely is a huge improvement, I would imagine.  Somebody
did "git branch -D <that-branch>" by accident in a submodule
checkout, or something?

> +test_expect_success 'deleting checked-out branch from repo that is a submodule' '
> +	test_when_finished "rm -rf repo1 repo2" &&
> +
> +	git init repo1 &&
> +	git init repo1/sub &&
> +	test_commit -C repo1/sub x &&
> +	git -C repo1 submodule add ./sub &&
> +	git -C repo1 commit -m "adding sub" &&
> +
> +	git clone --recurse-submodules repo1 repo2 &&
> +	git -C repo2/sub checkout -b work &&
> +	test_must_fail git -C repo2/sub branch -D work
> +'

That is a quite straightforward reproduction recipe.  Very good.

> diff --git a/worktree.c b/worktree.c
> index b45bfeb9d3..5d52b2ba53 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -49,18 +49,17 @@ static struct worktree *get_main_worktree(void)
>  	struct worktree *worktree = NULL;
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf worktree_path = STRBUF_INIT;
> -	int is_bare = 0;
>  
>  	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> -	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> -	if (is_bare)
> +	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
>  		strbuf_strip_suffix(&worktree_path, "/.");

So, we'd drop /.git or /. from the end, without any behaviour
change.  But we no longer take the fact that it was not the ".git"
subdirectory into account, as that is unreliable?

>  	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
>  
>  	worktree = xcalloc(1, sizeof(*worktree));
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
> -	worktree->is_bare = is_bare;
> +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
> +		is_bare_repository();

And instead core.bare being '1' is used as the definite sign
that we are dealing with a bare repository.

It all makes sense to me.

Thanks for working on it.

>  	add_head_info(worktree);
>  
>  	strbuf_release(&path);
