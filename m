Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C90DC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 09:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23FD22249
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 09:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvJJ2L3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKNJX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 04:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgKNJX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 04:23:56 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A6C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 01:23:55 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m13so12270969ioq.9
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 01:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjRHrQZoehZ7o+EzyRoi203Pli8drMZ38AWkaCp8Zqc=;
        b=jvJJ2L3Gg1xGTZH8QQZgPpvPjG1PUvejPvX9MDMfE4oMszVd6d/hhG17L9D/zEuV9w
         6Tky4NQqrRficdlAgVsCAmVcDrJiKj9IqRW+/UJSmQzLvzykh/J3lbFoOchbwP7dkmuX
         c/3Fr4XTe51txg88QAku+yNng0d/gSLuBgS8WPhq7z36+2mK1TFjgsOkAiE2/9r7pJFr
         hgejdB6w5CMtHs6EVRxtmdAZhzH3HnazD2113gUZpiOYMn1VBTURHh1WWNlG0NYf1MUT
         z0bLyc6TbypIvGcajPhJaABh0IzaMsk7k4BX7oS6e7olVkWtVj0fFxWMZq2XVptfOlAH
         iCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MjRHrQZoehZ7o+EzyRoi203Pli8drMZ38AWkaCp8Zqc=;
        b=iELesJnesnyWzvC0MIFbsJ6GK9stLSUfmLdDzpnPGld6om2YtGVe+hyqyGDvyd/wrw
         NBHfwEt0GisA3Wyl28jESzKG8ItCUJbdk/9wMGqqdUFnuhSoGYtHeYVPVHVqPpQiSFoP
         idnoBJCy6lkIJR/DxwYqG20+yUlHTlz2rgJajMda6qw4c3mZs39TIUYZPWEOUUDN7x1/
         kKYONM7oV4eHJgtJpN3zfgcshankizvCNYNUpxx7MEYRzptyUnbU22ptAui1nPAbAQZE
         0QzTlGn0pUv0Cags3qoJw8xW8dyZtEhr2Rv8QyHBjfhD8fkt7Xof2HFv9/WzrwLCayHJ
         jp5g==
X-Gm-Message-State: AOAM533VNBoLG7v1QIkG8dFHhYBHIquiCBd6wq7EzoSfVdAiLopg8ujI
        B3Ci3nEMwsh6cimJz976rJU=
X-Google-Smtp-Source: ABdhPJyuvnUZpvvmd1K2UW8mw9V48srPvfj6RhEDkOMUI+9W6Sxdr4+1+BQBmflz15zjt6yPJUWjNA==
X-Received: by 2002:a5d:8151:: with SMTP id f17mr2701658ioo.129.1605345834943;
        Sat, 14 Nov 2020 01:23:54 -0800 (PST)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id i16sm5852358ioh.30.2020.11.14.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 01:23:54 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 14 Nov 2020 04:23:48 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] Maintenance IV: Platform-specific background
 maintenance
Message-ID: <X6+iJNYEbpQjHCb0@flurp.local>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <CAPig+cRPKZGR0XKv4vwtP-xpzYDpB6PL-=Q7weeWtTbDG7o3vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRPKZGR0XKv4vwtP-xpzYDpB6PL-=Q7weeWtTbDG7o3vQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 03:47:15PM -0500, Eric Sunshine wrote:
> I forgot to mention a couple things when reviewing the patches
> individually, so I'll point them out here...

In v2, you added an `xmllint` check on MacOS after discovering that
gc.c was generating a malformed .plist file on that platform. That got
me thinking that it would have been nice to have caught the problem
earlier, if possible, even without having access to MacOS. Since none
of the code added to gc.c has a hard platform dependency, it should be
possible to perform all the tests on any platform rather than
restricting them to specific platforms via test prerequisites. The
patch below, which is built atop v3, does just that. It removes the
conditional compilation directives from gc.c and the prerequisites
from the test script so that all scheduler-specific code in gc.c is
tested on all platform.

The changes made by the patch are intended to be folded into each of
your patches where appropriate (rather than existing atop your series,
which, though possible, would be ugly). If you're interested in
incorporating any of these improvements into v4, you can have my
"Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>" in addition
to the Helped-by: you already added.

A few more notes...

In addition to making it possible to test all platform-specific
schedulers on each platform, I also made a few other
changes/enhancements:

