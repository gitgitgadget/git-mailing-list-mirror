Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A02C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E06E241A6
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edc7f5M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKQVNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQVNX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:13:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A7C0617A6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so24882268wrx.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n8o0+f4rBwfAyDCWo+XsZxkRoTHlM4kpAceXz0yGB4c=;
        b=Edc7f5M0eNv0HidGGVOgVYQBLrJrMZbWRJ080j+X9NDY37mJyHbf1UCz+y5zGJJMjV
         YkOwT4wylOpqr/p10P4KdA9XjmANc786X+p04r5u1p8z4+T3awG+gPRxaY7dhuUbUtCC
         +oF5EgwH9SsZRbK8yuKNK4h82pEO9YNvkC03Zfr2+6pxdsRreClS88aFpAJ+HcbkQLkB
         fqbR4PvKyaa3w5RFYuN72QTji8YP66vk+nDCw22JuPAwFeD9/nP73z4m0iULOfIz4bIa
         hQKXjRWEWjl23S7cQNXlYpFPmGt1s89kuhT9OrQoe07BeH1xI2C6igJ7I8FKfKTgXoKl
         nL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n8o0+f4rBwfAyDCWo+XsZxkRoTHlM4kpAceXz0yGB4c=;
        b=DRpIzOcoPqWUMqpEiO6TD2jqb3qSJZNKSyaDEaPseZ9qbQ8Y9zYcFQiDahAvpwA14P
         4Qtjgc/s7tdXSom/Bz8KunZOSTpMBDNoSW29tP/hKWr9gVk5PCSaQpTJl91EvcfwsKAB
         wAHuTlKBb1B5pDSeDQFlMXOe2m5qKX1YH3r0sVcxAj9qcCojzZVxYrLwvFVfE/u7u+n3
         fTRwxSBNoqtVDfwyd/PXiPf3mVCgLqCqQ+ZskaKE5T4ImPcXs+oxKpvgf/dCjw90EZs6
         N+1hzF/lQ3FgrfXZ0QULww96JgtafLW2HbQzD2oNx4q1IXBHxVF6b69aLscNqpOQTRos
         IRiQ==
X-Gm-Message-State: AOAM5322Gn+UcUzoDBS8SC4xPt/WbXMh7JNVDGvWEiIfn5TaOG1patuJ
        rWiF1dQc9CuaswItn90J1RSaJxHrixc=
X-Google-Smtp-Source: ABdhPJxPfhiDYGcsQ4rtmZABtJvzzDgAOQZV3nMvyfDs6tak6PYPg4SwJIzmndzNZBOH45SQRcrMPw==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr1514952wrp.363.1605647600134;
        Tue, 17 Nov 2020 13:13:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm5226971wml.21.2020.11.17.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:13:19 -0800 (PST)
Message-Id: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 21:13:14 +0000
Subject: [PATCH v4 0/4] Maintenance IV: Platform-specific background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/maintenance-part-3.

After sitting with the background maintenance as it has been cooking, I
wanted to come back around and implement the background maintenance for
Windows. However, I noticed that there were some things bothering me with
background maintenance on my macOS machine. These are detailed in PATCH 3,
but the tl;dr is that 'cron' is not recommended by Apple and instead
'launchd' satisfies our needs.

This series implements the background scheduling so git maintenance
(start|stop) works on those platforms. I've been operating with these
schedules for a while now without the problems described in the patches.

There is a particularly annoying case about console windows popping up on
Windows, but PATCH 4 describes a plan to get around that.

Updates in V4
=============

 * Eric did an excellent job providing a patch that cleans up several parts
   of my series. The most impressive is his mechanism for testing the
   platform-specific Git logic in a way that is (mostly) platform-agnostic.
   
   
 * Windows doesn't have the 'id' command, so we cannot run the macOS
   platform test on Windows.
   
   
 * I noticed far too late that while my example XML files had been edited
   with UTF-8 encoding, Git is actually writing them as US-ASCII. Somehow 
   xmllint and launchd are not complaining, but schtasks does complain.
   Unfortunately, I cannot find a way to catch this problem other than to
   install my tip version on all three platforms and go through the entire 
   git maintenance start process, and double-check that the processes are
   running on the hour.
   
   

Here is a diff from the tip of v3 + Eric's patch to the tip of v4:

diff --git a/builtin/gc.c b/builtin/gc.c
index 955d4b3baf..1a3725429c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1642,13 +1642,13 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
         break;
     }
     fprintf(plist, "</array>\n</dict>\n</plist>\n");
+    fclose(plist);

     /* bootout might fail if not already running, so ignore */
     launchctl_boot_plist(0, filename, cmd);
     if (launchctl_boot_plist(1, filename, cmd))
         die(_("failed to bootstrap service %s"), filename);

-    fclose(plist);
     free(filename);
     free(name);
     return 0;
@@ -1707,25 +1707,27 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
     int result;
     struct child_process child = CHILD_PROCESS_INIT;
     const char *xml;
-    char *xmlpath, *tempDir;
-    FILE *xmlfp;
+    char *xmlpath;
+    struct tempfile *tfile;
     const char *frequency = get_frequency(schedule);
     char *name = schtasks_task_name(frequency);

