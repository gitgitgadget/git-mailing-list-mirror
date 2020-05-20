Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C84C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A31206B6
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKm8RKrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETTJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 15:08:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2721C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:08:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z15so269863pjb.0
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8d9peAXBUukYtAlJieKlDDGBuMBzTvU2eKZOFT6nJQ=;
        b=JKm8RKrKo4ZcvFTbrtyzGyMiZUW3rp4+FDaG+UGjyqLZPa5B7YrVd1j5Q8VjDnLkAr
         xeRWfr8b5/7ilnYgN5pK7gMRPgoXEPpD3qVRZetaRNwJFVDEPQKb5/zCKpTB4/H6Dp9B
         ea0ptH9qXLe0GUZPjQDw0AwFEKuSurtZP6n6J9em7ypk+KgTfWT4yIOOwodzJOJZUGh0
         Dc0tEmx0psJONMcILTleIuzxSfVKlf1AOckIArdf/Zghj2YGfjSgiyttlAIydzcL1bUm
         1WpyqUBC0gz36imkgeIiPwdIPMZm0vYoikZmLtB2E2/8vf6+Bwbp6w2ABlgciWe4cJn+
         In6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=E8d9peAXBUukYtAlJieKlDDGBuMBzTvU2eKZOFT6nJQ=;
        b=Dc08rSzXGN5VrCdGAwVleXvnbnhxoJ3r0BXxfpLAW2EDpGJTkv8xaOZ9GqUKdUlKdw
         5kFSTgAdM25M8znLkx//Mxtj334Aw6pZW2T3Cm3mAs/TJd9jUx+EKQ6wig/alZtG1Gyf
         UPCtKivpOSM9s85Ag0sjYLe5Xb+dL/tbM7L19mVhxVFTPS8GKtZJ+sdwGbNDhmyQaz61
         cDDcS/c+yofA1zwhuFke4GzO/RrkiXQFMqkP8kEpaSv7HKVlAJIH64n4cBzJ6RxwCYvM
         9H7+l89cei9b/XrLbTHZZdZaAWgsUyKNmDP4br4PpTA6kHB+/YuIZfZ3ytM5mbQgBs0y
         oqPA==
X-Gm-Message-State: AOAM532OZQS0diBA6R+Bbr2O5d99/V9XiavLG/k7SatCcdISn5yd3UxJ
        Pectl74OjE5KFfLH3dvZ1jMh4Q==
X-Google-Smtp-Source: ABdhPJzxqWYrPdDQNnTWoVTYrHpwCD56LUa4vQQv0e2RaI7S0KQbv2LNKQMkOvuLseZ5+Dnv2NEBeg==
X-Received: by 2002:a17:902:bc89:: with SMTP id bb9mr6035405plb.101.1590001738719;
        Wed, 20 May 2020 12:08:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id o15sm2515699pjq.28.2020.05.20.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:08:57 -0700 (PDT)
Date:   Wed, 20 May 2020 12:08:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] run-job: implement fetch job
Message-ID: <20200520190852.GC163566@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.04.03 20:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When working with very large repositories, an incremental 'git fetch'
> command can download a large amount of data. If there are many other
> users pushing to a common repo, then this data can rival the initial
> pack-file size of a 'git clone' of a medium-size repo.
> 
> Users may want to keep the data on their local repos as close as
> possible to the data on the remote repos by fetching periodically in
> the background. This can break up a large daily fetch into several
> smaller hourly fetches.
> 
> However, if we simply ran 'git fetch <remote>' in the background,
> then the user running a foregroudn 'git fetch <remote>' would lose
> some important feedback when a new branch appears or an existing
> branch updates. This is especially true if a remote branch is
> force-updated and this isn't noticed by the user because it occurred
> in the background. Further, the functionality of 'git push
> --force-with-lease' becomes suspect.

It might be useful here to clarify the interaction between background
fetching & the expectations around --force-with-lease.


