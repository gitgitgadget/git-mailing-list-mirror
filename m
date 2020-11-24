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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A0DC6379F
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BB20857
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbdKeM7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgKXEQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 23:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKXEQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 23:16:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A16C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so5698043wrm.13
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eeIDcAqf+Pw9wlbNWcOjs+vTf7fkxhWHZFPcc4OB9h8=;
        b=mbdKeM7lW/rMYCfZ6uOCp3wV6dhpU63xkJAiEiMw6stfv52fqiT8W5PfNir6kBB5aM
         ucyvUHJKAE97l+zPn0PJCTKhestqjELFFSNodQMjaHbbNWNpKScWaHr1V7A/rptnWq2u
         cysThS8KHek7cecOoXaTAodmmHTxj3VzCo5vtfjkHdkdKmiheEgGdBnb5dorsZbedIDH
         kSsIGYo5z+dg5+avPzg6pPM9PngHXl2HFXELL6D8UhQVz8Rv2n8zQEzFniFZRKlfD1BZ
         ZvMavWOOYBqgT1Rgwud3YWSKpOvOCJ0xF3A/dOQHwDfET94i3654gE8oin1cyaX/EWKy
         tUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eeIDcAqf+Pw9wlbNWcOjs+vTf7fkxhWHZFPcc4OB9h8=;
        b=YeFfvdjWp1WAKvoZRXxAl0Thw8Ew1C2dOy5RoE7XUmegrPEJNTZXHj0tMQEKyvZs7Q
         N7pTsbCTxLuv7Sfz2dxcyR+yVZXe1vQzyLaPe5DKhhlIlDmiALhDV1JOuA8RXjQhT455
         uvgSATtt9wtWTlUCZpillPkH0WL3EMnwffuKEjjwTb4FsaxFw5e8gBdql12PL64KvA4+
         HEkREBmVHoVI35+4UVM6qwRo3AfG+dsBLL2LmVUWUW28kuYUGw5EutsLlgKmUVNDNOw8
         PiikFzklRFZCnnEteIpvKtF95Pble0ptf+6oKe3Q7mB8C8No+lF4a8GQNKSXkWGhZfPV
         LaSw==
X-Gm-Message-State: AOAM531bqsjBCLHc+GVSO8n4Y2dSAAlQ0FGn7nZRV6StcAGC3T4PoXUw
        VPU5PvLbiGQ5wMIknWMcqL9ujcXhaOg=
X-Google-Smtp-Source: ABdhPJzCMPyS/RSghA/LgRRpiS7fRRz8M63LwbYT9nZkRZ9f1ul/Cjxj8GEm7kchFW7LLnVV3WnuRQ==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr2875218wrq.274.1606191407415;
        Mon, 23 Nov 2020 20:16:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm27502160wrn.72.2020.11.23.20.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:16:46 -0800 (PST)
Message-Id: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
References: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 04:16:41 +0000
Subject: [PATCH v5 0/4] Maintenance IV: Platform-specific background maintenance
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

Updates in V5
=============

 * Fixed docs from PATCH 2 to match those in v3.
   
   
 * Despite my best efforts, I was unable to make the macOS tests work on
   Windows, so they are still marked with "!MINGW". I updated the commit
   message to describe my problems there.
   
   
 * The Windows platform now uses xmks_tempfile() to create the XML files for
   'schtasks'. This led to some test fallout since the pathnames are no
   longer predictable.
   
   

Thanks, -Stolee

