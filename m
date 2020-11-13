Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF32C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499CE2222F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB6UbvQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgKMOA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKMOA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:00:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152C6C0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:28 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so8574668wmb.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nly5aoUwoSfFzapqnHpVG8ijbTA7fs42NqNdOyOuJhA=;
        b=cB6UbvQv6yy64uWWrwYsnDIFoBbU2JcY7BPIG10EnGOwahXt732xoYUcBucaaeRufG
         9z8KMDkRrSgzhyjpGO+zbDpwxGp60bKhILdScWI7x036C6RUyCVlBDQ3p7TvY1kYoYOR
         /HP1b0EhLp63hNJ+IChnKnator65VSV6ourjPbqO8O2+JgJSdkAlrGf4CJMT49gEJNgx
         N1P/tYdX/UUTxit2yFWf3ZtCHNaTFpA7aM/WazNhpPtR9bkj9hBDB5OC6TR6TXJpKe1D
         bXOCJEga79M8hCxYQ5enVMFTajpM4pWZ3qS8Js+7LPo54pKojqUE8aFGXhgK1jpEsz8m
         qcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nly5aoUwoSfFzapqnHpVG8ijbTA7fs42NqNdOyOuJhA=;
        b=qw7WJfjrpDTzQa5BgJyKUcSw4ZC2jZz+ywHhMt8L1VHC2oxHQAtrcQ24xXpAVucmmL
         IuspRjDHJhEbMwl61LjQEIBOeISEh8xJ6jVisIGlr8od3IGzzNh9drD+sms50hrb+RYt
         MQlPMMYBsA3rgXDRtlcuVNlVS2ZaGnGK9XM2eWwSx3BkKJ56fHSw68pCGuyxlIZBk9Zb
         D0mZZ+G/W9TA/WY+mdKyly6Qur6bzTGQreZVu8Y7nWvsjkPVW2sEaXpDJa8U0IAsQq3Q
         aK8ph/a+2t5HEgWqhrPT85x5N7ku2NZ1WDnUzR+hMAIdo1UVcgc7t2SemwDZXDcIE8j+
         Ag9A==
X-Gm-Message-State: AOAM530n+0hI8xtiKcrpQAyoKJhGXBpBPcavArSMXNZ56BHPJDDKZVQE
        0f7q8t+raTzzUwXGixu0+ZBVfiPUm+M=
X-Google-Smtp-Source: ABdhPJxu8pD63PVLeuVGochyhLhkJkqVR7p3INo4SN93pUpOMKcSJ5ilnIbeJAqbiVP2F4Vb4+YPtw==
X-Received: by 2002:a1c:9c53:: with SMTP id f80mr2623981wme.19.1605276026620;
        Fri, 13 Nov 2020 06:00:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm11609927wrm.20.2020.11.13.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:00:26 -0800 (PST)
Message-Id: <d35f1aa162097d4dfe468b3ac1717bca92a41cfa.1605276024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
        <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 14:00:21 +0000
Subject: [PATCH v3 1/4] maintenance: extract platform-specific scheduling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing schedule mechanism using 'cron' is supported by POSIX
platforms, but not Windows. It also works slightly differently on
macOS to significant detriment of the user experience. To allow for
new implementations on these platforms, extract a method that
performs the platform-specific scheduling mechanism. This will be
swapped at compile time with new implementations on specialized
platforms.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e3098ef6a1..c1f7d9bdc2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1494,7 +1494,7 @@ static int maintenance_unregister(void)
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
-static int update_background_schedule(int run_maintenance)
+static int platform_update_schedule(int run_maintenance, int fd)
 {
 	int result = 0;
 	int in_old_region = 0;
@@ -1503,11 +1503,6 @@ static int update_background_schedule(int run_maintenance)
 	FILE *cron_list, *cron_in;
 	const char *crontab_name;
 	struct strbuf line = STRBUF_INIT;
-	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
-
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
-		return error(_("another process is scheduling background maintenance"));
 
 	crontab_name = getenv("GIT_TEST_CRONTAB");
 	if (!crontab_name)
@@ -1516,12 +1511,11 @@ static int update_background_schedule(int run_maintenance)
 	strvec_split(&crontab_list.args, crontab_name);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
-	crontab_list.out = dup(lk.tempfile->fd);
+	crontab_list.out = dup(fd);
 	crontab_list.git_cmd = 0;
 
 	if (start_command(&crontab_list)) {
-		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
-		goto cleanup;
+		return error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
 	}
 
 	/* Ignore exit code, as an empty crontab will return error. */
@@ -1531,7 +1525,7 @@ static int update_background_schedule(int run_maintenance)
 	 * Read from the .lock file, filtering out the old
 	 * schedule while appending the new schedule.
 	 */
-	cron_list = fdopen(lk.tempfile->fd, "r");
+	cron_list = fdopen(fd, "r");
 	rewind(cron_list);
 
 	strvec_split(&crontab_edit.args, crontab_name);
@@ -1539,8 +1533,7 @@ static int update_background_schedule(int run_maintenance)
 	crontab_edit.git_cmd = 0;
 
 	if (start_command(&crontab_edit)) {
-		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
-		goto cleanup;
+		return error(_("failed to run 'crontab'; your system might not support 'cron'"));
 	}
 
 	cron_in = fdopen(crontab_edit.in, "w");
@@ -1586,13 +1579,24 @@ static int update_background_schedule(int run_maintenance)
 	close(crontab_edit.in);
 
 done_editing:
-	if (finish_command(&crontab_edit)) {
+	if (finish_command(&crontab_edit))
 		result = error(_("'crontab' died"));
-		goto cleanup;
-	}
-	fclose(cron_list);
+	else
+		fclose(cron_list);
+	return result;
+}
+
+static int update_background_schedule(int run_maintenance)
+{
+	int result;
+	struct lock_file lk;
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
+		return error(_("another process is scheduling background maintenance"));
+
+	result = platform_update_schedule(run_maintenance, lk.tempfile->fd);
 
-cleanup:
 	rollback_lock_file(&lk);
 	return result;
 }
-- 
gitgitgadget

