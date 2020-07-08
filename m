Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8640C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C8620659
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlk1Cw4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGHX50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHX5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 19:57:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C29C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 16:57:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so111310pgm.11
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qoTwDgBZCWxJTz4I1SYUGCkpe2+y00B5btlMYuLIP5Y=;
        b=Dlk1Cw4LxVy9hcd4YB7dLAfbas+hQwVP6Um3gXlpi/pJZdPOOfzYE1BK4oi2RirYeW
         hhiZhcm+uRLjrlRhrJaUA3WlirtJRgowmb8NeOhdiMbFrgwrXOgJzVzq/JD4mVpuCxBz
         TYKJok7tLSVOrjHc1lsNh8PPlt6Le9e4PozDdSrvrw9UjeTvXBKn7aKxnL0S/WdaaciJ
         3mwIhWB1BzSZwUtDSKkfi3LyBTFjkWIL9jaPLt1J7hwgiutw3JPrcT77OS/inB7Xle+Y
         65YaIEjBKs4hq+0/J+WaXfMiiGyTahCqYtxUi/c4NJdWyv2K5E65KmD+8AWJprHYFWbA
         pDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoTwDgBZCWxJTz4I1SYUGCkpe2+y00B5btlMYuLIP5Y=;
        b=CsAv3nt3UYCrS/eBU3W0JikyKfrYROT4A8DNgSZsgICE8qwa3ZKN5LbtTIgxorKzGJ
         7OMdr+6f/hilRSFJlFXDFlI1hfx+pRkX7dcax/f2G+M2MNt5PBVFc2XyXxE+tSWQBmW+
         kN2OIAXrJVQRbYrl5HUh94RHhHG8/3Or5hQXcht07ab5sCzVIezWljCCiDq1EkrLA2bl
         rzbsDSIhwerZZ9ZY/+O/qeRb3U98b8CURYYLqVYSzioklnKIRu1zvlPh6G2bCCe0t35W
         oci1y2xNbA0m/dDLLoh5jrKCzparA5qhqZcOC7uWzmesC4vn/JYCIG92IdgkPoCSJN0+
         8+2A==
X-Gm-Message-State: AOAM530aea7HcnV4lNtsS5GBZWgsAd+eXScGlGhB7eBnyvi6YEdBELh4
        NyYz69rSj3dhfePfD/MWJE+X0A==
X-Google-Smtp-Source: ABdhPJyOu+CTlk9H4csNBGFfAXfNx1VnvjzNetX5DxDksEH9iv5bCZerJgWm/ZXPnV9dU35/Zf1+Aw==
X-Received: by 2002:a62:8c54:: with SMTP id m81mr51974959pfd.215.1594252644851;
        Wed, 08 Jul 2020 16:57:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id e5sm547225pjv.18.2020.07.08.16.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:57:24 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:57:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
Message-ID: <20200708235719.GA3189386@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 02:21:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> This is a second attempt at redesigning Git's repository maintenance
> patterns. The first attempt [1] included a way to run jobs in the background
> using a long-lived process; that idea was rejected and is not included in
> this series. A future series will use the OS to handle scheduling tasks.
> 
> [1] 
> https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/
> 
> As mentioned before, git gc already plays the role of maintaining Git
> repositories. It has accumulated several smaller pieces in its long history,
> including:
> 
>  1. Repacking all reachable objects into one pack-file (and deleting
>     unreachable objects).
>  2. Packing refs.
>  3. Expiring reflogs.
>  4. Clearing rerere logs.
>  5. Updating the commit-graph file.
> 
> While expiring reflogs, clearing rererelogs, and deleting unreachable
> objects are suitable under the guise of "garbage collection", packing refs
> and updating the commit-graph file are not as obviously fitting. Further,
> these operations are "all or nothing" in that they rewrite almost all
> repository data, which does not perform well at extremely large scales.
> These operations can also be disruptive to foreground Git commands when git
> gc --auto triggers during routine use.
> 
> This series does not intend to change what git gc does, but instead create
> new choices for automatic maintenance activities, of which git gc remains
> the only one enabled by default.
> 
> The new maintenance tasks are:
> 
>  * 'commit-graph' : write and verify a single layer of an incremental
>    commit-graph.
>  * 'loose-objects' : prune packed loose objects, then create a new pack from
>    a batch of loose objects.
>  * 'pack-files' : expire redundant packs from the multi-pack-index, then
>    repack using the multi-pack-index's incremental repack strategy.
>  * 'fetch' : fetch from each remote, storing the refs in 'refs/hidden//'.
> 
> These tasks are all disabled by default, but can be enabled with config
> options or run explicitly using "git maintenance run --task=". There are
> additional config options to allow customizing the conditions for which the
> tasks run during the '--auto' option. ('fetch' will never run with the
> '--auto' option.)
> 
>  Because 'gc' is implemented as a maintenance task, the most dramatic change
> of this series is to convert the 'git gc --auto' calls into 'git maintenance
> run --auto' calls at the end of some Git commands. By default, the only
> change is that 'git gc --auto' will be run below an additional 'git
> maintenance' process.
> 
> The 'git maintenance' builtin has a 'run' subcommand so it can be extended
> later with subcommands that manage background maintenance, such as 'start',
> 'stop', 'pause', or 'schedule'. These are not the subject of this series, as
> it is important to focus on the maintenance activities themselves.
> 
> An expert user could set up scheduled background maintenance themselves with
> the current series. I have the following crontab data set up to run
> maintenance on an hourly basis:
> 
> 0 * * * * git -C /<path-to-repo> maintenance run --no-quiet >>/<path-to-repo>/.git/maintenance.log

