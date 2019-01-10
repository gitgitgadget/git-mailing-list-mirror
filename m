Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EC11F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfAJViH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:38:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfAJViH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:38:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so13044214wra.6
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ptdq6XZCdY4kGRd6WL9DjvoZ8Vnczfb9ueC9hdsokMA=;
        b=aYgkvtybylPPJawJi7g+zorhmuo8yqKJ7PJOFx2BtoDeYDCgQOCv6S8UT9jtJ1pf2U
         IHTagh57t86unxokxIJ+/izaFsNuMSPw4zILGA9ZdQfBauokG2ndtZ+eMJnWEDvCT/fQ
         Mt77+JS0XAYbs2Bf4OGfosg4+50JlfhdHeNex5cVb1Jxu6C5no4IWvHEkzhB5Y9gqS8p
         v1giPuft72QLIwnC9FkbK6NlRyjvu1lX5i63wETdzTI8V6NTA8L2W86a75gx9tiKD/9w
         w40zbR1wwsfcd+FkakdZ7gjHJZR9uAf0q0I8Y2+zc3ofBUfvz9i4zDX2n5+A/vYQ6hYY
         nmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ptdq6XZCdY4kGRd6WL9DjvoZ8Vnczfb9ueC9hdsokMA=;
        b=XUaBJwu+uNwU+ogUvn2yNjc8iqcSkPCsHtxnbBiZVxjqoFSyfvamTRVdvRgv9eggQq
         xqkmd6xAYnuLClRWw9EeAmm05skKp3JGKSVOvl/WwiMlQ2enVSSpM9A4QPFjn2v52VZp
         C6czNrZUbekCjcHdzhg4ZkTGGfunzbmxTs+AgLtHeRn1vm9wXVlNUi+TSon3Z3/U/e8v
         HfMfcpCefTsOyrDdbj0txioTL8awMPTXeIiqsWo9CbmB/rXcw+DZRME2JSLlP0ibAqiD
         VZLapH3Nw00kRQhGp4Uhcw68CzCUvDFi4Rq5Im/vPKt7XhZ1U4ExglkrIF1cm7c0oabF
         SWvQ==
X-Gm-Message-State: AJcUukdxej9SsPlybXudrt9CCYJpqGrMomCg+joUmvuIHUxOEV88RscI
        MGE7dWusmNmBgyrMXNCneVI=
X-Google-Smtp-Source: ALg8bN7WutIrMdqJv8y4ioGk+l3tw2NPmwZhCCcKLd3H0JViuyko0j8a2mRyCL2pXHGlE4C9ErW3Wg==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr11716849wrw.50.1547156283814;
        Thu, 10 Jan 2019 13:38:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8sm47769945wrt.40.2019.01.10.13.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:38:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] config.c: avoid git_path() in do_git_config_sequence()
References: <20181227155611.10585-1-pclouds@gmail.com>
        <20181227155611.10585-2-pclouds@gmail.com>
Date:   Thu, 10 Jan 2019 13:38:02 -0800
In-Reply-To: <20181227155611.10585-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 27 Dec 2018 16:56:06 +0100")
Message-ID: <xmqqa7k819dx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This function has both $GIT_COMMON_DIR and $GIT_DIR in "opts". Use it
> to construct config.worktree path instead because git_pathdup() is
> tied to the current worktree, but the given $GIT_DIR could be from
> another one.

Given that git_pathdup() does

	do_git_path(the_repository, NULL, pathname, fmt, args);

I am not sure what you mean by "tied to the current worktree"
above.  As do_git_path() uses strbuf_worktree_gitdir() that does

	if (!wt)
		strbuf_addstr(buf, repo->gitdir);

you meant s/current worktree/current repository/, perhaps?  In which
case I think the description makes sense to me.

Thanks.


>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  config.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/config.c b/config.c
> index ff521eb27a..79fbe65da8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1665,6 +1665,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	char *xdg_config = xdg_config_home("config");
>  	char *user_config = expand_user_path("~/.gitconfig", 0);
>  	char *repo_config;
> +	char *worktree_config;
>  
>  	if (opts->commondir)
>  		repo_config = mkpathdup("%s/config", opts->commondir);
> @@ -1672,6 +1673,10 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		BUG("git_dir without commondir");
>  	else
>  		repo_config = NULL;
> +	if (repository_format_worktree_config)
> +		worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
> +	else
> +		worktree_config = NULL;
>  
>  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
>  	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
> @@ -1693,12 +1698,8 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
>  	 * But let's not complicate things before it's actually needed.
>  	 */
> -	if (repository_format_worktree_config) {
> -		char *path = git_pathdup("config.worktree");
> -		if (!access_or_die(path, R_OK, 0))
> -			ret += git_config_from_file(fn, path, data);
> -		free(path);
> -	}
> +	if (worktree_config && !access_or_die(worktree_config, R_OK, 0))
> +		ret += git_config_from_file(fn, worktree_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
>  	if (git_config_from_parameters(fn, data) < 0)
> @@ -1708,6 +1709,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	free(xdg_config);
>  	free(user_config);
>  	free(repo_config);
> +	free(worktree_config);
>  	return ret;
>  }