> When running 'git fetch <remote> <options>' in the background, use
> the following options for careful updating:
> 
> 1. --no-tags prevents getting a new tag when a user wants to see
>    the new tags appear in their foreground fetches.
> 
> 2. --refmap= removes the configured refspec which usually updates
>    refs/remotes/<remote>/* with the refs advertised by the remote.
> 
> 3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
>    we can ensure that we actually load the new values somewhere in
>    our refspace while not updating refs/heads or refs/remotes. By
>    storing these refs here, the commit-graph job will update the
>    commit-graph with the commits from these hidden refs.
> 
> 4. --prune will delete the refs/hidden/<remote> refs that no
>    longer appear on the remote.
> 
> We've been using this step as a critical background job in Scalar
> [1] (and VFS for Git). This solved a pain point that was showing up
> in user reports: fetching was a pain! Users do not like waiting to
> download the data that was created while they were away from their
> machines. After implementing background fetch, the foreground fetch
> commands sped up significantly because they mostly just update refs
> and download a small amount of new data. The effect is especially
> dramatic when paried with --no-show-forced-udpates (through
> fetch.showForcedUpdates=false).
> 
> [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/FetchStep.cs
> 
> RFC QUESTIONS:
> 
> 1. One downside of the refs/hidden pattern is that 'git log' will
>    decorate commits with twice as many refs if they appear at a
>    remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>    there an easy way to exclude a refspace from decorations? Should
>    we make refs/hidden/* a "special" refspace that is excluded from
>    decorations?
> 
> 2. This feature is designed for a desktop machine or equivalent
>    that has a permanent wired network connection, and the machine
>    stays on while the user is not present. For things like laptops
>    with inconsistent WiFi connections (that may be metered) the
>    feature can use the less stable connection more than the user
>    wants. Of course, this feature is opt-in for Git, but in Scalar
>    we have a "scalar pause" command [2] that pauses all maintenance
>    for some amount of time. We should consider a similar mechanism
>    for Git, but for the point of this series the user needs to set
>    up the "background" part of these jobs manually.
> 
> [2] https://github.com/microsoft/scalar/blob/master/Scalar/CommandLine/PauseVerb.cs
> [3] https://github.com/microsoft/scalar/blob/master/docs/advanced.md#controlling-background-maintenance
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-run-job.txt | 13 ++++-
>  builtin/run-job.c             | 89 ++++++++++++++++++++++++++++++++++-
>  t/t7900-run-job.sh            | 22 +++++++++
>  3 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> index 8bf2762d650..eb92e891915 100644
> --- a/Documentation/git-run-job.txt
> +++ b/Documentation/git-run-job.txt
> @@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
>  SYNOPSIS
>  --------
>  [verse]
> -'git run-job commit-graph'
> +'git run-job (commit-graph|fetch)'
>  
>  
>  DESCRIPTION
> @@ -47,6 +47,17 @@ since it will not expire `.graph` files that were in the previous
>  `commit-graph-chain` file. They will be deleted by a later run based on
>  the expiration delay.
>  
> +'fetch'::
> +
> +The `fetch` job updates the object directory with the latest objects
> +from all registered remotes. For each remote, a `git fetch` command is
> +run. The refmap is custom to avoid updating local or remote branches
> +(those in `refs/heads` or `refs/remotes`). Instead, the remote refs are
> +stored in `refs/hidden/<remote>/`. Also, no tags are updated.
> ++
> +This means that foreground fetches are still required to update the
> +remote refs, but the users is notified when the branches and tags are
> +updated on the remote.
>  
>  GIT
>  ---
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> index dd7709952d3..e59056b2918 100644
> --- a/builtin/run-job.c
> +++ b/builtin/run-job.c
> @@ -7,7 +7,7 @@
>  #include "run-command.h"
>  
>  static char const * const builtin_run_job_usage[] = {
> -	N_("git run-job commit-graph"),
> +	N_("git run-job (commit-graph|fetch)"),
>  	NULL
>  };
>  
> @@ -60,6 +60,91 @@ static int run_commit_graph_job(void)
>  	return 1;
>  }
>  
> +static int fetch_remote(const char *remote)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	struct strbuf refmap = STRBUF_INIT;
> +
> +	argv_array_pushl(&cmd, "fetch", remote, "--quiet", "--prune",
> +			 "--no-tags", "--refmap=", NULL);
> +
> +	strbuf_addf(&refmap, "+refs/heads/*:refs/hidden/%s/*", remote);
> +	argv_array_push(&cmd, refmap.buf);
> +
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> +	strbuf_release(&refmap);
> +	return result;
> +}
> +
> +static int fill_remotes(struct string_list *remotes)
> +{
> +	int result = 0;
> +	FILE *proc_out;
> +	struct strbuf line = STRBUF_INIT;
> +	struct child_process *remote_proc = xmalloc(sizeof(*remote_proc));

Shouldn't remote_proc just go on the stack here rather than getting
malloced?

> +
> +	child_process_init(remote_proc);
> +
> +	argv_array_pushl(&remote_proc->args, "git", "remote", NULL);
> +
> +	remote_proc->out = -1;
> +
> +	if (start_command(remote_proc)) {
> +		error(_("failed to start 'git remote' process"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	proc_out = xfdopen(remote_proc->out, "r");
> +
> +	/* if there is no line, leave the value as given */
> +	while (!strbuf_getline(&line, proc_out))
> +		string_list_append(remotes, line.buf);
> +
> +	strbuf_release(&line);
> +
> +	fclose(proc_out);
> +
> +	if (finish_command(remote_proc)) {
> +		error(_("failed to finish 'git remote' process"));
> +		result = 1;
> +	}
> +
> +cleanup:
> +	free(remote_proc);
> +	return result;
> +}
> +
> +static int run_fetch_job(void)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (fill_remotes(&remotes)) {
> +		error(_("failed to fill remotes"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * Do not modify the result based on the success of the 'fetch'
> +	 * operation, as a loss of network could cause 'fetch' to fail
> +	 * quickly. We do not want that to stop the rest of our
> +	 * background operations.
> +	 */
> +	for (item = remotes.items;
> +	     item && item < remotes.items + remotes.nr;
> +	     item++)
> +		fetch_remote(item->string);
> +
> +cleanup:
> +	string_list_clear(&remotes, 0);
> +	return result;
> +}
> +
>  int cmd_run_job(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_run_job_options[] = {
> @@ -79,6 +164,8 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
>  	if (argc > 0) {
>  		if (!strcmp(argv[0], "commit-graph"))
>  			return run_commit_graph_job();
> +		if (!strcmp(argv[0], "fetch"))
> +			return run_fetch_job();
>  	}
>  
>  	usage_with_options(builtin_run_job_usage,
> diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
> index 18b9bd26b3a..d3faeba135b 100755
> --- a/t/t7900-run-job.sh
> +++ b/t/t7900-run-job.sh
> @@ -44,4 +44,26 @@ test_expect_success 'commit-graph job' '
>  	)
>  '
>  
> +test_expect_success 'fetch job' '
> +	git clone "file://$(pwd)/server" client &&
> +
> +	# Before fetching, build a client commit-graph
> +	git -C client run-job commit-graph &&
> +	chain=client/.git/objects/info/commit-graphs/commit-graph-chain &&
> +	test_line_count = 1 $chain &&
> +
> +	git -C client branch -v --remotes >before-refs &&
> +	test_commit -C server 24 &&
> +
> +	git -C client run-job fetch &&
> +	git -C client branch -v --remotes >after-refs &&
> +	test_cmp before-refs after-refs &&
> +	test_cmp server/.git/refs/heads/master \
> +		 client/.git/refs/hidden/origin/master &&
> +
> +	# the hidden ref should trigger a new layer in the commit-graph
> +	git -C client run-job commit-graph &&
> +	test_line_count = 2 $chain
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
