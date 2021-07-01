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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B5C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF5461414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhGAOu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhGAOui (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD49C0613DF
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j34so4679527wms.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VhA8e70cmeJE/8taWH8a2ZkqsNWrr0+EV4Og5Cn7GBw=;
        b=nP7INjaYjqUto4SKdXQM5YdsCHjOh/AZXC35uTTT53iUclpCt1g7lBvl6gmzmYkZu7
         JH4+YqaoenxN6ROrkQZP0sUuNURhfnE11upP4UL93CBB0l+UaKGyXFunfbDKpMnn1Nfr
         7368EDHFVIpaWIxXycZ6QAtUjTGVeWme+DIbYwjBvJ85gGk19uyoaMHKENb0yhKH1Jkj
         y2aw6ucrvmMb4VAtrNKpvfPgXxUhVTm7QLz4CmnWyW+15zovEtdzOZlzpDz5GU91p3+6
         /a28arQMrbWwK3UU/sFN3B0sCUVQTVSvxmfdIdpHuoeTW5uJVWeOVFhM0Er5Jo0IcR3n
         LafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VhA8e70cmeJE/8taWH8a2ZkqsNWrr0+EV4Og5Cn7GBw=;
        b=SrEza7sDLgxbCqb8E3issqdUdIOhYaSJTtfLtfZRP3lIYLqeISBkezVevHwmNhgVVk
         0sqUAUHMVCcgzrG+DTAYr41BrsxVJyX0x/OMaiBB7keLXYb5kN8HPAr1aRRV8vw/0xPY
         VfQdkPfRGGXUszWbw4d4Hcpub5/5fwfGztEZ+90Du/9YUpIdZL5cOOntw3NyYu7r1YCi
         7l7IGuvwyUEaIVoD1tIVA3FMKnREPTmT+Zzyfpm7+XPpvtP/SCLhE3C09WoTxQ6/54kF
         vMTindKeZLq1sH6F9CGHNb+jZH87iHkxRspwyZ1/CWoDUT8o4AG40KV3tXiQ/pkNjqKV
         UM3A==
X-Gm-Message-State: AOAM5328A5NgD/kuLMM4FaxS2fW65dQkNNHUYw5PWUaA6i7u+mfvHJiI
        RQlMDIUkGiVjSTznWCg01DHnvKDPyUU=
X-Google-Smtp-Source: ABdhPJw+gDT92KkYOMFJn34Muw7Wk93tFeHpfWjqXPxGYP0O4nEjDQ12zZ1Mg7uewOt8TbmSn9SS5g==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr132882wmi.34.1625150885991;
        Thu, 01 Jul 2021 07:48:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm170890wrr.22.2021.07.01.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:05 -0700 (PDT)
Message-Id: <e32ba686f7e54097fb97f615d357ed3779755f21.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:43 +0000
Subject: [PATCH v3 33/34] fsmonitor: handle shortname for .git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

On Windows, teach FSMonitor to recognize the shortname of ".git"
as an alias for ".git".

Sometimes we receive FS events using the shortname, such as when
a CMD shell runs "RENAME GIT~1 FOO" or "RMDIR GIT~1".  The FS
notification arrives using whatever combination of long and
shortnames used by the other process.  (Shortnames do seem to
be case normalized, however.)

NEEDSWORK: This only addresses the case of removing or renaming
the ".git" directory using the shortname alias, so that the daemon
properly shuts down.  I'm leaving it a task for later to handle
the general case of shortnames and report them to the fsmonitor
client process.  This would include tracked and untracked paths
that just happen to have a shortname alias.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-win32.c | 192 +++++++++++++++----
 t/t7527-builtin-fsmonitor.sh                 |  65 +++++++
 2 files changed, 217 insertions(+), 40 deletions(-)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
index d707d47a0d7..f2ea5940790 100644
--- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
@@ -48,6 +48,8 @@ struct fsmonitor_daemon_backend_data
 #define LISTENER_HAVE_DATA_WORKTREE 1
 #define LISTENER_HAVE_DATA_GITDIR 2
 	int nr_listener_handles;
+
+	struct strbuf dot_git_shortname;
 };
 
 /*
@@ -250,6 +252,62 @@ static void cancel_rdcw_watch(struct one_watch *watch)
 	watch->is_active = FALSE;
 }
 
+/*
+ * Process a single relative pathname event.
+ * Return 1 if we should shutdown.
+ */
+static int process_1_worktree_event(
+	FILE_NOTIFY_INFORMATION *info,
+	struct string_list *cookie_list,
+	struct fsmonitor_batch **batch,
+	const struct strbuf *path,
+	enum fsmonitor_path_type t)
+{
+	const char *slash;
+
+	switch (t) {
+	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+		/* special case cookie files within .git */
+
+		/* Use just the filename of the cookie file. */
+		slash = find_last_dir_sep(path->buf);
+		string_list_append(cookie_list,
+				   slash ? slash + 1 : path->buf);
+		break;
+
+	case IS_INSIDE_DOT_GIT:
+		/* ignore everything inside of "<worktree>/.git/" */
+		break;
+
+	case IS_DOT_GIT:
+		/* "<worktree>/.git" was deleted (or renamed away) */
+		if ((info->Action == FILE_ACTION_REMOVED) ||
+		    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
+			trace2_data_string("fsmonitor", NULL,
+					   "fsm-listen/dotgit",
+					   "removed");
+			return 1;
+		}
+		break;
+
+	case IS_WORKDIR_PATH:
+		/* queue normal pathname */
+		if (!*batch)
+			*batch = fsmonitor_batch__new();
+		fsmonitor_batch__add_path(*batch, path->buf);
+		break;
+
+	case IS_GITDIR:
+	case IS_INSIDE_GITDIR:
+	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+	default:
+		BUG("unexpected path classification '%d' for '%s'",
+		    t, path->buf);
+	}
+
+	return 0;
+}
+
 /*
  * Process filesystem events that happen anywhere (recursively) under the
  * <worktree> root directory.  For a normal working directory, this includes
@@ -294,7 +352,6 @@ static int process_worktree_events(struct fsmonitor_daemon_state *state)
 	 */
 	for (;;) {
 		FILE_NOTIFY_INFORMATION *info = (void *)p;
-		const char *slash;
 		enum fsmonitor_path_type t;
 
 		strbuf_reset(&path);
@@ -303,45 +360,45 @@ static int process_worktree_events(struct fsmonitor_daemon_state *state)
 
 		t = fsmonitor_classify_path_workdir_relative(path.buf);
 
-		switch (t) {
-		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-			/* special case cookie files within .git */
-
-			/* Use just the filename of the cookie file. */
-			slash = find_last_dir_sep(path.buf);
-			string_list_append(&cookie_list,
-					   slash ? slash + 1 : path.buf);
-			break;
-
-		case IS_INSIDE_DOT_GIT:
-			/* ignore everything inside of "<worktree>/.git/" */
-			break;
-
-		case IS_DOT_GIT:
-			/* "<worktree>/.git" was deleted (or renamed away) */
-			if ((info->Action == FILE_ACTION_REMOVED) ||
-			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
-				trace2_data_string("fsmonitor", NULL,
-						   "fsm-listen/dotgit",
-						   "removed");
-				goto force_shutdown;
-			}
-			break;
-
-		case IS_WORKDIR_PATH:
-			/* queue normal pathname */
-			if (!batch)
-				batch = fsmonitor_batch__new();
-			fsmonitor_batch__add_path(batch, path.buf);
-			break;
-
-		case IS_GITDIR:
-		case IS_INSIDE_GITDIR:
-		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
-		default:
-			BUG("unexpected path classification '%d' for '%s'",
-			    t, path.buf);
-		}
+		if (process_1_worktree_event(info, &cookie_list, &batch,
+					     &path, t))
+			goto force_shutdown;
+
+		/*
+		 * NEEDSWORK: If `path` contains a shortname (that is,
+		 * if any component within it is a shortname), we
+		 * should expand it to a longname (See
+		 * `GetLongPathNameW()`) and re-normalize, classify,
+		 * and process it because our client is probably
+		 * expecting "normal" paths.
+		 *
+		 * HOWEVER, if our process has called `chdir()` to get
+		 * us out of the root of the worktree (so that the
+		 * root directory is not busy), then we have to be
+		 * careful to convert the paths in the INFO array
+		 * (which are relative to the directory of the RDCW
+		 * watch and not the CWD) into absolute paths before
+		 * calling GetLongPathNameW() and then convert the
+		 * computed value back to a RDCW-relative pathname
+		 * (which is what we and the client expect).
+		 *
+		 * FOR NOW, just handle case (1) exactly so that we
+		 * shutdown properly when ".git" is deleted via the
+		 * shortname alias.
+		 *
+		 * We might see case (2) events for cookie files, but
+		 * we can ignore them.
+		 *
+		 * FOR LATER, handle case (3) where the worktree
+		 * events contain shortnames.  We should convert
+		 * them to longnames to avoid confusing the client.
+		 */
+		if (data->dot_git_shortname.len &&
+		    !strcmp(path.buf, data->dot_git_shortname.buf) &&
+		    process_1_worktree_event(info, &cookie_list, &batch,
+					     &data->dot_git_shortname,
+					     IS_DOT_GIT))
+			goto force_shutdown;
 
 skip_this_path:
 		if (!info->NextEntryOffset)
@@ -415,6 +472,14 @@ static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 			    t, path.buf);
 		}
 
