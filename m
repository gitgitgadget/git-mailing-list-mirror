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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B0C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FCA2236F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH/MwMwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgKCOEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgKCODW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:03:22 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE4C0617A6
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 06:03:22 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so3467089wmg.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0dWYwY1UMHclsAWSGhds6Et6Ts3N5pObvdJeHdFKCN8=;
        b=OH/MwMwmlvoVK5rzNJxhmzI/vzArxqnKGwAhHulpZw1z8Ei4iNy9vmfngL8mFmAZO+
         fEhXBgCUwGA7c1jHZ8unT0/8uIf72V8DioDzDQwtcRfz0qTomonJgVgEGdKIo3n3dDof
         B6bermDlnrNx5snhPrwJF/WRd5szrQp/qvSx3q7ATxnu5EJA03ikOXmGir3M9MBYQBCQ
         KhXvDDNG4LhLqQ/5wmBHSohfOv9RKgj1UpGvndpA/hcnwQn2v5lS2TDBSbxYT6NLZs+d
         npIBuCfBJFlXsBWsHa1S7kK4q0pCgV8XJ1Yr6D0rP+6W0I0YpM067F6nZf0+qN577SQz
         hRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0dWYwY1UMHclsAWSGhds6Et6Ts3N5pObvdJeHdFKCN8=;
        b=VSuZP270oSGDw94uWH3CnS3iWusd8gxXxNxMmannRGpP5sCsYp5VfJJ5KX49xrCkeg
         /Rer6BPcThgpVjQoXZZ5kZ93VWG4EDQShcRXZHHEWiEmOWp1b4yU02dNiN9ARZb5WzHc
         YVkMt+OPHX//W8BWBwPgDgYxQiITvnC+DfJz2RhV7XHdU+EVzy0/vGZBjBX8VZAzaRUZ
         C1WlX32Zsa7VLT4/56Dq1wmfTZu2jzKd+7+tLMxm0B23WNMuhV26rVBWGe/yNWU8bYYA
         WcWYjiO1omu3w6RU7ovuVf0n++O7uX6NKp8KyBBcQS2k4BKd5PD487giATMLo/y9V0as
         0dbA==
X-Gm-Message-State: AOAM531XpPhq2uvyBD8FPJxL6IFdNXeZZuUV9tmtFcFZXdlB3y/P/9Lh
        WsoxAQioxs80vcIQ0HJdlW3bAxdnP98=
X-Google-Smtp-Source: ABdhPJyIg8XiSmmUVa3cL82UwH/Ux3LE5h17HimstO8rdh2wBkngLFM1C+GKZ/mS8vFwRxP2pT1VGg==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3799771wmd.48.1604412200801;
        Tue, 03 Nov 2020 06:03:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm26655169wrq.19.2020.11.03.06.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:03:20 -0800 (PST)
Message-Id: <a9221cc4aa12192e9a691f8e1b77a3cc2d7e4952.1604412197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 14:03:16 +0000
Subject: [PATCH 3/3] maintenance: use Windows scheduled tasks
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

Git's background maintenance uses cron by default, but this is not
available on Windows. Instead, integrate with Task Scheduler.

Tasks can be scheduled using the 'schtasks' command. There are several
command-line options that can allow for some advanced scheduling, but
unfortunately these seem to all require authenticating using a password.

Instead, use the "/xml" option to pass an XML file that contains the
configuration for the necessary schedule. These XML files are based on
some that I exported after constructing a schedule in the Task Scheduler
GUI. These options only run background maintenance when the user is
logged in, and more fields are populated with the current username and
SID at run-time by 'schtasks'.

There is a deficiency in the current design. Windows has two kinds of
applications: GUI applications that start by "winmain()" and console
applications that start by "main()". Console applications are attached
to a new Console window if they are not already associated with a GUI
application. This means that every hour the scheudled task launches a
command window for the scheduled tasks. Not only is this visually
obtrusive, but it also takes focus from whatever else the user is
doing!

