Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0ADC4742C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B69D2076D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSj/s+sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgKDUGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbgKDUGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:06:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF01C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:06:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n18so23388354wrs.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T+212svS589+wgo/bh0IJ/IgpZ5v4kEWB5VQsSADDPU=;
        b=iSj/s+swUQurGcAGYI7D8WEgAs0kGaZs4F7XVptIxoSCOOjTM7Iu3DPI+jlpfCBy6t
         vZM+5Db+h3XenRzPolPHH2njton4tLFpIWdpgilAeMhQhjamKNrYckjqvnOmDKHht2M7
         XWm36HiC/fSyD5x5KhDfn3g4ETWutpoksy26iM52dzSu6jG57EkYfxlLUuQwJ5kRiwyi
         OunQfsDEADLTlz5KyOBMCsbKLYTisqg4vYLSn/6oMiXUVGACQCOUGMwmuYpyQbbDEP1q
         H2wDGmkpHEsG3fiDNwkCu7QjahpYVIpOIMnK8GwCIv6q6Sg+fX/JkLcxWy3W90GBQIv6
         hvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T+212svS589+wgo/bh0IJ/IgpZ5v4kEWB5VQsSADDPU=;
        b=i7pwnN03GJb7magnvj3Ya953B+mG5osmamtjDF1Hwo5xKY83d+fURfARSRjYsw59sG
         S/jpeE962s/GjVEfoQpMmmkiA2iwiMKq3aLukDYtmI//7Dithg816m1nKkJ1AeDXxLpF
         DA7Kf/XThJEl4X8Ck1LlxhqTWJkFkxkGrdzs4FtD31h2q+lwyV8unDWUjx56DkOIVAdU
         Or/Rwd1f3cLarBMr6PrKo9eQEm2pYbzIYAb4UWwk5kO9BSLsTRNRc+AbYu02GUOh+LJ8
         CIXbQHLM0qb42Rg+dGaLPOb0Fe+iaiGyDzPwg7wTYUNK/+uTMuRC4QU5HvCAdXvnqdiu
         9lDA==
X-Gm-Message-State: AOAM533PRNlG8TOcueE4SyI60PTJf3zvkFmKfAzQJXsvTJThbWsri2hi
        j0xPZlB6ZPlTHg65HrmjdyDaTzVFizQ=
X-Google-Smtp-Source: ABdhPJz3Hh5P6BJvdfmrOfKa4xxiohBoXBunmAVXKm9pya8nWmQQ5qDwHhtzGP62Zb7VkAJtL+hE5A==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr33755703wro.24.1604520372299;
        Wed, 04 Nov 2020 12:06:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o184sm3851900wmo.37.2020.11.04.12.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:06:11 -0800 (PST)
Message-Id: <0fafd75d100f343f7cff6471772ed9b12793f81e.1604520368.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
        <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 20:06:07 +0000
Subject: [PATCH v2 3/4] maintenance: use launchctl on macOS
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing mechanism for scheduling background maintenance is done
through cron. The 'crontab -e' command allows updating the schedule
while cron itself runs those commands. While this is technically
supported by macOS, it has some significant deficiencies:

1. Every run of 'crontab -e' must request elevated privileges through
   the user interface. When running 'git maintenance start' from the
   Terminal app, it presents a dialog box saying "Terminal.app would
   like to administer your computer. Administration can include
   modifying passwords, networking, and system settings." This is more
   alarming than what we are hoping to achieve. If this alert had some
   information about how "git" is trying to run "crontab" then we would
   have some reason to believe that this dialog might be fine. However,
   it also doesn't help that some scenarios just leave Git waiting for
   a response without presenting anything to the user. I experienced
   this when executing the command from a Bash terminal view inside
   Visual Studio Code.

2. While cron initializes a user environment enough for "git config
   --global --show-origin" to show the correct config file information,
   it does not set up the environment enough for Git Credential Manager
   Core to load credentials during a 'prefetch' task. My prefetches
   against private repositories required re-authenticating through UI
   pop-ups in a way that should not be required.

The solution is to switch from cron to the Apple-recommended [1]
'launchd' tool.

[1] https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html

The basics of this tool is that we need to create XML-formatted
"plist" files inside "~/Library/LaunchAgents/" and then use the
'launchctl' tool to make launchd aware of them. The plist files
include all of the scheduling information, along with the command-line
arguments split across an array of <string> tags.