+		/*
+		 * WRT shortnames, this external gitdir will not see
+		 * case (1) nor case (3) events.
+		 *
+		 * We might see case (2) events for cookie files, but
+		 * we can ignore them.
+		 */
+
 skip_this_path:
 		if (!info->NextEntryOffset)
 			break;
@@ -493,6 +558,7 @@ clean_shutdown:
 int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
 {
 	struct fsmonitor_daemon_backend_data *data;
+	char shortname[16]; /* a padded 8.3 buffer */
 
 	CALLOC_ARRAY(data, 1);
 
@@ -523,6 +589,52 @@ int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
 		data->nr_listener_handles++;
 	}
 
+	/*
+	 * NEEDSWORK: Properly handle 8.3 shortnames.  RDCW events can
+	 * contain a shortname (if another application uses a
+	 * shortname in a system call).  We care about aliasing and
+	 * the use of shortnames for:
+	 *
+	 * (1) ".git",
+	 *     -- if an external process deletes ".git" using "GIT~1",
+	 *        we need to catch that and shutdown.
+	 *
+	 * (2) our cookie files,
+	 *     -- if an external process deletes one of our cookie
+	 *        files using a shortname, we will get a shortname
+	 *        event for it.  However, we should have already
+	 *        gotten a longname event for it when we created the
+	 *        cookie, so we can safely discard the shortname
+	 *        events for cookie files.
+	 *
+	 * (3) the spelling of modified files that we report to clients.
+	 *     -- we need to report the longname to the client because
+	 *        that is what they are expecting.  Presumably, the
+	 *        client is going to lookup the paths that we report
+	 *        in their index and untracked-cache, so we should
+	 *        normalize the data for them.  (Technically, they
+	 *        could adapt, so we could relax this maybe.)
+	 *
+	 * FOR NOW, while our CWD is at the root of the worktree we
+	 * can easily get the spelling of the shortname of ".git" (if
+	 * the volume has shortnames enabled).  For most worktrees
+	 * this value will be "GIT~1", but we don't want to assume
+	 * that.
+	 *
+	 * Capture this so that we can handle (1).
+	 *
+	 * We leave (3) for a future effort.
+	 */
+	strbuf_init(&data->dot_git_shortname, 0);
+	GetShortPathNameA(".git", shortname, sizeof(shortname));
+	if (!strcmp(".git", shortname))
+		trace_printf_key(&trace_fsmonitor, "No shortname for '.git'");
+	else {
+		trace_printf_key(&trace_fsmonitor,
+				 "Shortname of '.git' is '%s'", shortname);
+		strbuf_addstr(&data->dot_git_shortname, shortname);
+	}
+
 	state->backend_data = data;
 	return 0;
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d1832702397..b166b4a0a31 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -113,6 +113,71 @@ test_expect_success 'implicit daemon stop (rename .git)' '
 	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
 '
 
