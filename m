Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03340C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28F5610D2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbhIBNNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbhIBNNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECDC0612A9
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g18so2840299wrc.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBLvehO8O+oegJdV/7voBg3ClvqSb4B5JkMTiDKXPNU=;
        b=crzgBJQmbgSB2dQj0AinkC50Oo1OZKsvhsfGYnhzH2ZyHWaAT0zRCEnFKAZmkeX4CD
         HbS7Y0p0DFLpdF0SqsfMpZ/Fk8/UD0dzVWbWirK78++zBX7tAPCIqkPKnPDd+wvq1Ob7
         vNnMcO0oMA6uvk50jJ8OopGZ+EU33j3hXWtfCSn8pueZscr5ercMoH00/qoNxbttV7a9
         ad+TioOUxs4k1zsI9mQ1g23ZEHBJ5H2ePGgZP4hkwbXfINSXucBlvvh4MWIb6SwBhGUN
         c74r62w2my2GlC3VmFmFwN+3vt7lpoPhBrEXbP6th8PjvnSl0uwNTzccqWBkFAOqdqZd
         yfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBLvehO8O+oegJdV/7voBg3ClvqSb4B5JkMTiDKXPNU=;
        b=DajEXuZNKnpcAP07I3mT7/Q+uSsL0r1FWh1D0v6glJ5cxx0dCvVEthYZ/i6PhkIYLk
         UjVAq90eNKTkaY0/u9AABKmzrQR6JzBVY9ruYy69XbaTL83eT+wRNyr++nyhiUsOu8Pc
         GBqB8v5eYYwZIqecidcDEOHTZZ0VNNpVcj0FpZZmU6vjQZVJlAxW+m3RFb/8OSk3yizN
         Vgkmdx6PWCTfMwnIDfH/lggQs0R3A1HuHoV9ZaBKBLF1lvIPKc+N5PotlOdxTeDO5sP1
         pA/iuMzUmMYa2vKstFL73HTAdH1PlDUtKuhycbgCqTtF/ry9zTPfeMqpwanTUovL5L6r
         C74A==
X-Gm-Message-State: AOAM533ix3v8CzZ0yYtGvpkXSZd/1qAt7ZGHLjJX/VttbJq57acEEfPA
        Dvqbsc5pbl2znvABjBV9+/1CUR/mJZaZPQ==
X-Google-Smtp-Source: ABdhPJySv68fct8YAdKDz/FqDf0KfacIYWMLsK840YyfEJs91TOeRDS0EL9UUjY4DWHbtuiVTaQ/7Q==
X-Received: by 2002:a5d:456b:: with SMTP id a11mr3674555wrc.291.1630588321476;
        Thu, 02 Sep 2021 06:12:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/36] read-cache: convert post-index-change to use hook.h
Date:   Thu,  2 Sep 2021 15:11:18 +0200
Message-Id: <patch-v5-18.36-e2c94d95427-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_ve(), so we can make the
function static now. It'll be removed entirely soon.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 10 +++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7a9ffea0885..875f6c1dea5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3069,6 +3069,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate);
 
@@ -3097,9 +3098,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks_oneshot("post-index-change", &hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/run-command.c b/run-command.c
index 352f5be1646..b4341ba1c7b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1320,7 +1320,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index f76b740f927..7a867d41217 100644
--- a/run-command.h
+++ b/run-command.h
@@ -219,7 +219,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.33.0.816.g1ba32acadee