One thing I wonder about - now I have to go and make a new crontab
(which is easy) or Task Scheduler task (which is a pain) for every repo,
right?

Is it infeasible to ask for 'git maintenance' to learn something like
'--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
config like "maintenance.targetRepo = /<path-to-repo>"?

> 
> My config includes all tasks except the 'gc' task. The hourly run is
> over-aggressive, but is sufficient for testing. I'll replace it with daily
> when I feel satisfied.
> 
> Hopefully this direction is seen as a positive one. My goal was to add more
> options for expert users, along with the flexibility to create background
> maintenance via the OS in a later series.
> 
> OUTLINE
> =======
> 
> Patches 1-4 remove some references to the_repository in builtin/gc.c before
> we start depending on code in that builtin.
> 
> Patches 5-7 create the 'git maintenance run' builtin and subcommand as a
> simple shim over 'git gc' and replaces calls to 'git gc --auto' from other
> commands.

For me, I'd prefer to see 'git maintenance run' get bigger and 'git gc
--auto' get smaller or disappear. Is there a plan towards that
direction, or is that out of scope for 'git maintenance run'? Similar
examples I can think of include 'git annotate' and 'git pickaxe'.

> 
> Patches 8-15 create new maintenance tasks. These are the same tasks sent in
> the previous RFC.
> 
> Patches 16-21 create more customization through config and perform other
> polish items.
> 
> FUTURE WORK
> ===========
> 
>  * Add 'start', 'stop', and 'schedule' subcommands to initialize the
>    commands run in the background.
>    
>    
>  * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
>    default, but might have different '--auto' conditions and more config
>    options.

Like I mentioned above, for me, I'd rather just see the 'gc' builtin go
away :)

>    
>    
>  * Replace config like 'gc.writeCommitGraph' and 'fetch.writeCommitGraph'
>    with use of the 'commit-graph' task.
>    
>    
> 
> Thanks, -Stolee
> 
> Derrick Stolee (21):
>   gc: use the_repository less often
>   gc: use repository in too_many_loose_objects()
>   gc: use repo config
>   gc: drop the_repository in log location
>   maintenance: create basic maintenance runner
>   maintenance: add --quiet option
>   maintenance: replace run_auto_gc()
>   maintenance: initialize task array and hashmap
>   maintenance: add commit-graph task
>   maintenance: add --task option
>   maintenance: take a lock on the objects directory
>   maintenance: add fetch task
>   maintenance: add loose-objects task
>   maintenance: add pack-files task
>   maintenance: auto-size pack-files batch
>   maintenance: create maintenance.<task>.enabled config
>   maintenance: use pointers to check --auto
>   maintenance: add auto condition for commit-graph task
>   maintenance: create auto condition for loose-objects
>   maintenance: add pack-files auto condition
>   midx: use start_delayed_progress()
> 
>  .gitignore                           |   1 +
>  Documentation/config.txt             |   2 +
>  Documentation/config/maintenance.txt |  32 +
>  Documentation/fetch-options.txt      |   5 +-
>  Documentation/git-clone.txt          |   7 +-
>  Documentation/git-maintenance.txt    | 124 ++++
>  builtin.h                            |   1 +
>  builtin/am.c                         |   2 +-
>  builtin/commit.c                     |   2 +-
>  builtin/fetch.c                      |   6 +-
>  builtin/gc.c                         | 881 +++++++++++++++++++++++++--
>  builtin/merge.c                      |   2 +-
>  builtin/rebase.c                     |   4 +-
>  commit-graph.c                       |   8 +-
>  commit-graph.h                       |   1 +
>  config.c                             |  24 +-
>  config.h                             |   2 +
>  git.c                                |   1 +
>  midx.c                               |  12 +-
>  midx.h                               |   1 +
>  object.h                             |   1 +
>  run-command.c                        |   7 +-
>  run-command.h                        |   2 +-
>  t/t5319-multi-pack-index.sh          |  14 +-
>  t/t5510-fetch.sh                     |   2 +-
>  t/t5514-fetch-multiple.sh            |   2 +-
>  t/t7900-maintenance.sh               | 211 +++++++
>  27 files changed, 1265 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/config/maintenance.txt
>  create mode 100644 Documentation/git-maintenance.txt
>  create mode 100755 t/t7900-maintenance.sh
> 
> 
> base-commit: 4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-671%2Fderrickstolee%2Fmaintenance%2Fgc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-671/derrickstolee/maintenance/gc-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/671
> -- 
> gitgitgadget
