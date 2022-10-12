Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA74EC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJLVED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJLVDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF01ADA3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b4so27972203wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isce64CBtmUTAta7eZ83mkGxGAFgMqp1/1yVHncBawI=;
        b=ZRKdNHBypH5MivIWGtcILgxcFK/lhHF65WbW9p2dDJ6CcpIWI9rLtVG7nsroN/ULyw
         x7Q7uo/6HlP+pgCyDFdCAKkiwhnxrV/SMnhSj6UkDGMCVfgGKDNWWTTmfO1pkPB6/8nG
         Ynngp9Ek5vHRspfGUkrlpxO7o5ejWGhY+Nd69bFS9S1gudR0ISpOKQlpbTUuFAsi3F/Z
         uBOK8495CsjLfMGVOW+cpN2gCeyG6UcmXnwvItPPNB76TTOveAAnxPbY7mqZmWUOI8tz
         H+uejGz1v9hjE3GkNsNWfQBvjq9qWX2yOgPbebLkRIG8XDOnPPMlMDiaJK/afEQ76aRt
         j00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isce64CBtmUTAta7eZ83mkGxGAFgMqp1/1yVHncBawI=;
        b=XT2LnCdj0sRFkpcG14Abdtj+VfmIvrFUAtHtQ7VIlY7xVU1evI54kGf0YoohJRnEIa
         5PaNS4O3yN6opHXn1C3VBtml2vuXOPROzwFHIa8wGCISPnUGnSW+XSQ5TwebYTY1CYI0
         Gg4JP2tbpuL58nLaVw0wSjvODDMraxvBEioo3WFiX3lcmWk9v6ZOPjHOF4lOfF62qYWn
         dzynDnzj7PV9ytZqPUvPHpokM6Z5Kdgi7n2WRZtE/fQwtj9x9jFkwGvgw4KOOxJS34FO
         MZyBxqxpCu+oLwWggJfRRL0ZJv4+SyeBdCHcHl6HV31F4XQrLG4N80ra4s9I7cLwdf4S
         ejUg==
X-Gm-Message-State: ACrzQf2jxc9d8LefzXS8s4UwTR/vwGvWKx6EvHcfEGD5SuNqzHoOdSgg
        36POUGrlbQJQo9U+Bj5DE9HSBHw+FIujlw==
X-Google-Smtp-Source: AMsMyM64yVkzI7nIH95f2BnqKTEUrPCz/VFjn0rtApHoEKJDc7LuGlHH/ZziV/ufuXUfQNZ7bpX4sQ==
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id a11-20020a5d456b000000b002309e5bc64cmr10757241wrc.211.1665608607369;
        Wed, 12 Oct 2022 14:03:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/15] run-command API: don't fall back on online_cpus()
Date:   Wed, 12 Oct 2022 23:02:24 +0200
Message-Id: <patch-v3-05.15-e230701dff6-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a "jobs = 0" is passed let's BUG() out rather than fall back on
online_cpus(). The default behavior was added when this API was
implemented in c553c72eed6 (run-command: add an asynchronous parallel
child processor, 2015-12-15).

Most of our code in-tree that scales up to "online_cpus()" by default
calls that function by itself. Keeping this default behavior just for
the sake of two callers means that we'd need to maintain this one spot
where we're second-guessing the config passed down into pp_init().

The preceding commit has an overview of the API callers that passed
"jobs = 0". There were only two of them (actually three, but they
resolved to these two config parsing codepaths).

The "fetch.parallel" caller already had a test for the
"fetch.parallel=0" case added in 0353c688189 (fetch: do not run a
redundant fetch from submodule, 2022-05-16), but there was no such
test for "submodule.fetchJobs". Let's add one here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             | 2 ++
 run-command.c               | 7 +++----
 submodule-config.c          | 2 ++
 t/t5526-fetch-submodules.sh | 8 +++++++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 78043fb67ef..82f1da14ec1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -122,6 +122,8 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		fetch_parallel_config = git_config_int(k, v);
 		if (fetch_parallel_config < 0)
 			die(_("fetch.parallel cannot be negative"));
+		if (!fetch_parallel_config)
+			fetch_parallel_config = online_cpus();
 		return 0;
 	}
 
diff --git a/run-command.c b/run-command.c
index 14a6e38e804..14ea409375a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1564,8 +1564,8 @@ static void pp_init(struct parallel_processes *pp,
 		    task_finished_fn task_finished,
 		    void *data, int ungroup)
 {
-	if (n < 1)
-		n = online_cpus();
+	if (!n)
+		BUG("you must provide a non-zero number of processes!");
 
 	pp->max_processes = n;
 
@@ -1835,8 +1835,7 @@ void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
 				task_finished_fn task_finished, void *pp_cb,
 				const char *tr2_category, const char *tr2_label)
 {
-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
-				   ((n < 1) ? online_cpus() : n));
+	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
 
 	run_processes_parallel(n, get_next_task, start_failure,
 			       task_finished, pp_cb);
diff --git a/submodule-config.c b/submodule-config.c
index cd7ee236a12..4dc61b3a78a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -303,6 +303,8 @@ int parse_submodule_fetchjobs(const char *var, const char *value)
 	int fetchjobs = git_config_int(var, value);
 	if (fetchjobs < 0)
 		die(_("negative values not allowed for submodule.fetchJobs"));
+	if (!fetchjobs)
+		fetchjobs = online_cpus();
 	return fetchjobs;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a301b56db89..a5f494dfcfb 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -714,7 +714,13 @@ test_expect_success 'fetching submodules respects parallel settings' '
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "8 tasks" trace.out &&
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
-		grep "9 tasks" trace.out
+		grep "9 tasks" trace.out &&
+		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.fetchJobs=0 fetch &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
 	)
 '
 
-- 
2.38.0.971.ge79ff6d20e7

