Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C22C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhLIFMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhLIFMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BBC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o13so7608776wrs.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JWGrtdQmUz0n8syt0R7EEy38F83S6N1dSa0aH9FmPDo=;
        b=eQ6uIxnuADykAwCnFmCXG5wMckWHTzGcakA7o4wIJ3Q52zzyeIOmJVkXGGe8swLqJb
         ngmU2E6srh7fQt0ewMXNENAFSFUJ8tnlcwUIJ9Evjg0l5ZfbBhUuJKZ57ugtdESQ++hx
         rtFw7SDWKokHSJaJvbv9Ih0Na0HiMKEIoW6JkbAfJgEZmfmrYY3t20XkRpPtQ4BB1dF1
         kzIF8LcbytbMpAgbx99KwF82NDP+fdLCHJhacV5esOpnCno7xP3rbR2GfdzXFcYIhp/5
         5X/Z3EanuyzDXU4nvHJviGvSFZo5Bd69ynDlYLZi/kKJhApDGGx6dCyiPNLckNofP2ji
         9Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JWGrtdQmUz0n8syt0R7EEy38F83S6N1dSa0aH9FmPDo=;
        b=I1rqqrGAtrb5TpfOHGPmpafUCLXcpHvv7spxYxqGSBlGzska4jS+fdecYQCu8+ufwX
         bD6v6NkK8aRfywU9czuMmA+rvzciGrJTJT0OXYcLtU0JIvZbDaejxmbdZvgVdBMDGWUi
         CoOlA+VRe5GH8KIVHk7idJevqGxwT58HxoSNh4nxI41OsDUD3IUpx3LJboNBqkyqjwyC
         bn7rPviXLY8rfoHBLfEPUCG85Ja5Y4ViYJp2rYViIIeDW6l9+CO2mNb93prGEaJbJaCd
         Y2mQc3QFj8Te/67WdQHeKxMzC+cPF6rJFSm1A57hR9IIeDw/eT9RhDesUB4+qxY+VqaB
         /JTw==
X-Gm-Message-State: AOAM531DPq8O1DrxvYJB8avIbOtu3j4SVaYF/70RKksNWeBF5LOalMKd
        19j6nqXlqtS8e8GWWAz6xtsod0w+iUg=
X-Google-Smtp-Source: ABdhPJy8DTm08OTTjQcSAJ8P3qlxpM7hLlOldDiMmrd2JyCnp2CGI4HTZ9CTTRGXN+aU/Z9Gvs0PkQ==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr3824793wrd.114.1639026519318;
        Wed, 08 Dec 2021 21:08:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm9799795wmq.44.2021.12.08.21.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:38 -0800 (PST)
Message-Id: <cd1f564c4c0df9d6546e35a475e1f95d4afd5f59.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:26 +0000
Subject: [PATCH v6 02/11] setup: introduce startup_info->original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Removing the current working directory causes all subsequent git
commands run from that directory to get confused and fail with a message
about being unable to read the current working directory:

    $ git status
    fatal: Unable to read current working directory: No such file or directory

Non-git commands likely have similar warnings or even errors, e.g.

    $ bash -c 'echo hello'
    shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
    hello

This confuses end users, particularly since the command they get the
error from is not the one that caused the problem; the problem came from
the side-effect of some previous command.

We would like to avoid removing the current working directory of our
parent process; towards this end, introduce a new variable,
startup_info->original_cwd, that tracks the current working directory
that we inherited from our parent process.  For convenience of later
comparisons, we prefer that this new variable store a path relative to
the toplevel working directory (thus much like 'prefix'), except without
the trailing slash.

Subsequent commits will make use of this new variable.

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h       |  2 ++
 common-main.c |  4 ++++
 setup.c       | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/cache.h b/cache.h
index eba12487b99..92e181ea759 100644
--- a/cache.h
+++ b/cache.h
@@ -1834,8 +1834,10 @@ void overlay_tree_on_index(struct index_state *istate,
 struct startup_info {
 	int have_repository;
 	const char *prefix;
+	const char *original_cwd;
 };
 extern struct startup_info *startup_info;
+extern const char *tmp_original_cwd;
 
 /* merge.c */
 struct commit_list;
diff --git a/common-main.c b/common-main.c
index 71e21dd20a3..aa8d5aba5bb 100644
--- a/common-main.c
+++ b/common-main.c
@@ -26,6 +26,7 @@ static void restore_sigpipe_to_default(void)
 int main(int argc, const char **argv)
 {
 	int result;
+	struct strbuf tmp = STRBUF_INIT;
 
 	trace2_initialize_clock();
 
@@ -49,6 +50,9 @@ int main(int argc, const char **argv)
 	trace2_cmd_start(argv);
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
 
+	if (!strbuf_getcwd(&tmp))
+		tmp_original_cwd = strbuf_detach(&tmp, NULL);
+
 	result = cmd_main(argc, argv);
 
 	trace2_cmd_exit(result);
diff --git a/setup.c b/setup.c
index 347d7181ae9..af3b8c09abe 100644
--- a/setup.c
+++ b/setup.c
@@ -12,6 +12,7 @@ static int work_tree_config_is_bogus;
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
+const char *tmp_original_cwd;
 
 /*
  * The input parameter must contain an absolute path, and it must already be
@@ -432,6 +433,69 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static void setup_original_cwd(void)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	const char *worktree = NULL;
+	int offset = -1;
+
+	if (!tmp_original_cwd)
+		return;
+
+	/*
+	 * startup_info->original_cwd points to the current working
+	 * directory we inherited from our parent process, which is a
+	 * directory we want to avoid removing.
+	 *
+	 * For convience, we would like to have the path relative to the
+	 * worktree instead of an absolute path.
+	 *
+	 * Yes, startup_info->original_cwd is usually the same as 'prefix',
+	 * but differs in two ways:
+	 *   - prefix has a trailing '/'
+	 *   - if the user passes '-C' to git, that modifies the prefix but
+	 *     not startup_info->original_cwd.
+	 */
+
+	/* Normalize the directory */
+	strbuf_realpath(&tmp, tmp_original_cwd, 1);
+	free((char*)tmp_original_cwd);
+	tmp_original_cwd = NULL;
+	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+
+	/*
+	 * Get our worktree; we only protect the current working directory
+	 * if it's in the worktree.
+	 */
+	worktree = get_git_work_tree();
+	if (!worktree)
+		goto no_prevention_needed;
+
+	offset = dir_inside_of(startup_info->original_cwd, worktree);
+	if (offset >= 0) {
+		/*
+		 * If startup_info->original_cwd == worktree, that is already
+		 * protected and we don't need original_cwd as a secondary
+		 * protection measure.
+		 */
+		if (!*(startup_info->original_cwd + offset))
+			goto no_prevention_needed;
+
+		/*
+		 * original_cwd was inside worktree; precompose it just as
+		 * we do prefix so that built up paths will match
+		 */
+		startup_info->original_cwd = \
+			precompose_string_if_needed(startup_info->original_cwd
+						    + offset);
+		return;
+	}
+
+no_prevention_needed:
+	free((char*)startup_info->original_cwd);
+	startup_info->original_cwd = NULL;
+}
+
 static int read_worktree_config(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -1330,6 +1394,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	setup_original_cwd();
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
-- 
gitgitgadget

