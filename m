Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA985C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJLJCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJLJCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342C8C03A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso810005wma.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nes6Yql5QJWPT21WdhN3guFCtnHvRqAOJfIre0tEVmc=;
        b=nNtgpet70QKyUs/qyWMse98BNY/eR4u7sxC+1oQ1c7ywBUU4KqajN1syHe1p+1SiEh
         QQIPJLVeqskYTK6HrlGBU/UDuDrEBdUkfxBUtMfXbR7YKChMtvNTKTR1mIEwGFnafI1v
         QihnazeTt7xuoWK6a/cfJ+VIKqoBXH6Yb8c3WIWdqx+iAganbCBV+Rlyycricc8Wp/aF
         UjhJg4a1uCAje7i77mvXOQDcAT9AdIOH2b4m3e5V+KYlBR/PMbIsLREMtwTqdBbSBzwf
         C27F/0JTNaGfFhws0IGQDrBDn2iBhgDv3dkTe2Y5QJtpYCNtJZ5Nd+YwAxPFGRXtzNBe
         Wkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nes6Yql5QJWPT21WdhN3guFCtnHvRqAOJfIre0tEVmc=;
        b=OCY+/x92FG30pVETRt3pZ75X2cJ5734T01GSv6uN1NV6IFjnpQFUbJ0cTEqRZdRiSP
         g43qiTDrZRRSzh1ReO8jgTiFf9C87OvnwHO/VBhkGtCb9M6mjKbOpdhVsgreSBcbGNcF
         vEe+S/1EA8BCGZgBSV+DB6Uj4Oohvky+CJElon/CGJDBL0C7HT7ZirZzsalf+JCTvYCF
         wIzzJ/QsfGWCh3g+2DjW6hEURJS9wV89RzYoLciGStM8Ez7JsRFATuwcWbC6KV4GRNNv
         U7udThjqhMvprj7G2yV3JjmlegOLFCdQICAq1xSHcn44jo5H3GU6fixkhDN6NIDbKKDz
         yHJQ==
X-Gm-Message-State: ACrzQf1bR9/09DHvtks8D+Pfxl3zwPN09/cnHT5BuNpjzlKjS845aURX
        flVomU6X99YihW/u5qLINUAs7o2MSgeg7A==
X-Google-Smtp-Source: AMsMyM7CyJw9usu7TItB+ZmWWuiZWrWbFiy0spCuXdzrWpd15cIZzZv1L3lsa30Jr4ZHdmTm+TqeRA==
X-Received: by 2002:a1c:f30d:0:b0:3c3:7c80:67f4 with SMTP id q13-20020a1cf30d000000b003c37c8067f4mr1987501wmq.86.1665565309309;
        Wed, 12 Oct 2022 02:01:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/22] run-command API: don't fall back on online_cpus()
Date:   Wed, 12 Oct 2022 11:01:18 +0200
Message-Id: <patch-v2-10.22-eb9d672b0d8-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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
 run-command.c               | 7 +++----
 submodule-config.c          | 2 ++
 t/t5526-fetch-submodules.sh | 5 +++++
 4 files changed, 12 insertions(+), 4 deletions(-)

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
index 5a63008b6e1..21c00a48823 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1562,8 +1562,8 @@ static void pp_init(struct parallel_processes *pp,
 		    task_finished_fn task_finished,
 		    void *data, int ungroup)
 {
-	if (n < 1)
-		n = online_cpus();
+	if (!n)
+		BUG("you must provide a non-zero number of processes!");
 
 	pp->max_processes = n;
 
@@ -1831,8 +1831,7 @@ void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
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
2.38.0.971.ge79ff6d20e7

