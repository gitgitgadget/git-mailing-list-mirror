Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01B01FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbdFVSoF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:05 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32999 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdFVSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:04 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so12566993pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Ywgy8XJZI4z1Q/VGaP03PD1xw3obDmQ6oWvDOOgc3s=;
        b=hlPLgqvHazp639vvL8VUGuvwhM5yLivRs1sJ1SnOmQTt+td+VEqKNvz4YYxf0tMlBx
         PzEs4eLIHBAPPLhz/NTNdAy05tkC76o3ixeqWgjWctkn307HHqMq5bVYIpS+4en3AsGP
         3fkYY5jPxJtOw7uDjjPhbvakGuJLFEh0bwCMeFqQHxT44I80rsDxh2dLU+pnyKcKmzP3
         PEMHZTf4zMR0Ajm+7o+CzYqw+pNEWcQ4tvv0pQJwF9nc5oLOhqqk9EPlRBKwiWIU8Pqv
         bbyObhbFCHV7Hem3EDjphqjedpbcU6miC42MnW97YTW/GF3jUr7j7+/nCWekJBiqsBHm
         D/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Ywgy8XJZI4z1Q/VGaP03PD1xw3obDmQ6oWvDOOgc3s=;
        b=mrI/j92583QK+YJb4eMo+YyiXS5N7vukNEVr/kbtxELWuKFeV3BMgQ5ZZEOKa8yAyn
         aa+LzENfxT+E0jGMiRe+dS/3fp+sabsXLwmDKf6EGOsOyMgUajZl0JWXZ1Ui7Wr0rpH7
         MIlZjgO9AY4Fp6jFZzIqauIWMLXQqCWNLAQ0e3gUr3LiwdiW1SuScshfPXHeIV8/ryec
         m/+wMf1zQkCxwZobPh9fLPqwNV8ewB9GoFS1XScKuDyWtKjfYZWzKgqETccjtYtQWdvI
         OQAiO9wv2Cz8LlkLFF2fQdi0cPEU+OcV+MOh4suQwijgxZ2c7JLFJlddaS4+YEsiyKi/
         VT9g==
X-Gm-Message-State: AKS2vOzq5ShndUoZ2RB1YCwwE3E4udjW1K8scdsGvL+TpEcgAmndwAyz
        vMSRRT7Qj8SrMPdFqsLRog==
X-Received: by 10.84.236.6 with SMTP id q6mr4617378plk.146.1498157042697;
        Thu, 22 Jun 2017 11:44:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 01/20] setup: don't perform lazy initialization of repository state
Date:   Thu, 22 Jun 2017 11:43:29 -0700
Message-Id: <20170622184348.56497-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
2.13.1.704.gde00cce3c-goog

