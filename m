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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6283C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCB7206B6
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv3/zSpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgETTI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 15:08:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024CC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:08:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n15so1790703pjt.4
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=oS5wrQQrHVs2XMViuvCNmmxfLkSKi1xCnKxXc9TuSAs=;
        b=dv3/zSpk+bNJsL+R/J539d87uRgksO4XzGlfFs5sl9ZaEPJvZ9o8MrRyLcA5d0EtVH
         KX8FeacHPwXSyWqbeNdKwEmpA/Rh6bxGWl/IPuG7SmNV7txHnqlq5wr3sltgO2u3pgjF
         G94XVUl6/VqYtytSRtQq9cuMkfPuNvlN1x/+6039ilq0lGjA/hTagaSI8anch7NTQWSB
         sSfZwIwNFwlpflzOrINMCBVn2sbLB94JZUXMf/4Zw5UXr63sXJvg6PzANFU2U9RnC5bu
         cOCw2Ohj7jVBcWu8mMk8Y2HHBZF/OqnPWdlzskXTOKG5fA4UYs8XOoxm4eq3Ro/qjGav
         xryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=oS5wrQQrHVs2XMViuvCNmmxfLkSKi1xCnKxXc9TuSAs=;
        b=GPwnnSA3CpfkLk5eJ+7GybQmq0iBwgGnBaF3CdBSxQ92+oYvsNwtpAZ8YPNfqSUrRb
         8QwhvwFFbjLAwvfBvz8aB4MJzDIH/4AmKIxJn3J9Co3nrEn9kFjYfufxFog1POgWgbTg
         tL+9l4k/tAgIfw2NhTggREyTSuv/MwvUGp9dZnuej40onfEMaNoatleLUwbmOe1MFJxc
         2q9gq/i4FeSHBIhe/ugFT9fucR8Fm5gnPc+QkW3+TF2Id8+IwyozT/fnYhDYA60PLxOq
         KgCzrc8w3gHW0mLUWbDWeszw2S2t3K1iuh5m3yHOdbNTn0X2R5r/xc5dudzNCSdrF5Pn
         pAtQ==
X-Gm-Message-State: AOAM532++nJI4YgSkEUyS7LaIqimvxQA6EQkUt1BXbm8ah96Kj7dnFAD
        8DMO1u4FMDwA613Otg0W8TkbkmTkAfk=
X-Google-Smtp-Source: ABdhPJyJvFqgHoTaJ5SyS9/eToklYJHQRwrqcJMIFO9SKQQb5Fs7c9ppFPURhzGbxybCsw/pN/kf0Q==
X-Received: by 2002:a17:902:744b:: with SMTP id e11mr5914480plt.239.1590001706095;
        Wed, 20 May 2020 12:08:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id m4sm2637752pfm.26.2020.05.20.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:08:25 -0700 (PDT)
Date:   Wed, 20 May 2020 12:08:20 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] run-job: implement commit-graph job
Message-ID: <20200520190820.GB163566@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <cd3facd1e03923204bd2259ff0635a5bbf68d700.1585946894.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3facd1e03923204bd2259ff0635a5bbf68d700.1585946894.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for this series, and sorry for the delayed (and partial) review.
I hope comments here are still useful. I don't have any comments on the
larger design that other people haven't already made, but I do have a
few small questions and suggestions, inline below.


