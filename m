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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5658C64E7B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E91E2086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JegBhTKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgKXEQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 23:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKXEQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 23:16:54 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F01C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:53 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so1512657wmi.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I5yBdDTXqI57h59MTpcOKh4XdaaCl6u/q65+pPPF/5A=;
        b=JegBhTKokBC+Kuk5KUMvF2SlJbiC1qbovDoISSD++vLXkTrcTy56S5SEcvGx1NUard
         oBsQjBuiUm52lfiReuWY57JsCUONyLP9OB1zFMWGNESLllgH8r8lJ0zy/GykrqXVeC0M
         BfhywAjMZOQteAYDTeCeNE04KKp5ky93hKL0d0z33dEZOj0eHWy/b8DidtVykZsXdoWI
         GW6QMRGVS/yiDb3SgjnuF43BgRjPZ5I4TKNsLhAe7qicSfA0IkZaHZRBD2qNOSlly9Mu
         nsKPJ9TqcFG1i0k64lY3SsrlBgUW0Qm6ujmTj2OwJhXby5SuY9BUiLAZCz96aPiNtlgo
         Wlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I5yBdDTXqI57h59MTpcOKh4XdaaCl6u/q65+pPPF/5A=;
        b=m2JMnvwB5InK5xKyMeFqgWY7//Xc2pxeKkZJRAZYTbAJ3PEv1i39iixa1hcsX77fgv
         1neT4cENuGYMtCOaGC623ZoiFss2sfEpfly308aWJtwmJF3HiyigoQW1hBDXd94FaAOy
         46zAn3agkthDE/mSJHsw32foT2RUVPQQP0bJIoYX7pdtPvRK67tYw8DaE5cde50R+X71
         lMVYwIk5YO3ojsj3oi+mPRBzWmy6qGWf/aIZp5eq8ym74yxC4MGao9xqhQ0JYVLtHqth
         o5IHzcultg3kd5quQoAXaWs16rAm1WBa6HJB2QtSrfx4wgcBrMdoWGYRTyRdm8lAhb3e
         SZDA==
X-Gm-Message-State: AOAM532/MGq5eHELizPPe+m0fOYOWQPOJHJ03C6EA069zjlPVh20eah7
        6gQ/cc//m8fi12Es5vREJICKwv2peXU=
X-Google-Smtp-Source: ABdhPJwYjUm6ZcFdRaNVN63FDjGETXnAamm/ERubMfpa6OIsRcmB4uuozvL9ozGvQQYNeUHK6xq3mA==
X-Received: by 2002:a1c:309:: with SMTP id 9mr2018070wmd.80.1606191412366;
        Mon, 23 Nov 2020 20:16:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23sm2475743wmb.43.2020.11.23.20.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:16:51 -0800 (PST)
Message-Id: <ac9a28bea39b4d1897ad6a41331e52770c8c7531.1606191405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
References: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
        <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 04:16:45 +0000
Subject: [PATCH v5 4/4] maintenance: use Windows scheduled tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
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
must copy the file to a predictable filename. Use the number of lines in
the 'args' file to provide a filename for xmllint. Instead of an exact
match on the 'args' file, we 'grep' for the arguments other than the
filename.

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
 builtin/gc.c                      | 160 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  44 ++++++++
 3 files changed, 226 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 5f8f63f098..6970f2b898 100644
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
index 782769f243..43224e0dec 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1671,6 +1671,162 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
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
+
+	tfile = xmks_tempfile("schedule_XXXXXX");
+	if (!tfile || !fdopen_tempfile(tfile, "w"))
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
+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", tfile->filename.buf, NULL);
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
 
@@ -1761,6 +1917,8 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 
 #if defined(__APPLE__)
 static const char platform_scheduler[] = "launchctl";
+#elif defined(GIT_WINDOWS_NATIVE)
+static const char platform_scheduler[] = "schtasks";
 #else
 static const char platform_scheduler[] = "crontab";
 #endif
@@ -1789,6 +1947,8 @@ static int update_background_schedule(int enable)
 
 	if (!strcmp(scheduler, "launchctl"))
 		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
+	else if (!strcmp(scheduler, "schtasks"))
+		result = schtasks_update_schedule(enable, lk.tempfile->fd, cmd);
 	else if (!strcmp(scheduler, "crontab"))
 		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
 	else
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6d37312901..0246e4ce30 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -453,6 +453,50 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
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
+	lines=$(wc -l args | awk "{print \$1;}")
+	test -z "$xmlfile" || cp "$xmlfile" "schedule-$lines.xml"
+	EOF
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	for frequency in hourly daily weekly
+	do
+		grep "/create /tn Git Maintenance ($frequency) /f /xml" args \
+			|| return 1
+	done &&
+
+	for i in 1 2 3
+	do
+		test_xmllint "schedule-$i.xml" &&
+		grep "encoding=.US-ASCII." "schedule-$i.xml" || return 1
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
