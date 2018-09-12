Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76E91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeILXmc (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 19:42:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55534 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 19:42:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so3453325wmc.5
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IbVkjBYAg93+St5m3JNRrvSZnaDEtazfwLpkrcQhSsE=;
        b=LQPVt8IhLrUVwiQtGCqAVjoe/RifiZQlJfkmDEzt6oFJaMKUzGQegOzcbhmZ0+5Fas
         wniHzvuE2p7XZzlOGWlWgcnplXXACF5DKmJLD89GJ7Cn06N+fWx2keSXFFxEOmTqTwTj
         RLn2c0i7YAD52xvAWOYO9JVN7vxA7Fon4+2xaZ060JSJe4RTkFSshibQR0/pehOH+4/s
         UYBkE3uEyjpzXzMd18+19UE++4p/hwsKn9iSSikyUd/L8Q8mZK0tC7lHS2pWRzXOFZNM
         /RSA2UFoPalO2CMS/veJN9DEJ2fSRUGm83yvo1wb4+Mz3o+bqCFQ4TUPwFcTVa00ppDE
         5XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IbVkjBYAg93+St5m3JNRrvSZnaDEtazfwLpkrcQhSsE=;
        b=kS1zaH4fM4p4gIDVQ0KqgtuXWetUgrAx0IrzdryKkVoC7YAeAPsy8S6l++CT6u8Gi9
         k4fF3OnMlsLWx4jnEQpVxZ00xBAXlxTDpl1m8QhwPqHiznTFwrIwOXZTp99/tLL8EzAU
         +ffBoKoj1NEPHOaxDb9gVaA3cA/12hmmrWa2OUN81mbvxt77oP4SS7Ul+muYGZp1Wz/r
         D+boPd+7aGUyW3l9Yb44YxZmNdijML65YtuP1/hQM26d9f4Xbm6VuK8umaEKMEIMvwBY
         pGD0tgNhhTqnlXy9EIHI6U5mMc89jHMQtl6XPJjjbcQwgTEQMPpIutPT0032LLWeRAwF
         weUg==
X-Gm-Message-State: APzg51DLdyhBPadKdUHsDpLRWrHKot1E/E7iJFmXReBAosDYc2s5CZ5h
        PL4MfEUnSsm2wFaVEPpYit37CceXmKw=
X-Google-Smtp-Source: ANB0VdajMJ+YJrUze25QlinpSfUsRrH2VLi0qx4gkKr7oVKIsvmLooLrLXplq5UGHG8J8TwPRXXI2w==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr2509690wmp.129.1536777402962;
        Wed, 12 Sep 2018 11:36:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g129-v6sm2868176wmf.42.2018.09.12.11.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:36:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead of in worktree
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-8-sbeller@google.com>
Date:   Wed, 12 Sep 2018 11:36:41 -0700
In-Reply-To: <20180911234951.14129-8-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:49 -0700")
Message-ID: <xmqqlg86lg06.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This patch started as a refactoring to make 'get_next_submodule' more
> readable, but upon doing so, I realized that git-fetch actually doesn't
> need to be run in the worktree. So let's run it in the git dir instead.

It may be clear to the author but not clear to the reader of the
above paragraph that "worktree", "fetch" and "git dir" all refer to
the recursively invoked operation that updates the submodules
repository.  s/git-fetch/"git fetch" for the submodule/ should be
sufficient to help the readers.

> That should pave the way towards fetching submodules that are currently
> not checked out.

Very good.

> +static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
> +{
> +	prepare_submodule_repo_env_no_git_dir(out);
> +	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
> +}
> +
>  /* Helper function to display the submodule header line prior to the full
>   * summary output. If it can locate the submodule objects directory it will
>   * attempt to lookup both the left and right commits and put them into the
> @@ -1227,6 +1233,27 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
>  	return spf->default_option;
>  }
>  
> +static const char *get_submodule_git_dir(struct repository *r, const char *path)
> +{
> +	struct repository subrepo;
> +	const char *ret;
> +
> +	if (repo_submodule_init(&subrepo, r, path)) {
> +		/* no entry in .gitmodules? */
> +		struct strbuf gitdir = STRBUF_INIT;
> +		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
> +		if (repo_init(&subrepo, gitdir.buf, NULL)) {
> +			strbuf_release(&gitdir);
> +			return NULL;
> +		}

This is for the modern "absorbed" layout?  Do we get a notice and
encouragement to migrate from the historical layout, or there is no
need to (e.g. the migration happens automatically in some other
codepaths)?

> +	}
> +
> +	ret = xstrdup(subrepo.gitdir);
> +	repo_clear(&subrepo);
> +
> +	return ret;
> +}

