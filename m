Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADEC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045F260EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhHCTj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbhHCTjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22187C06179C
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b13so15628119wrs.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kw9QymIyq3vNdbRanlCbxxy13lTRBwg6cTFmzSwMEzE=;
        b=IYoBULyYQXe0Ast9oHQt9CWea6B/2VMC8ibLP+DnLQeLvMu3zq2fjNAuapdh7s4EKm
         azNN5jbirvbEo1CsrQDGnV6S2qaXDEU8BDJyVI+vNvGwdVaVziBRVbb3am1DKpWJMIyD
         CFIXq5wL/1Tu46I8596pDGdH2kiQlwlmpxETRDflYGW1ulm5y9AQyrJ5oOMX5LcLFbed
         2BLSLqfzAn4r8ZJC38xTkpYTYkyJcnvfzChcYMnz6C7FqoGiaVpGfSviktArqsCyi7C5
         eQJNb5HmX3BxryXwyVJbQa7jLTrFG8CfHZ3ToeHH4EgVQq1/Llc+Eh5OyPu3wwpul6gY
         UnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kw9QymIyq3vNdbRanlCbxxy13lTRBwg6cTFmzSwMEzE=;
        b=EocDLWIMWaC5/c8fPRjf1TrFSZuARlka9WRKH34ACnfTOceu7me0Dxx0VIfK3Tjffw
         oxSKLuPHFrNIgemes+03dQDrABRmGCdPEDk3ZvWyfngGBHYvq+Bz7R4ZiMLMoywH6Mt4
         FEe3GgM4jFCjce9MgWjPydj84RiQWyXAMj7ihxkVfvN869PpwH9bIi44KggRzr0vhune
         rN4qtpqwGKR0Yr3DRoaNDVF8isb35XliqPn5GHujDuVPLeBhZGHEl8vRjlBwvcQiQizh
         aGt2sSfu18l0iU+5+kB5Ymt9mH9G3nC40ofQmUVzmITbnZO6O/jlcMzPQtrA/Ex4rNjz
         3QYA==
X-Gm-Message-State: AOAM530q75qLAqDcDtgcQ4cXBrtqW3EizvZs1mKqO0Nlkc0yt5pO5LPB
        zzbB+J++3/OeOn6ZzORSQ9Bp/E+nA1FR8Q==
X-Google-Smtp-Source: ABdhPJwS1kGwsCMjZ4yNycSe2YG7wlVACtQQMrI/Wvl5rgfNWTpEWiJt8thM9RO7+j83Nnzx0E/elg==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr14136273wrn.308.1628019568473;
        Tue, 03 Aug 2021 12:39:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:28 -0700 (PDT)
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
Subject: [PATCH v4 18/36] read-cache: convert post-index-change to use hook.h
Date:   Tue,  3 Aug 2021 21:38:44 +0200
Message-Id: <patch-v4-18.36-3d3a33e2674-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index c9e2b013972..90099ca14df 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3068,6 +3068,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate);
 
@@ -3096,9 +3097,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
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
2.33.0.rc0.595.ge31e012651d

