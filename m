Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F131F453
	for <e@80x24.org>; Fri, 26 Oct 2018 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeJ0FTk (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:19:40 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55672 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJ0FTk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:19:40 -0400
Received: by mail-qt1-f201.google.com with SMTP id 4-v6so2344860qtt.22
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MEcc7odj6cv86r7vZuXIhZvHMn6AbHrNyOoCkve+eTk=;
        b=e+O/2EOzRicffdAgi3TE2DVivROZffEUvq7SAo4YKSkQEnBbl+3QGA+iJ6z57THmaM
         RaEkxAz+cH0ED3AdJydK4Xyyw0SpPeRHwpvR2UkpTv6kWxBqZ2KmA63XIjoOsBydm69B
         cwNGdj4BYylB/SH9y092XhRBW4nMRzfDB3UbED5ATa7fnxKxyZAfNA4HnKf6nh+Jl071
         veWkvqwsl/BU0OzvVWlYo1kf0I/HE5zSL0bt4IqkOEAAQC5kM+9z0KdNqldlyu7MKErC
         t0SDOEVe0xWKSW2wY1h9Brg+fqF/Z7yiP5kfEd1pp9XmVcnNN5PcnjfIu0HZPNCyW7KX
         Qo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MEcc7odj6cv86r7vZuXIhZvHMn6AbHrNyOoCkve+eTk=;
        b=imwizJVoy3kwUzJIy3gIWG5//l4eyJ5sButj9cY0ZVEuSXq0G5f3Y7rX5Abb8yRSe9
         VHde6lQ8DIfSDw2KnOF5+Si98lyKoYNz/1IfqOgc75nppFPCIQJ9Kp4+ztf4ly62LGod
         lnSbG6syCVfZWIWCxvNl2lNsFwPFfYkxc2hGZmyN7FMC9VH5d3CpVIzr4fZSIP18duSU
         jrBPZSndU99/Kae21hzGJb4ufn1Mpcyc4owi2qJeq5vRSQiw3SDifkrksMvgc74OuI5h
         7EVc1QCXLPK5HV/chGYIui/X6xN8sADlgMOC1evQTgRCdDdMpjYomuPscrqdVETbldl/
         SKOA==
X-Gm-Message-State: AGRZ1gJY/vtO2iJBLfZdtoU+K7H5ryX7WMBty9WR5NRmWJGX1dFpjN3f
        dvew3adhoj3wESUMbEU5FAEK9dztoF8poHRneIlo
X-Google-Smtp-Source: AJdET5fA+5kCbVrjKyZMu8v6GGyTSTAGovt5NYDee++Ow0Qm3O81CixBTYiwNjy1tZkIEnU7AmFM6hjzsVp6CE5sqIBf
X-Received: by 2002:a37:9a90:: with SMTP id c138mr4274606qke.36.1540586470430;
 Fri, 26 Oct 2018 13:41:10 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:41:06 -0700
In-Reply-To: <20181025233231.102245-10-sbeller@google.com>
Message-Id: <20181026204106.132296-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-10-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 09/10] fetch: try fetching submodules if needed objects
 were not fetched
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But this default fetch is not sufficient, as a newly fetched commit in
> the superproject could point to a commit in the submodule that is not
> in the default refspec. This is common in workflows like Gerrit's.
> When fetching a Gerrit change under review (from refs/changes/??), the
> commits in that change likely point to submodule commits that have not
> been merged to a branch yet.
> 
> Try fetching a submodule by object id if the object id that the
> superproject points to, cannot be found.

I see that these suggestions of mine (from [1]) was implemented, but not
others. If you disagree, that's fine, but I think they should be
discussed.

[1] https://public-inbox.org/git/20181018003954.139498-1-jonathantanmy@google.com/

> The try does not happen when the "git fetch" done at the
> superproject is not storing the fetched results in remote
> tracking branches (i.e. instead just recording them to
> FETCH_HEAD) in this step. A later patch will fix this.

E.g. here, I said that there was no remote tracking branch involved.

> -		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
> -		    (recurse_submodules != RECURSE_SUBMODULES_ON))
> +		if (recurse_submodules != RECURSE_SUBMODULES_OFF)

I think the next patch should be squashed into this patch. Then you can
say that these are now redundant and can be removed.

> @@ -1218,8 +1218,12 @@ struct submodule_parallel_fetch {
>  	int result;
>  
>  	struct string_list changed_submodule_names;
> +	struct get_next_submodule_task **fetch_specific_oids;
> +	int fetch_specific_oids_nr, fetch_specific_oids_alloc;
>  };

Add documentation for fetch_specific_oids. Also, it might be better to
call these oid_fetch_tasks and the struct, "struct fetch_task".

Here, struct get_next_submodule_task is used for 2 different things:
 (1) After the first round fetch, fetch_finish() uses it to determine if
     a second round is needed.
 (2) In submodule_parallel_fetch.fetch_specific_oids, to tell the
     parallel runner (through get_next_submodule_task()) to do this
     fetch.

I think that it's better to have 2 different structs for these 2
different uses. (Note that task_cb can be NULL for the second round.
Unless we plan to recheck the OIDs? Currently we recheck them, but we
don't do anything either way.)

> +static const struct submodule *get_default_submodule(const char *path)
> +{
> +	struct submodule *ret = NULL;
> +	const char *name = default_name_or_path(path);
> +
> +	if (!name)
> +		return NULL;
> +
> +	ret = xmalloc(sizeof(*ret));
> +	memset(ret, 0, sizeof(*ret));
> +	ret->path = name;
> +	ret->name = name;
> +
> +	return (const struct submodule *) ret;
> +}

I think that this is best described as the submodule that has no entry
in .gitmodules? Maybe call it "get_non_gitmodules_submodule" and
document it with a similar comment as in get_submodule_repo_for().

> +
> +static struct get_next_submodule_task *get_next_submodule_task_create(
> +	struct repository *r, const char *path)
> +{
> +	struct get_next_submodule_task *task = xmalloc(sizeof(*task));
> +	memset(task, 0, sizeof(*task));
> +
> +	task->sub = submodule_from_path(r, &null_oid, path);
> +	if (!task->sub) {
> +		task->sub = get_default_submodule(path);
> +		task->free_sub = 1;
> +	}
> +
> +	return task;
> +}

Clearer to me would be to make get_next_submodule_task_create() return
NULL if submodule_from_path() returns NULL.

> +	if (spf->fetch_specific_oids_nr) {
> +		struct get_next_submodule_task *task = spf->fetch_specific_oids[spf->fetch_specific_oids_nr - 1];

Break lines to 80.

> +		argv_array_pushv(&cp->args, spf->args.argv);
> +		argv_array_push(&cp->args, "on-demand");

Same comment about "on-demand" as in my previous e-mail.

> +		argv_array_push(&cp->args, "--submodule-prefix");
> +		argv_array_push(&cp->args, submodule_prefix.buf);
> +
> +		/* NEEDSWORK: have get_default_remote from s--h */

Same comment about "s--h" as in my previous e-mail.

> +	commits = it->util;
> +	oid_array_filter(commits,
> +			 commit_exists_in_sub,
> +			 task->repo);
> +
> +	/* Are there commits that do not exist? */
> +	if (commits->nr) {
> +		/* We already tried fetching them, do not try again. */
> +		if (task->commits)
> +			return 0;

Same comment about "task->commits" as in my previous e-mail.

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 6c2f9b2ba2..5a75b57852 100755

One more thing to test is the case where a submodule doesn't have a
.gitmodules entry.