For example, here is my plist file for the weekly scheduled tasks:

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>Label</key><string>org.git-scm.git.weekly</string>
<key>ProgramArguments</key>
<array>
<string>/usr/local/libexec/git-core/git</string>
<string>--exec-path=/usr/local/libexec/git-core</string>
<string>for-each-repo</string>
<string>--config=maintenance.repo</string>
<string>maintenance</string>
<string>run</string>
<string>--schedule=weekly</string>
</array>
<key>StartCalendarInterval</key>
<array>
<dict>
<key>Day</key><integer>0</integer>
<key>Hour</key><integer>0</integer>
<key>Minute</key><integer>0</integer>
</dict>
</array>
</dict>
</plist>

The schedules for the daily and hourly tasks are more complicated
since we need to use an array for the StartCalendarInterval with
an entry for each of the six days other than the 0th day (to avoid
colliding with the weekly task), and each of the 23 hours other
than the 0th hour (to avoid colliding with the daily task).

The "Label" value is currently filled with "org.git-scm.git.X"
where X is the frequency. We need a different plist file for each
frequency.

The launchctl command needs to be aligned with a user id in order
to initialize the command environment. This must be done using
the 'launchctl bootstrap' subcommand. This subcommand is new as
of macOS 10.11, which was released in September 2015. Before that
release the 'launchctl load' subcommand was recommended. The best
source of information on this transition I have seen is available
at [2].

[2] https://babodee.wordpress.com/2016/04/09/launchctl-2-0-syntax/

To remove a schedule, we must run 'launchctl bootout' with a valid
plist file. We also need to 'bootout' a task before the 'bootstrap'
subcommand will succeed, if such a task already exists.

We can verify the commands that were run by 'git maintenance start'
and 'git maintenance stop' by injecting a script that writes the
command-line arguments into GIT_TEST_CRONTAB.

An earlier version of this patch accidentally had an opening
"<dict>" tag when it should have had a closing "</dict>" tag. This
was caught during manual testing with actual 'launchctl' commands,
but we do not want to update developers' tasks when running tests.
It appears that macOS includes the "xmllint" tool which can verify
the XML format, so call it from the macOS-specific tests to ensure
the .plist files are well-formatted.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  43 ++++++
 builtin/gc.c                      | 209 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  53 +++++++-
 t/test-lib.sh                     |   4 +
 4 files changed, 306 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 4c7aac877d..451ebac131 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -273,6 +273,49 @@ for advanced scheduling techniques. Please do use the full path and
 executing the correct binaries in your schedule.
 
 
+BACKGROUND MAINTENANCE ON MACOS SYSTEMS
+---------------------------------------
+
+While macOS technically supports `cron`, using `crontab -e` requires
+elevated privileges and the executed process do not have a full user
+context. Without a full user context, Git and its credential helpers
+cannot access stored credentials, so some maintenance tasks are not
+functional.
+
+Instead, `git maintenance start` interacts with the `launchctl` tool,
+which is the recommended way to
+https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html[schedule timed jobs in macOS].
+
+Scheduling maintenance through `git maintenance (start|stop)` requires
+some `launchctl` features available only in macOS 10.11 or later.
+
+Your user-specific scheduled tasks are stored as XML-formatted `.plist`
+files in `~/Library/LaunchAgents/`. You can see the currently-registered
+tasks using the following command:
+
+-----------------------------------------------------------------------
+$ ls ~/Library/LaunchAgents/ | grep org.git-scm.git
+org.git-scm.git.daily.plist
+org.git-scm.git.hourly.plist
+org.git-scm.git.weekly.plist
+-----------------------------------------------------------------------
+
+One task is registered for each `--schedule=<frequency>` option. To
+inspect how the XML format describes each schedule, open one of these
+`.plist` files in an editor and inspect the `<array>` element following
+the `<key>StartCalendarInterval</key>` element.
+
+`git maintenance start` will overwrite these files and register the
+tasks again with `launchctl`, so any customizations should be done by
+creating your own `.plist` files with distinct names. Similarly, the
+`git maintenance stop` command will unregister the tasks with `launchctl`
+and delete the `.plist` files.
+
+To create more advanced customizations to your background tasks, see
+https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142[the `launchctl` documentation]
+for more information.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index c1f7d9bdc2..7604064a8d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1491,6 +1491,214 @@ static int maintenance_unregister(void)
 	return run_command(&config_unset);
 }
 