* simplified UID retrieval and eliminated platform-specific
  dependencies (though this may need some additional tweaking on
  Windows, for which I did not test); also fixed the $UID issue
  mentioned in review

* extended xmllint testing to the XML files generated for `schtasks`
  on Windows too; this required a small modification to the XML header
  boilerplate to specify the correct file encoding since `xmllint`
  complains when the file is UTF-8 but claims to be UTF-16; now that
  the test script captures the generated `schtasks` XML file for
  checking against `xmllint`, you have the opportunity to perform
  other sorts of validation checks on the XML too, such as you do in
  the MacOS `launchctl` test (though I did not add any additional
  checks)

* fixed a potentially crashable `fprintf(xmlfp, xml)` by changing it
  to `fputs(xml, xmlfp)` since the compiler complains about the former
  because it can crash if `xml` contains a "%"

* fixed the malformed write_script() issue for the MacOS test
  mentioned in review

--- >8 ---
From 016887b9fa4269bd4df46bea1d7849c08aba6ad6 Mon Sep 17 00:00:00 2001
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 14 Nov 2020 02:39:05 -0500
Subject: [PATCH] maintenance: test start/stop on all platforms from any
 platform

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/gc.c           | 204 +++++++++++++++++++----------------------
 t/t7900-maintenance.sh |  66 +++++++++----
 t/test-lib.sh          |   4 -
 3 files changed, 143 insertions(+), 131 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 76a3afa20a..955d4b3baf 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1491,16 +1491,28 @@ static int maintenance_unregister(void)
 	return run_command(&config_unset);
 }
 
-#if defined(__APPLE__)
+static const char *get_frequency(enum schedule_priority schedule)
+{
+	switch (schedule) {
+	case SCHEDULE_HOURLY:
+		return "hourly";
+	case SCHEDULE_DAILY:
+		return "daily";
+	case SCHEDULE_WEEKLY:
+		return "weekly";
+	default:
+		BUG("invalid schedule %d", schedule);
+	}
+}
 
-static char *get_service_name(const char *frequency)
+static char *launchctl_service_name(const char *frequency)
 {
 	struct strbuf label = STRBUF_INIT;
 	strbuf_addf(&label, "org.git-scm.git.%s", frequency);
 	return strbuf_detach(&label, NULL);
 }
 
-static char *get_service_filename(const char *name)
+static char *launchctl_service_filename(const char *name)
 {
 	char *expanded;
 	struct strbuf filename = STRBUF_INIT;
@@ -1514,49 +1526,23 @@ static char *get_service_filename(const char *name)
 	return expanded;
 }
 
-static const char *get_frequency(enum schedule_priority schedule)
-{
-	switch (schedule) {
-	case SCHEDULE_HOURLY:
-		return "hourly";
-	case SCHEDULE_DAILY:
-		return "daily";
-	case SCHEDULE_WEEKLY:
-		return "weekly";
-	default:
-		BUG("invalid schedule %d", schedule);
-	}
-}
-
-static char *get_uid(void)
+static char *launchctl_get_uid(void)
 {
-	struct strbuf output = STRBUF_INIT;
-	struct child_process id = CHILD_PROCESS_INIT;
-
-	strvec_pushl(&id.args, "/usr/bin/id", "-u", NULL);
-	if (capture_command(&id, &output, 0))
-		die(_("failed to discover user id"));
-
-	strbuf_trim_trailing_newline(&output);
-	return strbuf_detach(&output, NULL);
+	return xstrfmt("gui/%d", getuid());
 }
 
-static int boot_plist(int enable, const char *filename)
+static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
 {
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
-	char *uid = get_uid();
-	const char *launchctl = getenv("GIT_TEST_CRONTAB");
-	if (!launchctl)
-		launchctl = "/bin/launchctl";
-
-	strvec_split(&child.args, launchctl);
+	char *uid = launchctl_get_uid();
 
+	strvec_split(&child.args, cmd);
 	if (enable)
 		strvec_push(&child.args, "bootstrap");
 	else
 		strvec_push(&child.args, "bootout");
-	strvec_pushf(&child.args, "gui/%s", uid);
+	strvec_push(&child.args, uid);
 	strvec_push(&child.args, filename);
 
 	child.no_stderr = 1;
@@ -1571,33 +1557,33 @@ static int boot_plist(int enable, const char *filename)
 	return result;
 }
 
