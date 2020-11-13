Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E0EC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D272920797
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3iLXqZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKMOAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKMOAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:00:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CECC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so9998184wrf.12
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/xeQQ+7TOBPAGFMg2M38aXN7tYvw06twCzOW39sPpsM=;
        b=e3iLXqZj9Xl1jrBebHf64Wz70PSdVid80Cb+S/QJTkGuVB/OYSrFMeymTMOkgrycQT
         w38LuHR5+tuADXCpy5xLonH3l9PiX9fjZnHC3ZNOhNVVxnG0Ux+wIwHK434SsV9vjOGe
         lrGr/nAXR6Hgzc+jvyCNwsO03+DEwbkV8dKIN2u82FYuh6IKKrharx1EiM8xhf8TJP30
         +1o43qFCxaY0NjMxVn1+2Ca4FzH3QhGeaoTzPzvDU/t8dFouSElxSMdOcqmFCmKRWd9z
         StzI/SvW4YQDCVgKqMjHB4OBDqWBogqF8gN/eOPThVCI6S68rmyJ4KxoqPKPwjxOETEH
         oQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/xeQQ+7TOBPAGFMg2M38aXN7tYvw06twCzOW39sPpsM=;
        b=tIQOStO7yqea+m34KNqctc7H5HFxhh4Fd2LrbDT8pa+SOFH2sTH5DfYR+Iy0EasFv4
         SdrnCoZ5w1JZjei08EHZELZW4h0TBFtyjDn+cuE9fxzjFjnDzBgUbH5OHMFV1E8tt28G
         kqB3V76MyiSogJB9HpYx5VeYM3yjapHxonsNsy/tABm/InFIub+VEsQ4kbR/PbnJL7n1
         LQe3OJ3VvGfUMozPUWOGRkGElmMqUlA1lXVR7OiMPJPoXPyBE4ts9SV166SrZo5G7dxB
         WyxBBldMtXduXKk0VClZ0pte9yDSQBKsX+Wm6W73JHr6J0+LpAl5UqK2wtqZs0rnf4Zr
         rniw==
X-Gm-Message-State: AOAM533imApcB6ckrxzkZa7g+wa/xKA72+dG7i43R7CW/ydDfxScL+aV
        PUgVIKbQ/NttWUysbjCds7L/2wSJzw0=
X-Google-Smtp-Source: ABdhPJzg1RAuV8rywVyMa7gO/GOePWfLmeTI+xYmKzhoo7Rohe1ytA072YtKU/msfsvmGwKfcksYEg==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr3633062wrc.74.1605276025887;
        Fri, 13 Nov 2020 06:00:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm9710854wmj.36.2020.11.13.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:00:25 -0800 (PST)
Message-Id: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 14:00:20 +0000
Subject: [PATCH v3 0/4] Maintenance IV: Platform-specific background maintenance
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

Updates in V3
=============

 * This actually includes the feedback responses I had intended for v2.
   Sorry about that!
   
   
 * One major change is the use of a 'struct child_process' instead of just
   run_command_v_opt() so we can suppress error messages from the schedule
   helpers. We will rely on exit code and present our own error messages, as
   necessary.
   
   
 * Some doc and test fixes.
   
   

