Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD5EC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F82D22AAC
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbhAENJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbhAENJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 08:09:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE8C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 05:08:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so36081318wrm.11
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q4nS+fDZ9Vm3b8eZqeDiLs6aPe7ZjZu8SSFNC4PO6CU=;
        b=TUcIjjS18pnnhjxYciGYUYFz+2WumGpatvb84K/WUxsz7/0e2LPnWNBC17PghgdAi4
         AA1hliyQi5z2zPdSqDDdJr44PdnLRx0oRjVcHn62dcaFJP6xj5mw+YGrefMMRAEoYktJ
         n+MdfZZR8kl98p/wIvwFnTDeBxo9YFjUuHm2prUznKi7w2mJJXMKqAAInBulsQPNh8rq
         u/2Ntdb4I84PeqvH7yNFPZZ3dQ8J9Z02YHDOgukxq4k4LdCh2nib30m+YfO/ZV+wKoej
         nsfVFrbV6sgnsQ2Gcs5DRN/lXuyJcRRbmeYtd1hRwW1rgBHASV2UuiI0z99SQXroSPMy
         jpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q4nS+fDZ9Vm3b8eZqeDiLs6aPe7ZjZu8SSFNC4PO6CU=;
        b=Ire6iqC3qD8jt7qvghDcxD9I9ypKNRds7rICE4NElEUWXfwvsTw+n63LzF2IjarKQ4
         QF83iu69nCv7rUMQ74Udd0cjUgmrkLJo3IYe01Pe1C1/5JB3eQly/hTUN3u1hLOlKrvy
         0cSFByT7xBKV0SKsUq2i0xMIT+YG80cyfXgQ0K5Q0NJ181aYdQZ7KThfe8WCAEyU/zq6
         GRPltGjVma/1JjEZEtmR9tMn0ZZazolBUxjEpocZMPHvD1VM0og5FRK64ZnfOAy64HvD
         VDehZ/zgDANSM4/IY3TIEf0Kt1Jcl0WkALULwMqjutnyk/o62z5Qzthvk/VQBACvuJgd
         6YAg==
X-Gm-Message-State: AOAM532QfJvf+yVQgTyTJIx1JhrI7kRapq5kXmpXRZpl+4wZXo/dD13X
        lc8gAUc0HfIFGPWxu2uQcKhKlIuVaP8=
X-Google-Smtp-Source: ABdhPJwigUtizknUJaUfOiMK7eZD9KBlvgFFPSj2zv1MAEeG/FERd13nd5FV73/Lr6O+2e3/7GH26A==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr3396484wrx.300.1609852110451;
        Tue, 05 Jan 2021 05:08:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm4750712wmj.2.2021.01.05.05.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:08:29 -0800 (PST)
Message-Id: <pull.776.v7.git.1609852108.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
References: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 13:08:24 +0000
Subject: [PATCH v7 0/4] Maintenance IV: Platform-specific background maintenance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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


Update in V7
============

 * I had included an "encoding" string in the XML file for schtasks based on
   an example using UTF-8. The cross-platform tests then complained (in
   xmllint) because they wrote in ASCII instead. However, actually testing
   the situation on Windows (see [1]) against the real schtasks finds that
   it doesn't like that encoding string. I removed it entirely, and
   everything seems happier.

 * I squashed Eric's two commits making the tests better. He remains a
   co-author and I kept his Helped-by. I had to rearrange the commit message
   a bit to point out the care he took for the cross-platform tests without
   referring to the test doing the wrong thing.

[1] https://github.com/microsoft/git/pull/304

Thanks, -Stolee

cc: jrnieder@gmail.com cc: jonathantanmy@google.com cc: sluongng@gmail.com
cc: Đoàn Trần Công Danh congdanhqx@gmail.com cc: Martin Ågren
martin.agren@gmail.com cc: Eric Sunshine sunshine@sunshineco.com cc: Derrick
Stolee stolee@gmail.com

