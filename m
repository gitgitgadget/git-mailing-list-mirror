Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE361F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIMAJt (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:09:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeIMAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:09:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so3181456wrc.0
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S0RKASAJqiNW6VX5OpBm27AWmRTj/jsbV5Jae3uRnGs=;
        b=nCHstRhaD3CBmWRadznN+QC87qKJUaUKj6oMcWkz9ENAldXbc8xgOHhDtrjyUUzCLd
         8Q5Byrj13JJkROGmcxpCMNgjggIuoqnbtr4N8RQhYdkph4G8eNHEIYd9WnBFMtWafsfs
         SkwaP9AmC3QEA1WKs6AFr5jnzjs5oTpLnKiJNmkxtL9sHs9NKj51ysk9Qd2F5hkNSwkk
         VEhmIMdoWkWQCzU6pYObKos584wUGsjjQlgkYd4gK1toTNn05ol0QcwSs1iJxPBPQv/5
         iITyRMB1k6U+DMRdp4R456WBoUyHCY3uFv6m7zdCvQDHaSfzTM7wx8O+CTwaXGQ4c/TB
         Hp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S0RKASAJqiNW6VX5OpBm27AWmRTj/jsbV5Jae3uRnGs=;
        b=hAsMOhALqyK21vyV0iB7Bcm9oSZlJQUKxOU88m29y5+OedZmzg+Mwg/J7H7EuHX4kR
         5P3MI+1jSIJv4ygso9+ChlZMnOQrucxEG1ML4FYD0BdVSWXiow9nvMkyI0z9ZG/zZ3IM
         7INVQCVets94mkptzhcVWVlCxVzCj1u0pf1fzbmU+PgbuWjE+vvYMW2J3VIKsx+2FEXl
         Vd31cq8dV9LVZILM8HhV1OdQuu74FpykxrksFzD65go5Y/GKkrvRDUjlruVCqypO6amG
         151jjMXpQoshNthfl9+Nruioh9yw60owvXdL1l1AWYbxC80C7nR4Z4KKBI/szhp0mfwM
         WUTA==
X-Gm-Message-State: APzg51AQJVprhCkC3lsrSImHxBHPSWp7R4Y43tzWXhVpexHpYfCRKqdL
        DMbAn4h2IGRav8TRRY5FbSlyLdpVwcQ=
X-Google-Smtp-Source: ANB0VdZ2yX7Naz6dzuZC5x0wH2hWEEzwh1VKfUdFvpRL3mB5hXCBPGT79G/KhEIBG4kAzWLaQ4nvUg==
X-Received: by 2002:adf:ef51:: with SMTP id c17-v6mr2613470wrp.182.1536779033554;
        Wed, 12 Sep 2018 12:03:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z4-v6sm1064278wrt.89.2018.09.12.12.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:03:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] fetch: retry fetching submodules if sha1 were not fetched
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-9-sbeller@google.com>
Date:   Wed, 12 Sep 2018 12:03:52 -0700
In-Reply-To: <20180911234951.14129-9-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:50 -0700")
Message-ID: <xmqqftyeleqv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Retry fetching a submodule if the object id that the superproject points
> to, cannot be found.

By object name?  By attempting to fetch all refs?  Or by doing
something else?  Fetching by the exact object name is the most
efficient approach, but the server side may not be prepared to
serve such a request, and that is why spelling it out here would
help the readers.

> This doesn't support fetching to FETCH_HEAD yet, but only into a local
> branch.

It is not clear if this sentence is talking about the fetch done at
the superproject level, or what happens in a submodule repository
when this "retrying" happens.  Assuming that it is the former,
perhaps

    This retrying does not happen when the "git fetch" done at the
    superproject is not storing the fetched results in remote
    tracking branches (i.e. instead just recording them to
    FETCH_HEAD) in this step.

would help the readers understand what you are trying to say.

