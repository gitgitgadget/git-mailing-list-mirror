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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F47C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F466127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhHXPox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbhHXPos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:44:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C2C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2663749wma.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ANKf0ECfPlFUL7cO5fLb0cnAqo6XdAma/YDaYYkaAQo=;
        b=d1fCCsjiu95zh0I4vuvixKIZNw07m3iGUNPgHKv5NPCzQSaaS4HnO0cHUUbtQ3qIMA
         LZvrluIAbkgRxXfABGFULs5A7AnSz+08gYLmHsBzxraP3ldBbrTd3YuMsdU9AgaXBXiC
         AzV5q+Ktejg+c82cufoSR5diix/1jD6xDc/TYnjm+RB4ybGjAEv6M4Rk6GRlxjaaTKb3
         kS5d+gZq/6FDMsptDQH5Q882e4oxAPLAD8A4dDjG46Dj/oixFOiz+u4uksAAs/BYjqLZ
         H9LVuoxEF8hTlZKNOUbKlsdO772u+v3Hq5YNbXb2JRZurMwQm+W1d5Hq/zNv87BygBRm
         y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ANKf0ECfPlFUL7cO5fLb0cnAqo6XdAma/YDaYYkaAQo=;
        b=DG92JN/HsMjEqCLMMSOEwIpfaz4P3eXJYmXH4k5G9Jbf3srNiJDs6GN1StY9caS3N6
         7iRIO4MvZnXn4Q+2jsIe3F2XlOrqZ4uqACWIqyPouVjNsUvnUWjjDWkW2cOOq5epBX09
         m5VNtSTKzTjnQzb/rqSDvbeZjMj5R3cNmJVkMYkz8Y850RCyljra/sBPRXpZ1yyLF+zl
         oDEbhYlPmQ8keInnOfj2h321cdwkVgp/zvdjYD4vg2UC6RtFfhoM2Jr9gZ52towC5P7H
         PeAcYTjBh8k9BoPhdtnMdil3Z+2ViB8WAu+STlGNNuC7YAM4yCN3/2+g1a8M4KrNqx3v
         DmYA==
X-Gm-Message-State: AOAM531EYJB3Xcbs7OG/kyV0TyZ/g5CFF+3Rwrwtgh+wQ9Qly8gGtA8x
        kmUrVzfYDmhONuBYmoA3sVPf6RAQwSc=
X-Google-Smtp-Source: ABdhPJxCtcGBbbgOOjS0t/2o94SVsaQt2wxxywSoZ+gJxFWWVBhiULk87dU9IfUbEzG3OYhkEbm4xA==
X-Received: by 2002:a05:600c:1d29:: with SMTP id l41mr3018857wms.177.1629819842511;
        Tue, 24 Aug 2021 08:44:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm19403884wrv.20.2021.08.24.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:44:02 -0700 (PDT)
Message-Id: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
References: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 15:44:00 +0000
Subject: [PATCH 2/2] maintenance: skip bootout/bootstrap when plist is
 registered
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

On macOS, we use launchctl to manage the background maintenance
schedule. This uses a set of .plist files to describe the schedule, but
these files are also registered with 'launchctl bootstrap'. If multiple
'git maintenance start' commands run concurrently, then they can collide
replacing these schedule files and registering them with launchctl.

To avoid extra launchctl commands, do a check for the .plist files on
disk and check if they are registered using 'launchctl list <name>'.
This command will return with exit code 0 if it exists, or exit code 113
if it does not.

We can test this behavior using the GIT_TEST_MAINT_SCHEDULER environment
variable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           | 54 +++++++++++++++++++++++++++++++++++-------
 t/t7900-maintenance.sh | 17 +++++++++++++
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4a78b497d0e..02bbe889ca6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1615,6 +1615,29 @@ static int launchctl_remove_plists(const char *cmd)
 		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
 }
 
+static int launchctl_list_contains_plist(const char *name, const char *cmd)
+{
+	int result;
+	struct child_process child = CHILD_PROCESS_INIT;
+	char *uid = launchctl_get_uid();
+
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "list", name, NULL);
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
+
+	/* Returns failure if 'name' doesn't exist. */
+	return !result;
+}
+
 static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
 {
 	int i, fd;
@@ -1624,7 +1647,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	char *filename = launchctl_service_filename(name);
 	struct lock_file lk = LOCK_INIT;
 	static unsigned long lock_file_timeout_ms = ULONG_MAX;
-	struct strbuf plist = STRBUF_INIT;
+	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
+	struct stat st;
 
 	preamble = "<?xml version=\"1.0\"?>\n"
 		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
@@ -1691,18 +1715,30 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
 					       lock_file_timeout_ms);
 
-	if (write_in_full(fd, plist.buf, plist.len) < 0 ||
-	    commit_lock_file(&lk))
-		die_errno(_("could not write '%s'"), filename);
-
-	/* bootout might fail if not already running, so ignore */
-	launchctl_boot_plist(0, filename, cmd);
-	if (launchctl_boot_plist(1, filename, cmd))
-		die(_("failed to bootstrap service %s"), filename);
+	/*
+	 * Does this file already exist? With the intended contents? Is it
+	 * registered already? Then it does not need to be re-registered.
+	 */
+	if (!stat(filename, &st) && st.st_size == plist.len &&
+	    strbuf_read_file(&plist2, filename, plist.len) == plist.len &&
+	    !strbuf_cmp(&plist, &plist2) &&
+	    launchctl_list_contains_plist(name, cmd))
+		rollback_lock_file(&lk);
+	else {
+		if (write_in_full(fd, plist.buf, plist.len) < 0 ||
+		    commit_lock_file(&lk))
+			die_errno(_("could not write '%s'"), filename);
+
+		/* bootout might fail if not already running, so ignore */
+		launchctl_boot_plist(0, filename, cmd);
+		if (launchctl_boot_plist(1, filename, cmd))
+			die(_("failed to bootstrap service %s"), filename);
+	}
 
 	free(filename);
 	free(name);
 	strbuf_release(&plist);
+	strbuf_release(&plist2);
 	return 0;
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c00..14b30f37ec7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -578,6 +578,23 @@ test_expect_success 'start and stop macOS maintenance' '
 	test_line_count = 0 actual
 '
 
+test_expect_success 'use launchctl list to prevent extra work' '
+	# ensure we are registered
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+
+	# do it again on a fresh args file
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+
+	ls "$HOME/Library/LaunchAgents" >actual &&
+	cat >expect <<-\EOF &&
+	list org.git-scm.git.hourly
+	list org.git-scm.git.daily
+	list org.git-scm.git.weekly
+	EOF
+	test_cmp expect args
+'
+
 test_expect_success 'start and stop Windows maintenance' '
 	write_script print-args <<-\EOF &&
 	echo $* >>args
-- 
gitgitgadget
