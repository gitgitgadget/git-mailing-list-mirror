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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88826C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5067E23C91
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgLITcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgLITbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:31:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9442AC0619E3
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:29:09 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id q75so2902999wme.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFRcQ852RwNbb1VwF2AgrN1Q0DMPG2usrZg4fYN6HK4=;
        b=bOe1Oy9DjzpGtmGngY8iw99t/T877835c+K77n2tnjZPPS37lFF+HvZA1Ne+Tesw9o
         6SuLmhTFmzhig6B64utn0i5TdCj+Bl/iz7ATSvVHrJuUPshJjnIaxoFbGAXdPYaU9RI/
         h+ef2LBLBTrv3CklctzOLu6qDo8aI+nARnv8GoChU14MGcnsWowG/ekfVesJrWZjwpjN
         qJ2nt7sBApzGkmJLJOBQ6CZsHd2bs3630lCanhUVuzqKqtBssQlT7/aCIx3lrzyKm697
         P5kDUR5gIy/YUByEP68pzM8b03zDQGM75M3hlwO+CRDq8I/6N55sctAh5tpxyZ9R2b/y
         RUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFRcQ852RwNbb1VwF2AgrN1Q0DMPG2usrZg4fYN6HK4=;
        b=feJiA5NRTvqUDmSo1aL9NBXkW3dv6U0GNUw+1wRoDgMdRbwPZtO00tS8ei3c+KbaIM
         FGpTpUPaVa+HEuNbdM/bZfXClZFDrb8d/ZoAjQ9W0G2FAUoGQxXFCbjIlv6xRLZEh7vc
         msY65X9sskLwZI0EFrAvFtr7ATPkAwuq4vCJ7W9plKMvuPYahHwOA6kkCTJkFFivoEro
         bH9nxzES0KZiDV1CCiIWO9zlREwAYTwah7GVJxRuBkIF/b4W51J+0yYc6BGhdxOeremq
         cjgaRVcgi/o3XurQEsefRQ07WeUV7SARqg2pAshoO7DmBKq0g79d1LPcd74E5M0THHkO
         Zarw==
X-Gm-Message-State: AOAM532GsqVmbodI0tVkEHhHprnhByYEfF0X9yr2//2fd1sDn9CLJ448
        fuDEOkk1/U7JyS4UelGELTyLFpU4Dno=
X-Google-Smtp-Source: ABdhPJwW3zCByaqiZzfjBz5M148qMoLdb3vunyIq1Irs5W+dn9GICYfVDirc6ZhCs0J6PNMoaKHtFA==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr4290967wma.66.1607542147965;
        Wed, 09 Dec 2020 11:29:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm5618493wrn.65.2020.12.09.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:29:07 -0800 (PST)
Message-Id: <6ad4a6b98c63abc243bb16cfd10fbd583e90a3ae.1607542142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
        <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:29:02 +0000
Subject: [PATCH v6 4/4] maintenance: use Windows scheduled tasks
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

Since the GIT_TEST_MAINT_SCHEDULER environment variable allows us to
specify 'schtasks' as the scheduler, we can test the Windows-specific
logic on other platforms. Thus, add a check that the XML file written
by Git is valid when xmllint exists on the system.

Since we use a temporary file for the XML files sent to 'schtasks', we
prefix the random characters with the frequency so it is easier to
examine the proper file during tests. Instead of an exact match on the
'args' file, we 'grep' for the arguments other than the filename.

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

Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  22 ++++
 builtin/gc.c                      | 165 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  39 +++++++
 3 files changed, 226 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 5f8f63f0988..6970f2b8983 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -313,6 +313,28 @@ To create more advanced customizations to your background tasks, see
 launchctl.plist(5) for more information.
 
 
+BACKGROUND MAINTENANCE ON WINDOWS SYSTEMS
+-----------------------------------------
+
+Windows does not support `cron` and instead has its own system for
+scheduling background tasks. The `git maintenance start` command uses
+the `schtasks` command to submit tasks to this system. You can inspect
+all background tasks using the Task Scheduler application. The tasks
+added by Git have names of the form `Git Maintenance (<frequency>)`.
+The Task Scheduler GUI has ways to inspect these tasks, but you can also
+export the tasks to XML files and view the details there.
+
+Note that since Git is a console application, these background tasks
+create a console window visible to the current user. This can be changed
+manually by selecting the "Run whether user is logged in or not" option
+in Task Scheduler. This change requires a password input, which is why
+`git maintenance start` does not select it by default.
+
+If you want to customize the background tasks, please rename the tasks
+so future calls to `git maintenance (start|stop)` do not overwrite your
+custom tasks.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index 782769f2438..7c989904671 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1671,6 +1671,167 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
 		return launchctl_remove_plists(cmd);
 }
 
