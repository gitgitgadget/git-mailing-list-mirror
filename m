Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22523C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhKWMLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhKWMLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57143C061746
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so616319wrp.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cay9e82rEnCkID8RP8Q70MLtN2EKo+TvbOi9ZND+HdQ=;
        b=KMgjYMOQbeGj++1jd7aMdH70ihMhghR1l0AbKI2v4wUmxWMnt+FiTZ7Y7kMOSU9LYv
         OeEgd7pDcDIGDD3oXwiV05cM+elU9H7zW0V1fyANhvr91wG2/EABKwqGH6ofu2eXzz+9
         096asCNjxZswNmIkSXmCm6sk/ySci24F0dlWzQ0GjDIIocQfQ1EwBeIuNjUw7WO3MGW5
         QOXm/FWGGZRCp8kKAklyfyKaEhWrmMELidQcUIT7xL0W1P8Ijkh26YaVdBlNKOJoSfTS
         b7wljXyAGbm0c3bI3+7xdik6KFdAK8tilmmZNrPkAmJ4/DuuZP4QGkmSAMIi9xsqyCkC
         0Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cay9e82rEnCkID8RP8Q70MLtN2EKo+TvbOi9ZND+HdQ=;
        b=Mx4qjZuXbISTyQxrdGhaRBXmTQUgy00AtbU+XUxE84sPez4qiPpveU2KikJ0qZBrYw
         gtprNTX8zNeaDVJiqKGzWxstCc2gLLX/mOK0q6sVYEWFqZrIizZUip+ThG4pfvyQ+8X9
         7tNvB05IxGT25uTYW1fSup9MF1wOnXGcUb56ug4uGQuLHKCm9LfFezUoHbmkJ7PmR7hp
         52JX1zb9BRAL4emJ8RD9cpStHNPdO8R+7gfy/RPIGYFBbzuTZz0Y4xEStx+/mNCsT3+F
         jtADI60WGjgTx+/Nu0iPMM5MWFfoVNf6JP09LByTIMgxK7i14nlR2ILd7bZlaEtNAHDQ
         J6Bg==
X-Gm-Message-State: AOAM533mVVMEixOZLSS9rfNk7j4qF5PUjOnsUuqSdB8h8b4aL1Kq+sr8
        wJFj82rWwYPYbptcxrQ2AUL4altg/2Rpow==
X-Google-Smtp-Source: ABdhPJz+zd9UVrwifQkesToQxETPrK1mNdGFMSQ4u+eBSX37L5xbG1qUlXVs1g6cDJPwaim9lQQpLw==
X-Received: by 2002:adf:f907:: with SMTP id b7mr6849239wrr.5.1637669281709;
        Tue, 23 Nov 2021 04:08:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:08:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] run-command tests: use strvec_pushv(), not argv assignment
Date:   Tue, 23 Nov 2021 13:06:31 +0100
Message-Id: <patch-v2-4.9-a2ee10e214c-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit change this API user to use strvec_pushv()
instead of assigning to the "argv" member directly. This leaves is
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
2.34.0.831.gd33babec0d1

