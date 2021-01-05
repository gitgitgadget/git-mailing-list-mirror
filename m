Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B51C433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D8122B30
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbhAENJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbhAENJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 08:09:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A39C061796
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 05:08:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i9so36125317wrc.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SfeZtHvAZcdKjf4/1ooSPlrX3oyoViFaD4G679ZrPiE=;
        b=CbUqx0Ar0Lmmnf9N57GryIrSBIrQlaQ7rG9wIgwlX8Kl1U9rDTrj4d06+/TePW7o4L
         7NQVB8PLv58YS6MeJlMtd0Y9ZDAXYcVZ23mEDR1NQsVYIud+QSvOZn3HigLWx8caaNe3
         UppYVkZd2GTRg8iZ1rjwy9IKFg5D52vQPh/U4Btzu5A7GM6hhXFOCqHmu6bPpd8JHvR4
         fDj0Oo9u6SV1X4YJ6vF9gdR0o3PGpfO8o3gP2qVlXuvJapGf1A1KrI+NKcoIAezZOZgx
         fWn54WGDrJLZyd+ZVYmpejRx8Uka5qxDYBRyXGHiuADCCklg4+K+9BBhUrICwiRE4aAM
         5iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SfeZtHvAZcdKjf4/1ooSPlrX3oyoViFaD4G679ZrPiE=;
        b=nuyU4mlGzoRGvizP6E6lFYwNLirij8eRXQhhAivXvdhzUzjZEp7+SoG1Zgk8UXshSW
         jZZKEdKftcdp0riEG23YAO5x+xMrwwSkThjVRXNyNPOPmowdOA+aivb3y7Qjy4JZ/j5c
         pf/0R08MUwGkO/F4fKmzgGipMPrNvNbRteu/IzbhMdY49yA3+oUSAQPx4xLVM96DJgxO
         sy1x+L5StWRMhabKrcDRxbzDdL2fHdj1HRQP9tkxt3lCLJqoEtOwYy3AL7mKf2ppYPEv
         zplBPMsgNxsXkr0huNoFc4MhwO/T2XUfklm6Yjr+gcGdpXegWHRQE9M2g5LJTnHV9huq
         QfWA==
X-Gm-Message-State: AOAM530OBsEePU5k8sXJcOXIG+3yBf31yk8ODwmyIOnJ76UfdaDu1jGU
        EyhSAXDAyqgCjNlSO15Zbfn7jNSoEEk=
X-Google-Smtp-Source: ABdhPJxnu3VR/87c3HhuKbXPO2zm9Lge7iRAP//rDUV2AtLtzu3nTJKnPJfQI03PJxJI47m5TW15xg==
X-Received: by 2002:a5d:47a5:: with SMTP id 5mr86587262wrb.109.1609852113340;
        Tue, 05 Jan 2021 05:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d191sm3764556wmd.24.2021.01.05.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:08:32 -0800 (PST)
Message-Id: <3576c7aa54e08c11ac86675ca9bc11b80366d390.1609852109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v7.git.1609852108.gitgitgadget@gmail.com>
References: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
        <pull.776.v7.git.1609852108.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 13:08:27 +0000
Subject: [PATCH v7 3/4] maintenance: use launchctl on macOS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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
at [2]. The current design does not preclude a future version that
detects the available fatures of 'launchctl' to use the older
commands. However, it is best to rely on the newest version since
Apple might completely remove the deprecated version on short
notice.

[2] https://babodee.wordpress.com/2016/04/09/launchctl-2-0-syntax/

To remove a schedule, we must run 'launchctl bootout' with a valid
plist file. We also need to 'bootout' a task before the 'bootstrap'
subcommand will succeed, if such a task already exists.

The need for a user id requires us to run 'id -u' which works on
POSIX systems but not Windows. Further, the need for fully-qualitifed
path names including $HOME behaves differently in the Git internals and
the external test suite. The $HOME variable starts with "C:\..." instead
of the "/c/..." that is provided by Git in these subcommands. The test
therefore has a prerequisite that we are not on Windows. The cross-
platform logic still allows us to test the macOS logic on a Linux
machine.

We can verify the commands that were run by 'git maintenance start'
and 'git maintenance stop' by injecting a script that writes the
command-line arguments into GIT_TEST_MAINT_SCHEDULER.

An earlier version of this patch accidentally had an opening
"<dict>" tag when it should have had a closing "</dict>" tag. This
was caught during manual testing with actual 'launchctl' commands,
but we do not want to update developers' tasks when running tests.
It appears that macOS includes the "xmllint" tool which can verify
the XML format. This is useful for any system that might contain
the tool, so use it whenever it is available.

We strive to make these tests work on all platforms, but Windows caused
some headaches. In particular, the value of getuid() called by the C
code is not guaranteed to be the same as `$(id -u)` invoked by a test.
This is because `git.exe` is a native Windows program, whereas the
utility programs run by the test script mostly utilize the MSYS2 runtime,
which emulates a POSIX-like environment. Since the purpose of the test
is to check that the input to the hook is well-formed, the actual user
ID is immaterial, thus we can work around the problem by making the the
test UID-agnostic. Another subtle issue is the $HOME environment
variable being a Windows-style path instead of a Unix-style path. We can
be more flexible here instead of expecting exact path matches.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  40 +++++++
 builtin/gc.c                      | 188 +++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            |  59 ++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 1aa11124186..5f8f63f0988 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -273,6 +273,46 @@ schedule to ensure you are executing the correct binaries in your
 schedule.
 
 
