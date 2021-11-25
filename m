Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06E0C433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbhKYW5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhKYWzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:55:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F40C06174A
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso9407374wml.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQ4PjCDnLFArC5f08daji1CSyq+B7ba+7v/SclBvCuA=;
        b=EPSiCpYnHV/U7TjUINXY/KsZ0g1RD/CGJKOhrgKa82jrn9BNAKICw21v/5jnMRfnx7
         XkiGn2e22sGo3R/XIUnOE+ZUvgwaDi1eKCGAVQJ6O+W6g0Rfl//OVyYYwhgusg6BQFc2
         sLp7tS7J5Da+HLI/ZTkIX8EGNGrZH4HUxniVTEXnKgvlusJJMKokRUt3JE+ttW5owIqA
         mAMl4QaHo45jSpTZC9JAGDnWFGK7Na5cMc9sutWbb09X63RLyNwTwBEqCThsVu47fdUc
         yJNyj+CTdl+dc6fVuiRlRBr6sMJLSJuJ7AJhgfJEWHrTa3tyoch3Udw9BXYUTibTdWe7
         k9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQ4PjCDnLFArC5f08daji1CSyq+B7ba+7v/SclBvCuA=;
        b=5aH6co5SMsUC3K9lkTA952vKXGEhrPsbuZeRMPbbKGKffzM4hVtrX5K2UJBJ9attUx
         1WPZsxNEntuzbMzI40RFL9UIxle2sDnXvFCY+Bsvdt/r4P1C9NCu0Y7sjXjf0JZ22ol4
         hsZr/sF5cOO0F7+TzkmQkld5CboIwjtcyS8RmXGj7sqK87nejLNGrMbvqmq5CctdmX0J
         VP5bEk34iJeAjWRrkUf/lhe5LKNI93s11yRirRwN/gpmQDhg3Ql6bk2LrA21iTO6uMFd
         lcaqPX47nETcyQOeqoSB1a3bpI8m46R3YvFwpy6DdagTPTk0rcdf4FsZ7pzebCzNFRru
         0ehQ==
X-Gm-Message-State: AOAM532lVeV654+yNug7p2zZC0GH97/Ai+7VbLEMzkDPAs0zHpWkjfuC
        gXcLhZA5ds/Q96uedXMFLJVH34rBHaqiuQ==
X-Google-Smtp-Source: ABdhPJyBa5v1wdUUh9CgFfeEkXAPRwM80qLfgWYHbCVBOf9ZcsHUjXB84jTCbazkAz9fGznV1KBfSA==
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr11820009wmq.43.1637880751147;
        Thu, 25 Nov 2021 14:52:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] run-command tests: use strvec_pushv(), not argv assignment
Date:   Thu, 25 Nov 2021 23:52:19 +0100
Message-Id: <patch-v3-4.9-764c9b813fb-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit change this API user to use strvec_pushv()
instead of assigning to the "argv" member directly. This leaves us
without test coverage of how the "argv" assignment in this API works,
but we'll be removing it in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3c4fb862234..913775a14b7 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -31,7 +31,7 @@ static int parallel_next(struct child_process *cp,
 	if (number_callbacks >= 4)
 		return 0;
 
-	strvec_pushv(&cp->args, d->argv);
+	strvec_pushv(&cp->args, d->args.v);
 	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 1;
@@ -274,7 +274,7 @@ static int quote_stress_test(int argc, const char **argv)
 		if (i < skip)
 			continue;
 
-		cp.argv = args.v;
+		strvec_pushv(&cp.args, args.v);
 		strbuf_reset(&out);
 		if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
 			return error("Failed to spawn child process");
@@ -396,7 +396,7 @@ int cmd__run_command(int argc, const char **argv)
 	}
 	if (argc < 3)
 		return 1;
-	proc.argv = (const char **)argv + 2;
+	strvec_pushv(&proc.args, (const char **)argv + 2);
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
 		if (start_command(&proc) < 0 && errno == ENOENT)
@@ -408,7 +408,8 @@ int cmd__run_command(int argc, const char **argv)
 		exit(run_command(&proc));
 
 	jobs = atoi(argv[2]);
-	proc.argv = (const char **)argv + 3;
+	strvec_clear(&proc.args);
+	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-- 
2.34.1.838.g779e9098efb

