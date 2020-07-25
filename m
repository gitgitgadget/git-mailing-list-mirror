Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352BC433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782722070E
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLP7X0AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGYBhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgGYBhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:37:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBEC0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:37:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so6461653pjb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=twDRZtSbHIkWzueBTjVSQOWPJlo9BD7xt1betKuljps=;
        b=BLP7X0AJBdhftoPAkVBGGr5hqmG+1jVUPcbJlbf/CDqmInJo63pWu05/7HatmYAugG
         T/jRGVDZ9E7sy9G0t4hqtfqakX1Qfi7svvmYR8ScD6uKnR2lmHaBayTu1CdWN61KXx4A
         d8kqePaXXUBNG+nRQJ5ACq30HOYjrbylkGz48gRjIPe0ehc4l/vUVkFFyKkwa9VyTVir
         FcIHNEj6nSp0Iufxq0m1A66clL7c88SGxDWKtqvRhUxBsuDeOexWc2J52MR1KKQCOVm/
         J0EluBxoty/iXBhyp1rz7FuWmmHmvq9u2X9vCUr+/Y/lrrzIKWHryg9kHwCwOFq3C1Ob
         CK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twDRZtSbHIkWzueBTjVSQOWPJlo9BD7xt1betKuljps=;
        b=PGZWsSS3b6dpRijjUyMshBu8CScSWHxjnGfdPoSwbP2Cu4srSfMQxVuY0KzfhNd5By
         m/1HJl9d498lhzMhbR9zsvhQCCxAreyP/QFBFXeu7Q8FAm69WagyZnZe81z8l+bgUyaU
         cRKpzqJ7KzOEevHlgW/oK2cxA1NRGqJylL7HPvMR2MEjTrP9zgWWNM5iwAMDsjG6yXM4
         DdUle8hKFYH7Kq3uHs1j2ewqd5FUSYDctysrWUtQs3kxY19p1htMu8pwd362pfunKE4z
         NCiqOnMPbDMrJGcZqDSzbBDAYc8CQnRfyWqwORA+YS5wGvrJ74FP+B7Ek53b7Xm4nn/5
         5+mg==
X-Gm-Message-State: AOAM53028o/X5rSNwUTsnxs+zaUT0Jd/Wh9X22Bt6kKocRhv02n9qch/
        L/KYx+ckFVh+ladc/DTw3l4=
X-Google-Smtp-Source: ABdhPJyyYL4687dJmq/uaF0VKHklXfXpACPSambFFKDJBZCqivFDimTi9YG8WAWEfixCXaIurGUAWA==
X-Received: by 2002:a17:90b:196:: with SMTP id t22mr8359615pjs.13.1595641038070;
        Fri, 24 Jul 2020 18:37:18 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id d18sm6803575pjv.25.2020.07.24.18.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:37:16 -0700 (PDT)
Date:   Sat, 25 Jul 2020 08:37:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
Message-ID: <20200725013715.GA2436@danh.dev>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-23 17:56:30+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
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
> The task is called "prefetch" because it is work done in advance
> of a foreground fetch to make that 'git fetch' command much faster.
> 
> However, if we simply ran 'git fetch <remote>' in the background,
> then the user running a foregroudn 'git fetch <remote>' would lose
> some important feedback when a new branch appears or an existing
> branch updates. This is especially true if a remote branch is
> force-updated and this isn't noticed by the user because it occurred
> in the background. Further, the functionality of 'git push
> --force-with-lease' becomes suspect.
> 
> When running 'git fetch <remote> <options>' in the background, use
> the following options for careful updating:

Does this job interfere with FETCH_HEAD?
From my quick test (by applying 01-08 on top of rc1, and messing with t7900),
it looks like yes.

I (and some other people, probably) rely on FETCH_HEAD for our scripts.
Hence, it would be nice to not touch FETCH_HEAD with prefetch job.

Thanks,
-Danh