-static int remove_plist(enum schedule_priority schedule)
+static int launchctl_remove_plist(enum schedule_priority schedule, const char *cmd)
 {
 	const char *frequency = get_frequency(schedule);
-	char *name = get_service_name(frequency);
-	char *filename = get_service_filename(name);
-	int result = boot_plist(0, filename);
+	char *name = launchctl_service_name(frequency);
+	char *filename = launchctl_service_filename(name);
+	int result = launchctl_boot_plist(0, filename, cmd);
 	unlink(filename);
 	free(filename);
 	free(name);
 	return result;
 }
 
-static int remove_plists(void)
+static int launchctl_remove_plists(const char *cmd)
 {
-	return remove_plist(SCHEDULE_HOURLY) ||
-		remove_plist(SCHEDULE_DAILY) ||
-		remove_plist(SCHEDULE_WEEKLY);
+	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
+		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
+		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
 }
 
-static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
+static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
 {
 	FILE *plist;
 	int i;
 	const char *preamble, *repeat;
 	const char *frequency = get_frequency(schedule);
-	char *name = get_service_name(frequency);
-	char *filename = get_service_filename(name);
+	char *name = launchctl_service_name(frequency);
+	char *filename = launchctl_service_filename(name);
 
 	if (safe_create_leading_directories(filename))
 		die(_("failed to create directories for '%s'"), filename);
@@ -1658,8 +1644,8 @@ static int schedule_plist(const char *exec_path, enum schedule_priority schedule
 	fprintf(plist, "</array>\n</dict>\n</plist>\n");
 
 	/* bootout might fail if not already running, so ignore */
-	boot_plist(0, filename);
-	if (boot_plist(1, filename))
+	launchctl_boot_plist(0, filename, cmd);
+	if (launchctl_boot_plist(1, filename, cmd))
 		die(_("failed to bootstrap service %s"), filename);
 
 	fclose(plist);
@@ -1668,57 +1654,38 @@ static int schedule_plist(const char *exec_path, enum schedule_priority schedule
 	return 0;
 }
 
-static int add_plists(void)
+static int launchctl_add_plists(const char *cmd)
 {
 	const char *exec_path = git_exec_path();
 
-	return schedule_plist(exec_path, SCHEDULE_HOURLY) ||
-		schedule_plist(exec_path, SCHEDULE_DAILY) ||
-		schedule_plist(exec_path, SCHEDULE_WEEKLY);
+	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY, cmd) ||
+		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY, cmd) ||
+		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
 }
 
-static int platform_update_schedule(int run_maintenance, int fd)
+static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
 {
 	if (run_maintenance)
-		return add_plists();
+		return launchctl_add_plists(cmd);
 	else
-		return remove_plists();
-}
-
-#elif defined(GIT_WINDOWS_NATIVE)
-
-static const char *get_frequency(enum schedule_priority schedule)
-{
-	switch (schedule) {
-	case SCHEDULE_HOURLY:
-		return "hourly";
-	case SCHEDULE_DAILY:
-		return "daily";
-	case SCHEDULE_WEEKLY:
-		return "weekly";
-	default:
-		BUG("invalid schedule %d", schedule);
-	}
+		return launchctl_remove_plists(cmd);
 }
 
-static char *get_task_name(const char *frequency)
+static char *schtasks_task_name(const char *frequency)
 {
 	struct strbuf label = STRBUF_INIT;
 	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
 	return strbuf_detach(&label, NULL);
 }
 
-static int remove_task(enum schedule_priority schedule)
+static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd)
 {
 	int result;
 	struct strvec args = STRVEC_INIT;
 	const char *frequency = get_frequency(schedule);
-	char *name = get_task_name(frequency);
-	const char *schtasks = getenv("GIT_TEST_CRONTAB");
-	if (!schtasks)
-		schtasks = "schtasks";
+	char *name = schtasks_task_name(frequency);
 
-	strvec_split(&args, schtasks);
+	strvec_split(&args, cmd);
 	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
 
 	result = run_command_v_opt(args.v, 0);
@@ -1728,33 +1695,33 @@ static int remove_task(enum schedule_priority schedule)
 	return result;
 }
 
-static int remove_scheduled_tasks(void)
+static int schtasks_remove_tasks(const char *cmd)
 {
-	return remove_task(SCHEDULE_HOURLY) ||
-		remove_task(SCHEDULE_DAILY) ||
-		remove_task(SCHEDULE_WEEKLY);
+	return schtasks_remove_task(SCHEDULE_HOURLY, cmd) ||
+		schtasks_remove_task(SCHEDULE_DAILY, cmd) ||
+		schtasks_remove_task(SCHEDULE_WEEKLY, cmd);
 }
 