Derrick Stolee (4):
  maintenance: extract platform-specific scheduling
  maintenance: include 'cron' details in docs
  maintenance: use launchctl on macOS
  maintenance: use Windows scheduled tasks

 Documentation/git-maintenance.txt | 116 ++++++++
 builtin/gc.c                      | 422 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 104 +++++++-
 t/test-lib.sh                     |   7 +-
 4 files changed, 615 insertions(+), 34 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v6:

 1:  4807342b001 = 1:  4807342b001 maintenance: extract platform-specific scheduling
 2:  7cc70a8fe7b = 2:  7cc70a8fe7b maintenance: include 'cron' details in docs
 3:  cd015a5cbd7 ! 3:  3576c7aa54e maintenance: use launchctl on macOS
     @@ Commit message
          the XML format. This is useful for any system that might contain
          the tool, so use it whenever it is available.
      
     +    We strive to make these tests work on all platforms, but Windows caused
     +    some headaches. In particular, the value of getuid() called by the C
     +    code is not guaranteed to be the same as `$(id -u)` invoked by a test.
     +    This is because `git.exe` is a native Windows program, whereas the
     +    utility programs run by the test script mostly utilize the MSYS2 runtime,
     +    which emulates a POSIX-like environment. Since the purpose of the test
     +    is to check that the input to the hook is well-formed, the actual user
     +    ID is immaterial, thus we can work around the problem by making the the
     +    test UID-agnostic. Another subtle issue is the $HOME environment
     +    variable being a Windows-style path instead of a Unix-style path. We can
     +    be more flexible here instead of expecting exact path matches.
     +
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule'
       	grep "Important information!" cron.txt
       '
       
     -+test_expect_success !MINGW 'start and stop macOS maintenance' '
     -+	uid=$(id -u) &&
     ++test_expect_success 'start and stop macOS maintenance' '
     ++	# ensure $HOME can be compared against hook arguments on all platforms
     ++	pfx=$(cd "$HOME" && pwd) &&
      +
      +	write_script print-args <<-\EOF &&
     -+	echo $* >>args
     ++	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
      +	EOF
      +
      +	rm -f args &&
     @@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule'
      +	EOF
      +	test_cmp expect actual &&
      +
     -+	rm expect &&
     ++	rm -f expect &&
      +	for frequency in hourly daily weekly
      +	do
     -+		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
     ++		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
      +		test_xmllint "$PLIST" &&
      +		grep schedule=$frequency "$PLIST" &&
     -+		echo "bootout gui/$uid $PLIST" >>expect &&
     -+		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
     ++		echo "bootout gui/[UID] $PLIST" >>expect &&
     ++		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
      +	done &&
      +	test_cmp expect args &&
      +
     @@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule'
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
     ++	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
      +		hourly daily weekly >expect &&
      +	test_cmp expect args &&
      +	ls "$HOME/Library/LaunchAgents" >actual &&
 4:  6ad4a6b98c6 ! 4:  68f5013dee3 maintenance: use Windows scheduled tasks
     @@ Documentation/git-maintenance.txt: To create more advanced customizations to you
       Part of the linkgit:git[1] suite
      
       ## builtin/gc.c ##
     +@@ builtin/gc.c: static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
     + 		die(_("failed to create directories for '%s'"), filename);
     + 	plist = xfopen(filename, "w");
     + 
     +-	preamble = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
     ++	preamble = "<?xml version=\"1.0\"?>\n"
     + 		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
     + 		   "<plist version=\"1.0\">"
     + 		   "<dict>\n"
      @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
       		return launchctl_remove_plists(cmd);
       }
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	char *name = schtasks_task_name(frequency);
      +	struct strbuf tfilename = STRBUF_INIT;
      +
     -+	strbuf_addf(&tfilename, "schedule_%s_XXXXXX", frequency);
     ++	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
     ++		    get_git_common_dir(), frequency);
      +	tfile = xmks_tempfile(tfilename.buf);
      +	strbuf_release(&tfilename);
      +
      +	if (!fdopen_tempfile(tfile, "w"))
      +		die(_("failed to create temp xml file"));
      +
     -+	xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
     ++	xml = "<?xml version=\"1.0\" ?>\n"
      +	      "<Task version=\"1.4\" xmlns=\"http://schemas.microsoft.com/windows/2004/02/mit/task\">\n"
      +	      "<Triggers>\n"
      +	      "<CalendarTrigger>\n";
     @@ builtin/gc.c: static int update_background_schedule(int enable)
       	else
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS maintenance' '
     +@@ t/t7900-maintenance.sh: test_expect_success 'start and stop macOS maintenance' '
       	test_line_count = 0 actual
       '
       
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +	EOF
      +
      +	rm -f args &&
     -+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" GIT_TRACE2_PERF=1 git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
      +
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +	for frequency in hourly daily weekly
      +	do
      +		grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
     -+		file=$(ls schedule_$frequency*.xml) &&
     -+		test_xmllint "$file" &&
     -+		grep "encoding=.US-ASCII." "$file" || return 1
     ++		file=$(ls .git/schedule_${frequency}*.xml) &&
     ++		test_xmllint "$file" || return 1
      +	done &&
      +
      +	rm -f args &&
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +	# stop does not unregister the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
     -+	rm expect &&
      +	printf "/delete /tn Git Maintenance (%s) /f\n" \
      +		hourly daily weekly >expect &&
      +	test_cmp expect args

-- 
gitgitgadget
