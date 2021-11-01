Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDEC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1722560EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhKATB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119AC06122E
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r8so16665802wra.7
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyC7uo4XjFURyMdmVff+ksQZo5Xgh04teTh0uKohKB0=;
        b=bW5RXe3j3ZEJ629e2nYdy5WnUNhS+ZXD9H3iwWyTiuvgTY7Rs5cADMRQOMNTuSahP6
         U8+NRbmBR0e9VTcUi8tJ56bJea6KtThNoMRy3ny6zDNvoWEXIH36cTak+QLzrFENZJ7g
         rnV9sMXKrbzRU6TDdGUTk3DeSfdkJexog/cM/N1nqrE8ghXwIWVLod5f0B8uoL0Qxalj
         AJ7PxYmtA7cPUHo9kgLE+dxAzgV5MA272t24bgG0QOuYN6gHOdDFCQYHUCKQXzMYhHeu
         my7fdkQhlfnZ6OaXdUHlbLjsPpTQ7T7nOfHnMBJhXkq+Mq6QbDxXwEl7iPeu6BqV6dhe
         tvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyC7uo4XjFURyMdmVff+ksQZo5Xgh04teTh0uKohKB0=;
        b=B/lImZJfug8EU7dwOTFFKp4nu96zNtTgz6DtiqwiTgoqbR25HlhqRDtKRI3rsYi7b8
         uE4wud3/LjXEBQdkk8JEmM8NAT7j1Jppd4rvabvGwFnbwp+7/CRXrQPR6Ly/aFn2WCei
         0HHPuZMaYVqU5sJPmQzJi8n9HcEaeSr6x2iHBE8xUxAWtpP4n3yoNM6Usrv5+3Y3TlsX
         /oXt03bMQB3RSGQPMw6t5NKmDYzLzbBEGCKYuJi9O8jkuacfN0uLFlsrqqgBEFzrAkiL
         0ererAdpy5KiiX7V5/IcQtWWaXrkdfNUM5kWKVYZBx9mhYuJ0DFMjMPM/DhucYQQO9HT
         upMw==
X-Gm-Message-State: AOAM533NW6Y56kbxyx6Aq8QsVmQV9YofxN2uuUxA05NxdK0qJ0a/vKG7
        4w6WAIlELETHdf5t51VOkfcSeYTKJ62kIC4b
X-Google-Smtp-Source: ABdhPJyGB9fxM2DGRRnVGL6PtMpDCsKZ+kgJaCXsW/fkrGRLfrGX1WH99gpW5CDDK3y8LlqmPltAbg==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr13136047wrv.61.1635792997045;
        Mon, 01 Nov 2021 11:56:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:35 -0700 (PDT)
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
Subject: [PATCH v4 14/17] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Mon,  1 Nov 2021 19:56:19 +0100
Message-Id: <patch-v4-14.17-79ea5a2a4f5-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
index 551de4903c1..581d7dc216c 100644
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
+	return run_hooks_opt(name, &opt);
 }
-- 
2.33.1.1570.g069344fdd45