-static int schedule_task(const char *exec_path, enum schedule_priority schedule)
+static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
 {
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
-	const char *xml, *schtasks;
+	const char *xml;
 	char *xmlpath, *tempDir;
 	FILE *xmlfp;
 	const char *frequency = get_frequency(schedule);
-	char *name = get_task_name(frequency);
+	char *name = schtasks_task_name(frequency);
 
 	tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
 	xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
 	safe_create_leading_directories(xmlpath);
 	xmlfp = xfopen(xmlpath, "w");
 
-	xml = "<?xml version=\"1.0\" encoding=\"UTF-16\"?>\n"
+	xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
 	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
 	      "<Triggers>\n"
 	      "<CalendarTrigger>\n";
-	fprintf(xmlfp, xml);
+	fputs(xml, xmlfp);
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
@@ -1831,10 +1798,7 @@ static int schedule_task(const char *exec_path, enum schedule_priority schedule)
 	fprintf(xmlfp, xml, exec_path, exec_path, frequency);
 	fclose(xmlfp);
 
-	schtasks = getenv("GIT_TEST_CRONTAB");
-	if (!schtasks)
-		schtasks = "schtasks";
-	strvec_split(&child.args, schtasks);
+	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
 
 	child.no_stdout = 1;
@@ -1851,42 +1815,36 @@ static int schedule_task(const char *exec_path, enum schedule_priority schedule)
 	return result;
 }
 
-static int add_scheduled_tasks(void)
+static int schtasks_schedule_tasks(const char *cmd)
 {
 	const char *exec_path = git_exec_path();
 
-	return schedule_task(exec_path, SCHEDULE_HOURLY) ||
-		schedule_task(exec_path, SCHEDULE_DAILY) ||
-		schedule_task(exec_path, SCHEDULE_WEEKLY);
+	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY, cmd) ||
+		schtasks_schedule_task(exec_path, SCHEDULE_DAILY, cmd) ||
+		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
 }
 
-static int platform_update_schedule(int run_maintenance, int fd)
+static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
 {
 	if (run_maintenance)
-		return add_scheduled_tasks();
+		return schtasks_schedule_tasks(cmd);
 	else
-		return remove_scheduled_tasks();
+		return schtasks_remove_tasks(cmd);
 }
 
-#else
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
-static int platform_update_schedule(int run_maintenance, int fd)
+static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 {
 	int result = 0;
 	int in_old_region = 0;
 	struct child_process crontab_list = CHILD_PROCESS_INIT;
 	struct child_process crontab_edit = CHILD_PROCESS_INIT;
 	FILE *cron_list, *cron_in;
-	const char *crontab_name;
 	struct strbuf line = STRBUF_INIT;
 
-	crontab_name = getenv("GIT_TEST_CRONTAB");
-	if (!crontab_name)
-		crontab_name = "crontab";
-
-	strvec_split(&crontab_list.args, crontab_name);
+	strvec_split(&crontab_list.args, cmd);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
 	crontab_list.out = dup(fd);
@@ -1906,7 +1864,7 @@ static int platform_update_schedule(int run_maintenance, int fd)
 	cron_list = fdopen(fd, "r");
 	rewind(cron_list);
 
-	strvec_split(&crontab_edit.args, crontab_name);
+	strvec_split(&crontab_edit.args, cmd);
 	crontab_edit.in = -1;
 	crontab_edit.git_cmd = 0;
 
@@ -1963,20 +1921,48 @@ static int platform_update_schedule(int run_maintenance, int fd)
 		fclose(cron_list);
 	return result;
 }
+
+#if defined(__APPLE__)
+static const char platform_scheduler[] = "launchctl";
+#elif defined(GIT_WINDOWS_NATIVE)
+static const char platform_scheduler[] = "schtasks";
+#else
+static const char platform_scheduler[] = "crontab";
 #endif
 
