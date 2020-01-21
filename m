Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01BC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C8D24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tK4MvOyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAUV6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:58:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36809 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUV6d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 16:58:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so2291518pjb.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOgOWuL/iyDk1rzEHDHCM3rSIqxalHGM0ZGj9srxZ9U=;
        b=tK4MvOyMtzM4l/QIWe25Wx3RE23UiSFAkRxmIV/i0x8SFrADHdDcF3UUoJOEKy2pie
         RF587Mg1mCpJHRauc7vnCDu5xdfD6LwF/SFN51ewr5rzOJ0Dq2GYlzcQCDPeYqZl12IO
         mKuhqJMiRIGQwWWSWKhSpF/cxCDAd5Rya9s3KoAQKzAU1WlSr4uXADJ7VwgScrmaBGsu
         d4oqcd0i/0+26+aZ5Eyzgs2SJMjSqNrF0ddbWoJ89K+woXtOnBieu82+LLivlIqrg2e8
         fMqR0FhxCfuCPHEGegnvrsIaLRVXDC9NjuCS3Ogodzt+WHA624KFbVaSiZvHcsrHW+qa
         6Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=VOgOWuL/iyDk1rzEHDHCM3rSIqxalHGM0ZGj9srxZ9U=;
        b=jvzxkXS+gNu86UJDTpuOcShkhgknNGA7GenPwSvkgCm06iN0vYZNriZFCR1lNbFBDX
         cxXL+tQ3ooT5DENplbY+bqxvnFVUd+BrapsOSF6/fys2c/2rfO5SjZR4br6wPMoGg8df
         mf1HCVjBbhDSKIStFm+6ePOrVZ+62/qbNbYMcL645cGpxlmU19q3MlwywACPY0P+5pXD
         MTa6UnFqdFLWrW2A46AU04K7Ckq24kn2FiICoyJ4nUqIaQBIP01FdynRWEciVU7cmex4
         72jG1UnEn5F2nVM7rFixCZttHmQFPR/ud3urxHQPERirMn67FlPwEr1zf/2r/2JizVxh
         t55w==
X-Gm-Message-State: APjAAAU7PkSfvdF5j2kkULjsrYpYa+ElLqQPGeCDNIjampKyzc5UTTYl
        TTpyS/9rIWSxpHkXs2Y4wh6zQWN18BMXtQ==
X-Google-Smtp-Source: APXvYqyMhbT18gdT5EK6q1sVLdhd+CldAoOSslaELLLOL7dnLQGOat73Lo/Qp7q/OMPSEbovArQexQ==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr657200pjv.34.1579643912173;
        Tue, 21 Jan 2020 13:58:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id b19sm43400609pfo.56.2020.01.21.13.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 13:58:31 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:58:26 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule.c: mark more strings for translation
