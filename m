Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E1C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0827961040
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhJLNdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbhJLNdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011AC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so80381164edj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aS07F5XXW2YQcc52JWFDy8Wv0Sv3g8l6JlGjWc0BNhs=;
        b=qPpOdJeOKLPETu/N0GafwKZpDBI4w1TReRrLT6A0PLTHeND9ziPOVLQFkPLh5Tg9PG
         TPtqJ/Zrh7ucJBnG7iyt5KBsNbwoPASt8czW8q9yKNe9QhNXL8kbAIZWNjztqwi7w15a
         A51GAh1spSVWBs0ZnT2j0wFxp5zakHfQcS+bF7hFfLsbGXKQasXsQ1SiVgP4eCjrJq/W
         4G1nhbyJHs+HiwxqlBJkQ8tEXgzPqPw/RAh1CBVTQ2rBJEzjGETyP0MajX+ntASO8bvF
         IGENW/T1Gx6S3TCPX1JS+UaDO5xTv12hK6Il/7OL+3d4vevUN5RJ/pzB1aNjtgGTve88
         aM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aS07F5XXW2YQcc52JWFDy8Wv0Sv3g8l6JlGjWc0BNhs=;
        b=g5JqDpllXG8pwkxpTmQ78CIBjHdBouL53wg/UTiIcN+hTfKCwxBdYk7kvXRlFWCHZv
         xL4eNmXtohgYXak3n6vBtJq3b5ajCDzQXesFoaNb1MdoGmr/odvo2bfaJl3dz4Gi3KSH
         of93wJlzCtKovYkkg+4XqNZ6FC98n/CJwmtKxUaqbmo4HDA2vfB3PgCDsZIZx2Krd3d1
         xhacmDat3qKBc1FI9DouCGRjRpmTPph0In1A1vqxCIQN3mTXWJhESy5OVPCwzXobCcWV
         K6ozZTFd97Q3gYofEQPLeV/bL1uquj8zOKlRj1CxWFHXZHAArM9+y9K1hkDOpyDeqlOL
         16EQ==
X-Gm-Message-State: AOAM5320bd8K4hIybA9ssJ8A7HKatsVSxFTEYtwLRyoeoI9bPM3hT4+H
        YC8iG+9aIsN3LA9aFmZzWxMVx2uORxOLYw==
X-Google-Smtp-Source: ABdhPJxrhLQruwY3tQY4eZUN2ZA5ywLoCYL3n4LL64LNv999CDknqStkI8NI5NgAiwKrb1gYtQXJHQ==
X-Received: by 2002:a50:c006:: with SMTP id r6mr51978692edb.289.1634045467749;
        Tue, 12 Oct 2021 06:31:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/13] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Tue, 12 Oct 2021 15:30:35 +0200
Message-Id: <patch-10.13-1c22b2992cf-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
2.33.0.1567.g7b23ce7ed9e

