Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E63C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E346323C31
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgLITbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgLITbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:31:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42CC0619DF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:29:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so1475706wmh.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RodYAdkQd8R+l8FdZHezwZH9UXeD13YYCk5O1JOaM8I=;
        b=pt4N1FKT5XBiAusdnAzY1i94HU+bevGYvccQDUDVHyaodZt6rOoQncYg9YyDqVu4du
         AjK6x7/rKJ005zyQ9xt0zV1sHIBQqb6ZL/BDuR1yXBHK2C7c//djYDS6Zc9u1y8UF5JK
         k7wlzXix2Qw3QavLRN2R+ZS55pE8oHlUc72cG0mu8EpVR3jtgnwYiwHDFitRkLKovSnJ
         gcsE8EBn9Lp4n2Jgh92iVwy2nmU50XA8q+eHFO7LfShEXWDN5AsYqA5zVxXQeoNk0ICi
         ujoc7L5lmjuVcyBgddG3jw+moR4WgFiZMHhF1AREyNzEZ7GUI/adhmITmJBzDcMIQ8+L
         ViWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RodYAdkQd8R+l8FdZHezwZH9UXeD13YYCk5O1JOaM8I=;
        b=WL0+vEN/8E2D7lstOOQtgZMNGGKSx0vfFVw7naH4T0lnNgfLf5funCfliMXBkEC5q2
         qLRmbNwNhiPBZxofcfkdd82yuhJl1VEu+BAxvfePeaFAPXvPPATLtItD1uaczjhVb0DY
         6V42zwfHg4Hc0clSj/cYTsm4dLPd53Np8zVUbQlM7hG9sZmtsADvpWVbKx3zRaz4H8kv
         22qnLu56nlwyzArsrbifNmhE0SNHVGv93f1FX+/CLXNFJEmfodDVpAKkOfCznqd94x7N
         +33lJ2U6a8oPct0xjcYA5gVo9GwhXZkUKh+ehnVgydyCcSQ346y0S/JMMRFav8djozFI
         /J6g==
X-Gm-Message-State: AOAM531+HCiVZjiY1c9W2q8DuyoQesEMbjuAHqV3e1qPkzctk25/hi0w
        ZWh7MuSmaH6TUisSDwLx9LmW6P6cFEg=
X-Google-Smtp-Source: ABdhPJysh37h2NlrZPdWN1wYTiPPf7dv7dd+IMDScefFEv6R6NlwV56lsf24Mp3YNcFQUpegHODh/A==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr4437823wmi.151.1607542145108;
        Wed, 09 Dec 2020 11:29:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm5722583wrw.81.2020.12.09.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:29:04 -0800 (PST)
Message-Id: <4807342b0019be29bb369ed3403a485f0ce9c15d.1607542142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
        <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:28:59 +0000
Subject: [PATCH v6 1/4] maintenance: extract platform-specific scheduling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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