> To make fetching into FETCH_HEAD work, we need some refactoring
> in builtin/fetch.c to adjust the calls to 'check_for_new_submodule_commits'
> that is coming in the next patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/fetch.c             |  9 ++--
>  submodule.c                 | 87 ++++++++++++++++++++++++++++++++++++-
>  t/t5526-fetch-submodules.sh | 16 +++++++
>  3 files changed, 104 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 61bec5d213d..95c44bf6ffa 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -700,8 +700,7 @@ static int update_local_ref(struct ref *ref,
>  			what = _("[new ref]");
>  		}
>  
> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> +		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
>  			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref(msg, ref, 0);
>  		format_display(display, r ? '!' : '*', what,
> @@ -716,8 +715,7 @@ static int update_local_ref(struct ref *ref,
>  		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>  		strbuf_addstr(&quickref, "..");
>  		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> +		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
>  			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref("fast-forward", ref, 1);
>  		format_display(display, r ? '!' : ' ', quickref.buf,
> @@ -731,8 +729,7 @@ static int update_local_ref(struct ref *ref,
>  		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>  		strbuf_addstr(&quickref, "...");
>  		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> +		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
>  			check_for_new_submodule_commits(&ref->new_oid);
>  		r = s_update_ref("forced-update", ref, 1);
>  		format_display(display, r ? '!' : '+', quickref.buf,

All of these used to react to any value set to recurse-submodules
that is not off or on (i.e. on-demand, default, none), but now
unless the value is explicitly set to off, we call into the check.
It is not immediately clear how that change is linked to the
retrying.  "When set to 'on', we did not check for new commits, but
now we do" can be read from the patch text but not the reasoning
behind it.

What was the reason why we didn't call "check-for-new" when recurse
is set to "on"?  Is it because "we are going to recurse anyway, so
there is no need to check to decide if we need to fetch in
submodule"?  And the reason why we now need to call when we are set
to recurse anyway is because check-for-new now learns much more than
just "do we need to cd there and run git-fetch? yes/no?"

The answers to these two questions would help readers in the log
message.

> diff --git a/submodule.c b/submodule.c
> index 1e6781504f0..a75146e89cf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1127,8 +1127,11 @@ struct submodule_parallel_fetch {
>  	int result;
>  
>  	struct string_list changed_submodule_names;
> +	struct string_list retry;
>  };
> -#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
> +#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
> +		  STRING_LIST_INIT_DUP, \
> +		  STRING_LIST_INIT_NODUP}
>  
>  static void calculate_changed_submodule_paths(
>  	struct submodule_parallel_fetch *spf)
> @@ -1259,8 +1262,10 @@ static int get_next_submodule(struct child_process *cp,
>  {
>  	int ret = 0;
>  	struct submodule_parallel_fetch *spf = data;
> +	struct string_list_item *it;
>  
>  	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
> +		int recurse_config;
>  		struct strbuf submodule_prefix = STRBUF_INIT;
>  		const struct cache_entry *ce = spf->r->index->cache[spf->count];
>  		const char *git_dir, *default_argv;
> @@ -1280,7 +1285,9 @@ static int get_next_submodule(struct child_process *cp,
>  			}
>  		}
>  
> -		switch (get_fetch_recurse_config(submodule, spf))
> +		recurse_config = get_fetch_recurse_config(submodule, spf);
> +
> +		switch (recurse_config)
>  		{
>  		default:
>  		case RECURSE_SUBMODULES_DEFAULT:
> @@ -1319,9 +1326,50 @@ static int get_next_submodule(struct child_process *cp,
>  		strbuf_release(&submodule_prefix);
>  		if (ret) {
>  			spf->count++;
> +			if (submodule != &default_submodule)
> +				/* discard const-ness: */
> +				*task_cb = (void*)submodule;
>  			return 1;
>  		}
>  	}
> +
> +retry_next:
> +
> +	if (spf->retry.nr) {
> +		struct strbuf submodule_prefix = STRBUF_INIT;
> +		const struct submodule *sub;
> +
> +		it = string_list_last(&spf->retry);
> +		sub = submodule_from_name(spf->r, &null_oid,
> +					  it->string);
> +
> +		child_process_init(cp);
> +		cp->dir = get_submodule_git_dir(spf->r, sub->path);
> +		if (!cp->dir) {
> +			string_list_pop(&spf->retry, 0);
> +			goto retry_next;
> +		}
> +		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +		cp->git_cmd = 1;
> +
> +		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, sub->path);
> +		argv_array_init(&cp->args);
> +		argv_array_pushv(&cp->args, spf->args.argv);
> +		argv_array_push(&cp->args, "on-demand");
> +		argv_array_push(&cp->args, "--submodule-prefix");
> +		argv_array_push(&cp->args, submodule_prefix.buf);
> +
> +		/* NEEDSWORK: have get_default_remote from s--h */
> +		argv_array_push(&cp->args, "origin");
> +		oid_array_for_each_unique(it->util,
> +					  append_oid_to_argv, &cp->args);
> +
> +		*task_cb = NULL; /* make sure we do not recurse forever */
> +		strbuf_release(&submodule_prefix);
> +		string_list_pop(&spf->retry, 0);
> +		return 1;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1335,14 +1383,49 @@ static int fetch_start_failure(struct strbuf *err,
>  	return 0;
>  }
>  
> +static int commit_exists_in_sub(const struct object_id *oid, void *data)
> +{
> +	struct repository *subrepo = data;
> +
> +	enum object_type type = oid_object_info(subrepo, oid, NULL);
> +
> +	return type != OBJ_COMMIT;
> +}

Is this checking if the 'oid' exists as a comit in the submodule
repository?  It smells to me that it is checking the opposite.
Shouldn't the function be named "commit_missing_from_submodule()" or
something like that?

>  static int fetch_finish(int retvalue, struct strbuf *err,
>  			void *cb, void *task_cb)
>  {
>  	struct submodule_parallel_fetch *spf = cb;
> +	struct submodule *sub = task_cb;
> +	struct repository subrepo;
>  
>  	if (retvalue)
>  		spf->result = 1;
>  
> +	if (!sub)
> +		return 0;
> +
> +	if (repo_submodule_init(&subrepo, spf->r, sub->path) < 0)
> +		warning(_("Could not get submodule repository for submodule '%s' in repository '%s'"),
> +			  sub->path, spf->r->worktree);
> +	else {
> +		struct string_list_item *it;
> +		struct oid_array *commits;
> +
> +		it = string_list_lookup(&spf->changed_submodule_names, sub->name);
> +		if (!it)
> +			return 0;

OK, so after a fetch, if we have missing commits, we append to the
spf->retry list, which will be looked at in the function we looked
at earlier.

> +		commits = it->util;
> +		oid_array_filter(commits,
> +				 commit_exists_in_sub,
> +				 &subrepo);
> +
> +		if (commits->nr)
> +			string_list_append(&spf->retry, sub->name)
> +				->util = commits;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 42692219a1a..af12c50e7dd 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -605,4 +605,20 @@ test_expect_success "fetch new commits when submodule got renamed" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success "fetch new commits on-demand when they are not reachable" '
> +	git checkout --detach &&
> +	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
> +	git -C submodule update-ref refs/changes/1 $C &&
> +	git update-index --cacheinfo 160000 $C submodule &&
> +	git commit -m "updated submodule outside of refs/heads" &&
> +	D=$(git rev-parse HEAD) &&
> +	git update-ref refs/changes/2 $D &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
> +		git -C submodule cat-file -t $C &&
> +		git checkout --recurse-submodules FETCH_HEAD
> +	)
> +'
> +
>  test_done
