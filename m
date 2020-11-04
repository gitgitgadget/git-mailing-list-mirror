Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A6BC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EF82076D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2CMTLAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgKDUGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbgKDUGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:06:14 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4ECC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:06:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so3505522wme.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NR1LoP115CjTsX53Y9Y/EgMRSl+LEzxKaB91fvmP6xI=;
        b=C2CMTLAjYsIjPV/N52ydClF+NEvnyCb4/N1n2Am/t0s+XNoGes3tDozerOWsXV6pHS
         czWSKtmluMyzMnRRBzSMw8VNc78ZXkDuOxJaQRwN11WEi3JDnYLI1XhQ74JFWsqAskde
         MElyqY2bmM0x7sj1+87F4U70YEn0reWqLKCd3enGfah1byxD4A2oqv+yLgtR1Tun13rf
         QhfLGBatm2vBu/mkkAXfP59hQDKbp61iwXr8noKYC7tW7PauVua4+WCSI+FSRcguP9AR
         6fLxELsJtdPECZMatQ03yfQgMLfdWS4cwWVZLKwdMYkhGbS3AE3SgkD3PFjQO1SKcT+/
         JG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NR1LoP115CjTsX53Y9Y/EgMRSl+LEzxKaB91fvmP6xI=;
        b=ExCUEoP/vCHE2/gXlRvZhftqKcT69aPLez98Vs6uBFQzA1ZxZ/QKDnkEZynafMsBhG
         iHYfatOWAySc8GND2I/N/K10ZHmRkN5aiPUh4DvPDGhiTj/nGBhj668fMhm/1EgZ0a4m
         DgQ9Z8ilVNyXoYMtij4R3LvMjBIOT57ecM1/kFI/79s8LessoW+GipL5B6sCd0n/RaQ4
         S0GnmI9A34bRmFb2CsCgwZHGf4ckx3/b2rSye1KT0vLVxmf7FopwLoXkPUCsx1So2S3L
         3hBGmT5cCsG7a3duUMPMvAMG3kyosstNOcJpSGxURqMNRQJSjzCFvlQaoMzHOB+KdC67
         ZCeA==
X-Gm-Message-State: AOAM531FMcZC+JIIW2kV77RNFMh8ZxbKT7sqbnsVNiPyQ87dx7ruc4tp
        ZZ3ZL0D4KMRuP4WZcEQBvL8CCZwsOZw=
X-Google-Smtp-Source: ABdhPJxTTe0v992ipD+U9F03fKaqNuvqqCo+XOqEk8HGAK3d3yU+2Nwji77vkvIOMFPGRCvJF0h8dQ==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr6257554wmg.2.1604520369720;
        Wed, 04 Nov 2020 12:06:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm3957311wro.89.2020.11.04.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:06:09 -0800 (PST)
Message-Id: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 20:06:04 +0000
Subject: [PATCH v2 0/4] Maintenance IV: Platform-specific background maintenance
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