-    tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
-    xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
-    safe_create_leading_directories(xmlpath);
-    xmlfp = xfopen(xmlpath, "w");
+    xmlpath =  xstrfmt("%s/schedule-%s.xml",
+               the_repository->objects->odb->path,
+               frequency);
+    tfile = create_tempfile(xmlpath);
+    if (!tfile || !fdopen_tempfile(tfile, "w"))
+        die(_("failed to create '%s'"), xmlpath);

-    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
+    xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
           "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
           "<Triggers>\n"
           "<CalendarTrigger>\n";
-    fputs(xml, xmlfp);
+    fputs(xml, tfile->fp);

     switch (schedule) {
     case SCHEDULE_HOURLY:
-        fprintf(xmlfp,
+        fprintf(tfile->fp,
             "<StartBoundary>2020-01-01T01:00:00</StartBoundary>\n"
             "<Enabled>true</Enabled>\n"
             "<ScheduleByDay>\n"
@@ -1739,7 +1741,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
         break;

     case SCHEDULE_DAILY:
-        fprintf(xmlfp,
+        fprintf(tfile->fp,
             "<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
             "<Enabled>true</Enabled>\n"
             "<ScheduleByWeek>\n"
@@ -1756,7 +1758,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
         break;

     case SCHEDULE_WEEKLY:
-        fprintf(xmlfp,
+        fprintf(tfile->fp,
             "<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
             "<Enabled>true</Enabled>\n"
             "<ScheduleByWeek>\n"
@@ -1771,7 +1773,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
         break;
     }

-    xml=  "</CalendarTrigger>\n"
+    xml = "</CalendarTrigger>\n"
           "</Triggers>\n"
           "<Principals>\n"
           "<Principal id=\"Author\">\n"
@@ -1795,11 +1797,10 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
           "</Exec>\n"
           "</Actions>\n"
           "</Task>\n";
-    fprintf(xmlfp, xml, exec_path, exec_path, frequency);
-    fclose(xmlfp);
-
+    fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
     strvec_split(&child.args, cmd);
     strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
+    close_tempfile_gently(tfile);

     child.no_stdout = 1;
     child.no_stderr = 1;
@@ -1808,8 +1809,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
         die(_("failed to start schtasks"));
     result = finish_command(&child);

-    unlink(xmlpath);
-    rmdir(tempDir);
+    delete_tempfile(&tfile);
     free(xmlpath);
     free(name);
     return result;
@@ -1850,9 +1850,8 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
     crontab_list.out = dup(fd);
     crontab_list.git_cmd = 0;

-    if (start_command(&crontab_list)) {
+    if (start_command(&crontab_list))
         return error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
-    }

     /* Ignore exit code, as an empty crontab will return error. */
     finish_command(&crontab_list);
@@ -1868,9 +1867,8 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
     crontab_edit.in = -1;
     crontab_edit.git_cmd = 0;

-    if (start_command(&crontab_edit)) {
+    if (start_command(&crontab_edit))
         return error(_("failed to run 'crontab'; your system might not support 'cron'"));
-    }

     cron_in = fdopen(crontab_edit.in, "w");
     if (!cron_in) {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e92946c10a..a26ff22541 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -408,7 +408,7 @@ test_expect_success 'start preserves existing schedule' '
     grep "Important information!" cron.txt
 '

-test_expect_success 'start and stop macOS maintenance' '
+test_expect_success !MINGW 'start and stop macOS maintenance' '
     uid=$(id -u) &&

     write_script print-args <<-\EOF &&
@@ -421,7 +421,6 @@ test_expect_success 'start and stop macOS maintenance' '
     # start registers the repo
     git config --get --global maintenance.repo "$(pwd)" &&

-    # ~/Library/LaunchAgents
     ls "$HOME/Library/LaunchAgents" >actual &&
     cat >expect <<-\EOF &&
     org.git-scm.git.daily.plist
@@ -468,12 +467,12 @@ test_expect_success 'start and stop Windows maintenance' '
     EOF

     rm -f args &&
-    GIT_TEST_MAINT_SCHEDULER="schtasks:/bin/sh print-args" git maintenance start &&
+    GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&

     # start registers the repo
     git config --get --global maintenance.repo "$(pwd)" &&

-    printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/temp/schedule-%s.xml\n" \
+    printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
         hourly hourly daily daily weekly weekly >expect &&
     test_cmp expect args &&

@@ -483,7 +482,7 @@ test_expect_success 'start and stop Windows maintenance' '
     done &&

     rm -f args &&
-    GIT_TEST_MAINT_SCHEDULER="schtasks:/bin/sh print-args" git maintenance stop &&
+    GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&

     # stop does not unregister the repo
     git config --get --global maintenance.repo "$(pwd)" &&
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

Thanks, -Stolee

cc: jrnieder@gmail.com [jrnieder@gmail.com], jonathantanmy@google.com
[jonathantanmy@google.com], sluongng@gmail.com [sluongng@gmail.com]cc:
Derrick Stolee stolee@gmail.com [stolee@gmail.com]cc: Đoàn Trần Công Danh 
congdanhqx@gmail.com [congdanhqx@gmail.com]cc: Martin Ågren 
martin.agren@gmail.com [martin.agren@gmail.com]cc: Eric Sunshine 
sunshine@sunshineco.com [sunshine@sunshineco.com]cc: Derrick Stolee 
stolee@gmail.com [stolee@gmail.com]

Derrick Stolee (4):
  maintenance: extract platform-specific scheduling
  maintenance: include 'cron' details in docs
  maintenance: use launchctl on macOS
  maintenance: use Windows scheduled tasks

 Documentation/git-maintenance.txt | 116 ++++++++
 builtin/gc.c                      | 421 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 106 +++++++-
 t/test-lib.sh                     |   7 +-
 4 files changed, 616 insertions(+), 34 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v3:

 1:  d35f1aa162 ! 1:  4807342b00 maintenance: extract platform-specific scheduling
     @@ Commit message
          swapped at compile time with new implementations on specialized
          platforms.
      
     +    As we add this generality, rename GIT_TEST_CRONTAB to
     +    GIT_TEST_MAINT_SCHEDULER. Further, this variable is now parsed as
     +    "<scheduler>:<command>" so we can test platform-specific scheduling
     +    logic even when not on the correct platform. By specifying the
     +    <scheduler> in this string, we will be able to test all three sets of
     +    Git logic from a Linux machine.
     +
     +    Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_unregister(void)
       #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
       
      -static int update_background_schedule(int run_maintenance)
     -+static int platform_update_schedule(int run_maintenance, int fd)
     ++static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
       {
       	int result = 0;
       	int in_old_region = 0;
     -@@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
     + 	struct child_process crontab_list = CHILD_PROCESS_INIT;
     + 	struct child_process crontab_edit = CHILD_PROCESS_INIT;
       	FILE *cron_list, *cron_in;
     - 	const char *crontab_name;
     +-	const char *crontab_name;
       	struct strbuf line = STRBUF_INIT;
      -	struct lock_file lk;
      -	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
     --
     + 
      -	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
      -		return error(_("another process is scheduling background maintenance"));
     - 
     - 	crontab_name = getenv("GIT_TEST_CRONTAB");
     - 	if (!crontab_name)
     -@@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
     - 	strvec_split(&crontab_list.args, crontab_name);
     +-
     +-	crontab_name = getenv("GIT_TEST_CRONTAB");
     +-	if (!crontab_name)
     +-		crontab_name = "crontab";
     +-
     +-	strvec_split(&crontab_list.args, crontab_name);
     ++	strvec_split(&crontab_list.args, cmd);
       	strvec_push(&crontab_list.args, "-l");
       	crontab_list.in = -1;
      -	crontab_list.out = dup(lk.tempfile->fd);
      +	crontab_list.out = dup(fd);
       	crontab_list.git_cmd = 0;
       
     - 	if (start_command(&crontab_list)) {
     +-	if (start_command(&crontab_list)) {
      -		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
      -		goto cleanup;
     +-	}
     ++	if (start_command(&crontab_list))
      +		return error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
     - 	}
       
       	/* Ignore exit code, as an empty crontab will return error. */
     + 	finish_command(&crontab_list);
      @@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
       	 * Read from the .lock file, filtering out the old
       	 * schedule while appending the new schedule.
     @@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
      +	cron_list = fdopen(fd, "r");
       	rewind(cron_list);
       
     - 	strvec_split(&crontab_edit.args, crontab_name);
     -@@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
     +-	strvec_split(&crontab_edit.args, crontab_name);
     ++	strvec_split(&crontab_edit.args, cmd);
     + 	crontab_edit.in = -1;
       	crontab_edit.git_cmd = 0;
       
     - 	if (start_command(&crontab_edit)) {
     +-	if (start_command(&crontab_edit)) {
      -		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
      -		goto cleanup;
     +-	}
     ++	if (start_command(&crontab_edit))
      +		return error(_("failed to run 'crontab'; your system might not support 'cron'"));
     - 	}
       
       	cron_in = fdopen(crontab_edit.in, "w");
     + 	if (!cron_in) {
      @@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
       	close(crontab_edit.in);
       
     @@ builtin/gc.c: static int update_background_schedule(int run_maintenance)
      +	if (finish_command(&crontab_edit))
       		result = error(_("'crontab' died"));
      -		goto cleanup;
     --	}
     --	fclose(cron_list);
      +	else
      +		fclose(cron_list);
      +	return result;
      +}
      +
     -+static int update_background_schedule(int run_maintenance)
     ++static const char platform_scheduler[] = "crontab";
     ++
     ++static int update_background_schedule(int enable)
      +{
      +	int result;
     ++	const char *scheduler = platform_scheduler;
     ++	const char *cmd = scheduler;
     ++	char *testing;
      +	struct lock_file lk;
      +	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
      +
     ++	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
     ++	if (testing) {
     ++		char *sep = strchr(testing, ':');
     ++		if (!sep)
     ++			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
     ++		*sep = '\0';
     ++		scheduler = testing;
     ++		cmd = sep + 1;
     + 	}
     +-	fclose(cron_list);
     + 
     +-cleanup:
      +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
      +		return error(_("another process is scheduling background maintenance"));
      +
     -+	result = platform_update_schedule(run_maintenance, lk.tempfile->fd);
     - 
     --cleanup:
     ++	if (!strcmp(scheduler, "crontab"))
     ++		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
     ++	else
     ++		die("unknown background scheduler: %s", scheduler);
     ++
       	rollback_lock_file(&lk);
     ++	free(testing);
       	return result;
       }
     + 
     +
     + ## t/t7900-maintenance.sh ##
     +@@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
     + '
     + 
     + test_expect_success 'start from empty cron table' '
     +-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
     + 
     + 	# start registers the repo
     + 	git config --get --global maintenance.repo "$(pwd)" &&
     +@@ t/t7900-maintenance.sh: test_expect_success 'start from empty cron table' '
     + '
     + 
     + test_expect_success 'stop from existing schedule' '
     +-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
     ++	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
     + 
     + 	# stop does not unregister the repo
     + 	git config --get --global maintenance.repo "$(pwd)" &&
     + 
     + 	# Operation is idempotent
     +-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
     ++	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
     + 	test_must_be_empty cron.txt
     + '
     + 
     + test_expect_success 'start preserves existing schedule' '
     + 	echo "Important information!" >cron.txt &&
     +-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
     + 	grep "Important information!" cron.txt
     + '
     + 
     +
     + ## t/test-lib.sh ##
     +@@ t/test-lib.sh: test_lazy_prereq REBASE_P '
     + '
     + 
     + # Ensure that no test accidentally triggers a Git command
     +-# that runs 'crontab', affecting a user's cron schedule.
     +-# Tests that verify the cron integration must set this locally
     ++# that runs the actual maintenance scheduler, affecting a user's
     ++# system permanently.
     ++# Tests that verify the scheduler integration must set this locally
     + # to avoid errors.
     +-GIT_TEST_CRONTAB="exit 1"
     ++GIT_TEST_MAINT_SCHEDULER="none:exit 1"
 2:  0dfe53092e ! 2:  99170df462 maintenance: include 'cron' details in docs
     @@ Documentation/git-maintenance.txt: Further, the `git gc` command should not be c
      +---------------------------------------
      +
      +The standard mechanism for scheduling background tasks on POSIX systems
     -+is cron(8). This tool executes commands based on a given schedule. The
     ++is `cron`. This tool executes commands based on a given schedule. The
      +current list of user-scheduled tasks can be found by running `crontab -l`.
      +The schedule written by `git maintenance start` is similar to this:
      +
     @@ Documentation/git-maintenance.txt: Further, the `git gc` command should not be c
      +Any modifications within this region will be completely deleted by
      +`git maintenance stop` or overwritten by `git maintenance start`.
      +
     -+The `crontab` entry specifies the full path of the `git` executable to
     -+ensure that the executed `git` command is the same one with which
     -+`git maintenance start` was issued independent of `PATH`. If the same user
     -+runs `git maintenance start` with multiple Git executables, then only the
     -+latest executable is used.
     ++The `<path>` string is loaded to specifically use the location for the
     ++`git` executable used in the `git maintenance start` command. This allows
     ++for multiple versions to be compatible. However, if the same user runs
     ++`git maintenance start` with multiple Git executables, then only the
     ++latest executable will be used.
      +
      +These commands use `git for-each-repo --config=maintenance.repo` to run
      +`git maintenance run --schedule=<frequency>` on each repository listed in
      +the multi-valued `maintenance.repo` config option. These are typically
     -+loaded from the user-specific global config. The `git maintenance` process
     -+then determines which maintenance tasks are configured to run on each
     -+repository with each `<frequency>` using the `maintenance.<task>.schedule`
     -+config options. These values are loaded from the global or repository
     -+config values.
     ++loaded from the user-specific global config located at `~/.gitconfig`.
     ++The `git maintenance` process then determines which maintenance tasks
     ++are configured to run on each repository with each `<frequency>` using
     ++the `maintenance.<task>.schedule` config options. These values are loaded
     ++from the global or repository config values.
      +
      +If the config values are insufficient to achieve your desired background
      +maintenance schedule, then you can create your own schedule. If you run
      +`crontab -e`, then an editor will load with your user-specific `cron`
      +schedule. In that editor, you can add your own schedule lines. You could
      +start by adapting the default schedule listed earlier, or you could read
     -+the crontab(5) documentation for advanced scheduling techniques. Please
     -+do use the full path and `--exec-path` techniques from the default
     -+schedule to ensure you are executing the correct binaries in your
     -+schedule.
     ++https://man7.org/linux/man-pages/man5/crontab.5.html[the `crontab` documentation]
     ++for advanced scheduling techniques. Please do use the full path and
     ++`--exec-path` techniques from the default schedule to ensure you are
     ++executing the correct binaries in your schedule.
      +
       
       GIT
 3:  1629bcfcf8 ! 3:  ed0a0011fb maintenance: use launchctl on macOS
     @@ Commit message
          plist file. We also need to 'bootout' a task before the 'bootstrap'
          subcommand will succeed, if such a task already exists.
      
     +    The need for a user id requires us to run 'id -u' which works on
     +    POSIX systems but not Windows. The test therefore has a prerequisite
     +    that we are not on Windows. The cross-platform logic still allows us to
     +    test the macOS logic on a Linux machine.
     +
          We can verify the commands that were run by 'git maintenance start'
          and 'git maintenance stop' by injecting a script that writes the
     -    command-line arguments into GIT_TEST_CRONTAB.
     +    command-line arguments into GIT_TEST_MAINT_SCHEDULER.
      
          An earlier version of this patch accidentally had an opening
          "<dict>" tag when it should have had a closing "</dict>" tag. This
          was caught during manual testing with actual 'launchctl' commands,
          but we do not want to update developers' tasks when running tests.
          It appears that macOS includes the "xmllint" tool which can verify
     -    the XML format, so call it from the macOS-specific tests to ensure
     -    the .plist files are well-formatted.
     +    the XML format. This is useful for any system that might contain
     +    the tool, so use it whenever it is available.
      
     -    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: schedule to ensure you are executing the correct binaries in your
     - schedule.
     +@@ Documentation/git-maintenance.txt: for advanced scheduling techniques. Please do use the full path and
     + executing the correct binaries in your schedule.
       
       
      +BACKGROUND MAINTENANCE ON MACOS SYSTEMS
     @@ builtin/gc.c: static int maintenance_unregister(void)
       	return run_command(&config_unset);
       }
       
     -+#if defined(__APPLE__)
     ++static const char *get_frequency(enum schedule_priority schedule)
     ++{
     ++	switch (schedule) {
     ++	case SCHEDULE_HOURLY:
     ++		return "hourly";
     ++	case SCHEDULE_DAILY:
     ++		return "daily";
     ++	case SCHEDULE_WEEKLY:
     ++		return "weekly";
     ++	default:
     ++		BUG("invalid schedule %d", schedule);
     ++	}
     ++}
      +
     -+static char *get_service_name(const char *frequency)
     ++static char *launchctl_service_name(const char *frequency)
      +{
      +	struct strbuf label = STRBUF_INIT;
      +	strbuf_addf(&label, "org.git-scm.git.%s", frequency);
      +	return strbuf_detach(&label, NULL);
      +}
      +
     -+static char *get_service_filename(const char *name)
     ++static char *launchctl_service_filename(const char *name)
      +{
      +	char *expanded;
      +	struct strbuf filename = STRBUF_INIT;
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	return expanded;
      +}
      +
     -+static const char *get_frequency(enum schedule_priority schedule)
     ++static char *launchctl_get_uid(void)
      +{
     -+	switch (schedule) {
     -+	case SCHEDULE_HOURLY:
     -+		return "hourly";
     -+	case SCHEDULE_DAILY:
     -+		return "daily";
     -+	case SCHEDULE_WEEKLY:
     -+		return "weekly";
     -+	default:
     -+		BUG("invalid schedule %d", schedule);
     -+	}
     ++	return xstrfmt("gui/%d", getuid());
      +}
      +
     -+static char *get_uid(void)
     -+{
     -+	struct strbuf output = STRBUF_INIT;
     -+	struct child_process id = CHILD_PROCESS_INIT;
     -+
     -+	strvec_pushl(&id.args, "/usr/bin/id", "-u", NULL);
     -+	if (capture_command(&id, &output, 0))
     -+		die(_("failed to discover user id"));
     -+
     -+	strbuf_trim_trailing_newline(&output);
     -+	return strbuf_detach(&output, NULL);
     -+}
     -+
     -+static int boot_plist(int enable, const char *filename)
     ++static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
      +{
      +	int result;
      +	struct child_process child = CHILD_PROCESS_INIT;
     -+	char *uid = get_uid();
     -+	const char *launchctl = getenv("GIT_TEST_CRONTAB");
     -+	if (!launchctl)
     -+		launchctl = "/bin/launchctl";
     -+
     -+	strvec_split(&child.args, launchctl);
     ++	char *uid = launchctl_get_uid();
      +
     ++	strvec_split(&child.args, cmd);
      +	if (enable)
      +		strvec_push(&child.args, "bootstrap");
      +	else
      +		strvec_push(&child.args, "bootout");
     -+	strvec_pushf(&child.args, "gui/%s", uid);
     ++	strvec_push(&child.args, uid);
      +	strvec_push(&child.args, filename);
      +
      +	child.no_stderr = 1;
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	return result;
      +}
      +
     -+static int remove_plist(enum schedule_priority schedule)
     ++static int launchctl_remove_plist(enum schedule_priority schedule, const char *cmd)
      +{
      +	const char *frequency = get_frequency(schedule);
     -+	char *name = get_service_name(frequency);
     -+	char *filename = get_service_filename(name);
     -+	int result = boot_plist(0, filename);
     ++	char *name = launchctl_service_name(frequency);
     ++	char *filename = launchctl_service_filename(name);
     ++	int result = launchctl_boot_plist(0, filename, cmd);
      +	unlink(filename);
      +	free(filename);
      +	free(name);
      +	return result;
      +}
      +
     -+static int remove_plists(void)
     ++static int launchctl_remove_plists(const char *cmd)
      +{
     -+	return remove_plist(SCHEDULE_HOURLY) ||
     -+		remove_plist(SCHEDULE_DAILY) ||
     -+		remove_plist(SCHEDULE_WEEKLY);
     ++	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
     ++		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
     ++		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
      +}
      +
     -+static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
     ++static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
      +{
      +	FILE *plist;
      +	int i;
      +	const char *preamble, *repeat;
      +	const char *frequency = get_frequency(schedule);
     -+	char *name = get_service_name(frequency);
     -+	char *filename = get_service_filename(name);
     ++	char *name = launchctl_service_name(frequency);
     ++	char *filename = launchctl_service_filename(name);
      +
      +	if (safe_create_leading_directories(filename))
      +		die(_("failed to create directories for '%s'"), filename);
      +	plist = xfopen(filename, "w");
      +
     -+	preamble = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
     ++	preamble = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
      +		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
      +		   "<plist version=\"1.0\">"
      +		   "<dict>\n"
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +		break;
      +	}
      +	fprintf(plist, "</array>\n</dict>\n</plist>\n");
     ++	fclose(plist);
      +
      +	/* bootout might fail if not already running, so ignore */
     -+	boot_plist(0, filename);
     -+	if (boot_plist(1, filename))
     ++	launchctl_boot_plist(0, filename, cmd);
     ++	if (launchctl_boot_plist(1, filename, cmd))
      +		die(_("failed to bootstrap service %s"), filename);
      +
     -+	fclose(plist);
      +	free(filename);
      +	free(name);
      +	return 0;
      +}
      +
     -+static int add_plists(void)
     ++static int launchctl_add_plists(const char *cmd)
      +{
      +	const char *exec_path = git_exec_path();
      +
     -+	return schedule_plist(exec_path, SCHEDULE_HOURLY) ||
     -+		schedule_plist(exec_path, SCHEDULE_DAILY) ||
     -+		schedule_plist(exec_path, SCHEDULE_WEEKLY);
     ++	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY, cmd) ||
     ++		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY, cmd) ||
     ++		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
      +}
      +
     -+static int platform_update_schedule(int run_maintenance, int fd)
     ++static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
      +{
      +	if (run_maintenance)
     -+		return add_plists();
     ++		return launchctl_add_plists(cmd);
      +	else
     -+		return remove_plists();
     ++		return launchctl_remove_plists(cmd);
      +}
     -+#else
     ++
       #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
       #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
       
     -@@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
     - 		fclose(cron_list);
     +@@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
       	return result;
       }
     + 
     ++#if defined(__APPLE__)
     ++static const char platform_scheduler[] = "launchctl";
     ++#else
     + static const char platform_scheduler[] = "crontab";
      +#endif
       
     - static int update_background_schedule(int run_maintenance)
     + static int update_background_schedule(int enable)
       {
     +@@ builtin/gc.c: static int update_background_schedule(int enable)
     + 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
     + 		return error(_("another process is scheduling background maintenance"));
     + 
     +-	if (!strcmp(scheduler, "crontab"))
     ++	if (!strcmp(scheduler, "launchctl"))
     ++		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
     ++	else if (!strcmp(scheduler, "crontab"))
     + 		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
     + 	else
     + 		die("unknown background scheduler: %s", scheduler);
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
     - 	test_cmp before actual
     - '
     - 
     --test_expect_success 'start from empty cron table' '
     -+test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     - 
     - 	# start registers the repo
     -@@ t/t7900-maintenance.sh: test_expect_success 'start from empty cron table' '
     - 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
     - '
     - 
     --test_expect_success 'stop from existing schedule' '
     -+test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
     +@@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
     + GIT_TEST_COMMIT_GRAPH=0
     + GIT_TEST_MULTI_PACK_INDEX=0
       
     - 	# stop does not unregister the repo
     -@@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
     - 	test_must_be_empty cron.txt
     - '
     - 
     --test_expect_success 'start preserves existing schedule' '
     -+test_expect_success !MACOS_MAINTENANCE 'start preserves existing schedule' '
     - 	echo "Important information!" >cron.txt &&
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     ++test_lazy_prereq XMLLINT '
     ++	xmllint --version
     ++'
     ++
     ++test_xmllint () {
     ++	if test_have_prereq XMLLINT
     ++	then
     ++		xmllint --noout "$@"
     ++	else
     ++		true
     ++	fi
     ++}
     ++
     + test_expect_success 'help text' '
     + 	test_expect_code 129 git maintenance -h 2>err &&
     + 	test_i18ngrep "usage: git maintenance <subcommand>" err &&
     +@@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule' '
       	grep "Important information!" cron.txt
       '
       
     -+test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
     -+	write_script print-args "#!/bin/sh\necho \$* >>args" &&
     ++test_expect_success !MINGW 'start and stop macOS maintenance' '
     ++	uid=$(id -u) &&
     ++
     ++	write_script print-args <<-\EOF &&
     ++	echo $* >>args
     ++	EOF
      +
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="./print-args" git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
      +
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	# ~/Library/LaunchAgents
      +	ls "$HOME/Library/LaunchAgents" >actual &&
      +	cat >expect <<-\EOF &&
      +	org.git-scm.git.daily.plist
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
      +	for frequency in hourly daily weekly
      +	do
      +		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
     -+		xmllint --noout "$PLIST" &&
     ++		test_xmllint "$PLIST" &&
      +		grep schedule=$frequency "$PLIST" &&
     -+		echo "bootout gui/$UID $PLIST" >>expect &&
     -+		echo "bootstrap gui/$UID $PLIST" >>expect || return 1
     ++		echo "bootout gui/$uid $PLIST" >>expect &&
     ++		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
      +	done &&
      +	test_cmp expect args &&
      +
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="./print-args" git maintenance stop &&
     ++	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
      +
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	printf "bootout gui/$UID $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
     ++	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
      +		hourly daily weekly >expect &&
      +	test_cmp expect args &&
      +	ls "$HOME/Library/LaunchAgents" >actual &&
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
       test_expect_success 'register preserves existing strategy' '
       	git config maintenance.strategy none &&
       	git maintenance register &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: test_lazy_prereq REBASE_P '
     - 	test -z "$GIT_TEST_SKIP_REBASE_P"
     - '
     - 
     -+test_lazy_prereq MACOS_MAINTENANCE '
     -+	launchctl list
     -+'
     -+
     - # Ensure that no test accidentally triggers a Git command
     - # that runs 'crontab', affecting a user's cron schedule.
     - # Tests that verify the cron integration must set this locally
 4:  ed7a61978f ! 4:  b8d86fb983 maintenance: use Windows scheduled tasks
     @@ Commit message
          logged in, and more fields are populated with the current username and
          SID at run-time by 'schtasks'.
      
     +    Since the GIT_TEST_MAINT_SCHEDULER environment variable allows us to
     +    specify 'schtasks' as the scheduler, we can test the Windows-specific
     +    logic on a macOS platform. Thus, add a check that the XML file written
     +    by Git is valid when xmllint exists on the system.
     +
          There is a deficiency in the current design. Windows has two kinds of
          applications: GUI applications that start by "winmain()" and console
          applications that start by "main()". Console applications are attached
     @@ Commit message
          short term. In the long term, we can consider creating this GUI
          shim application within core Git, perhaps in contrib/.
      
     -    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ Documentation/git-maintenance.txt: To create more advanced customizations to you
       Part of the linkgit:git[1] suite
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
     - 	else
     - 		return remove_plists();
     +@@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
     + 		return launchctl_remove_plists(cmd);
       }
     -+
     -+#elif defined(GIT_WINDOWS_NATIVE)
     -+
     -+static const char *get_frequency(enum schedule_priority schedule)
     -+{
     -+	switch (schedule) {
     -+	case SCHEDULE_HOURLY:
     -+		return "hourly";
     -+	case SCHEDULE_DAILY:
     -+		return "daily";
     -+	case SCHEDULE_WEEKLY:
     -+		return "weekly";
     -+	default:
     -+		BUG("invalid schedule %d", schedule);
     -+	}
     -+}
     -+
     -+static char *get_task_name(const char *frequency)
     + 
     ++static char *schtasks_task_name(const char *frequency)
      +{
      +	struct strbuf label = STRBUF_INIT;
      +	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
      +	return strbuf_detach(&label, NULL);
      +}
      +
     -+static int remove_task(enum schedule_priority schedule)
     ++static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd)
      +{
      +	int result;
      +	struct strvec args = STRVEC_INIT;
      +	const char *frequency = get_frequency(schedule);
     -+	char *name = get_task_name(frequency);
     -+	const char *schtasks = getenv("GIT_TEST_CRONTAB");
     -+	if (!schtasks)
     -+		schtasks = "schtasks";
     ++	char *name = schtasks_task_name(frequency);
      +
     -+	strvec_split(&args, schtasks);
     ++	strvec_split(&args, cmd);
      +	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
      +
      +	result = run_command_v_opt(args.v, 0);
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +	return result;
      +}
      +
     -+static int remove_scheduled_tasks(void)
     ++static int schtasks_remove_tasks(const char *cmd)
      +{
     -+	return remove_task(SCHEDULE_HOURLY) ||
     -+		remove_task(SCHEDULE_DAILY) ||
     -+		remove_task(SCHEDULE_WEEKLY);
     ++	return schtasks_remove_task(SCHEDULE_HOURLY, cmd) ||
     ++		schtasks_remove_task(SCHEDULE_DAILY, cmd) ||
     ++		schtasks_remove_task(SCHEDULE_WEEKLY, cmd);
      +}
      +
     -+static int schedule_task(const char *exec_path, enum schedule_priority schedule)
     ++static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
      +{
      +	int result;
      +	struct child_process child = CHILD_PROCESS_INIT;
     -+	const char *xml, *schtasks;
     -+	char *xmlpath, *tempDir;
     -+	FILE *xmlfp;
     ++	const char *xml;
     ++	char *xmlpath;
     ++	struct tempfile *tfile;
      +	const char *frequency = get_frequency(schedule);
     -+	char *name = get_task_name(frequency);
     ++	char *name = schtasks_task_name(frequency);
      +
     -+	tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
     -+	xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
     -+	safe_create_leading_directories(xmlpath);
     -+	xmlfp = xfopen(xmlpath, "w");
     ++	xmlpath =  xstrfmt("%s/schedule-%s.xml",
     ++			   the_repository->objects->odb->path,
     ++			   frequency);
     ++	tfile = create_tempfile(xmlpath);
     ++	if (!tfile || !fdopen_tempfile(tfile, "w"))
     ++		die(_("failed to create '%s'"), xmlpath);
      +
     -+	xml = "<?xml version=\"1.0\" encoding=\"UTF-16\"?>\n"
     ++	xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
      +	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
      +	      "<Triggers>\n"
      +	      "<CalendarTrigger>\n";
     -+	fprintf(xmlfp, xml);
     ++	fputs(xml, tfile->fp);
      +
      +	switch (schedule) {
      +	case SCHEDULE_HOURLY:
     -+		fprintf(xmlfp,
     ++		fprintf(tfile->fp,
      +			"<StartBoundary>2020-01-01T01:00:00</StartBoundary>\n"
      +			"<Enabled>true</Enabled>\n"
      +			"<ScheduleByDay>\n"
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +		break;
      +
      +	case SCHEDULE_DAILY:
     -+		fprintf(xmlfp,
     ++		fprintf(tfile->fp,
      +			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
      +			"<Enabled>true</Enabled>\n"
      +			"<ScheduleByWeek>\n"
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +		break;
      +
      +	case SCHEDULE_WEEKLY:
     -+		fprintf(xmlfp,
     ++		fprintf(tfile->fp,
      +			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
      +			"<Enabled>true</Enabled>\n"
      +			"<ScheduleByWeek>\n"
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +		break;
      +	}
      +
     -+	xml=  "</CalendarTrigger>\n"
     ++	xml = "</CalendarTrigger>\n"
      +	      "</Triggers>\n"
      +	      "<Principals>\n"
      +	      "<Principal id=\"Author\">\n"
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +	      "</Exec>\n"
      +	      "</Actions>\n"
      +	      "</Task>\n";
     -+	fprintf(xmlfp, xml, exec_path, exec_path, frequency);
     -+	fclose(xmlfp);
     -+
     -+	schtasks = getenv("GIT_TEST_CRONTAB");
     -+	if (!schtasks)
     -+		schtasks = "schtasks";
     -+	strvec_split(&child.args, schtasks);
     ++	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
     ++	strvec_split(&child.args, cmd);
      +	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
     ++	close_tempfile_gently(tfile);
      +
      +	child.no_stdout = 1;
      +	child.no_stderr = 1;
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +		die(_("failed to start schtasks"));
      +	result = finish_command(&child);
      +
     -+	unlink(xmlpath);
     -+	rmdir(tempDir);
     ++	delete_tempfile(&tfile);
      +	free(xmlpath);
      +	free(name);
      +	return result;
      +}
      +
     -+static int add_scheduled_tasks(void)
     ++static int schtasks_schedule_tasks(const char *cmd)
      +{
      +	const char *exec_path = git_exec_path();
      +
     -+	return schedule_task(exec_path, SCHEDULE_HOURLY) ||
     -+		schedule_task(exec_path, SCHEDULE_DAILY) ||
     -+		schedule_task(exec_path, SCHEDULE_WEEKLY);
     ++	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY, cmd) ||
     ++		schtasks_schedule_task(exec_path, SCHEDULE_DAILY, cmd) ||
     ++		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
      +}
      +
     -+static int platform_update_schedule(int run_maintenance, int fd)
     ++static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
      +{
      +	if (run_maintenance)
     -+		return add_scheduled_tasks();
     ++		return schtasks_schedule_tasks(cmd);
      +	else
     -+		return remove_scheduled_tasks();
     ++		return schtasks_remove_tasks(cmd);
      +}
      +
     - #else
       #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
       #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
     -
     - ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
     - 	test_cmp before actual
     - '
     - 
     --test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
     -+test_expect_success !MACOS_MAINTENANCE,!MINGW 'start from empty cron table' '
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     - 
     - 	# start registers the repo
     -@@ t/t7900-maintenance.sh: test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
     - 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
     - '
       
     --test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
     -+test_expect_success !MACOS_MAINTENANCE,!MINGW 'stop from existing schedule' '
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
     +@@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
       
     - 	# stop does not unregister the repo
     -@@ t/t7900-maintenance.sh: test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
     - 	test_must_be_empty cron.txt
     - '
     + #if defined(__APPLE__)
     + static const char platform_scheduler[] = "launchctl";
     ++#elif defined(GIT_WINDOWS_NATIVE)
     ++static const char platform_scheduler[] = "schtasks";
     + #else
     + static const char platform_scheduler[] = "crontab";
     + #endif
     +@@ builtin/gc.c: static int update_background_schedule(int enable)
       
     --test_expect_success !MACOS_MAINTENANCE 'start preserves existing schedule' '
     -+test_expect_success !MACOS_MAINTENANCE,!MINGW 'start preserves existing schedule' '
     - 	echo "Important information!" >cron.txt &&
     - 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
     - 	grep "Important information!" cron.txt
     -@@ t/t7900-maintenance.sh: test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
     + 	if (!strcmp(scheduler, "launchctl"))
     + 		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
     ++	else if (!strcmp(scheduler, "schtasks"))
     ++		result = schtasks_update_schedule(enable, lk.tempfile->fd, cmd);
     + 	else if (!strcmp(scheduler, "crontab"))
     + 		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
     + 	else
     +
     + ## t/t7900-maintenance.sh ##
     +@@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS maintenance' '
       	test_line_count = 0 actual
       '
       
     -+test_expect_success MINGW 'start and stop Windows maintenance' '
     ++test_expect_success 'start and stop Windows maintenance' '
      +	write_script print-args <<-\EOF &&
      +	echo $* >>args
     ++	while test $# -gt 0
     ++	do
     ++		case "$1" in
     ++		/xml) shift; xmlfile=$1; break ;;
     ++		*) shift ;;
     ++		esac
     ++	done
     ++	test -z "$xmlfile" || cp "$xmlfile" .
      +	EOF
      +
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
      +
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/temp/schedule-%s.xml\n" \
     ++	printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
      +		hourly hourly daily daily weekly weekly >expect &&
      +	test_cmp expect args &&
      +
     ++	for frequency in hourly daily weekly
     ++	do
     ++		test_xmllint "schedule-$frequency.xml"
     ++	done &&
     ++
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance stop &&
     ++	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&
      +
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&

-- 
gitgitgadget
