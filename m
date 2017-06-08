Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B981FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdFHXlb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:31 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36531 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdFHXlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:22 -0400
Received: by mail-pg0-f42.google.com with SMTP id a70so20691604pge.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T25PkEtCWX4TX68vpWe5rWPt6YtCi2v38LC41JQ63wM=;
        b=RJhV3I58IKvtPlqyr4q0TTYRQeiiM2sAD+Zt9AhdqsSGEspTGyTn4PIyclieGZVbTy
         PV5Q1HoR2t4FZKV5Vp0zbL41ZX8S7c0nbsJUU1QXLMLw45Y89iXjb/nwiPdXpkuGf5Qt
         7Bpo8gbKNNf5zoMB00KKWHDM7gKLlw1GlQ1nJV1UGD2lqm8QVgNEFcmtlfl7h3U+uB5J
         XUGfEScZUav8LJZ1pTKerN7AZAUBdSNadVlruNIiI4yB/dyiu6hTN9sBWYle8nfkeO/X
         iAJWPYmeg/XCedYHE5I+YdeTzPicUPxV+2IkwKbdNGPfhaNSKVWcg78DK0/Dz6ukUfde
         8kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T25PkEtCWX4TX68vpWe5rWPt6YtCi2v38LC41JQ63wM=;
        b=cCFUdfJg4yASQlIh4XG5/VMKAdhM/SoBZLKYjo8aBPAADZ2H8xVqHIqyGC1+LtlZO2
         zuRJwYTKAMp1uMFyWXRuRLzh9RCc5Me8rZiciUtC26VNMSBtNbJtDw6sgdb/2byVrs51
         Qt4/LtlS1rA2mn5xjlwwl14Fq6z0Qz9FhSlLiilwm55uulEMnYrM8AxXEJylFqVK5/HJ
         mS5BHZyWQ49oPNu09Hht/RZnWvCXuhbYVbOkVtrgqKtoqZZ2ayP9zaRQYZGckarkMOzf
         dmSFAP1Oe/e2Or3llj1AiZACeeisVAPI7OY5MEZlFMpbkJ539EeLc0nfNJXdkxVycTWY
         zweg==
X-Gm-Message-State: AODbwcAjQwU3EIc6J/LAwcaPcRrU5MGmT8MwHMQHQZdlCYRlhiWafMaF
        RN23Qv/1XM619EuBd9euTg==
X-Received: by 10.84.196.129 with SMTP id l1mr33423442pld.109.1496965281324;
        Thu, 08 Jun 2017 16:41:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 05/32] setup: don't perform lazy initialization of repository state
Date:   Thu,  8 Jun 2017 16:40:33 -0700
Message-Id: <20170608234100.188529-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