+# File systems on Windows may or may not have shortnames.
+# This is a volume-specific setting on modern systems.
+# "C:/" drives are required to have them enabled.  Other
+# hard drives default to disabled.
+#
+# This is a crude test to see if shortnames are enabled
+# on the volume containing the test directory.  It is
+# crude, but it does not require elevation like `fsutil`.
+#
+test_lazy_prereq SHORTNAMES '
+	mkdir .foo &&
+	test -d "FOO~1"
+'
+
+# Here we assume that the shortname of ".git" is "GIT~1".
+test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~1)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1s" &&
+
+	git init test_implicit_1s &&
+
+	start_daemon test_implicit_1s &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	# this moves {.git, GIT~1} to {.gitxyz, GITXYZ~1}.
+	# the rename-from FS Event will contain the shortname.
+	#
+	mv test_implicit_1s/GIT~1 test_implicit_1s/.gitxyz &&
+
+	sleep 1 &&
+	# put it back so that our status will not crawl out to our
+	# parent directory.
+	# this moves {.gitxyz, GITXYZ~1} to {.git, GIT~1}.
+	mv test_implicit_1s/.gitxyz test_implicit_1s/.git &&
+
+	test_must_fail git -C test_implicit_1s fsmonitor--daemon status
+'
+
+# Here we first create a file with LONGNAME of "GIT~1" before
+# we create the repo.  This will cause the shortname of ".git"
+# to be "GIT~2".
+test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1s2" &&
+
+	mkdir test_implicit_1s2 &&
+	echo HELLO >test_implicit_1s2/GIT~1 &&
+	git init test_implicit_1s2 &&
+
+	[ -f test_implicit_1s2/GIT~1 ] &&
+	[ -d test_implicit_1s2/GIT~2 ] &&
+
+	start_daemon test_implicit_1s2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	# the rename-from FS Event will contain the shortname.
+	#
+	mv test_implicit_1s2/GIT~2 test_implicit_1s2/.gitxyz &&
+
+	sleep 1 &&
+	# put it back so that our status will not crawl out to our
+	# parent directory.
+	mv test_implicit_1s2/.gitxyz test_implicit_1s2/.git &&
+
+	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
+'
+
 test_expect_success 'cannot start multiple daemons' '
 	test_when_finished "stop_daemon_delete_repo test_multiple" &&
 
-- 
gitgitgadget