Message-ID: <20200121215826.GC63040@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20200115180701.14657-1-ralf.thielow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115180701.14657-1-ralf.thielow@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.01.15 19:07, Ralf Thielow wrote:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  submodule.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 9da7181321..9430db8ffc 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -431,7 +431,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  	else if (!strcmp(arg, "dirty"))
>  		diffopt->flags.ignore_dirty_submodules = 1;
>  	else if (strcmp(arg, "none"))
> -		die("bad --ignore-submodules argument: %s", arg);
> +		die(_("bad --ignore-submodules argument: %s"), arg);
>  	/*
>  	 * Please update _git_status() in git-completion.bash when you
>  	 * add new options
> @@ -812,9 +812,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>  				submodule = submodule_from_name(me->repo,
>  								commit_oid, name);
>  			if (submodule) {
> -				warning("Submodule in commit %s at path: "
> +				warning(_("Submodule in commit %s at path: "
>  					"'%s' collides with a submodule named "
> -					"the same. Skipping it.",
> +					"the same. Skipping it."),
>  					oid_to_hex(commit_oid), p->two->path);
>  				name = NULL;
>  			}
> @@ -844,7 +844,7 @@ static void collect_changed_submodules(struct repository *r,
>  	repo_init_revisions(r, &rev, NULL);
>  	setup_revisions(argv->argc, argv->argv, &rev, NULL);
>  	if (prepare_revision_walk(&rev))
> -		die("revision walk setup failed");
> +		die(_("revision walk setup failed"));
>  
>  	while ((commit = get_revision(&rev))) {
>  		struct rev_info diff_rev;
> @@ -992,7 +992,7 @@ static int submodule_needs_pushing(struct repository *r,
>  		cp.out = -1;
>  		cp.dir = path;
>  		if (start_command(&cp))
> -			die("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s",
> +			die(_("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s"),
>  					path);
>  		if (strbuf_read(&buf, cp.out, the_hash_algo->hexsz + 1))
>  			needs_pushing = 1;
> @@ -1115,7 +1115,7 @@ static void submodule_push_check(const char *path, const char *head,
>  	 * child process.
>  	 */
>  	if (run_command(&cp))
> -		die("process for submodule '%s' failed", path);
> +		die(_("process for submodule '%s' failed"), path);
>  }
>  
>  int push_unpushed_submodules(struct repository *r,
> @@ -1155,10 +1155,10 @@ int push_unpushed_submodules(struct repository *r,
>  	/* Actually push the submodules */
>  	for (i = 0; i < needs_pushing.nr; i++) {
>  		const char *path = needs_pushing.items[i].string;
> -		fprintf(stderr, "Pushing submodule '%s'\n", path);
> +		fprintf(stderr, _("Pushing submodule '%s'\n"), path);
>  		if (!push_submodule(path, remote, rs,
>  				    push_options, dry_run)) {
> -			fprintf(stderr, "Unable to push submodule '%s'\n", path);
> +			fprintf(stderr, _("Unable to push submodule '%s'\n"), path);
>  			ret = 0;
>  		}
>  	}
> @@ -1448,7 +1448,7 @@ static int get_next_submodule(struct child_process *cp,
>  			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
>  			cp->git_cmd = 1;
>  			if (!spf->quiet)
> -				strbuf_addf(err, "Fetching submodule %s%s\n",
> +				strbuf_addf(err, _("Fetching submodule %s%s\n"),
>  					    spf->prefix, ce->name);
>  			argv_array_init(&cp->args);
>  			argv_array_pushv(&cp->args, spf->args.argv);
> @@ -1610,7 +1610,7 @@ int fetch_populated_submodules(struct repository *r,
>  		goto out;
>  
>  	if (repo_read_index(r) < 0)
> -		die("index file corrupt");
> +		die(_("index file corrupt"));
>  
>  	argv_array_push(&spf.args, "fetch");
>  	for (i = 0; i < options->argc; i++)
> @@ -1665,7 +1665,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  	cp.out = -1;
>  	cp.dir = path;
>  	if (start_command(&cp))
> -		die("Could not run 'git status --porcelain=2' in submodule %s", path);
> +		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
>  
>  	fp = xfdopen(cp.out, "r");
>  	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
> @@ -1706,7 +1706,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  	fclose(fp);
>  
>  	if (finish_command(&cp) && !ignore_cp_exit_code)
> -		die("'git status --porcelain=2' failed in submodule %s", path);
> +		die(_("'git status --porcelain=2' failed in submodule %s"), path);
>  
>  	strbuf_release(&buf);
>  	return dirty_submodule;
> @@ -1841,7 +1841,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
>  	cp.no_stdout = 1;
>  	cp.dir = sub->path;
>  	if (start_command(&cp))
> -		die("could not recurse into submodule '%s'", sub->path);
> +		die(_("could not recurse into submodule '%s'"), sub->path);
>  
>  	return finish_command(&cp);
>  }
> @@ -1862,7 +1862,7 @@ static void submodule_reset_index(const char *path)
>  	argv_array_push(&cp.args, empty_tree_oid_hex());
>  
>  	if (run_command(&cp))
> -		die("could not reset submodule index");
> +		die(_("could not reset submodule index"));
>  }
>  
>  /**
> -- 
> 2.25.0.341.g760bfbb309

This all looks good to me. Thanks for the patch!