> 
> 1. --no-tags prevents getting a new tag when a user wants to see
>    the new tags appear in their foreground fetches.
> 
> 2. --refmap= removes the configured refspec which usually updates
>    refs/remotes/<remote>/* with the refs advertised by the remote.
> 
> 3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
>    we can ensure that we actually load the new values somewhere in
>    our refspace while not updating refs/heads or refs/remotes. By
>    storing these refs here, the commit-graph job will update the
>    commit-graph with the commits from these hidden refs.
> 
> 4. --prune will delete the refs/prefetch/<remote> refs that no
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
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-maintenance.txt | 12 ++++++
>  builtin/gc.c                      | 64 ++++++++++++++++++++++++++++++-
>  t/t7900-maintenance.sh            | 24 ++++++++++++
>  3 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 9204762e21..0927643247 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -53,6 +53,18 @@ since it will not expire `.graph` files that were in the previous
>  `commit-graph-chain` file. They will be deleted by a later run based on
>  the expiration delay.
>  
> +prefetch::
> +	The `fetch` task updates the object directory with the latest objects
> +	from all registered remotes. For each remote, a `git fetch` command
> +	is run. The refmap is custom to avoid updating local or remote
> +	branches (those in `refs/heads` or `refs/remotes`). Instead, the
> +	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
> +	not updated.
> ++
> +This means that foreground fetches are still required to update the
> +remote refs, but the users is notified when the branches and tags are
> +updated on the remote.
> +
>  gc::
>  	Cleanup unnecessary files and optimize the local repository. "GC"
>  	stands for "garbage collection," but this task performs many
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 5d99b4b805..969c127877 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -28,6 +28,7 @@
>  #include "blob.h"
>  #include "tree.h"
>  #include "promisor-remote.h"
> +#include "remote.h"
>  
>  #define FAILED_RUN "failed to run %s"
>  
> @@ -700,7 +701,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -#define MAX_NUM_TASKS 2
> +#define MAX_NUM_TASKS 3
>  
>  static const char * const builtin_maintenance_usage[] = {
>  	N_("git maintenance run [<options>]"),
> @@ -781,6 +782,63 @@ static int maintenance_task_commit_graph(void)
>  	return 1;
>  }
>  
> +static int fetch_remote(const char *remote)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	struct strbuf refmap = STRBUF_INIT;
> +
> +	argv_array_pushl(&cmd, "fetch", remote, "--prune",
> +			 "--no-tags", "--refmap=", NULL);
> +
> +	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
> +	argv_array_push(&cmd, refmap.buf);
> +
> +	if (opts.quiet)
> +		argv_array_push(&cmd, "--quiet");
> +
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> +	strbuf_release(&refmap);
> +	return result;
> +}
> +
> +static int fill_each_remote(struct remote *remote, void *cbdata)
> +{
> +	struct string_list *remotes = (struct string_list *)cbdata;
> +
> +	string_list_append(remotes, remote->name);
> +	return 0;
> +}
> +
> +static int maintenance_task_prefetch(void)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (for_each_remote(fill_each_remote, &remotes)) {
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
>  static int maintenance_task_gc(void)
>  {
>  	int result;
> @@ -871,6 +929,10 @@ static void initialize_tasks(void)
>  	for (i = 0; i < MAX_NUM_TASKS; i++)
>  		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
>  
> +	tasks[num_tasks]->name = "prefetch";
> +	tasks[num_tasks]->fn = maintenance_task_prefetch;
> +	num_tasks++;
> +
>  	tasks[num_tasks]->name = "gc";
>  	tasks[num_tasks]->fn = maintenance_task_gc;
>  	tasks[num_tasks]->enabled = 1;
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index c09a9eb90b..8b04a04c79 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -44,4 +44,28 @@ test_expect_success 'run --task duplicate' '
>  	test_i18ngrep "cannot be selected multiple times" err
>  '
>  
> +test_expect_success 'run --task=prefetch with no remotes' '
> +	git maintenance run --task=prefetch 2>err &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'prefetch multiple remotes' '
> +	git clone . clone1 &&
> +	git clone . clone2 &&
> +	git remote add remote1 "file://$(pwd)/clone1" &&
> +	git remote add remote2 "file://$(pwd)/clone2" &&
> +	git -C clone1 switch -c one &&
> +	git -C clone2 switch -c two &&
> +	test_commit -C clone1 one &&
> +	test_commit -C clone2 two &&
> +	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch &&
> +	grep ",\"fetch\",\"remote1\"" run-prefetch.txt &&
> +	grep ",\"fetch\",\"remote2\"" run-prefetch.txt &&
> +	test_path_is_missing .git/refs/remotes &&
> +	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
> +	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
> +	git log prefetch/remote1/one &&
> +	git log prefetch/remote2/two
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 

-- 
Danh
