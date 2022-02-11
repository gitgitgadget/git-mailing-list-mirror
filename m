Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67ACC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353584AbiBKU5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353544AbiBKU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3ED53
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v129so6184308wme.2
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b7cpQJtN1ExFiwysgLweLmA1ZMe7XzGXY14S4s0cGpE=;
        b=JeXgDMwur5f0aU+6DwPvKLS+V4YB1Wrr18JdYfJ9XSIU4BF6NW7wG5W/rkErE7ae6R
         TmB85CeN4ZEL+FSSYZXqWkX9bMb+LmMwWsJnbqCDe3nPDhmZeVBed08YjAtn4Gj5XI9a
         RQ52jftn8SPXheHFOrG2zfJQbnTEP9Bc7J279cX4Uxr5uQU/NH0Kb8aM9Km4Y0ZLw3+m
         N21FQU2eOhYAEqq/jTfFEuqbmOqOdfeKU5IQI8nMRHn3Y3Hwa19/1WF3zuTxtoc4LjfR
         k+W+1MUoSkRzGpwwj8jq133afVVjOgCnXhV3vjSN/LnCLRem/vcVz7NRGta4oXFI+gve
         4H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b7cpQJtN1ExFiwysgLweLmA1ZMe7XzGXY14S4s0cGpE=;
        b=bK7JN/lAPyRY66mV3Kw8vopmBPWjkWyuFNvCM360AQ/OWDPsP3cobFLdoNWh73lH/g
         JyfGYZ5BcxlSlTTnNviwhEyDuVv/D7VfMDOUP8Z954eA4Lc1m908bI+udhc7XmS3i9of
         ZwPP1PURfjWpy7C15eVlZvx+O6CaE4x3gPycqV+YsjkePqfYPA+t583Ia9ANcTSUx4aY
         V2pCSDhHBawsVimOdE67+Bux622Hna+D6q8Ybrq/quIqE5t5TbEfN9/flRFcZC1rNJzT
         rO6BY0qPnhjly0iiaZNXfSdVsTdoTMibEnZmYSg/4ai/zYrenKkTzoOishMV1vfLKY+k
         MElQ==
X-Gm-Message-State: AOAM5311n9wkxh7BtJyND1WvYnRhIwWnSrpRgnVWfdzFVotIIP89EK9L
        mvsawbjdzvUCX05P4SN1qQ2F/G+cgFY=
X-Google-Smtp-Source: ABdhPJwU/bUXnUPrqjUqatX2TK81cdAjXF7q61dH6bBkQnJ0GxxkG9/ZT2eOTqPm5OAW69i8Z85b7A==
X-Received: by 2002:a05:600c:224b:: with SMTP id a11mr1787566wmm.191.1644612990782;
        Fri, 11 Feb 2022 12:56:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm27187035wry.12.2022.02.11.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:30 -0800 (PST)
Message-Id: <21c099c5197168ffba5861d2b7a992fce84a7252.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:01 +0000
Subject: [PATCH v5 12/30] fsmonitor--daemon: add pathname classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
index 8988440b7c1..1618f1aa27f 100644
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
 static void *fsm_listen__thread_proc(void *_state)
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