+static char *schtasks_task_name(const char *frequency)
+{
+	struct strbuf label = STRBUF_INIT;
+	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
+	return strbuf_detach(&label, NULL);
+}
+
+static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd)
+{
+	int result;
+	struct strvec args = STRVEC_INIT;
+	const char *frequency = get_frequency(schedule);
+	char *name = schtasks_task_name(frequency);
+
+	strvec_split(&args, cmd);
+	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
+
+	result = run_command_v_opt(args.v, 0);
+
+	strvec_clear(&args);
+	free(name);
+	return result;
+}
+
+static int schtasks_remove_tasks(const char *cmd)
+{
+	return schtasks_remove_task(SCHEDULE_HOURLY, cmd) ||
+		schtasks_remove_task(SCHEDULE_DAILY, cmd) ||
+		schtasks_remove_task(SCHEDULE_WEEKLY, cmd);
+}
+
+static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
+{
+	int result;
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *xml;
+	struct tempfile *tfile;
+	const char *frequency = get_frequency(schedule);
+	char *name = schtasks_task_name(frequency);
+	struct strbuf tfilename = STRBUF_INIT;
+
+	strbuf_addf(&tfilename, "schedule_%s_XXXXXX", frequency);
+	tfile = xmks_tempfile(tfilename.buf);
+	strbuf_release(&tfilename);
+
+	if (!fdopen_tempfile(tfile, "w"))
+		die(_("failed to create temp xml file"));
+
+	xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
+	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
+	      "<Triggers>\n"
+	      "<CalendarTrigger>\n";
+	fputs(xml, tfile->fp);
+
+	switch (schedule) {
+	case SCHEDULE_HOURLY:
+		fprintf(tfile->fp,
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
+		fprintf(tfile->fp,
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
+		fprintf(tfile->fp,
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
+	xml = "</CalendarTrigger>\n"
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
+	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml",
+				  get_tempfile_path(tfile), NULL);
+	close_tempfile_gently(tfile);
+
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+
+	if (start_command(&child))
+		die(_("failed to start schtasks"));
+	result = finish_command(&child);
+
+	delete_tempfile(&tfile);
+	free(name);
+	return result;
+}
+
+static int schtasks_schedule_tasks(const char *cmd)
+{
+	const char *exec_path = git_exec_path();
+
+	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY, cmd) ||
+		schtasks_schedule_task(exec_path, SCHEDULE_DAILY, cmd) ||
+		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
+}
+
+static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
+{
+	if (run_maintenance)
+		return schtasks_schedule_tasks(cmd);
+	else
+		return schtasks_remove_tasks(cmd);
+}
+
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
@@ -1761,6 +1922,8 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 
 #if defined(__APPLE__)
 static const char platform_scheduler[] = "launchctl";
+#elif defined(GIT_WINDOWS_NATIVE)
+static const char platform_scheduler[] = "schtasks";
 #else
 static const char platform_scheduler[] = "crontab";
 #endif
@@ -1789,6 +1952,8 @@ static int update_background_schedule(int enable)
 
 	if (!strcmp(scheduler, "launchctl"))
 		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
+	else if (!strcmp(scheduler, "schtasks"))
+		result = schtasks_update_schedule(enable, lk.tempfile->fd, cmd);
 	else if (!strcmp(scheduler, "crontab"))
 		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
 	else
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6d373129016..f080c29a61d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -453,6 +453,45 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	test_line_count = 0 actual
 '
 
+test_expect_success 'start and stop Windows maintenance' '
+	write_script print-args <<-\EOF &&
+	echo $* >>args
+	while test $# -gt 0
+	do
+		case "$1" in
+		/xml) shift; xmlfile=$1; break ;;
+		*) shift ;;
+		esac
+	done
+	test -z "$xmlfile" || cp "$xmlfile" "$xmlfile.xml"
+	EOF
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" GIT_TRACE2_PERF=1 git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	for frequency in hourly daily weekly
+	do
+		grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
+		file=$(ls schedule_$frequency*.xml) &&
+		test_xmllint "$file" &&
+		grep "encoding=.US-ASCII." "$file" || return 1
+	done &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	rm expect &&
+	printf "/delete /tn Git Maintenance (%s) /f\n" \
+		hourly daily weekly >expect &&
+	test_cmp expect args
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
-- 
gitgitgadget
