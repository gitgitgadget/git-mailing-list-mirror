Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CB520D15
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdFTTUN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:13 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33272 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:12 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so66730290pgc.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+BWtY2Mc1b8LlRlypd9JXlo7nZ8kUdLiNpD9zxBGHzg=;
        b=XoiRxnyutewVhqWnxoMpxCFPECdBHOA/PK/XFPngYlWpXOrf2ycuBI5M02OY0bc26i
         rYP7QLWFaNgeYva6Pk2gB0JSySvWseeb4KwXlw7aZYf2iJ3iPKfoWwgYsbgNbjVx9rZD
         tCnGAF3QHFZnxahH9136KqVGKuwpm0IkZ42QE1IXD3dyhf6/GoZoix/zet/CE76i5EGT
         d4thsKlpH3CgB0Ex7MUJqguTT32ZZY+bLHiVO2RERlNKBPfvBLPMKM5CvaFIVdaf8usJ
         c9Ax/LnTzDJOgpZKbv9ekZZWmtkDECOlkOo9kxEpCvc4vhDJEkx+ivUdvNhdw8sipUnA
         4e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+BWtY2Mc1b8LlRlypd9JXlo7nZ8kUdLiNpD9zxBGHzg=;
        b=ZsNzmEdyNSCSTLYJjfCE6uSp7eIgIxTalWUnBw8dcTVsf4ddFT9ArPju/UyWQJxCTa
         4Di+qLUno+bZZNvMD7cdAcyFaQLjrUhm6xvmDyXEAn93qnR0Z46oDnfT8+beFUlVnE7+
         KXmovY2/3SW4PUmHJ7OAQ5vRshanIHtba/NgmIQUQPyb/+3wyrHmI2KKi0nz5/bOH4sA
         pysjaRAdgdupWGd7dL7xFvsj4CnlJL0Ff2bEbDmphsHADq8OoIoI+CSP2nGXZ/yt64iM
         RPigZfZNM9J9Z+MhdoQuMsXb9zXSRrXhzQIq86X8/YyPJfiLkwFCxUaeAiyRwVTSyhVe
         aJjA==
X-Gm-Message-State: AKS2vOxEAvcBurKO9dsBKmtPL+237OobDtGMMVx8XjJq4Ds2nxer4ojV
        MDsFvhIzzWEJv4misf8H7w==
X-Received: by 10.84.218.198 with SMTP id g6mr14512673plm.132.1497986411148;
        Tue, 20 Jun 2017 12:20:11 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 01/20] setup: don't perform lazy initialization of repository state
Date:   Tue, 20 Jun 2017 12:19:32 -0700
Message-Id: <20170620191951.84791-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
index 96055c222..7c81749a9 100644
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
index 358fbc2e5..24a738b0d 100644
--- a/setup.c
+++ b/setup.c
@@ -1091,6 +1091,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
2.13.1.611.g7e3b11ae1-goog

