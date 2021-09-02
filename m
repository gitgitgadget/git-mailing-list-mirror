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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47774C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1D16108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbhIBNNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbhIBNND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D987C0612A7
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b10so2915216wru.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xo+rXtd5NZVQ5e01Rdl5+TrwkeWvb51b+GFIkIRqKBo=;
        b=Ar33kEKW5yj+d2sIl7QvcBqzGmz7tQfbzCz7RWM5kjmQ/zNaj0EynYWvZQy+A+Re9C
         ZPfUzfWC2yswXSz3S/a7XNWCVxnfJn7mOyBmd2q8efGK3zq/ATgU9xzFR8fIfI2bFlEL
         yKjLB1anguBT8bWtkbBaoi9wcGUIJWqiOzFH7Ow3/FvBB3QxnTVwEeyqJF3YghLdcgbF
         d6cmaT6HerObIrLU0D6l9m5SUEqxNLatJNw1ZIcMoYdWAJqYOBk9sLWJhtgmhHTIikcK
         rw6QTVDYMngTpRnxGtiBKVwfGRiMpcOiAjcBOSnPFSd3cotwKmqdA1BwfahMYpYswK4s
         C+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xo+rXtd5NZVQ5e01Rdl5+TrwkeWvb51b+GFIkIRqKBo=;
        b=Dd5ed/GEIQGZfSVNk1YsW7tFXt2Hoh8uPF6+i1XvVhZJvfnakJ4/CA3cCuFDPVGEy1
         rj4IpGU9skR0OdBb10Ue8BaOV0UWO0J/iLw2aAUIWsBBpTBuIkWyF5PgyJ1+UPwkelXh
         qdAnrpPy/a8r3r46XyUfBBNMs3MEr9N2NiK18SrCms+WVvz5E5mo5/y7irq59tbz/gJT
         Z/GrlcSkJ6UfKSQUsGb0kKznAlMuOMWZT00Pr3PpZ8nmF5zLwS6uDrstOuci6CZ8Q16S
         LYMGNbnq34BDQ54CApOEAb2hJU6QwoMDzdqyhfxHqL7El+l/4sw0jjUgbIyC7Kedsst6
         todw==
X-Gm-Message-State: AOAM530DE/hEk3ONzCsH78YSeGfKXiNNoKPy/iZBK0tYAAgE4peDk80I
        HwQ5zECIhrt7of+pUgnmnpLuX9HYH8aAQg==
X-Google-Smtp-Source: ABdhPJzDVbZSnhhAzLLXzull2Vm995SPNmjshJ7/CpPMoB+/v2QjaE6pKbv+EVbkrnVXXmjHEODNhQ==
X-Received: by 2002:adf:804a:: with SMTP id 68mr3692580wrk.236.1630588320483;
        Thu, 02 Sep 2021 06:12:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.59
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
Subject: [PATCH v5 17/36] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Thu,  2 Sep 2021 15:11:17 +0200
Message-Id: <patch-v5-17.36-509761454e6-20210902T125110Z-avarab@gmail.com>
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

Move these hooks hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 143f472c0f2..63d7943a86d 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1698,22 +1699,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
-	int ret;
+	const char *arg;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
 
-	return ret;
+	return run_hooks_oneshot(name, &opt);
 }
-- 
2.33.0.816.g1ba32acadee

