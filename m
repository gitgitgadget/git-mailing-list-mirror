Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B2DC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F4F23C90
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgLITbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387749AbgLITbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:31:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A302C0619DA
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:29:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so3018970wrn.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DZEiXfB6BvgGgB0pG5NCe7hvlLnMGZTNk17lHdl6+D4=;
        b=PloTZ7AEUDZdVoGrGBoTTN3/GNoa/O3HGls1CdSKaYWqXt4ogTkShFXXKydxwZyaBI
         Clmjumnz91fUkqnfsExXe86XE42kZediwEOsKMv4Ke1uXFkhQNLOaaIED7Kgi9/OSHvV
         PRPEshDtuy4+o/Ea2edeJtJdDuVg5ufxNCD03pEqOUDZd+hVFG/rkCGYmWLbadRRVkNq
         2mvZawlOoZWl+3DKqX8YI+vUKdPoHAKrwVNYhehL7wBWlohhZlDu+U8HnfkMMeo6HJ7P
         3lT6G8UbzM39Asvq475pIY2hFH7/r7NnH00IhPgsutf2P3n/BH4Dh/iLibEmqHvFiJdf
         QrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DZEiXfB6BvgGgB0pG5NCe7hvlLnMGZTNk17lHdl6+D4=;
        b=mgy956I1eyGzZZYWgnPz8zsLmUUeVVRKCjgIo8i4Dl0+3wde8WrkGi4jiovMxWyGNw
         6AaOT5rTX7+1vIYMyDLy4A9kvKft8ZrfCsPuIPxemZvNYIxsvJDZvA7rKXK7rRBNG7iY
         fMHUjafZgmDyfBB0zdJxsWbtUeTgcKuiSi54TmEb4Kzh5C+d4otvaMG1Dvid/uY6HHTO
         aEdC+j5ErPrX7wreKSwT2UUFX/A0i5YTf6BnvTLIZ+P51+LhAUfUxZz60++EkERPBWzm
         hV1rmB0iXGz6papKe22A0XqXFFdFCgYfTGVMo5s5O/1czdtizOrcInTZdQffisXfYR4P
         VFXg==
X-Gm-Message-State: AOAM5319vzdYDkQ8pA/AdKgtrQmIgDcmGlZy2UsY9+BLnsBu5dMto25a
        avZUzw7etnrimLUgclHac/FBl5z0yH8=
X-Google-Smtp-Source: ABdhPJyR4avYK3B6XQ05nPVweFmx5yuitufaKoGyu07ijNMvf2Yk1igXWU8DltOMbQy5ypCfu2lxgw==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr183590wru.87.1607542143914;
        Wed, 09 Dec 2020 11:29:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm5149300wrr.85.2020.12.09.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:29:03 -0800 (PST)
Message-Id: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:28:58 +0000
Subject: [PATCH v6 0/4] Maintenance IV: Platform-specific background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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


Update in V6
============

 * The Windows platform uses the tempfile API a bit better, including using
   the frequency in the filename to make the test simpler.

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
 builtin/gc.c                      | 421 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            | 105 +++++++-
 t/test-lib.sh                     |   7 +-
 4 files changed, 615 insertions(+), 34 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/776

Range-diff vs v5:

 1:  4807342b001 = 1:  4807342b001 maintenance: extract platform-specific scheduling
 2:  7cc70a8fe7b = 2:  7cc70a8fe7b maintenance: include 'cron' details in docs
 3:  cd015a5cbd7 = 3:  cd015a5cbd7 maintenance: use launchctl on macOS
 4:  ac9a28bea39 ! 4:  6ad4a6b98c6 maintenance: use Windows scheduled tasks
     @@ Commit message
          by Git is valid when xmllint exists on the system.
      
          Since we use a temporary file for the XML files sent to 'schtasks', we
     -    must copy the file to a predictable filename. Use the number of lines in
     -    the 'args' file to provide a filename for xmllint. Instead of an exact
     -    match on the 'args' file, we 'grep' for the arguments other than the
     -    filename.
     +    prefix the random characters with the frequency so it is easier to
     +    examine the proper file during tests. Instead of an exact match on the
     +    'args' file, we 'grep' for the arguments other than the filename.
      
          There is a deficiency in the current design. Windows has two kinds of
          applications: GUI applications that start by "winmain()" and console
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	struct tempfile *tfile;
      +	const char *frequency = get_frequency(schedule);
      +	char *name = schtasks_task_name(frequency);
     ++	struct strbuf tfilename = STRBUF_INIT;
      +
     -+	tfile = xmks_tempfile("schedule_XXXXXX");
     -+	if (!tfile || !fdopen_tempfile(tfile, "w"))
     ++	strbuf_addf(&tfilename, "schedule_%s_XXXXXX", frequency);
     ++	tfile = xmks_tempfile(tfilename.buf);
     ++	strbuf_release(&tfilename);
     ++
     ++	if (!fdopen_tempfile(tfile, "w"))
      +		die(_("failed to create temp xml file"));
      +
      +	xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"
     @@ builtin/gc.c: static int launchctl_update_schedule(int run_maintenance, int fd,
      +	      "</Task>\n";
      +	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
      +	strvec_split(&child.args, cmd);
     -+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", tfile->filename.buf, NULL);
     ++	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml",
     ++				  get_tempfile_path(tfile), NULL);
      +	close_tempfile_gently(tfile);
      +
      +	child.no_stdout = 1;
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
      +		*) shift ;;
      +		esac
      +	done
     -+	lines=$(wc -l args | awk "{print \$1;}")
     -+	test -z "$xmlfile" || cp "$xmlfile" "schedule-$lines.xml"
     ++	test -z "$xmlfile" || cp "$xmlfile" "$xmlfile.xml"
      +	EOF
      +
      +	rm -f args &&
     -+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
     ++	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" GIT_TRACE2_PERF=1 git maintenance start &&
      +
      +	# start registers the repo
      +	git config --get --global maintenance.repo "$(pwd)" &&
      +
      +	for frequency in hourly daily weekly
      +	do
     -+		grep "/create /tn Git Maintenance ($frequency) /f /xml" args \
     -+			|| return 1
     -+	done &&
     -+
     -+	for i in 1 2 3
     -+	do
     -+		test_xmllint "schedule-$i.xml" &&
     -+		grep "encoding=.US-ASCII." "schedule-$i.xml" || return 1
     ++		grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
     ++		file=$(ls schedule_$frequency*.xml) &&
     ++		test_xmllint "$file" &&
     ++		grep "encoding=.US-ASCII." "$file" || return 1
      +	done &&
      +
      +	rm -f args &&

-- 
gitgitgadget
