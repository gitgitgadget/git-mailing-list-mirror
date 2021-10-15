Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F75C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082BD60EDF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhJOJqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhJOJqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B075C061753
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so25483132wrc.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/U+BFDW9z5vUtc6ShiHg2+qWUKxNYZGW8R5GfgLyWE=;
        b=Idxm1Lg0bVZHjrENTyqjovedjMLQdcaDFZptwRThf/Cgz+uM9eBNYaLFRp2bZ6RseG
         l7WODTlOpZfIO5Ss/w/JkUU4B4vizbB01VmP55iy7C6G6ppIbAn870Evi0A2hlTg/zJR
         aneG+1JQCqLDPGL/KblcGBFCoLgQmj56RiJ3BqFYFTBIEx9M5JNI2EJURwrMfp2qaPd4
         MTDO30vc9DbH/zG7lCRQnNs6vt5ycPcI2B3wt7t7cKNMPbt5IM7+NF1PLYl/wFdg7waM
         a19hwvCOrASvzaWSOKSyM6O9Gn6Mx25kDxuCTjbUvX+tb5S4EMtpbyurvVysCOeQxNeF
         tlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/U+BFDW9z5vUtc6ShiHg2+qWUKxNYZGW8R5GfgLyWE=;
        b=AGB26SHhza+RLKLrEYyWAbDTFB5Pc2T15SwU+ljPEp0gZzdu5MH2o/xa83x3vGuxsK
         k1VnV5lJWuoY5OGWrs1i5ZQLJyRH3OTwstjiGNSBXq56GaqtdaUTAEpbUHv10HUBi/QD
         ptZN3BPMdF3Qa8DsKOHmBBx8a8u2x0qJlGu/JkW7DZ2MzHGbSKTbfzzbKM3irlEZfjYY
         KRCJQylGXOpsVb5eQAD1f+S0BjMhoY94AUXeUutl1PFn3eudwvo10rzlfAl9Hl2OsFbB
         B/s88mcHq/GETsrxnogukpdVbTXRfq6eBfLJZfjOe26/euRwURiAJyHkWc2UTn7WdJb+
         DsbQ==
X-Gm-Message-State: AOAM531LTKinK9z7rH1NQN6nYLAvLJpy7ktSOoENQDz3cSNZo78QeRf8
        ZhTGHQ7XYJWeoUP7eNcsL3XsgF+xSfei3g==
X-Google-Smtp-Source: ABdhPJz/St/h8sLa94h29KBp89BZaBT+RU7F+DXp//Yqkv5dmG3n1fLQ7FjVmboCt10OqJtzLkDIWg==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr13334169wrg.327.1634291033585;
        Fri, 15 Oct 2021 02:43:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/13] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Fri, 15 Oct 2021 11:43:38 +0200
Message-Id: <patch-v2-10.13-dc31d98acdf-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
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
index 551de4903c1..4e7cbd7585d 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1700,22 +1701,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
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
2.33.1.1338.g20da966911a