As we add this generality, rename GIT_TEST_CRONTAB to
GIT_TEST_MAINT_SCHEDULER. Further, this variable is now parsed as
"<scheduler>:<command>" so we can test platform-specific scheduling
logic even when not on the correct platform. By specifying the
<scheduler> in this string, we will be able to test all three sets of
Git logic from a Linux machine.

Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 70 ++++++++++++++++++++++++++----------------
 t/t7900-maintenance.sh |  8 ++---
 t/test-lib.sh          |  7 +++--
 3 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e3098ef6a12..18ae7f7138a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1494,35 +1494,23 @@ static int maintenance_unregister(void)
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
-static int update_background_schedule(int run_maintenance)
+static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 {
 	int result = 0;
 	int in_old_region = 0;
 	struct child_process crontab_list = CHILD_PROCESS_INIT;
 	struct child_process crontab_edit = CHILD_PROCESS_INIT;
 	FILE *cron_list, *cron_in;
-	const char *crontab_name;
 	struct strbuf line = STRBUF_INIT;
-	struct lock_file lk;
-	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
 
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
-		return error(_("another process is scheduling background maintenance"));
-
-	crontab_name = getenv("GIT_TEST_CRONTAB");
-	if (!crontab_name)
-		crontab_name = "crontab";
-
-	strvec_split(&crontab_list.args, crontab_name);
+	strvec_split(&crontab_list.args, cmd);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
-	crontab_list.out = dup(lk.tempfile->fd);
+	crontab_list.out = dup(fd);
 	crontab_list.git_cmd = 0;
 
-	if (start_command(&crontab_list)) {
-		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
-		goto cleanup;
-	}
+	if (start_command(&crontab_list))
+		return error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
 
 	/* Ignore exit code, as an empty crontab will return error. */
 	finish_command(&crontab_list);
@@ -1531,17 +1519,15 @@ static int update_background_schedule(int run_maintenance)
 	 * Read from the .lock file, filtering out the old
 	 * schedule while appending the new schedule.
 	 */
-	cron_list = fdopen(lk.tempfile->fd, "r");
+	cron_list = fdopen(fd, "r");
 	rewind(cron_list);
 
-	strvec_split(&crontab_edit.args, crontab_name);
+	strvec_split(&crontab_edit.args, cmd);
 	crontab_edit.in = -1;
 	crontab_edit.git_cmd = 0;
 
-	if (start_command(&crontab_edit)) {
-		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
-		goto cleanup;
-	}
+	if (start_command(&crontab_edit))
+		return error(_("failed to run 'crontab'; your system might not support 'cron'"));
 
 	cron_in = fdopen(crontab_edit.in, "w");
 	if (!cron_in) {
@@ -1586,14 +1572,44 @@ static int update_background_schedule(int run_maintenance)
 	close(crontab_edit.in);
 
 done_editing:
-	if (finish_command(&crontab_edit)) {
+	if (finish_command(&crontab_edit))
 		result = error(_("'crontab' died"));
-		goto cleanup;
+	else
+		fclose(cron_list);
+	return result;
+}
+
+static const char platform_scheduler[] = "crontab";
+
+static int update_background_schedule(int enable)
+{
+	int result;
+	const char *scheduler = platform_scheduler;
+	const char *cmd = scheduler;
+	char *testing;
+	struct lock_file lk;
+	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
+
+	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
+	if (testing) {
+		char *sep = strchr(testing, ':');
+		if (!sep)
+			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
+		*sep = '\0';
+		scheduler = testing;
+		cmd = sep + 1;
 	}
-	fclose(cron_list);
 
-cleanup:
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
+		return error(_("another process is scheduling background maintenance"));
+
+	if (!strcmp(scheduler, "crontab"))
+		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
+	else
+		die("unknown background scheduler: %s", scheduler);
+
 	rollback_lock_file(&lk);
+	free(testing);
 	return result;
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 20184e96e1a..eeb939168da 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -368,7 +368,7 @@ test_expect_success 'register and unregister' '
 '
 
 test_expect_success 'start from empty cron table' '
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
@@ -379,19 +379,19 @@ test_expect_success 'start from empty cron table' '
 '
 
 test_expect_success 'stop from existing schedule' '
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
 	# Operation is idempotent
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 	test_must_be_empty cron.txt
 '
 
 test_expect_success 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
 	grep "Important information!" cron.txt
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a60d1ed766..ddbeee1f5eb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1704,7 +1704,8 @@ test_lazy_prereq REBASE_P '
 '
 
 # Ensure that no test accidentally triggers a Git command
-# that runs 'crontab', affecting a user's cron schedule.
-# Tests that verify the cron integration must set this locally
+# that runs the actual maintenance scheduler, affecting a user's
+# system permanently.
+# Tests that verify the scheduler integration must set this locally
 # to avoid errors.
-GIT_TEST_CRONTAB="exit 1"
+GIT_TEST_MAINT_SCHEDULER="none:exit 1"
-- 
gitgitgadget