Derrick Stolee (4):
  maintenance: extract platform-specific scheduling
  maintenance: include 'cron' details in docs
  maintenance: use launchctl on macOS
  maintenance: use Windows scheduled tasks

 Documentation/git-maintenance.txt | 116 +++++++++
 builtin/gc.c                      | 416 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 110 +++++++-
 t/test-lib.sh                     |   7 +-
 4 files changed, 615 insertions(+), 34 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v4:

 1:  4807342b00 = 1:  4807342b00 maintenance: extract platform-specific scheduling
 2:  99170df462 ! 2:  7cc70a8fe7 maintenance: include 'cron' details in docs
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
 3:  ed0a0011fb ! 3:  cd015a5cbd maintenance: use launchctl on macOS
     @@ Commit message
          subcommand will succeed, if such a task already exists.
      
          The need for a user id requires us to run 'id -u' which works on
     -    POSIX systems but not Windows. The test therefore has a prerequisite
     -    that we are not on Windows. The cross-platform logic still allows us to
     -    test the macOS logic on a Linux machine.
     +    POSIX systems but not Windows. Further, the need for fully-qualitifed
     +    path names including $HOME behaves differently in the Git internals and
     +    the external test suite. The $HOME variable starts with "C:\..." instead
     +    of the "/c/..." that is provided by Git in these subcommands. The test
     +    therefore has a prerequisite that we are not on Windows. The cross-
     +    platform logic still allows us to test the macOS logic on a Linux
     +    machine.
      
          We can verify the commands that were run by 'git maintenance start'
          and 'git maintenance stop' by injecting a script that writes the
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: for advanced scheduling techniques. Please do use the full path and
     - executing the correct binaries in your schedule.
     +@@ Documentation/git-maintenance.txt: schedule to ensure you are executing the correct binaries in your
     + schedule.
       
       
      +BACKGROUND MAINTENANCE ON MACOS SYSTEMS
 4:  b8d86fb983 ! 4:  ac9a28bea3 maintenance: use Windows scheduled tasks
     @@ Commit message
      
          Since the GIT_TEST_MAINT_SCHEDULER environment variable allows us to
          specify 'schtasks' as the scheduler, we can test the Windows-specific
     -    logic on a macOS platform. Thus, add a check that the XML file written
     +    logic on other platforms. Thus, add a check that the XML file written
          by Git is valid when xmllint exists on the system.
      
     +    Since we use a temporary file for the XML files sent to 'schtasks', we
     +    must copy the file to a predictable filename. Use the number of lines in
     +    the 'args' file to provide a filename for xmllint. Instead of an exact
     +    match on the 'args' file, we 'grep' for the arguments other than the
     +    filename.
     +
          There is a deficiency in the current design. Windows has two kinds of
          applications: GUI applications that start by "winmain()" and console
          applications that start by "main()". Console applications are attached
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	int result;
      +	struct child_process child = CHILD_PROCESS_INIT;
      +	const char *xml;
     -+	char *xmlpath;
      +	struct tempfile *tfile;
      +	const char *frequency = get_frequency(schedule);
      +	char *name = schtasks_task_name(frequency);
      +
     -+	xmlpath =  xstrfmt("%s/schedule-%s.xml",
     -+			   the_repository->objects->odb->path,
     -+			   frequency);
     -+	tfile = create_tempfile(xmlpath);
     ++	tfile = xmks_tempfile("schedule_XXXXXX");
      +	if (!tfile || !fdopen_tempfile(tfile, "w"))
     -+		die(_("failed to create '%s'"), xmlpath);
     ++		die(_("failed to create temp xml file"));
      +
      +	xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
      +	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	      "</Task>\n";
      +	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
      +	strvec_split(&child.args, cmd);
     -+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", xmlpath, NULL);
     ++	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", tfile->filename.buf, NULL);
      +	close_tempfile_gently(tfile);
      +
      +	child.no_stdout = 1;
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	result = finish_command(&child);
      +
      +	delete_tempfile(&tfile);
     -+	free(xmlpath);
      +	free(name);
      +	return result;
      +}
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +		*) shift ;;
      +		esac
      +	done
     -+	test -z "$xmlfile" || cp "$xmlfile" .
     ++	lines=$(wc -l args | awk "{print \$1;}")
     ++	test -z "$xmlfile" || cp "$xmlfile" "schedule-$lines.xml"
      +	EOF
      +
      +	rm -f args &&
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
     -+		hourly hourly daily daily weekly weekly >expect &&
     -+	test_cmp expect args &&
     -+
      +	for frequency in hourly daily weekly
      +	do
     -+		test_xmllint "schedule-$frequency.xml"
     ++		grep "/create /tn Git Maintenance ($frequency) /f /xml" args \
     ++			|| return 1
     ++	done &&
     ++
     ++	for i in 1 2 3
     ++	do
     ++		test_xmllint "schedule-$i.xml" &&
     ++		grep "encoding=.US-ASCII." "schedule-$i.xml" || return 1
      +	done &&
      +
      +	rm -f args &&

-- 
gitgitgadget
