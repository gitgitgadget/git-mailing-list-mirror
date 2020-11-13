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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32893C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D1D20797
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhSfnYO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKMOAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKMOAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:00:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F629C061A04
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so10037529wrx.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fTEjAtkU6V7Q0ym/yQsJ8oc/O6O+oT50gXUWwlJA/2o=;
        b=FhSfnYO3NSv7JvyH40xAiJ8zSvN/YNcN9GWy4SYM7w1zHfgFuqZsfDfyZ8FkqU2H1M
         SAfGrVu87KqRNtsYMWP/4nvfdez+w9pxPoUF8JmF7f3cdL6ImqHVLj7Yuzs+dJt7VVO9
         1MIcZrTiqEYi5wJiklUUikptJJ55TmpG+wQEfpXuUso0o812K7Eh9QIA+UZnkKDEX10u
         zV9k9Sq8mQaE7/04vXA+4xwi6xFffMs6Is57zQYADqz818KO7v6y2uZbwpsb4zHJrhHy
         R8zViWbWRnEk0ts9uDTo44MTUCmBjk0qPamkbuJGzwnvw4BHUWiPjDeYP7SaEQ7cIEDC
         sNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fTEjAtkU6V7Q0ym/yQsJ8oc/O6O+oT50gXUWwlJA/2o=;
        b=AWpDZn2UhXDwgC1DjM+s2W9qPU9b948yAsjuCQsjYldgkMKKS8vlOkqwcZNtNupJc1
         dhXXmnNJmSjYJahD6bEDjjP7/VpiRDTytwVgV+9Jq1cBW640aFThAgtd45sl9A9DUfJt
         7PUnWdFGOgf6gPgM3g2wTiQTD97BVp1H31ld3bH7BZKL9OjxhH3KEU2JK0+iE9ZznpdU
         jOMzBovavM7zFp5yqoDSJkmKtoZL4tLrn6fkRVFXB2vLeK5fdeDtXw+1vi9U2jsxcM7v
         nmruxpzLCfMFNY7jPZfO/K89kSuIgckNwvoNFLNW037tz7EYE/qjXIsSCwG2YrAdYugu
         lvNw==
X-Gm-Message-State: AOAM5321IFuO4J9p0YXgPDZpXaN2520pZJ/iDNzIh12az2efEETeAzFD
        eot2F3pkSOe4umxrrpkBZL702wGagfU=
X-Google-Smtp-Source: ABdhPJx+fvTvZXpKB/RTtwdEtwc/aCzBHVETfpRbyH6/EWcxfJQ+DVIaIwr9/lC556dXIqi7AmlhKg==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr3673963wrr.295.1605276030469;
        Fri, 13 Nov 2020 06:00:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm6780115wrv.6.2020.11.13.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:00:29 -0800 (PST)
Message-Id: <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
        <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 14:00:24 +0000
Subject: [PATCH v3 4/4] maintenance: use Windows scheduled tasks
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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  22 ++++
 builtin/gc.c                      | 184 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  33 +++++-
 3 files changed, 236 insertions(+), 3 deletions(-)

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
index da2c892f68..76a3afa20a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1684,6 +1684,190 @@ static int platform_update_schedule(int run_maintenance, int fd)
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
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *xml, *schtasks;
+	char *xmlpath, *tempDir;
+	FILE *xmlfp;
+	const char *frequency = get_frequency(schedule);
+	char *name = get_task_name(frequency);
+
+	tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
+	xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
+	safe_create_leading_directories(xmlpath);
+	xmlfp = xfopen(xmlpath, "w");
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
+	strvec_split(&child.args, schtasks);
+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
+
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+
+	if (start_command(&child))
+		die(_("failed to start schtasks"));
+	result = finish_command(&child);
+
+	unlink(xmlpath);
+	rmdir(tempDir);
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
index 29d340a828..0dc2479117 100755
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
@@ -437,6 +437,33 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
 	test_line_count = 0 actual
 '
 
+test_expect_success MINGW 'start and stop Windows maintenance' '
+	write_script print-args <<-\EOF &&
+	echo $* >>args
+	EOF
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/temp/schedule-%s.xml\n" \
+		hourly hourly daily daily weekly weekly >expect &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance stop &&
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
