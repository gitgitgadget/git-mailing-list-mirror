Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC6C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C6464ED7
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBINpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhBINnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:43:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF86C061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:42:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j11so3167031wmi.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tIRlEuWT4Gs12QPnjq5cGp0N4UPq8cjlPoSl3qFrJ/I=;
        b=i3GAb5LGkiijESBogZj+3tipneHbWMCxWIHB2uEKIPw+ScWktzgSb4udqJvgfuA/mx
         PXPehLFmUoTFPNyKwbywBYo3RDrsC16TJdx4yzp51QI/9rIsqE9jlXozeS6oeZun5Hfp
         8lQmQl3PH9p8tOy10p5d6h/trk7/SRa+YFqL3K5+d9ZZ7qCpx9ixzWKsZxs81+0G0nYc
         LCurXNg15N6Om+77l7TngAiWCVO6niPtTrLRVXemzNHpOmzUY+gpqJ17V7m/tsrChDBf
         JvQQlEDkBUkO46JPyaHA0zEOQ2FXYM7aDVObtBn2O+do+1FfoVNUpJWMd/bvyXvvV7mv
         KvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tIRlEuWT4Gs12QPnjq5cGp0N4UPq8cjlPoSl3qFrJ/I=;
        b=IcNsV6ThI5trYgw21OAo3izivSpTOTDD6rpINi1+MjtzfO+4A/a1qGNPh6ktlTyToD
         hTOn73N790Mx1vtaoPaXj0BA8adWjc3mI8IsuUAiOtqcyhiaSx2xQDrrfHv3jS8odrCw
         uVigcygSHL03sq4g4ZJeMM28EdNv/UwCP3OJtnlnyPQVK8kCTdFOsrpm3vxaN3pjHk9Y
         zKZDu/X09jfAxKYUGPVkc4PTnKznHWdqjEgAjnxMqqJq57+hbgvzqITUgXpfouJvsmsX
         p4VM/F3WVXC/pzgHtQOB+gbfCaX/HZwExvZGUdF6J6Cer53X0IgRgk682T2RgkmvpgQx
         dRcA==
X-Gm-Message-State: AOAM532iMO4KK5gAe1nEgJosM6w1xOHZLDPsiqOXFt+GrWnF3oTZsn7f
        4ad9sARcSzBAYfLrlIOLS2lhjnKPnh4=
X-Google-Smtp-Source: ABdhPJz09a+cZ1zU4QlT9A38xoKtupr/ep/FVFD+XpNx9UPuFgNUXZ+sjKEnxzGU7cmV04kPPbvhSg==
X-Received: by 2002:a1c:40d4:: with SMTP id n203mr3552836wma.46.1612878151676;
        Tue, 09 Feb 2021 05:42:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j71sm4571360wmj.31.2021.02.09.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:42:30 -0800 (PST)
Message-Id: <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
In-Reply-To: <pull.871.git.1612795943.gitgitgadget@gmail.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 13:42:27 +0000
Subject: [PATCH v2 0/2] Maintenance: add pack-refs task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a new pack-refs task to the maintenance builtin. This
operation already happens within git gc (and hence the gc task) but it is
easy to extract. Packing refs does not delete any data, only collects loose
objects into a combined file. This makes things faster in subtle ways,
especially when a command needs to iterate through refs (especially tags).

Credit for inspiring this goes to Suolong, who asked for this to be added to
Scalar [1]. I've been waiting instead to add it directly to Git and its
background maintenance. Now is the time!

[1] https://github.com/microsoft/scalar/issues/382

I chose to add it to the incremental maintenance strategy at a weekly
cadence. I'm not sure there is significant value to the difference between
weekly and daily. It just seems to me that weekly is often enough. Feel free
to correct me if you have a different opinion.

My hope is that this patch series could be used as an example for further
extracting tasks out of the gc task and making them be full maintenance
tasks. Doing more of these extractions could be a good project for a new
contributor.

