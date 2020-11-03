Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E5C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D53522280
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaS5ClxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgKCOEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgKCODW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:03:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D29C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 06:03:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b3so12777205wrx.11
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nly5aoUwoSfFzapqnHpVG8ijbTA7fs42NqNdOyOuJhA=;
        b=aaS5ClxIVHLVAzWR2ymQXcxAOgJ4vdaQ9UN5DxY3kALiPJ7t55cW7+5DlMFDojjeup
         laULMwLyZENCUHBAHyPLKgfPtfbru4yc+aMZKQpXvgFUU6tv97Mv7lCktECeKY0/fiPf
         Jyig9h4CvoMvksutFxHxpW4Jqz/uSPmJ/33DWNBHO/XlJPG4DYMLtDPSa3/bZFEMWAPT
         yVv5qdUWujuYzhKRpzkdQ22UpAhrwfbAV2XzEGLlrzRdhI2Z4B/RN0gnMmZkTEOvJCc2
         SV16QosFUdKPNJ5qgnMdcbyCRJ8vslWnfZT8c8pJJbY790gQ8PSzp6L9QGsD3wBBB1Bs
         Tb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nly5aoUwoSfFzapqnHpVG8ijbTA7fs42NqNdOyOuJhA=;
        b=PEkJss/9CpihtPOJLy0+So8uD9H9YxKTOl3+giXkgOIYrytQxK6AzNSD8e0TD41DAH
         SRNZ2p9sAcX8FTUBEIVa3Pw77KRCCLq7oxaPYjQ5ZohiolwSMnkr7HyaLlGpk/81ROAF
         MuwECaR6t9F2EG4s5yCfPbuPFa7NmvKjoCsrbpsl32mekCp2FhWjDCeqCczoK3uFdEIX
         /a4UpWIw0sxgjEg8CX0pEChOQaD47f9HAq4yo8P0tqUVWpJ+fx25ot6DoMS5OrrwS9nv
         78EFEDBi3g94b21FN13+o6HP2gK7yn4uuFtL/gA5zgjPXxg7HqZ20K2pKJgvh78iqJVG
         ezOg==
X-Gm-Message-State: AOAM530nV0Nyac5OuqSxsO8h4HJYQxoBZkotaTHLXF9M0RK4QHlqgS+F
        6ohBw8E/v3ab/D5RlZ31ynXQz79sWvM=
X-Google-Smtp-Source: ABdhPJxRm3uYkQWEkVvOnFdz4CQNT6nienWTPUWlyqsdCI0ZTSMatvDruHA4wWLhaoVw8/aY92t1ww==
X-Received: by 2002:a05:6000:1046:: with SMTP id c6mr2034573wrx.315.1604412199159;
        Tue, 03 Nov 2020 06:03:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm26491521wrn.32.2020.11.03.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:03:18 -0800 (PST)
Message-Id: <d35f1aa162097d4dfe468b3ac1717bca92a41cfa.1604412196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 14:03:14 +0000
Subject: [PATCH 1/3] maintenance: extract platform-specific scheduling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
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