Updates in V2
=============

 * This is a faster turnaround for a v2 than I would normally like, but Eric
   inspired extra documentation about how to customize background schedules.
   
   
 * New extensions to git-maintenance.txt include guidelines for inspecting
   what git maintenance start does and how to customize beyond that. This
   includes a new PATCH 2 that includes documentation for 'cron' on
   non-macOS non-Windows systems.
   
   
 * Several improvements, especially in the tests, are included.
   
   
 * While testing manually, I noticed that somehow I had incorrectly had an
   opening <dict> tag instead of a closing </dict> tag in the hourly format
   on macOS. I found that the xmllint tool can verify the XML format of a
   file, which catches the bug. This seems like a good approach since the
   test is macOS-only. Does anyone have concerns about adding this
   dependency?
   
   

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

 Documentation/git-maintenance.txt | 116 +++++++++
 builtin/gc.c                      | 417 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            |  75 +++++-
 t/test-lib.sh                     |   4 +
 4 files changed, 592 insertions(+), 20 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v2:

 1:  d35f1aa162 = 1:  d35f1aa162 maintenance: extract platform-specific scheduling
 2:  709a173720 ! 2:  0dfe53092e maintenance: include 'cron' details in docs
     @@ Commit message
          baseline can provide a way forward for users who have never worked with
          cron schedules.
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ Documentation/git-maintenance.txt: Further, the `git gc` command should not be c
      +---------------------------------------
      +
      +The standard mechanism for scheduling background tasks on POSIX systems
     -+is `cron`. This tool executes commands based on a given schedule. The
     ++is cron(8). This tool executes commands based on a given schedule. The
      +current list of user-scheduled tasks can be found by running `crontab -l`.
      +The schedule written by `git maintenance start` is similar to this:
      +
     @@ Documentation/git-maintenance.txt: Further, the `git gc` command should not be c
      +Any modifications within this region will be completely deleted by
      +`git maintenance stop` or overwritten by `git maintenance start`.
      +
     -+The `<path>` string is loaded to specifically use the location for the
     -+`git` executable used in the `git maintenance start` command. This allows
     -+for multiple versions to be compatible. However, if the same user runs
     -+`git maintenance start` with multiple Git executables, then only the
     -+latest executable will be used.
     ++The `crontab` entry specifies the full path of the `git` executable to
     ++ensure that the executed `git` command is the same one with which
     ++`git maintenance start` was issued independent of `PATH`. If the same user
     ++runs `git maintenance start` with multiple Git executables, then only the
     ++latest executable is used.
      +
      +These commands use `git for-each-repo --config=maintenance.repo` to run
      +`git maintenance run --schedule=<frequency>` on each repository listed in
      +the multi-valued `maintenance.repo` config option. These are typically
     -+loaded from the user-specific global config located at `~/.gitconfig`.
     -+The `git maintenance` process then determines which maintenance tasks
     -+are configured to run on each repository with each `<frequency>` using
     -+the `maintenance.<task>.schedule` config options. These values are loaded
     -+from the global or repository config values.
     ++loaded from the user-specific global config. The `git maintenance` process
     ++then determines which maintenance tasks are configured to run on each
     ++repository with each `<frequency>` using the `maintenance.<task>.schedule`
     ++config options. These values are loaded from the global or repository
     ++config values.
      +
      +If the config values are insufficient to achieve your desired background
      +maintenance schedule, then you can create your own schedule. If you run
      +`crontab -e`, then an editor will load with your user-specific `cron`
      +schedule. In that editor, you can add your own schedule lines. You could
      +start by adapting the default schedule listed earlier, or you could read
     -+https://man7.org/linux/man-pages/man5/crontab.5.html[the `crontab` documentation]
     -+for advanced scheduling techniques. Please do use the full path and
     -+`--exec-path` techniques from the default schedule to ensure you are
     -+executing the correct binaries in your schedule.
     ++the crontab(5) documentation for advanced scheduling techniques. Please
     ++do use the full path and `--exec-path` techniques from the default
     ++schedule to ensure you are executing the correct binaries in your
     ++schedule.
      +
       
       GIT
 3:  0fafd75d10 ! 3:  1629bcfcf8 maintenance: use launchctl on macOS
     @@ Commit message
          of macOS 10.11, which was released in September 2015. Before that
          release the 'launchctl load' subcommand was recommended. The best
          source of information on this transition I have seen is available
     -    at [2].
     +    at [2]. The current design does not preclude a future version that
     +    detects the available fatures of 'launchctl' to use the older
     +    commands. However, it is best to rely on the newest version since
     +    Apple might completely remove the deprecated version on short
     +    notice.
      
          [2] https://babodee.wordpress.com/2016/04/09/launchctl-2-0-syntax/
      
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: for advanced scheduling techniques. Please do use the full path and
     - executing the correct binaries in your schedule.
     +@@ Documentation/git-maintenance.txt: schedule to ensure you are executing the correct binaries in your
     + schedule.
       
       
      +BACKGROUND MAINTENANCE ON MACOS SYSTEMS
      +---------------------------------------
      +
      +While macOS technically supports `cron`, using `crontab -e` requires
     -+elevated privileges and the executed process do not have a full user
     ++elevated privileges and the executed process does not have a full user
      +context. Without a full user context, Git and its credential helpers
      +cannot access stored credentials, so some maintenance tasks are not
      +functional.
      +
      +Instead, `git maintenance start` interacts with the `launchctl` tool,
     -+which is the recommended way to
     -+https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html[schedule timed jobs in macOS].
     -+
     -+Scheduling maintenance through `git maintenance (start|stop)` requires
     -+some `launchctl` features available only in macOS 10.11 or later.
     ++which is the recommended way to schedule timed jobs in macOS. Scheduling
     ++maintenance through `git maintenance (start|stop)` requires some
     ++`launchctl` features available only in macOS 10.11 or later.
      +
      +Your user-specific scheduled tasks are stored as XML-formatted `.plist`
      +files in `~/Library/LaunchAgents/`. You can see the currently-registered
      +tasks using the following command:
      +
      +-----------------------------------------------------------------------
     -+$ ls ~/Library/LaunchAgents/ | grep org.git-scm.git
     ++$ ls ~/Library/LaunchAgents/org.git-scm.git*
      +org.git-scm.git.daily.plist
      +org.git-scm.git.hourly.plist
      +org.git-scm.git.weekly.plist
     @@ Documentation/git-maintenance.txt: for advanced scheduling techniques. Please do
      +and delete the `.plist` files.
      +
      +To create more advanced customizations to your background tasks, see
     -+https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142[the `launchctl` documentation]
     -+for more information.
     ++launchctl.plist(5) for more information.
      +
      +
       GIT
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	return strbuf_detach(&output, NULL);
      +}
      +
     -+static int bootout(const char *filename)
     ++static int boot_plist(int enable, const char *filename)
      +{
      +	int result;
     -+	struct strvec args = STRVEC_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +	char *uid = get_uid();
      +	const char *launchctl = getenv("GIT_TEST_CRONTAB");
      +	if (!launchctl)
      +		launchctl = "/bin/launchctl";
      +
     -+	strvec_split(&args, launchctl);
     -+	strvec_push(&args, "bootout");
     -+	strvec_pushf(&args, "gui/%s", uid);
     -+	strvec_push(&args, filename);
     ++	strvec_split(&child.args, launchctl);
      +
     -+	result = run_command_v_opt(args.v, 0);
     ++	if (enable)
     ++		strvec_push(&child.args, "bootstrap");
     ++	else
     ++		strvec_push(&child.args, "bootout");
     ++	strvec_pushf(&child.args, "gui/%s", uid);
     ++	strvec_push(&child.args, filename);
      +
     -+	strvec_clear(&args);
     -+	free(uid);
     -+	return result;
     -+}
     ++	child.no_stderr = 1;
     ++	child.no_stdout = 1;
      +
     -+static int bootstrap(const char *filename)
     -+{
     -+	int result;
     -+	struct strvec args = STRVEC_INIT;
     -+	char *uid = get_uid();
     -+	const char *launchctl = getenv("GIT_TEST_CRONTAB");
     -+	if (!launchctl)
     -+		launchctl = "/bin/launchctl";
     ++	if (start_command(&child))
     ++		die(_("failed to start launchctl"));
      +
     -+	strvec_split(&args, launchctl);
     -+	strvec_push(&args, "bootstrap");
     -+	strvec_pushf(&args, "gui/%s", uid);
     -+	strvec_push(&args, filename);
     ++	result = finish_command(&child);
      +
     -+	result = run_command_v_opt(args.v, 0);
     -+
     -+	strvec_clear(&args);
      +	free(uid);
      +	return result;
      +}
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	const char *frequency = get_frequency(schedule);
      +	char *name = get_service_name(frequency);
      +	char *filename = get_service_filename(name);
     -+	int result = bootout(filename);
     ++	int result = boot_plist(0, filename);
     ++	unlink(filename);
      +	free(filename);
      +	free(name);
      +	return result;
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +
      +	if (safe_create_leading_directories(filename))
      +		die(_("failed to create directories for '%s'"), filename);
     -+	plist = fopen(filename, "w");
     -+
     -+	if (!plist)
     -+		die(_("failed to open '%s'"), filename);
     ++	plist = xfopen(filename, "w");
      +
      +	preamble = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
      +		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +	fprintf(plist, "</array>\n</dict>\n</plist>\n");
      +
      +	/* bootout might fail if not already running, so ignore */
     -+	bootout(filename);
     -+	if (bootstrap(filename))
     ++	boot_plist(0, filename);
     ++	if (boot_plist(1, filename))
      +		die(_("failed to bootstrap service %s"), filename);
      +
      +	fclose(plist);
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
       '
       
      +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
     -+	echo "#!/bin/sh\necho \$@ >>args" >print-args &&
     -+	chmod a+x print-args &&
     ++	write_script print-args "#!/bin/sh\necho \$* >>args" &&
      +
      +	rm -f args &&
      +	GIT_TEST_CRONTAB="./print-args" git maintenance start &&
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
      +	for frequency in hourly daily weekly
      +	do
      +		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
     -+		xmllint "$PLIST" >/dev/null &&
     ++		xmllint --noout "$PLIST" &&
      +		grep schedule=$frequency "$PLIST" &&
      +		echo "bootout gui/$UID $PLIST" >>expect &&
      +		echo "bootstrap gui/$UID $PLIST" >>expect || return 1
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
      +	test_cmp expect args &&
      +
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="./print-args"  git maintenance stop &&
     ++	GIT_TEST_CRONTAB="./print-args" git maintenance stop &&
      +
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	# stop does not remove plist files, but boots them out
     -+	rm expect &&
     -+	for frequency in hourly daily weekly
     -+	do
     -+		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
     -+		grep schedule=$frequency "$PLIST" &&
     -+		echo "bootout gui/$UID $PLIST" >>expect || return 1
     -+	done &&
     -+	test_cmp expect args
     ++	printf "bootout gui/$UID $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
     ++		hourly daily weekly >expect &&
     ++	test_cmp expect args &&
     ++	ls "$HOME/Library/LaunchAgents" >actual &&
     ++	test_line_count = 0 actual
      +'
      +
       test_expect_success 'register preserves existing strategy' '
 4:  84eb44de31 ! 4:  ed7a61978f maintenance: use Windows scheduled tasks
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSy
     - for more information.
     +@@ Documentation/git-maintenance.txt: To create more advanced customizations to your background tasks, see
     + launchctl.plist(5) for more information.
       
       
      +BACKGROUND MAINTENANCE ON WINDOWS SYSTEMS
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +static int schedule_task(const char *exec_path, enum schedule_priority schedule)
      +{
      +	int result;
     -+	struct strvec args = STRVEC_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +	const char *xml, *schtasks;
     -+	char *xmlpath;
     ++	char *xmlpath, *tempDir;
      +	FILE *xmlfp;
      +	const char *frequency = get_frequency(schedule);
      +	char *name = get_task_name(frequency);
      +
     -+	xmlpath =  xstrfmt("%s/schedule-%s.xml",
     -+			   the_repository->objects->odb->path,
     -+			   frequency);
     -+	xmlfp = fopen(xmlpath, "w");
     -+	if (!xmlfp)
     -+		die(_("failed to open '%s'"), xmlpath);
     ++	tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
     ++	xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
     ++	safe_create_leading_directories(xmlpath);
     ++	xmlfp = xfopen(xmlpath, "w");
      +
      +	xml = "<?xml version=\"1.0\" encoding=\"UTF-16\"?>\n"
      +	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
     @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
      +	schtasks = getenv("GIT_TEST_CRONTAB");
      +	if (!schtasks)
      +		schtasks = "schtasks";
     -+	strvec_split(&args, schtasks);
     -+	strvec_pushl(&args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
     ++	strvec_split(&child.args, schtasks);
     ++	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
      +
     -+	result = run_command_v_opt(args.v, 0);
     ++	child.no_stdout = 1;
     ++	child.no_stderr = 1;
     ++
     ++	if (start_command(&child))
     ++		die(_("failed to start schtasks"));
     ++	result = finish_command(&child);
      +
     -+	strvec_clear(&args);
      +	unlink(xmlpath);
     ++	rmdir(tempDir);
      +	free(xmlpath);
      +	free(name);
      +	return result;
     @@ t/t7900-maintenance.sh: test_expect_success !MACOS_MAINTENANCE 'stop from existi
       	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
       	grep "Important information!" cron.txt
      @@ t/t7900-maintenance.sh: test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
     - 	test_cmp expect args
     + 	test_line_count = 0 actual
       '
       
      +test_expect_success MINGW 'start and stop Windows maintenance' '
     @@ t/t7900-maintenance.sh: test_expect_success MACOS_MAINTENANCE 'start and stop ma
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	for frequency in hourly daily weekly
     -+	do
     -+		printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
     -+			$frequency $frequency
     -+	done >expect &&
     ++	printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/temp/schedule-%s.xml\n" \
     ++		hourly hourly daily daily weekly weekly >expect &&
      +	test_cmp expect args &&
      +
      +	rm -f args &&

-- 
gitgitgadget
