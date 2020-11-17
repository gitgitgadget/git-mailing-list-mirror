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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D54C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E76F24248
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPMUKHEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKQVNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQVNW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:13:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A8C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:22 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so7643778wrg.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GeHMVAQUD8d6JoZr3OOSyoRumStUgEOOmfk4MjdgbTM=;
        b=FPMUKHEKuoj7aLVCJE18eqglKz2NDpUKdd7Hm8tlmkiV/5Qhr0SaWR1KJisb4UVRTy
         KlrvcZ2NHrgXNHf7FXhIvdfSCPqMJHJLUBQQsJsuVDR5iECkxZZdvswBw2RJTpbONQvb
         vORbCzcJAL32nNTUf2W2Q7RMb4k+bdmbYt4yo6nSyC2cfKEwR2F/xDV8zEJ0n6q5ibUp
         1V/AEvOJmpZcFcIexKvJCMNbzQAVuP3Er8Hyf/Te4V9VhMcudrRHmx1QgvqHCMyNAfSd
         llV54yBaxZJRzE1dqCZYwPTcItO7goAEeTGQbSqEHgblAqu+gJgCvSrqN1CLOnkRsuH1
         1hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GeHMVAQUD8d6JoZr3OOSyoRumStUgEOOmfk4MjdgbTM=;
        b=gYLjd/+mpbMO4l6RU8T8EQunZpsWJor/P/o5pwCu5w0WcYnToQ9T2CfZdi+bcqG0wy
         h/VElR5jE2XXyrIv3QuGqW8O7uXnFbqBVujNOivDPzFuuW++0exmw1jK5Y/SHMlf7175
         PTtrCtz2paIlO2GgyhO5RVAxO8EapHU3j4kuy9CJDu7ILovcDbnBsMkQbppHV05KgQ+c
         l24SJzxPms3k+2sWh1mG0rIc7u/DDQFlYre/lPf+hgQO90fLq5aRWlipHoYQbZfGxo+N
         RrgATohwlgoQObVGpAGasXzVPEY1xpRWOLm1xoA3vNB35Vg2tZ/9TlTDNE1NB17ImV0S
         PeBQ==
X-Gm-Message-State: AOAM533VLKqdGit8MaQVqqlIksVc570GK2orl8FE37j8wnA3WP7DyXYX
        /44+7tlL0rPDVAG6s93GFRIFAy4UM/o=
X-Google-Smtp-Source: ABdhPJxid0qPyqNtwpB61xAXIATk+OqDdC+Z//Zcf6+/Jd0kTbJ+LT6zHdVXny794Y5uni82XC7xKQ==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr1598492wrt.158.1605647600878;
        Tue, 17 Nov 2020 13:13:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm29927656wrp.0.2020.11.17.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:13:20 -0800 (PST)
Message-Id: <4807342b0019be29bb369ed3403a485f0ce9c15d.1605647598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
        <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 21:13:15 +0000
Subject: [PATCH v4 1/4] maintenance: extract platform-specific scheduling
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
index e3098ef6a1..18ae7f7138 100644
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
index 20184e96e1..eeb939168d 100755
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
index 4a60d1ed76..ddbeee1f5e 100644
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