On 2020.04.03 20:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The first job to implement in the 'git run-job' command is the
> 'commit-graph' job. It is based on the sequence of events in the
> 'commit-graph' job in Scalar [1]. This sequence is as follows:
> 
> 1. git commit-graph write --reachable --split
> 2. git commit-graph verify --shallow
> 3. If the verify succeeds, stop.
> 4. Delete the commit-graph-chain file.
> 5. git commit-graph write --reachable --split
> 
> By writing an incremental commit-graph file using the "--split"
> option we minimize the disruption from this operation. The default
> behavior is to merge layers until the new "top" layer is less than
> half the size of the layer below. This provides quick writes "most"
> of the time, with the longer writes following a power law
> distribution.
> 
> Most importantly, concurrent Git processes only look at the
> commit-graph-chain file for a very short amount of time, so they
> will verly likely not be holding a handle to the file when we try
> to replace it. (This only matters on Windows.)
> 
> If a concurrent process reads the old commit-graph-chain file, but
> our job expires some of the .graph files before they can be read,
> then those processes will see a warning message (but not fail).
> This could be avoided by a future update to use the --expire-time
> argument when writing the commit-graph.
> 
> By using 'git commit-graph verify --shallow' we can ensure that
> the file we just wrote is valid. This is an extra safety precaution
> that is faster than our 'write' subcommand. In the rare situation
> that the newest layer of the commit-graph is corrupt, we can "fix"
> the corruption by deleting the commit-graph-chain file and rewrite
> the full commit-graph as a new one-layer commit graph. This does
> not completely prevent _that_ file from being corrupt, but it does
> recompute the commit-graph by parsing commits from the object
> database. In our use of this step in Scalar and VFS for Git, we
> have only seen this issue arise because our microsoft/git fork
> reverted 43d3561 ("commit-graph write: don't die if the existing
> graph is corrupt" 2019-03-25) for a while to keep commit-graph
> writes very fast. We dropped the revert when updating to v2.23.0.
> The verify still has potential for catching corrupt data across
> the layer boundary: if the new file has commit X with parent Y
> in an old file but the commit ID for Y in the old file had a
> bitswap, then we will notice that in the 'verify' command.
> 
> [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/CommitGraphStep.cs
> 
> RFC QUESTIONS:
> 
> 1. Are links like [1] helpful?

Yes, I appreciate being able to reference these. However, given that
these will show up in commit logs for ~forever, and ongoing work might
happen on Scalar, perhaps the links should be pinned to a specific
revision?


> 
> 2. Can anyone think of a way to test the rewrite fallback?
>    It requires corrupting the latest file between two steps of
>    this one command, so that is a tricky spot to inject a fault.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-run-job.txt | 21 ++++++++++--
>  builtin/run-job.c             | 60 ++++++++++++++++++++++++++++++++++-
>  commit-graph.c                |  2 +-
>  commit-graph.h                |  1 +
>  t/t7900-run-job.sh            | 32 +++++++++++++++++++
>  5 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> index 0627b3ed259..8bf2762d650 100644
> --- a/Documentation/git-run-job.txt
> +++ b/Documentation/git-run-job.txt
> @@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
>  SYNOPSIS
>  --------
>  [verse]
> -'git run-job <job-name>'
> +'git run-job commit-graph'
>  
>  
>  DESCRIPTION
> @@ -28,7 +28,24 @@ BEHAVIOR MAY BE ALTERED IN THE FUTURE.
>  JOBS
>  ----
>  
> -TBD
> +'commit-graph'::
> +
> +The `commit-graph` job updates the `commit-graph` files incrementally,
> +then verifies that the written data is correct. If the new layer has an
> +issue, then the chain file is removed and the `commit-graph` is
> +rewritten from scratch.
> ++
> +The verification only checks the top layer of the `commit-graph` chain.
> +If the incremental write merged the new commits with at least one
> +existing layer, then there is potential for on-disk corruption being
> +carried forward into the new file. This will be noticed and the new
> +commit-graph file will be clean as Git reparses the commit data from
> +the object database.
> ++
> +The incremental write is safe to run alongside concurrent Git processes
> +since it will not expire `.graph` files that were in the previous
> +`commit-graph-chain` file. They will be deleted by a later run based on
> +the expiration delay.
>  
>  
>  GIT
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> index 2c78d053aa4..dd7709952d3 100644
> --- a/builtin/run-job.c
> +++ b/builtin/run-job.c
> @@ -1,12 +1,65 @@
>  #include "builtin.h"
>  #include "config.h"
> +#include "commit-graph.h"
> +#include "object-store.h"
>  #include "parse-options.h"
> +#include "repository.h"
> +#include "run-command.h"
>  
>  static char const * const builtin_run_job_usage[] = {
> -	N_("git run-job"),
> +	N_("git run-job commit-graph"),
>  	NULL
>  };
>  
> +static int run_write_commit_graph(void)
> +{
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&cmd, "commit-graph", "write",
> +			 "--split", "--reachable", "--no-progress",
> +			 NULL);
> +
> +	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +}
> +
> +static int run_verify_commit_graph(void)
> +{
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&cmd, "commit-graph", "verify",
> +			 "--shallow", "--no-progress", NULL);
> +
> +	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +}
> +
> +static int run_commit_graph_job(void)
> +{
> +	char *chain_path;
> +
> +	if (run_write_commit_graph()) {
> +		error(_("failed to write commit-graph"));
> +		return 1;
> +	}
> +
> +	if (!run_verify_commit_graph())
> +		return 0;
> +
> +	warning(_("commit-graph verify caught error, rewriting"));
> +
> +	chain_path = get_chain_filename(the_repository->objects->odb);

Should we avoid new uses of `the_repository` and take a repo pointer
argument here instead?


> +	if (unlink(chain_path)) {
> +		UNLEAK(chain_path);
> +		die(_("failed to remove commit-graph at %s"), chain_path);
> +	}
> +	free(chain_path);
> +
> +	if (!run_write_commit_graph())
> +		return 0;

Is there a reason why we don't verify the second write attempt?


> +
> +	error(_("failed to rewrite commit-graph"));
> +	return 1;
> +}
> +
>  int cmd_run_job(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_run_job_options[] = {
> @@ -23,6 +76,11 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
>  			     builtin_run_job_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
>  
> +	if (argc > 0) {
> +		if (!strcmp(argv[0], "commit-graph"))
> +			return run_commit_graph_job();
> +	}
> +
>  	usage_with_options(builtin_run_job_usage,
>  			   builtin_run_job_options);
>  }
> diff --git a/commit-graph.c b/commit-graph.c
> index f013a84e294..6867f92d04a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -56,7 +56,7 @@ static char *get_split_graph_filename(struct object_directory *odb,
>  		       oid_hex);
>  }
>  
> -static char *get_chain_filename(struct object_directory *odb)
> +char *get_chain_filename(struct object_directory *odb)
>  {
>  	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
>  }
> diff --git a/commit-graph.h b/commit-graph.h
> index e87a6f63600..8b7bd5a6cb1 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -13,6 +13,7 @@
>  struct commit;
>  
>  char *get_commit_graph_filename(struct object_directory *odb);
> +char *get_chain_filename(struct object_directory *odb);
>  int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
>  
>  /*
> diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
> index 1eac80b7ed3..18b9bd26b3a 100755
> --- a/t/t7900-run-job.sh
> +++ b/t/t7900-run-job.sh
> @@ -5,6 +5,8 @@ test_description='git run-job
>  Testing the background jobs, in the foreground
>  '
>  
> +GIT_TEST_COMMIT_GRAPH=0
> +
>  . ./test-lib.sh
>  
>  test_expect_success 'help text' '
> @@ -12,4 +14,34 @@ test_expect_success 'help text' '
>  	test_i18ngrep "usage: git run-job" err
>  '
>  
> +test_expect_success 'commit-graph job' '
> +	git init server &&
> +	(
> +		cd server &&
> +		chain=.git/objects/info/commit-graphs/commit-graph-chain &&
> +		git checkout -b master &&
> +		for i in $(test_seq 1 15)
> +		do
> +			test_commit $i || return 1
> +		done &&
> +		git run-job commit-graph 2>../err &&
> +		test_must_be_empty ../err &&
> +		test_line_count = 1 $chain &&
> +		for i in $(test_seq 16 19)
> +		do
> +			test_commit $i || return 1
> +		done &&
> +		git run-job commit-graph 2>../err &&
> +		test_must_be_empty ../err &&
> +		test_line_count = 2 $chain &&
> +		for i in $(test_seq 20 23)
> +		do
> +			test_commit $i || return 1
> +		done &&
> +		git run-job commit-graph 2>../err &&
> +		test_must_be_empty ../err &&
> +		test_line_count = 1 $chain
> +	)
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