Returned value from this function is xstrdup()'ed so the caller
owns, not borrows.  There is no need to return "const char *" from
this function.  Also the caller needs to free it once done.

>  static int get_next_submodule(struct child_process *cp,
>  			      struct strbuf *err, void *data, void **task_cb)
>  {
> @@ -1234,8 +1261,6 @@ static int get_next_submodule(struct child_process *cp,
>  	struct submodule_parallel_fetch *spf = data;
>  
>  	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
> -		struct strbuf submodule_path = STRBUF_INIT;
> -		struct strbuf submodule_git_dir = STRBUF_INIT;
>  		struct strbuf submodule_prefix = STRBUF_INIT;
>  		const struct cache_entry *ce = spf->r->index->cache[spf->count];
>  		const char *git_dir, *default_argv;
> @@ -1274,16 +1299,12 @@ static int get_next_submodule(struct child_process *cp,
>  			continue;
>  		}
>  
> -		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
> -		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
>  		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
> -		git_dir = read_gitfile(submodule_git_dir.buf);
> -		if (!git_dir)
> -			git_dir = submodule_git_dir.buf;
> -		if (is_directory(git_dir)) {

In the old code, git_dir came from read_gitfile() which borrowed.

> +		git_dir = get_submodule_git_dir(spf->r, ce->name);

In the new code, we own it, so we'd eventually need to get rid of
it.  How does it happen?

> +		if (git_dir) {
>  			child_process_init(cp);
> -			cp->dir = strbuf_detach(&submodule_path, NULL);
> -			prepare_submodule_repo_env(&cp->env_array);
> +			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +			cp->dir = git_dir;

Does cp now own it and cp->dir gets freed once run_processes_parallel()
is done with this task?  Or is cp->dir simply leaking?  The old code
gave the result of strbuf_detach(), so even if cp->dir is leaking,
the leak is not new in this patch.

>  			cp->git_cmd = 1;
>  			if (!spf->quiet)
>  				strbuf_addf(err, "Fetching submodule %s%s\n",
> @@ -1295,8 +1316,6 @@ static int get_next_submodule(struct child_process *cp,
>  			argv_array_push(&cp->args, submodule_prefix.buf);
>  			ret = 1;
>  		}
> -		strbuf_release(&submodule_path);
> -		strbuf_release(&submodule_git_dir);

But if it is a leak, it is easily plugged by freeing git_dir here, I
think.

Thanks.


>  		strbuf_release(&submodule_prefix);
>  		if (ret) {
>  			spf->count++;
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 6c2f9b2ba26..42692219a1a 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -566,7 +566,12 @@ test_expect_success 'fetching submodule into a broken repository' '
>  
>  	test_must_fail git -C dst status &&
>  	test_must_fail git -C dst diff &&
> -	test_must_fail git -C dst fetch --recurse-submodules
> +
> +	# git-fetch cannot find the git directory of the submodule,
> +	# so it will do nothing, successfully, as it cannot distinguish between
> +	# this broken submodule and a submodule that was just set active but
> +	# not cloned yet
> +	git -C dst fetch --recurse-submodules
>  '
>  
>  test_expect_success "fetch new commits when submodule got renamed" '
