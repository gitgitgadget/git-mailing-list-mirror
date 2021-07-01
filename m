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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3AC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA56140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhGAOui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhGAOu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADEC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso4392592wme.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e9Y6nq/FoJ44oZvKJhw5ixuYaT7LRyHPOTQ3LNw2vyQ=;
        b=EG1Ihcx8vi7tFeaucaCuhWV8BaalCFgJykui/8EwhFNdffa5pfY9s3U+L93MRGf30a
         ePr2BnBJcSf1HLBv7uvm/iREmAe8Jz46sTMofH/biPQlh3vIMTAM3DsufJ1SSfr6G9ve
         pzUGnd/CM3w+LHGnpAS1j9Tl/qGhzLdOOOn4amK58gbApIkRFyxlDXqCHCtCcWO0RWfp
         ePFEtDVZZ15cL2+TGZkPesGqZQ4ODB6+bzd5G5EG8+1GGSlzS8ZdYVgMRyoCzDD+fXnw
         6H8ATPN9X7OVzj0oPvPTxegOtZ6lS+hQCrjdIC0r+Hr/dF1ih8Aa4hEG//KlAGECvRKH
         mXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e9Y6nq/FoJ44oZvKJhw5ixuYaT7LRyHPOTQ3LNw2vyQ=;
        b=oAxkCPuwXXT8rgnajhqJR2N5tTWJQ3b/aJkkPxumcqkH8hNMCjWX+KVoRX7BXOvbU4
         Mug0z3X2cSpcH6RKP67AzjwAQGtZ+ZpI+ynx0JKSBYvDm0x5slrZX5/AUumKIgd/vopX
         Gsdsjbk7WfWm5rHqrkHGxpCMpHgl3lOnxzsbexQhrs9VgcFRfbKwFQN9pykPdEeP7s9T
         CpO1JDNR22dh3B/DfsV80jPfYAnrba01zNQtMAKdP4KKIH1F/myfIVyCLcTmfrWuUwzk
         /C1mkmKYzK1XLCNHYHRq+5uWfGAD0ziwC5BRafda3MnFN0NOgojR1cPhlxeAAmKD/Roz
         wkcA==
X-Gm-Message-State: AOAM533XdQc2NxatBugO+vca6Mep2ATgcFzrO3hBE/k73JcOu4o1hD2T
        Pf3J2t1R8nQJc2BMg8XA7sol+17m1+Y=
X-Google-Smtp-Source: ABdhPJxB55g74BC++KUx2M1JIiMzdvSzdCBkOmuWe+XzpRAWskC4KeYZT7ZTySD/jKWs9bamovpjOA==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr11185167wmd.33.1625150874983;
        Thu, 01 Jul 2021 07:47:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm134749wrr.68.2021.07.01.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:54 -0700 (PDT)
Message-Id: <3b12f668060fc757d7d36dcad2c86bbb917a8b8b.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:26 +0000
Subject: [PATCH v3 16/34] fsmonitor--daemon: add pathname classification
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

Teach fsmonitor--daemon to classify relative and absolute
pathnames and decide how they should be handled.  This will
be used by the platform-specific backend to respond to each
filesystem event.

When we register for filesystem notifications on a directory,
we get events for everything (recursively) in the directory.
We want to report to clients changes to tracked and untracked
paths within the working directory.  We do not want to report
changes within the .git directory, for example.

This classification will be used in a later commit by the
different backends to classify paths as events are received.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 81 +++++++++++++++++++++++++++++++++++++
 fsmonitor--daemon.h         | 61 ++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index d6161ad95a5..e942f7c5840 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -121,6 +121,87 @@ static int handle_client(void *data,
 	return result;
 }
 
+#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *rel)
+{
+	if (fspathncmp(rel, ".git", 4))
+		return IS_WORKDIR_PATH;
+	rel += 4;
+
+	if (!*rel)
+		return IS_DOT_GIT;
+	if (*rel != '/')
+		return IS_WORKDIR_PATH; /* e.g. .gitignore */
+	rel++;
+
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_DOT_GIT;
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *rel)
+{
+	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
+			strlen(FSMONITOR_COOKIE_PREFIX)))
+		return IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX;
+
+	return IS_INSIDE_GITDIR;
+}
+
+static enum fsmonitor_path_type try_classify_workdir_abs_path(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+
+	if (fspathncmp(path, state->path_worktree_watch.buf,
+		       state->path_worktree_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_worktree_watch.len;
+
+	if (!*rel)
+		return IS_WORKDIR_PATH; /* it is the root dir exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_workdir_relative(rel);
+}
+
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path)
+{
+	const char *rel;
+	enum fsmonitor_path_type t;
+
+	t = try_classify_workdir_abs_path(state, path);
+	if (state->nr_paths_watching == 1)
+		return t;
+	if (t != IS_OUTSIDE_CONE)
+		return t;
+
+	if (fspathncmp(path, state->path_gitdir_watch.buf,
+		       state->path_gitdir_watch.len))
+		return IS_OUTSIDE_CONE;
+
+	rel = path + state->path_gitdir_watch.len;
+
+	if (!*rel)
+		return IS_GITDIR; /* it is the <gitdir> exactly */
+	if (*rel != '/')
+		return IS_OUTSIDE_CONE;
+	rel++;
+
+	return fsmonitor_classify_path_gitdir_relative(rel);
+}
+
 static void *fsmonitor_fs_listen__thread_proc(void *_state)
 {
 	struct fsmonitor_daemon_state *state = _state;
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 3009c1a83de..7bbb3a27a1c 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -30,5 +30,66 @@ struct fsmonitor_daemon_state {
 	struct ipc_server_data *ipc_server_data;
 };
 
+/*
+ * Pathname classifications.
+ *
+ * The daemon classifies the pathnames that it receives from file
+ * system notification events into the following categories and uses
+ * that to decide whether clients are told about them.  (And to watch
+ * for file system synchronization events.)
+ *
+ * The client should only care about paths within the working
+ * directory proper (inside the working directory and not ".git" nor
+ * inside of ".git/").  That is, the client has read the index and is
+ * asking for a list of any paths in the working directory that have
+ * been modified since the last token.  The client does not care about
+ * file system changes within the .git directory (such as new loose
+ * objects or packfiles).  So the client will only receive paths that
+ * are classified as IS_WORKDIR_PATH.
+ *
+ * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
+ * exact ".git" directory or GITDIR.  If the daemon receives a delete
+ * event for either of these directories, it will automatically
+ * shutdown, for example.
+ *
+ * Note that the daemon DOES NOT explicitly watch nor special case the
+ * ".git/index" file.  The daemon does not read the index and does not
+ * have any internal index-relative state.  The daemon only collects
+ * the set of modified paths within the working directory.
+ */
+enum fsmonitor_path_type {
+	IS_WORKDIR_PATH = 0,
+
+	IS_DOT_GIT,
+	IS_INSIDE_DOT_GIT,
+	IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX,
+
+	IS_GITDIR,
+	IS_INSIDE_GITDIR,
+	IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX,
+
+	IS_OUTSIDE_CONE,
+};
+
+/*
+ * Classify a pathname relative to the root of the working directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify a pathname relative to a <gitdir> that is external to the
+ * worktree directory.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
+	const char *relative_path);
+
+/*
+ * Classify an absolute pathname received from a filesystem event.
+ */
+enum fsmonitor_path_type fsmonitor_classify_path_absolute(
+	struct fsmonitor_daemon_state *state,
+	const char *path);
+
 #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 #endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