One thing that is not implemented in this series is a notion of the behavior
for the pack-refs task during git maintenance run --auto. This could be
added in the future, but I wanted to focus on getting this behavior into the
incremental maintenance schedule.


Updates in V2
=============

 * Fixed doc typo. Thanks, Eric!
 * Updated commit messages to make it clear that the 'pack-refs' step will
   still happen within the 'gc' task.
 * Updated the test to check that we run the correct subcommand.
 * maintenance_task_pack_refs() uses MAYBE_UNUSED on its parameter.

Thanks, -Stolee

Cc: gitster@pobox.com Cc: sluongng@gmail.com Cc: martin.agren@gmail.com Cc:
sunshine@sunshineco.com

Derrick Stolee (2):
  maintenance: add pack-refs task
  maintenance: incremental strategy runs pack-refs weekly

 Documentation/config/maintenance.txt |  5 +++--
 Documentation/git-maintenance.txt    |  6 ++++++
 builtin/gc.c                         | 23 +++++++++++++++++++----
 t/t7900-maintenance.sh               | 26 ++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 6 deletions(-)


base-commit: fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-871%2Fderrickstolee%2Fmaintenance%2Fpack-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-871/derrickstolee/maintenance/pack-refs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/871

Range-diff vs v1:

 1:  33b7a74af4eb ! 1:  bedaeb548b06 maintenance: add pack-refs task
     @@ Commit message
          by terminal prompts to show when a detatched HEAD is pointing to an
          existing tag, so having it be slow causes significant delays for users.
      
     -    Add a new 'pack-refs' maintenance task. This is already a sub-step of
     -    the 'gc' task, but users could run this at other intervals if they are
     -    interested. Also, if users opt-in to the default background maintenance
     -    schedule, then the 'gc' task is disabled.
     +    Add a new 'pack-refs' maintenance task. It runs 'git pack-refs --all
     +    --prune' to move loose refs into a packed form. For now, that is the
     +    packed-refs file, but could adjust to other file formats in the future.
     +
     +    This is the first of several sub-tasks of the 'gc' task that could be
     +    extracted to their own tasks. In this process, we should not change the
     +    behavior of the 'gc' task since that remains the default way to keep
     +    repositories maintained. Creating a new task for one of these sub-tasks
     +    only provides more customization options for those choosing to not use
     +    the 'gc' task. It is certainly possible to have both the 'gc' and
     +    'pack-refs' tasks enabled and run regularly. While they may repeat
     +    effort, they do not conflict in a destructive way.
     +
     +    The 'auto_condition' function pointer is left NULL for now. We could
     +    extend this in the future to have a condition check if pack-refs should
     +    be run during 'git maintenance run --auto'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ Documentation/git-maintenance.txt: incremental-repack::
      +pack-refs::
      +	The `pack-refs` task collects the loose reference files and
      +	collects them into a single file. This speeds up operations that
     -+	need to iterate across many refereences. See linkgit:git-pack-refs[1]
     ++	need to iterate across many references. See linkgit:git-pack-refs[1]
      +	for more information.
      +
       OPTIONS
     @@ builtin/gc.c: static void gc_config(void)
       }
       
      +struct maintenance_run_opts;
     -+static int maintenance_task_pack_refs(struct maintenance_run_opts *opts)
     ++static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
      +{
      +	struct strvec pack_refs_cmd = STRVEC_INIT;
      +	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
     @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
      +	do
      +		git branch -f to-pack/$n HEAD || return 1
      +	done &&
     -+	git maintenance run --task=pack-refs &&
     ++	GIT_TRACE2_EVENT="$(pwd)/pack-refs.txt" \
     ++		git maintenance run --task=pack-refs &&
      +	ls .git/refs/heads/ >after &&
     -+	test_must_be_empty after
     ++	test_must_be_empty after &&
     ++	test_subcommand git pack-refs --all --prune <pack-refs.txt
      +'
      +
       test_expect_success '--auto and --schedule incompatible' '
 2:  8012d2dc1420 = 2:  c38fc9a4170e maintenance: incremental strategy runs pack-refs weekly

-- 
gitgitgadget
