Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E401FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdEaVos (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:48 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34219 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdEaVon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:43 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so18577114pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=peC3ImFReYOqbW6oObtcGdI/PL9hdsJmVj+9l5thF50=;
        b=eCiaF3mBq9aPOWUQT4LnV3Ib/qyhLlAKZ+HJQhCa363/wX5Ea+6NVd1oKb7cMD97sF
         zLD/DWZ/EKTL6+Ixp9Fu3hKs46MDdY6LLzO9mCfyLm5e4nc9okL4PBdl/RV38HkqsYzX
         +pLYpmEiR156UH6pbPu3Q9cRNMiQtPDnJsRSZkKVWRlMcVJmr1Y85rOPOSiHuzYOmgOf
         09a2kAlB+zKLaKxB87j+FoXEHTTHaHnjXJLzT4fokmURddo5Z4kELvKcv61TOsToYTiP
         xIHvHDeh5GBYmZ67y1m5h4fDCAT3XBJDdUmLil3LuaOw748nFLs/sce/Zc9+80e5/sa2
         bvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=peC3ImFReYOqbW6oObtcGdI/PL9hdsJmVj+9l5thF50=;
        b=ktRezP+Fj2z5mOU+/2EH9cPdJXYslFj5nonNMHT+SiZhWHVmjUWVjNCTO8JoAMDC+2
         yRFYW3sSHc6hannToynLVm0LJ5gWzitkz2OGS7kN6YOpzNUjwXlpVyGaWZUS/6mUngN3
         IogbqP9BoOVsPOUuurKbjcJ95MaM1RC4EZafgReZMEQsu9xy6dKtVb41Oucj5Oo57kyo
         VhxN/7k/9EojPJhxU3mFKXiU/Ru9OlBw47VYUbgkdSPB8TUENTEH0jSGDlbqqpOh/KF6
         jA0+zHeRqnIPKO9SsBdBwGos0euJD/PS739u3zvY4Hhtytp32g6wj6Iqxd+DLUNtsM98
         utlg==
X-Gm-Message-State: AODbwcC86rWGLVzbOxBIwM8fJS4ZnLE6eSYQb0WJVSfbAMkKUEda3uPm
        gdANQmcRdzjghmC5Z7IHnQ==
X-Received: by 10.99.169.26 with SMTP id u26mr35652628pge.177.1496267077582;
        Wed, 31 May 2017 14:44:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/31] setup: don't perform lazy initialization of repository state
Date:   Wed, 31 May 2017 14:43:50 -0700
Message-Id: <20170531214417.38857-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under some circumstances (bogus GIT_DIR value or the discovered gitdir
is '.git') 'setup_git_directory()' won't initialize key repository
state.  This leads to inconsistent state after running the setup code.
To account for this inconsistent state, lazy initialization is done once
a caller asks for the repository's gitdir or some other piece of
repository state.  This is confusing and can be error prone.

Instead let's tighten the expected outcome of 'setup_git_directory()'
and ensure that it initializes repository state in all cases that would
have been handled by lazy initialization.

This also lets us drop the requirement to have 'have_git_dir()' check if
the environment variable GIT_DIR was set as that will be handled by the
end of the setup code.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       |  2 ++
 environment.c | 17 ++++++++---------
 setup.c       | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 272f8e021..d41aab82f 100644
--- a/cache.h
+++ b/cache.h
@@ -462,6 +462,8 @@ static inline enum object_type object_type(unsigned int mode)
  */
 extern const char * const local_repo_env[];
 
+extern void setup_git_env(void);
+
 /*
  * Returns true iff we have a configured git repository (either via
  * setup_git_directory, or in the environment via $GIT_DIR).
diff --git a/environment.c b/environment.c
index d40b21fb7..a73b08f5d 100644
--- a/environment.c
+++ b/environment.c
@@ -160,7 +160,7 @@ static char *git_path_from_env(const char *envvar, const char *git_dir,
 	return xstrdup(value);
 }
 
-static void setup_git_env(void)
+void setup_git_env(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *gitfile;
@@ -205,28 +205,27 @@ int is_bare_repository(void)
 int have_git_dir(void)
 {
 	return startup_info->have_repository
-		|| git_dir
-		|| getenv(GIT_DIR_ENVIRONMENT);
+		|| git_dir;
 }
 
 const char *get_git_dir(void)
 {
 	if (!git_dir)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return git_dir;
 }
 
 const char *get_git_common_dir(void)
 {
 	if (!git_dir)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return git_common_dir;
 }
 
 const char *get_git_namespace(void)
 {
 	if (!namespace)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return namespace;
 }
 
@@ -276,7 +275,7 @@ const char *get_git_work_tree(void)
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return git_object_dir;
 }
 
@@ -316,14 +315,14 @@ int odb_pack_keep(const char *name)
 char *get_index_file(void)
 {
 	if (!git_index_file)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return git_index_file;
 }
 
 char *get_graft_file(void)
 {
 	if (!git_graft_file)
-		setup_git_env();
+		BUG("git environment hasn't been setup");
 	return git_graft_file;
 }
 
diff --git a/setup.c b/setup.c
index e99a82cbe..b2e05145c 100644
--- a/setup.c
+++ b/setup.c
@@ -1063,6 +1063,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	startup_info->have_repository = !nongit_ok || !*nongit_ok;
 	startup_info->prefix = prefix;
 
+	/*
+	 * Not all paths through the setup code will call 'set_git_dir()' (which
+	 * directly sets up the environment) so in order to guarantee that the
+	 * environment is in a consistent state after setup, explicitly setup
+	 * the environment if we have a repository.
+	 *
+	 * NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
+	 * code paths so we also need to explicitly setup the environment if
+	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
+	 * GIT_DIR values at some point in the future.
+	 */
+	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT))
+		setup_git_env();
+
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
 
-- 
2.13.0.506.g27d5fe0cd-goog