+#if defined(__APPLE__)
+
+static char *get_service_name(const char *frequency)
+{
+	struct strbuf label = STRBUF_INIT;
+	strbuf_addf(&label, "org.git-scm.git.%s", frequency);
+	return strbuf_detach(&label, NULL);
+}
+
+static char *get_service_filename(const char *name)
+{
+	char *expanded;
+	struct strbuf filename = STRBUF_INIT;
+	strbuf_addf(&filename, "~/Library/LaunchAgents/%s.plist", name);
+
+	expanded = expand_user_path(filename.buf, 1);
+	if (!expanded)
+		die(_("failed to expand path '%s'"), filename.buf);
+
+	strbuf_release(&filename);
+	return expanded;
+}
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
+static char *get_uid(void)
+{
+	struct strbuf output = STRBUF_INIT;
+	struct child_process id = CHILD_PROCESS_INIT;
+
+	strvec_pushl(&id.args, "/usr/bin/id", "-u", NULL);
+	if (capture_command(&id, &output, 0))
+		die(_("failed to discover user id"));
+
+	strbuf_trim_trailing_newline(&output);
+	return strbuf_detach(&output, NULL);
+}
+
+static int bootout(const char *filename)
+{
+	int result;
+	struct strvec args = STRVEC_INIT;
+	char *uid = get_uid();
+	const char *launchctl = getenv("GIT_TEST_CRONTAB");
+	if (!launchctl)
+		launchctl = "/bin/launchctl";
+
+	strvec_split(&args, launchctl);
+	strvec_push(&args, "bootout");
+	strvec_pushf(&args, "gui/%s", uid);
+	strvec_push(&args, filename);
+
+	result = run_command_v_opt(args.v, 0);
+
+	strvec_clear(&args);
+	free(uid);
+	return result;
+}
+
+static int bootstrap(const char *filename)
+{
+	int result;
+	struct strvec args = STRVEC_INIT;
+	char *uid = get_uid();
+	const char *launchctl = getenv("GIT_TEST_CRONTAB");
+	if (!launchctl)
+		launchctl = "/bin/launchctl";
+
+	strvec_split(&args, launchctl);
+	strvec_push(&args, "bootstrap");
+	strvec_pushf(&args, "gui/%s", uid);
+	strvec_push(&args, filename);
+
+	result = run_command_v_opt(args.v, 0);
+
+	strvec_clear(&args);
+	free(uid);
+	return result;
+}
+
+static int remove_plist(enum schedule_priority schedule)
+{
+	const char *frequency = get_frequency(schedule);
+	char *name = get_service_name(frequency);
+	char *filename = get_service_filename(name);
+	int result = bootout(filename);
+	free(filename);
+	free(name);
+	return result;
+}
+
+static int remove_plists(void)
+{
+	return remove_plist(SCHEDULE_HOURLY) ||
+		remove_plist(SCHEDULE_DAILY) ||
+		remove_plist(SCHEDULE_WEEKLY);
+}
+
+static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
+{
+	FILE *plist;
+	int i;
+	const char *preamble, *repeat;
+	const char *frequency = get_frequency(schedule);
+	char *name = get_service_name(frequency);
+	char *filename = get_service_filename(name);
+
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+	plist = fopen(filename, "w");
+
+	if (!plist)
+		die(_("failed to open '%s'"), filename);
+
+	preamble = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
+		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
+		   "<plist version=\"1.0\">"
+		   "<dict>\n"
+		   "<key>Label</key><string>%s</string>\n"
+		   "<key>ProgramArguments</key>\n"
+		   "<array>\n"
+		   "<string>%s/git</string>\n"
+		   "<string>--exec-path=%s</string>\n"
+		   "<string>for-each-repo</string>\n"
+		   "<string>--config=maintenance.repo</string>\n"
+		   "<string>maintenance</string>\n"
+		   "<string>run</string>\n"
+		   "<string>--schedule=%s</string>\n"
+		   "</array>\n"
+		   "<key>StartCalendarInterval</key>\n"
+		   "<array>\n";
+	fprintf(plist, preamble, name, exec_path, exec_path, frequency);
+
+	switch (schedule) {
+	case SCHEDULE_HOURLY:
+		repeat = "<dict>\n"
+			 "<key>Hour</key><integer>%d</integer>\n"
+			 "<key>Minute</key><integer>0</integer>\n"
+			 "</dict>\n";
+		for (i = 1; i <= 23; i++)
+			fprintf(plist, repeat, i);
+		break;
+
+	case SCHEDULE_DAILY:
+		repeat = "<dict>\n"
+			 "<key>Day</key><integer>%d</integer>\n"
+			 "<key>Hour</key><integer>0</integer>\n"
+			 "<key>Minute</key><integer>0</integer>\n"
+			 "</dict>\n";
+		for (i = 1; i <= 6; i++)
+			fprintf(plist, repeat, i);
+		break;
+
+	case SCHEDULE_WEEKLY:
+		fprintf(plist,
+			"<dict>\n"
+			"<key>Day</key><integer>0</integer>\n"
+			"<key>Hour</key><integer>0</integer>\n"
+			"<key>Minute</key><integer>0</integer>\n"
+			"</dict>\n");
+		break;
+
+	default:
+		/* unreachable */
+		break;
+	}
+	fprintf(plist, "</array>\n</dict>\n</plist>\n");
+
+	/* bootout might fail if not already running, so ignore */
+	bootout(filename);
+	if (bootstrap(filename))
+		die(_("failed to bootstrap service %s"), filename);
+
+	fclose(plist);
+	free(filename);
+	free(name);
+	return 0;
+}
+
+static int add_plists(void)
+{
+	const char *exec_path = git_exec_path();
+
+	return schedule_plist(exec_path, SCHEDULE_HOURLY) ||
+		schedule_plist(exec_path, SCHEDULE_DAILY) ||
+		schedule_plist(exec_path, SCHEDULE_WEEKLY);
+}
+
+static int platform_update_schedule(int run_maintenance, int fd)
+{
+	if (run_maintenance)
+		return add_plists();
+	else
+		return remove_plists();
+}
+#else
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
@@ -1585,6 +1793,7 @@ static int platform_update_schedule(int run_maintenance, int fd)
 		fclose(cron_list);
 	return result;
 }
