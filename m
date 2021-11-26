Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDEBC433FE
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbhKZWsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbhKZWqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79035C061763
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so21597670wrb.3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pXzafwMgh7oMX3BiplDKEE+Xu2DA06KjCNpz9Sj+YI=;
        b=PcoONVN3uDBjE5L3F3lLxj7hzWmjRtDYHrsXDMJInvBB7SRHqfxn2Jn9J28WsQtyHB
         PaIRvG0NzFzXGU1Ffnm9UcqI04WefuOPd0PaPmYlRuus3Za77yBhYOusqq011t5DFNwT
         VuRwnFW4XTxRog6q1rL9FzRAycsywADCpFs9LNbUbgSiCQ72Sqy780catYW9CsmQIYoB
         LiMx87BZwwLtee1ZM8US818JWzZeK1SQX8k8qxj3CUMFBaJLSjWfXtbT+6RO31rnEDm/
         jfET8AfvwrObGNSKq0pFz1IOh2H5kt9QImgU4bYwCm7x2UUsksQDucK67zri33hOkbrh
         TgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pXzafwMgh7oMX3BiplDKEE+Xu2DA06KjCNpz9Sj+YI=;
        b=TLOktRJvdpNDFGdjjH8Xn1fN2VFowkZZFGjueIcohBhop42y19eLfvhX872dwAtbgb
         MmlEHINl8/FbE0IcjQ3N8OuOngA/zGFX5mlGnY0kQ3lQZRJY4t8GHmK0gHCRqpao64sM
         RGtgk/q4csKr204wizspy4wjyYWXb1vTRKCvXtGtDE8aiRus/n+hiQ6sEjEEVFi5solA
         6sqorMG7kAp+C02WAJfr4oThGy5V9T50dkMEMzmx7j7odcsfb0fVgEy7iHPaKNYKFltw
         lLCHaaBQiktoItFKxs87Q88X8HbPeMvHfB2NteMXnICBwJi2hQibZ2ykKEagocwlLoE1
         hC2Q==
X-Gm-Message-State: AOAM530/jlwU4Gy5HZ1H+GDTk+lVucWFde8ZJ4jvAqFUHu2pY444x2SN
        dMUmrPmh/DQDZ5ctYFS3FeL2LE2Vluc=
X-Google-Smtp-Source: ABdhPJwK2iGEIXYvWa4hXT8An6istFHrHS23uXZdxStQFk7D89ny00qunZz7mOrMbQDrEVW2xHHN+w==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr17306450wrj.576.1637966465933;
        Fri, 26 Nov 2021 14:41:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm7335786wmr.35.2021.11.26.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:05 -0800 (PST)
Message-Id: <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:53 +0000
Subject: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
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
index 347d7181ae9..44f5bd38f7b 100644
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
+	}
+	return;
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

