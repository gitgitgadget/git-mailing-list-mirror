Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ADC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiI3Lgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiI3Lfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954C13DD9A
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so6388313wrb.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tR4mV3mihcBhvV+6ZOW3NruCzTQRl98E0ocYKkK6rIQ=;
        b=bozhR0ft5ZsC3gpWFdyCFqPHi2R4BL4Z161MBUfhgLaKLzdKh3EdtTGED+F0yBHMBF
         2hnpRSk8PCihzyECy8GVlGAlllsIRMIPuhTNk3A4j4Js9ru982B4BxQb9NBxziw1uxNr
         acUshtb+RmnJp0KREpbw/V07K7zAiEx3fe4YaE21GhpXtYodl7+8bJucQSoGMf8eUzI3
         vnPOaZG6S6c9f19nKOD25Y3D0I4PlFw7L5OUmwRICLRWzYkRhrXIWYMprlZlLIthGJx3
         BiMw/LlY+tmze3nhDdOkIhoilRLk4GralzWdM7UxtT3j64KoKslB3Yd5u+j1l93wZx66
         r7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tR4mV3mihcBhvV+6ZOW3NruCzTQRl98E0ocYKkK6rIQ=;
        b=TFpUfuLlVAIHIqE3+4v9ppP9KhLe5afx2MEc13JqcMB1KgN8TZuNcu//GIhfUt82MN
         gmtOeFTBuH3bA4+TVeyGPU/hFQlDDTxLLVzWbwPmz1f2hKXsZGbjc/lhe2gwU6HqmgZ/
         Rp1WFeLzDTKjgcr2WNXzd4YRq7mP89bZBU8WrDtH2gntV4pm+99oY7Oqp73dScPBpkbY
         v04td+Ttempqn/XR6OD83oJ1EV/m7Wq1at8i3nOSGMV7Lw5ES5jt4YilTMqYwuIGfKbk
         2+i/iksHkTU9zuoh8li/53zygVzEYxcnVUxR+RD/MpvfGzfsuQlK8bQ3v1JAcwoxGCxw
         BiiQ==
X-Gm-Message-State: ACrzQf0+y91nAM94DUT9Lja6GjhtCmeu9r/F2qrpn24DLtQDiIQHOvBk
        4sR8loQajmU/jdKXrnhrmpQskW/B4ss/4Q==
X-Google-Smtp-Source: AMsMyM7czkZ9/0AplvywvYQdZxCqHPMcePq5TbfcDI/34oT2gCxrvP0q7d3zfSFN94J8WUxrsO3BoQ==
X-Received: by 2002:a05:6000:1688:b0:22a:fba6:77fe with SMTP id y8-20020a056000168800b0022afba677femr5373986wrd.266.1664537304931;
        Fri, 30 Sep 2022 04:28:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/15] run-command API: don't fall back on online_cpus()
Date:   Fri, 30 Sep 2022 13:28:05 +0200
Message-Id: <patch-08.15-4223980f296-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
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
calls that function by itself. By having these callers of the
"run_processes_parallel()" API do the same we can in subsequent
commits pass all arguments down as a "const struct".

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
 run-command.c               | 6 +++---
 submodule-config.c          | 2 ++
 t/t5526-fetch-submodules.sh | 5 +++++
 4 files changed, 12 insertions(+), 3 deletions(-)

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
index 80d282dbdb6..1a604af14fb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1568,8 +1568,8 @@ static void pp_init(struct parallel_processes *pp,
 {
 	unsigned int i;
 
-	if (jobs < 1)
-		jobs = online_cpus();
+	if (!jobs)
+		BUG("you must provide a non-zero number of jobs!");
 
 	pp->max_processes = jobs;
 
@@ -1843,7 +1843,7 @@ void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
 				const char *tr2_category, const char *tr2_label)
 {
 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
-				   ((jobs < 1) ? online_cpus() : jobs));
+				   jobs);
 
 	run_processes_parallel(jobs, get_next_task, start_failure,
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
index e36f9fdf242..98a287ffb90 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -724,6 +724,11 @@ test_expect_success 'fetching submodules respects parallel settings' '
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
 		grep "9 tasks" trace.out &&
 		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.fetchJobs=0 fetch &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
 	)
 '
 
-- 
2.38.0.rc2.935.g6b421ae1592