+#endif
 
 static int update_background_schedule(int run_maintenance)
 {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 20184e96e1..1c43b34a93 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -367,7 +367,7 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
-test_expect_success 'start from empty cron table' '
+test_expect_success !MACOS_MAINTENANCE 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
@@ -378,7 +378,7 @@ test_expect_success 'start from empty cron table' '
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
-test_expect_success 'stop from existing schedule' '
+test_expect_success !MACOS_MAINTENANCE 'stop from existing schedule' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
@@ -389,12 +389,59 @@ test_expect_success 'stop from existing schedule' '
 	test_must_be_empty cron.txt
 '
 
-test_expect_success 'start preserves existing schedule' '
+test_expect_success !MACOS_MAINTENANCE 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 	grep "Important information!" cron.txt
 '
 
+test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
+	echo "#!/bin/sh\necho \$@ >>args" >print-args &&
+	chmod a+x print-args &&
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="./print-args" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	# ~/Library/LaunchAgents
+	ls "$HOME/Library/LaunchAgents" >actual &&
+	cat >expect <<-\EOF &&
+	org.git-scm.git.daily.plist
+	org.git-scm.git.hourly.plist
+	org.git-scm.git.weekly.plist
+	EOF
+	test_cmp expect actual &&
+
+	rm expect &&
+	for frequency in hourly daily weekly
+	do
+		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		xmllint "$PLIST" >/dev/null &&
+		grep schedule=$frequency "$PLIST" &&
+		echo "bootout gui/$UID $PLIST" >>expect &&
+		echo "bootstrap gui/$UID $PLIST" >>expect || return 1
+	done &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_CRONTAB="./print-args"  git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	# stop does not remove plist files, but boots them out
+	rm expect &&
+	for frequency in hourly daily weekly
+	do
+		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		grep schedule=$frequency "$PLIST" &&
+		echo "bootout gui/$UID $PLIST" >>expect || return 1
+	done &&
+	test_cmp expect args
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a60d1ed76..620ffbf3af 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1703,6 +1703,10 @@ test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
 
+test_lazy_prereq MACOS_MAINTENANCE '
+	launchctl list
+'
+
 # Ensure that no test accidentally triggers a Git command
 # that runs 'crontab', affecting a user's cron schedule.
 # Tests that verify the cron integration must set this locally
-- 
gitgitgadget

