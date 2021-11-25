Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6071CC433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353579AbhKYIod (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353356AbhKYImc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40690C06175C
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y196so4843960wmc.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8XVljRNRP03QkD5N2mWUjNprvwcPNj5TXePdLPaYnmk=;
        b=XqMI5AHQt3U67JUkk7ph7AhGPTqJKxCOatV1wpx87GsfW16ipUCQXbNaX9WxiquPyo
         2d7V282nhWlm/OAbpofn53sIjTApFF2yv68c9tPaANywIO14YWyO5L99YnAy3B3/LPjm
         I+PW94YmEGE+8bVH/6pZXJ5F77rssnxcnpTMP9B2CTeKjqcJ91T4HxAqwOx4woWdZuoD
         Q0IA/VJC6ardWmffot+rSQQumUHPVjowD82XS/qG9DhYppXcWNhjFafvtM1Eldbqbo5E
         paplIf3DDmP2g3qlsN/jcnjK2GS60TjswYiqJddZ7SXyO/J2ikH10X6irbiEVv7vs9qq
         dePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8XVljRNRP03QkD5N2mWUjNprvwcPNj5TXePdLPaYnmk=;
        b=4/T2LUO5LHeCGm4RV16PGSQywNOo3kjFX1cO08DMdeZv1BwqTgrzPM3q5HQw7gJJ1W
         M74LJLRvAWnVInFuVF4CmOtmC/pn4wtXrOGTuYAyd1BrxcI0zT0iI94kelvgC3NH+QAh
         FqwPtFq7a9jrhVyaS3mHTlDll+oQZ98847FXjFHcgO3KAsPIn/Emtx//5rqVnzkHaLOq
         Y+gjnjjUrl1fSjwpDPJVZ+wujS9TChfYKmNtEJBFdatxTeMuL1IrgyHSflGuSj8F1nBT
         GI8DO0KHeVgaaFSAQt/sxXy6E7fME5iKnvBmoAyj2cKzUmZ8NpLjIxnYAk4Mp/12roQ3
         UBjQ==
X-Gm-Message-State: AOAM531e91U/FIBNIQI/0aa5PkfYsKD+stdQDvUpmwaOK2nZyuGcXT5W
        5Wz6A7zbzr0KHOoyNOFDmSRJwUU9PZo=
X-Google-Smtp-Source: ABdhPJy92fiTDQlzJmk8x57yZGQvlyC8cfyE4upmO+UHua/dR5j3PJCfLxBxwEJTyYWro7t9ZMnF4g==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr5046610wmm.189.1637829559565;
        Thu, 25 Nov 2021 00:39:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm2435900wre.46.2021.11.25.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:19 -0800 (PST)
Message-Id: <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:09 +0000
Subject: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
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
 cache.h |  1 +
 git.c   |  2 ++
 setup.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/cache.h b/cache.h
index eba12487b99..d7903c65b57 100644
--- a/cache.h
+++ b/cache.h
@@ -1834,6 +1834,7 @@ void overlay_tree_on_index(struct index_state *istate,
 struct startup_info {
 	int have_repository;
 	const char *prefix;
+	const char *original_cwd;
 };
 extern struct startup_info *startup_info;
 
diff --git a/git.c b/git.c
index 5ff21be21f3..2c98ab48936 100644
--- a/git.c
+++ b/git.c
@@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
 
 	trace_command_performance(argv);
 
+	startup_info->original_cwd = xgetcwd();
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/setup.c b/setup.c
index 347d7181ae9..f30657723ea 100644
--- a/setup.c
+++ b/setup.c
@@ -432,6 +432,54 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static void setup_original_cwd(void)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	const char *worktree = NULL;
+	int offset = -1;
+
+	/*
+	 * startup_info->original_cwd wass set early on in cmd_main(), unless
+	 * we're an auxiliary tool like git-remote-http or test-tool.
+	 */
+	if (!startup_info->original_cwd)
+		return;
+
+	/*
+	 * startup_info->original_cwd points to the current working
+	 * directory we inherited from our parent process, which is a
+	 * directory we want to avoid incidentally removing.
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
+	strbuf_realpath(&tmp, startup_info->original_cwd, 1);
+	free((char*)startup_info->original_cwd);
+	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+
+	/* Find out if this is in the worktree */
+	worktree = get_git_work_tree();
+	if (worktree)
+		offset = dir_inside_of(startup_info->original_cwd, worktree);
+	if (offset >= 0) {
+		/*
+		 * original_cwd was inside worktree; precompose it just as
+		 * we do prefix so that built up paths will match
+		 */
+		startup_info->original_cwd = \
+			precompose_string_if_needed(startup_info->original_cwd
+						    + offset);
+	}
+}
+
 static int read_worktree_config(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -1330,6 +1378,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	setup_original_cwd();
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
-- 
gitgitgadget

