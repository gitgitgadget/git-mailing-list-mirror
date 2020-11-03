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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD1C55179
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5A122243
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz08/kdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgKCOFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgKCODW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:03:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C2C0617A6
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 06:03:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e6so1443763wro.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m8gW5bCgQFFAeBqgmq1s4ELpH4Xy61wnkyZoneclv/g=;
        b=Fz08/kdwA6jNgrvlbSyp125bg530Pq1Qf+/y6Mv25ZwvsVbMHm1iUccD+h6BHs6e2G
         Fx2RmzJImI5PDvhBZ7vNIcnmJbqM6Jju0mfGomvRyJh/P6/PLqHzg+FuMLfGD8KY8UGb
         Nq9y9BRr/K6ebDbMFKjljHcRk1HXUajG+gQINGQ2FH19yIS+quqQ/Gv0zR/hzVqId8ui
         /P6ox2betp7PTythM8G44/ra2mb+pwv5+oGPfkw4NAfHbfrBfMESPa9SeHrouI9M8GNH
         rQYZXe/UIq5OpNx/GmxFI1ZX+rWJ6tyc0u1NKOfZUyQDftxFgWaRnRVlgZdAy8/g3W7K
         98aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m8gW5bCgQFFAeBqgmq1s4ELpH4Xy61wnkyZoneclv/g=;
        b=hXXfRD1Idxzhrb9Dzw0mw83Arnx98y7MlLlpCEGgQ/hX71grEfl48HM2ZIktMZPfqr
         aDDvHLMqPTxFYyEdO1YXn7ly6rrvsxSCGHXz5C0/qAwW+Gz37pXGmA/B8Pq4XHKwCtEj
         0OFN7Z2Q7/ilQTA5Nwz7skTC6D1tRkU69KdsI7DDsByjjEX/mKx2mS96B8Mkw+Jw58qx
         4w7QnORMkH18Tn0hGeI8U9wVjQJFe+pXiGQFOC+/u9G782tlctYORnbslpUCR1RRgt9T
         o78eFAC4yJ0mK8DmtsDNdJfgm4fblPFm5JqEcfsKSZ5mc7RTVsJsfOtoyJsZsCPRkQZE
         YBag==
X-Gm-Message-State: AOAM532+bVCfmjhro9AzjH16CMu4xlZIpnoNdtUraWCYOu0sUVv+/G0i
        7bsfLWWfXmVwKs8yq/T2R8yF/JCaGIY=
X-Google-Smtp-Source: ABdhPJysT26RwBmU1YtL3htUr0wI5brV/+2waGISnN+i4p3eMSW3V7Ylv53jpkQSCZjjlwoDJV9m4A==
X-Received: by 2002:adf:b1d6:: with SMTP id r22mr25299659wra.136.1604412200088;
        Tue, 03 Nov 2020 06:03:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm27432107wrx.64.2020.11.03.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:03:19 -0800 (PST)
Message-Id: <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 14:03:15 +0000
Subject: [PATCH 2/3] maintenance: use launchctl on macOS
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 209 +++++++++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh |  52 +++++++++-
 t/test-lib.sh          |   4 +
 3 files changed, 262 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c1f7d9bdc2..fa0ae63a80 100644
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
+			 "<dict>\n";
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
index 20184e96e1..f0210aa206 100755
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
@@ -389,12 +389,58 @@ test_expect_success 'stop from existing schedule' '
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