+BACKGROUND MAINTENANCE ON MACOS SYSTEMS
+---------------------------------------
+
+While macOS technically supports `cron`, using `crontab -e` requires
+elevated privileges and the executed process does not have a full user
+context. Without a full user context, Git and its credential helpers
+cannot access stored credentials, so some maintenance tasks are not
+functional.
+
+Instead, `git maintenance start` interacts with the `launchctl` tool,
+which is the recommended way to schedule timed jobs in macOS. Scheduling
+maintenance through `git maintenance (start|stop)` requires some
+`launchctl` features available only in macOS 10.11 or later.
+
+Your user-specific scheduled tasks are stored as XML-formatted `.plist`
+files in `~/Library/LaunchAgents/`. You can see the currently-registered
+tasks using the following command:
+
+-----------------------------------------------------------------------
+$ ls ~/Library/LaunchAgents/org.git-scm.git*
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
+launchctl.plist(5) for more information.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index 18ae7f7138a..782769f2438 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1491,6 +1491,186 @@ static int maintenance_unregister(void)
 	return run_command(&config_unset);
 }
 
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
+static char *launchctl_service_name(const char *frequency)
+{
+	struct strbuf label = STRBUF_INIT;
+	strbuf_addf(&label, "org.git-scm.git.%s", frequency);
+	return strbuf_detach(&label, NULL);
+}
+
+static char *launchctl_service_filename(const char *name)
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
+static char *launchctl_get_uid(void)
+{
+	return xstrfmt("gui/%d", getuid());
+}
+
+static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
+{
+	int result;
+	struct child_process child = CHILD_PROCESS_INIT;
+	char *uid = launchctl_get_uid();
+
+	strvec_split(&child.args, cmd);
+	if (enable)
+		strvec_push(&child.args, "bootstrap");
+	else
+		strvec_push(&child.args, "bootout");
+	strvec_push(&child.args, uid);
+	strvec_push(&child.args, filename);
+
+	child.no_stderr = 1;
+	child.no_stdout = 1;
+
+	if (start_command(&child))
+		die(_("failed to start launchctl"));
+
+	result = finish_command(&child);
+
+	free(uid);
+	return result;
+}
+
+static int launchctl_remove_plist(enum schedule_priority schedule, const char *cmd)
+{
+	const char *frequency = get_frequency(schedule);
+	char *name = launchctl_service_name(frequency);
+	char *filename = launchctl_service_filename(name);
+	int result = launchctl_boot_plist(0, filename, cmd);
+	unlink(filename);
+	free(filename);
+	free(name);
+	return result;
+}
+
+static int launchctl_remove_plists(const char *cmd)
+{
+	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
+		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
+		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
+}
+
+static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
+{
+	FILE *plist;
+	int i;
+	const char *preamble, *repeat;
+	const char *frequency = get_frequency(schedule);
+	char *name = launchctl_service_name(frequency);
+	char *filename = launchctl_service_filename(name);
+
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+	plist = xfopen(filename, "w");
+
+	preamble = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
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
+	fclose(plist);
+
+	/* bootout might fail if not already running, so ignore */
+	launchctl_boot_plist(0, filename, cmd);
+	if (launchctl_boot_plist(1, filename, cmd))
+		die(_("failed to bootstrap service %s"), filename);
+
+	free(filename);
+	free(name);
+	return 0;
+}
+
+static int launchctl_add_plists(const char *cmd)
+{
+	const char *exec_path = git_exec_path();
+
+	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY, cmd) ||
+		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY, cmd) ||
+		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
+}
+
+static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
+{
+	if (run_maintenance)
+		return launchctl_add_plists(cmd);
+	else
+		return launchctl_remove_plists(cmd);
+}
+
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
@@ -1579,7 +1759,11 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 	return result;
 }
 
+#if defined(__APPLE__)
+static const char platform_scheduler[] = "launchctl";
+#else
 static const char platform_scheduler[] = "crontab";
+#endif
 
 static int update_background_schedule(int enable)
 {
@@ -1603,7 +1787,9 @@ static int update_background_schedule(int enable)
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
 		return error(_("another process is scheduling background maintenance"));
 
-	if (!strcmp(scheduler, "crontab"))
+	if (!strcmp(scheduler, "launchctl"))
+		result = launchctl_update_schedule(enable, lk.tempfile->fd, cmd);
+	else if (!strcmp(scheduler, "crontab"))
 		result = crontab_update_schedule(enable, lk.tempfile->fd, cmd);
 	else
 		die("unknown background scheduler: %s", scheduler);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index eeb939168da..adf24dee72d 100755
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
@@ -395,6 +408,52 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
+test_expect_success 'start and stop macOS maintenance' '
+	# ensure $HOME can be compared against hook arguments on all platforms
+	pfx=$(cd "$HOME" && pwd) &&
+
+	write_script print-args <<-\EOF &&
+	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
+	EOF
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+
+	# start registers the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	ls "$HOME/Library/LaunchAgents" >actual &&
+	cat >expect <<-\EOF &&
+	org.git-scm.git.daily.plist
+	org.git-scm.git.hourly.plist
+	org.git-scm.git.weekly.plist
+	EOF
+	test_cmp expect actual &&
+
+	rm -f expect &&
+	for frequency in hourly daily weekly
+	do
+		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		test_xmllint "$PLIST" &&
+		grep schedule=$frequency "$PLIST" &&
+		echo "bootout gui/[UID] $PLIST" >>expect &&
+		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
+	done &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global maintenance.repo "$(pwd)" &&
+
+	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+		hourly daily weekly >expect &&
+	test_cmp expect args &&
+	ls "$HOME/Library/LaunchAgents" >actual &&
+	test_line_count = 0 actual
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
-- 
gitgitgadget

