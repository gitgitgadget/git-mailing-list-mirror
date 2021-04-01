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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12240C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62576044F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhDASJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbhDASDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B4C02D540
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so2266691wrt.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v+4ydFp20gfehTB/QwfCWmMDLcbizE3XcA7eYRrUGT0=;
        b=Ry1NS8AoUVnj5UHjSG3YyHi8Pdty8F92LUO0nQNiNaKoI5vcTfMvjdB7ZuDLDTF0oY
         6YQ2kt9lcNBA4A1GuG8rEiCJaRztFwIYqx493RtYdueqwBYQL017w+9UX4edd7PULQJO
         b9iYHHNLDJVYHQBf/oaBXgV1hvLTMN5+FFwlBEG3lg6VDCGMXb/vCGcDWcZptKxPq0st
         +vI1iIEy36EuwElJ/bkSxq5Y6dhICOzyEzv42YufBheuxpaArM20L7A65AeSPa4yDYme
         7onEtczK2TSE8Vm8wrUnZ+mS+6KMIvDdgshGt+ABKG0xCx+8dH1ekhyIdJYfcLQLyzeg
         Y2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v+4ydFp20gfehTB/QwfCWmMDLcbizE3XcA7eYRrUGT0=;
        b=V0ykEBAL6dBTVEHjCwxDxyJjPYq58SjKZr1bulNma7WbZIFz5vdKNB/rTyNDaPzjaY
         wOZw5heyQDGFJ6ayFhQQD5uevNku8+zNBTRBzzA13L4mr316uBz3DKOsaUCYR4WKuUHc
         TaaqxylEhyq04y/NFPttz8bsUQUA66L2vRK7T2rflxXF9yq9yMSktvMuuwRa/XR0BJwi
         ohIe/ZAbA7U9DjOhTSW8/dARVty2skr4GYY7Tvz6JMyvicase7TT3LU8bF4wqOPrJT0p
         EnzF5eiiwayThpzfttAPvaTETOJvg2kzy99LdyoLdP00Bm37maYrn/PrM/LxdyhnfVaU
         UJAQ==
X-Gm-Message-State: AOAM530t1+BWwc+0BlitgMlHCWeVYkIKBoKlxnUb0FsbkDBiwtbSRn5J
        55/hmU/c05Xqn0QAlaeQKVMvoIE5qYU=
X-Google-Smtp-Source: ABdhPJwlbXDX326D0vhZ8+GuIcsjn3q+wTeoncPXufoZ7bzpy96uphxFcLGzOfusYiaFcRkHMcncag==
X-Received: by 2002:adf:f711:: with SMTP id r17mr10493675wrp.358.1617291674502;
        Thu, 01 Apr 2021 08:41:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm11308451wrg.84.2021.04.01.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:14 -0700 (PDT)
Message-Id: <451563314d84f9d6dee29a4899b5d18033aa227d.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:52 +0000
Subject: [PATCH 10/23] fsmonitor--daemon: add pathname classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
index 23a063707972..16252487240a 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -168,6 +168,87 @@ static int handle_client(void *data, const char *command,
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
index 09e4a6fb6675..97ea3766e900 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -32,5 +32,66 @@ struct fsmonitor_daemon_state {
 	int test_client_delay_ms;
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