-static int update_background_schedule(int run_maintenance)
+static int update_background_schedule(int enable)
 {
 	int result;
+	const char *scheduler = platform_scheduler;
+	const char *cmd = scheduler;
+	char *testing;
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
 
+	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
+	if (testing) {
+		char *sep = strchr(testing, ':');
+		if (!sep)
+			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
+		*sep = '\0';
+		scheduler = testing;
+		cmd = sep + 1;
+	}
+
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
 		return error(_("another process is scheduling background maintenance"));
 
-	result = platform_update_schedule(run_maintenance, lk.tempfile->fd);
+	if (!strcmp(scheduler, "launchctl"))
+		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
+	else if (!strcmp(scheduler, "schtasks"))
+		result = schtasks_update_schedule(enable, lk.tempfile->fd, cmd);
+	else if (!strcmp(scheduler, "crontab"))
+		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
+	else
+		die("unknown background scheduler: %s", scheduler);
 
 	rollback_lock_file(&lk);
+	free(testing);
 	return result;
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0dc2479117..e92946c10a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -7,6 +7,19 @@ test_description='git maintenance builtin'
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_MULTI_PACK_INDEX=0
 
+test_lazy_prereq XMLLINT '
+	xmllint --version
+'
+
+test_xmllint () {
+	if test_have_prereq XMLLINT
+	then
+		xmllint --noout "$@"
+	else
+		true
+	fi
+}
+
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance <subcommand>" err &&
@@ -367,8 +380,8 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
-test_expect_success !MACOS_MAINTENANCE,!MINGW 'start from empty cron table' '
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+test_expect_success 'start from empty cron table' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
@@ -378,28 +391,32 @@ test_expect_success !MACOS_MAINTENANCE,!MINGW 'start from empty cron table' '
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
-test_expect_success !MACOS_MAINTENANCE,!MINGW 'stop from existing schedule' '
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+test_expect_success 'stop from existing schedule' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
 	# Operation is idempotent
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 	test_must_be_empty cron.txt
 '
 
-test_expect_success !MACOS_MAINTENANCE,!MINGW 'start preserves existing schedule' '
+test_expect_success 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
-	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
 	grep "Important information!" cron.txt
 '
 
-test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
-	write_script print-args "#!/bin/sh\necho \$* >>args" &&
+test_expect_success 'start and stop macOS maintenance' '
+	uid=$(id -u) &&
+
+	write_script print-args <<-\EOF &&
+	echo $* >>args
+	EOF
 
 	rm -f args &&
-	GIT_TEST_CRONTAB="./print-args" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
 
 	# start registers the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
@@ -417,33 +434,41 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
 	for frequency in hourly daily weekly
 	do
 		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
-		xmllint --noout "$PLIST" &&
+		test_xmllint "$PLIST" &&
 		grep schedule=$frequency "$PLIST" &&
-		echo "bootout gui/$UID $PLIST" >>expect &&
-		echo "bootstrap gui/$UID $PLIST" >>expect || return 1
+		echo "bootout gui/$uid $PLIST" >>expect &&
+		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
 	done &&
 	test_cmp expect args &&
 
 	rm -f args &&
-	GIT_TEST_CRONTAB="./print-args" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
 
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
-	printf "bootout gui/$UID $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >expect &&
 	test_cmp expect args &&
 	ls "$HOME/Library/LaunchAgents" >actual &&
 	test_line_count = 0 actual
 '
 
-test_expect_success MINGW 'start and stop Windows maintenance' '
+test_expect_success 'start and stop Windows maintenance' '
 	write_script print-args <<-\EOF &&
 	echo $* >>args
+	while test $# -gt 0
+	do
+		case "$1" in
+		/xml) shift; xmlfile=$1; break ;;
+		*) shift ;;
+		esac
+	done
+	test -z "$xmlfile" || cp "$xmlfile" .
 	EOF
 
 	rm -f args &&
-	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:/bin/sh print-args" git maintenance start &&
 
 	# start registers the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
@@ -452,8 +477,13 @@ test_expect_success MINGW 'start and stop Windows maintenance' '
 		hourly hourly daily daily weekly weekly >expect &&
 	test_cmp expect args &&
 
+	for frequency in hourly daily weekly
+	do
+		test_xmllint "schedule-$frequency.xml"
+	done &&
+
 	rm -f args &&
-	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:/bin/sh print-args" git maintenance stop &&
 
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 620ffbf3af..4a60d1ed76 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1703,10 +1703,6 @@ test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
 
-test_lazy_prereq MACOS_MAINTENANCE '
-	launchctl list
-'
-
 # Ensure that no test accidentally triggers a Git command
 # that runs 'crontab', affecting a user's cron schedule.
 # Tests that verify the cron integration must set this locally
-- 
2.29.2.454.gaff20da3a2