Derrick Stolee (4):
  maintenance: extract platform-specific scheduling
  maintenance: include 'cron' details in docs
  maintenance: use launchctl on macOS
  maintenance: use Windows scheduled tasks

 Documentation/git-maintenance.txt | 119 +++++++++
 builtin/gc.c                      | 428 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            |  83 +++++-
 t/test-lib.sh                     |   4 +
 4 files changed, 614 insertions(+), 20 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v1:

 1:  d35f1aa162 = 1:  d35f1aa162 maintenance: extract platform-specific scheduling
 -:  ---------- > 2:  709a173720 maintenance: include 'cron' details in docs
 2:  832fdf1687 ! 3:  0fafd75d10 maintenance: use launchctl on macOS
     @@ Commit message
          and 'git maintenance stop' by injecting a script that writes the
          command-line arguments into GIT_TEST_CRONTAB.
      
     +    An earlier version of this patch accidentally had an opening
     +    "<dict>" tag when it should have had a closing "</dict>" tag. This
     +    was caught during manual testing with actual 'launchctl' commands,
     +    but we do not want to update developers' tasks when running tests.
     +    It appears that macOS includes the "xmllint" tool which can verify
     +    the XML format, so call it from the macOS-specific tests to ensure
     +    the .plist files are well-formatted.
     +
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## Documentation/git-maintenance.txt ##
     +@@ Documentation/git-maintenance.txt: for advanced scheduling techniques. Please do use the full path and
     + executing the correct binaries in your schedule.
     + 
     + 
     ++BACKGROUND MAINTENANCE ON MACOS SYSTEMS
     ++---------------------------------------
     ++
     ++While macOS technically supports `cron`, using `crontab -e` requires
     ++elevated privileges and the executed process do not have a full user
     ++context. Without a full user context, Git and its credential helpers
     ++cannot access stored credentials, so some maintenance tasks are not
     ++functional.
     ++
     ++Instead, `git maintenance start` interacts with the `launchctl` tool,
     ++which is the recommended way to
     ++https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html[schedule timed jobs in macOS].
     ++
     ++Scheduling maintenance through `git maintenance (start|stop)` requires
     ++some `launchctl` features available only in macOS 10.11 or later.
     ++
     ++Your user-specific scheduled tasks are stored as XML-formatted `.plist`
     ++files in `~/Library/LaunchAgents/`. You can see the currently-registered
     ++tasks using the following command:
     ++
     ++-----------------------------------------------------------------------
     ++$ ls ~/Library/LaunchAgents/ | grep org.git-scm.git
     ++org.git-scm.git.daily.plist
     ++org.git-scm.git.hourly.plist
     ++org.git-scm.git.weekly.plist
     ++-----------------------------------------------------------------------
     ++
     ++One task is registered for each `--schedule=<frequency>` option. To
     ++inspect how the XML format describes each schedule, open one of these
     ++`.plist` files in an editor and inspect the `<array>` element following
     ++the `<key>StartCalendarInterval</key>` element.
     ++
     ++`git maintenance start` will overwrite these files and register the
     ++tasks again with `launchctl`, so any customizations should be done by
     ++creating your own `.plist` files with distinct names. Similarly, the
     ++`git maintenance stop` command will unregister the tasks with `launchctl`
     ++and delete the `.plist` files.
     ++
     ++To create more advanced customizations to your background tasks, see
     ++https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142[the `launchctl` documentation]
     ++for more information.
     ++
     ++
     + GIT
     + ---
     + Part of the linkgit:git[1] suite
     +
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_unregister(void)
       	return run_command(&config_unset);
     @@ builtin/gc.c: static int maintenance_unregister(void)
      +		repeat = "<dict>\n"
      +			 "<key>Hour</key><integer>%d</integer>\n"
      +			 "<key>Minute</key><integer>0</integer>\n"
     -+			 "<dict>\n";
     ++			 "</dict>\n";
      +		for (i = 1; i <= 23; i++)
      +			fprintf(plist, repeat, i);
      +		break;
     @@ t/t7900-maintenance.sh: test_expect_success 'stop from existing schedule' '
      +	for frequency in hourly daily weekly
      +	do
      +		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
     ++		xmllint "$PLIST" >/dev/null &&
      +		grep schedule=$frequency "$PLIST" &&
      +		echo "bootout gui/$UID $PLIST" >>expect &&
      +		echo "bootstrap gui/$UID $PLIST" >>expect || return 1
 3:  a9221cc4aa ! 4:  84eb44de31 maintenance: use Windows scheduled tasks
     @@ Commit message
          short term. In the long term, we can consider creating this GUI
          shim application within core Git, perhaps in contrib/.
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## Documentation/git-maintenance.txt ##
     +@@ Documentation/git-maintenance.txt: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSy
     + for more information.
     + 
     + 
     ++BACKGROUND MAINTENANCE ON WINDOWS SYSTEMS
     ++-----------------------------------------
     ++
     ++Windows does not support `cron` and instead has its own system for
     ++scheduling background tasks. The `git maintenance start` command uses
     ++the `schtasks` command to submit tasks to this system. You can inspect
     ++all background tasks using the Task Scheduler application. The tasks
     ++added by Git have names of the form `Git Maintenance (<frequency>)`.
     ++The Task Scheduler GUI has ways to inspect these tasks, but you can also
     ++export the tasks to XML files and view the details there.
     ++
     ++Note that since Git is a console application, these background tasks
     ++create a console window visible to the current user. This can be changed
     ++manually by selecting the "Run whether user is logged in or not" option
     ++in Task Scheduler. This change requires a password input, which is why
     ++`git maintenance start` does not select it by default.
     ++
     ++If you want to customize the background tasks, please rename the tasks
     ++so future calls to `git maintenance (start|stop)` do not overwrite your
     ++custom tasks.
     ++
     ++
     + GIT
     + ---
     + Part of the linkgit:git[1] suite
     +
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int platform_update_schedule(int run_maintenance, int fd)
       	else
     @@ t/t7900-maintenance.sh: test_expect_success MACOS_MAINTENANCE 'start and stop ma
       '
       
      +test_expect_success MINGW 'start and stop Windows maintenance' '
     -+	echo "echo \$@ >>args" >print-args &&
     -+	chmod a+x print-args &&
     ++	write_script print-args <<-\EOF &&
     ++	echo $* >>args
     ++	EOF
      +
      +	rm -f args &&
      +	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
     -+	cat args &&
      +
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	rm expect &&
      +	for frequency in hourly daily weekly
      +	do
     -+		echo "/create /tn Git Maintenance ($frequency) /f /xml .git/objects/schedule-$frequency.xml" >>expect \
     -+			|| return 1
     -+	done &&
     ++		printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
     ++			$frequency $frequency
     ++	done >expect &&
      +	test_cmp expect args &&
      +
      +	rm -f args &&
     -+	GIT_TEST_CRONTAB="/bin/sh print-args"  git maintenance stop &&
     ++	GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance stop &&
      +
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
      +	rm expect &&
     -+	for frequency in hourly daily weekly
     -+	do
     -+		echo "/delete /tn Git Maintenance ($frequency) /f" >>expect \
     -+			|| return 1
     -+	done &&
     ++	printf "/delete /tn Git Maintenance (%s) /f\n" \
     ++		hourly daily weekly >expect &&
      +	test_cmp expect args
      +'
      +

-- 
gitgitgadget