A simple fix would be to insert a GUI application that acts as a shim
between the scheduled task and Git. This is currently possible in Git
for Windows by setting the <Command> tag equal to

  C:\Program Files\Git\git-bash.exe

with options "--hide --no-needs-console --command=cmd\git.exe"
followed by the arguments currently used. Since git-bash.exe is not
included in Windows builds of core Git, I chose to leave out this
feature. My plan is to submit a small patch to Git for Windows that
converts the use of git.exe with this use of git-bash.exe in the
short term. In the long term, we can consider creating this GUI
shim application within core Git, perhaps in contrib/.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 181 +++++++++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh |  40 ++++++++-
 2 files changed, 218 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fa0ae63a80..24511fec2e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1698,6 +1698,187 @@ static int platform_update_schedule(int run_maintenance, int fd)
 	else
 		return remove_plists();
 }
+
+#elif defined(GIT_WINDOWS_NATIVE)
+
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
+
+static char *get_task_name(const char *frequency)
+{
+	struct strbuf label = STRBUF_INIT;
+	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
+	return strbuf_detach(&label, NULL);
+}
+
+static int remove_task(enum schedule_priority schedule)
+{
+	int result;
+	struct strvec args = STRVEC_INIT;
+	const char *frequency = get_frequency(schedule);
+	char *name = get_task_name(frequency);
+	const char *schtasks = getenv("GIT_TEST_CRONTAB");
+	if (!schtasks)
+		schtasks = "schtasks";
+
+	strvec_split(&args, schtasks);
+	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
+
+	result = run_command_v_opt(args.v, 0);
+
+	strvec_clear(&args);
+	free(name);
+	return result;
+}
+
+static int remove_scheduled_tasks(void)
+{
+	return remove_task(SCHEDULE_HOURLY) ||
+		remove_task(SCHEDULE_DAILY) ||
+		remove_task(SCHEDULE_WEEKLY);
+}
+
+static int schedule_task(const char *exec_path, enum schedule_priority schedule)
+{
+	int result;
+	struct strvec args = STRVEC_INIT;
+	const char *xml, *schtasks;
+	char *xmlpath;
+	FILE *xmlfp;
+	const char *frequency = get_frequency(schedule);
+	char *name = get_task_name(frequency);
+
+	xmlpath =  xstrfmt("%s/schedule-%s.xml",
+			   the_repository->objects->odb->path,
+			   frequency);
+	xmlfp = fopen(xmlpath, "w");
+	if (!xmlfp)
+		die(_("failed to open '%s'"), xmlpath);
+
+	xml = "<?xml version=\"1.0\" encoding=\"UTF-16\"?>\n"
+	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
+	      "<Triggers>\n"
+	      "<CalendarTrigger>\n";
+	fprintf(xmlfp, xml);
+
+	switch (schedule) {
+	case SCHEDULE_HOURLY:
+		fprintf(xmlfp,
+			"<StartBoundary>2020-01-01T01:00:00</StartBoundary>\n"
+			"<Enabled>true</Enabled>\n"
+			"<ScheduleByDay>\n"
+			"<DaysInterval>1</DaysInterval>\n"
+			"</ScheduleByDay>\n"
+			"<Repetition>\n"
+			"<Interval>PT1H</Interval>\n"
+			"<Duration>PT23H</Duration>\n"
+			"<StopAtDurationEnd>false</StopAtDurationEnd>\n"
+			"</Repetition>\n");
+		break;
+
+	case SCHEDULE_DAILY:
+		fprintf(xmlfp,
+			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
+			"<Enabled>true</Enabled>\n"
+			"<ScheduleByWeek>\n"
+			"<DaysOfWeek>\n"
+			"<Monday />\n"
+			"<Tuesday />\n"
+			"<Wednesday />\n"
+			"<Thursday />\n"
+			"<Friday />\n"
+			"<Saturday />\n"
+			"</DaysOfWeek>\n"
+			"<WeeksInterval>1</WeeksInterval>\n"
+			"</ScheduleByWeek>\n");
+		break;
+
+	case SCHEDULE_WEEKLY:
+		fprintf(xmlfp,
+			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
+			"<Enabled>true</Enabled>\n"
+			"<ScheduleByWeek>\n"
+			"<DaysOfWeek>\n"
+			"<Sunday />\n"
+			"</DaysOfWeek>\n"
+			"<WeeksInterval>1</WeeksInterval>\n"
+			"</ScheduleByWeek>\n");
+		break;
+
+	default:
+		break;
+	}
+
+	xml=  "</CalendarTrigger>\n"
+	      "</Triggers>\n"
+	      "<Principals>\n"
+	      "<Principal id=\"Author\">\n"
+	      "<LogonType>InteractiveToken</LogonType>\n"
+	      "<RunLevel>LeastPrivilege</RunLevel>\n"
+	      "</Principal>\n"
+	      "</Principals>\n"
+	      "<Settings>\n"
+	      "<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>\n"
+	      "<Enabled>true</Enabled>\n"
+	      "<Hidden>true</Hidden>\n"
+	      "<UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>\n"
+	      "<WakeToRun>false</WakeToRun>\n"
+	      "<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>\n"
+	      "<Priority>7</Priority>\n"
+	      "</Settings>\n"
+	      "<Actions Context=\"Author\">\n"
+	      "<Exec>\n"
+	      "<Command>\"%s\\git.exe\"</Command>\n"
+	      "<Arguments>--exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
+	      "</Exec>\n"
+	      "</Actions>\n"
+	      "</Task>\n";
+	fprintf(xmlfp, xml, exec_path, exec_path, frequency);
+	fclose(xmlfp);
+
+	schtasks = getenv("GIT_TEST_CRONTAB");
+	if (!schtasks)
+		schtasks = "schtasks";
+	strvec_split(&args, schtasks);
+	strvec_pushl(&args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
+
+	result = run_command_v_opt(args.v, 0);
+
+	strvec_clear(&args);
+	unlink(xmlpath);
+	free(xmlpath);
+	free(name);
+	return result;
+}
+
+static int add_scheduled_tasks(void)
+{
+	const char *exec_path = git_exec_path();
+
+	return schedule_task(exec_path, SCHEDULE_HOURLY) ||
+		schedule_task(exec_path, SCHEDULE_DAILY) ||
+		schedule_task(exec_path, SCHEDULE_WEEKLY);
+}
+
+static int platform_update_schedule(int run_maintenance, int fd)
+{
+	if (run_maintenance)
+		return add_scheduled_tasks();
+	else
+		return remove_scheduled_tasks();
+}
+
 #else
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index f0210aa206..73dc0078da 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -367,7 +367,7 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
-test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
+test_expect_success !MACOS_MAINTENANCE,!MINGW 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
@@ -378,7 +378,7 @@ test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
-test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
+test_expect_success !MACOS_MAINTENANCE,!MINGW 'stop from existing schedule' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
@@ -389,7 +389,7 @@ test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
 	test_must_be_empty cron.txt
 '
 
-test_expect_success !MACOS_MAINTENANCE 'start preserves existing schedule' '
+test_expect_success !MACOS_MAINTENANCE,!MINGW 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 	grep "Important information!" cron.txt
@@ -441,6 +441,40 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
 	test_cmp expect args
 '
 
+test_expect_success MINGW 'start and stop Windows maintenance' '
+	echo "echo \$@ >>args" >print-args &&
+	chmod a+x print-args &&
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
+	cat args &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	rm expect &&
+	for frequency in hourly daily weekly
+	do
+		echo "/create /tn Git Maintenance ($frequency) /f /xml .git/objects/schedule-$frequency.xml" >>expect \
+			|| return 1
+	done &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="/bin/sh print-args"  git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	rm expect &&
+	for frequency in hourly daily weekly
+	do
+		echo "/delete /tn Git Maintenance ($frequency) /f" >>expect \
+			|| return 1
+	done &&
+	test_cmp expect args
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
-- 
gitgitgadget
