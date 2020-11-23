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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227DFC63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90652076E
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAI0Ynrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbgKWQFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKWQFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC827C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so19091723wrb.9
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bdKDxDb9RzI+vgaBN2FGE+rXi/8HQWGBhbOztKwyx2k=;
        b=nAI0YnrcSDdzUdLLHOSWKMW7B7QJrrsCNZbvN4e8EZpY84MAQLzsFZznpqj4TsaSEn
         g6DlYlMntJNx1vAhwPnYY06Z2WPRUDreoccGiFUc5Q1whx8AtBKNzzd6T+IFwdb6Thgz
         DB1dUbvPn0BZN+I90a1sleZ0zlxeXKAk9QqX4GH6g781EJHY7sc+6iqoVxTs9hWMOxst
         rFup7aAi0BllzDFOEn1fOWPpazP0TfnAQKNnsTLYB4hdlCq2xQaTVTD6FQITdNjUPzhL
         hBfXPYQjw9FsBofbarDGclbDZlBUCVxja+THvU3Alo2YNbNH8ltvrYhy5m5r7ChCRnB7
         10Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bdKDxDb9RzI+vgaBN2FGE+rXi/8HQWGBhbOztKwyx2k=;
        b=PuKIYLcXvwluMNZrmLYcmItXSbaqi+K2bAjUJ6c3z1/kyhtg9hUfWHxeD8YhZ+jaOq
         yiys9hSMKY9wvG89rCh6O9j/74oxFi6G2qT8ZnlOlxcrlLL3p9iP1GxOmY5oEq9Lme/r
         mT7igTxKpTCPxc5+bj5PlD1/E+KFXE3ViPkVwPpZTzkKBuJX5rFywm0Azlx+0+0L4lOr
         2fPybmsvP9lwhU5UTnaCCOLRbOjp1nzgYjwAe5sJEVPRipKIvii0yFRXIw3osSWdxQQW
         f+bZq20o+fRsNJbYbLhHd8Hg18RoT2X/0sQVe8ygWBE2QFr+/fc0RAy2GM5k8MlYU8p7
         +KFw==
X-Gm-Message-State: AOAM5331+w5QeUgoR1lXzwxjDcCkR7LaAk/49ECFYSQ7n9BQI2OwNpRl
        gQhkZohWaVGsaduCerDMyCa6muXV35Y=
X-Google-Smtp-Source: ABdhPJwv52ocjCvP0ZgRPQQJaPZFnqFeYsbJbqtCRkGCndfdPFEmo2LAoesH1CLbIktXClpyVFDsag==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr309881wrt.385.1606147513111;
        Mon, 23 Nov 2020 08:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm8968473wmf.15.2020.11.23.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:12 -0800 (PST)
Message-Id: <0c152faa00881483db0a59f4c5bc7204ebed8966.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:03 +0000
Subject: [PATCH v2 3/7] config: convert multi_replace to flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will extend the flexibility of the config API. Before doing so, let's
take an existing 'int multi_replace' parameter and replace it with a new
'unsigned flags' parameter that can take multiple options as a bit field.

Update all callers that specified multi_replace to now specify the
CONFIG_FLAGS_MULTI_REPLACE flag. To add more clarity, extend the
documentation of git_config_set_multivar_in_file() including a clear
labeling of its arguments. Other config API methods in config.h require
only a change of the final parameter from 'int' to 'unsigned'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/branch.c |  4 ++--
 builtin/config.c |  6 ++++--
 builtin/remote.c |  8 +++++---
 config.c         | 24 ++++++++++++------------
 config.h         | 29 ++++++++++++++++++++++-------
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e82301fb1b..5ce3844d22 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -829,10 +829,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		if (filter.kind != FILTER_REFS_BRANCHES)
diff --git a/builtin/config.c b/builtin/config.c
index 5e39f61885..e7c7f3d455 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -823,7 +823,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2], 1);
+							      argv[0], value, argv[2],
+							      CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -859,7 +860,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, argv[1], 1);
+							      argv[0], NULL, argv[1],
+							      CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/builtin/remote.c b/builtin/remote.c
index c8240e9fcd..29b1652975 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -708,7 +708,7 @@ static int mv(int argc, const char **argv)
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
-	git_config_set_multivar(buf.buf, NULL, NULL, 1);
+	git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 	for (i = 0; i < oldremote->fetch.raw_nr; i++) {
 		char *ptr;
@@ -1485,7 +1485,8 @@ static int update(int argc, const char **argv)
 
 static int remove_all_fetch_refspecs(const char *key)
 {
-	return git_config_set_multivar_gently(key, NULL, NULL, 1);
+	return git_config_set_multivar_gently(key, NULL, NULL,
+					      CONFIG_FLAGS_MULTI_REPLACE);
 }
 
 static void add_branches(struct remote *remote, const char **branches,
@@ -1674,7 +1675,8 @@ static int set_url(int argc, const char **argv)
 	if (!delete_mode)
 		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
 	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+		git_config_set_multivar(name_buf.buf, NULL, oldurl,
+					CONFIG_FLAGS_MULTI_REPLACE);
 out:
 	strbuf_release(&name_buf);
 	return 0;
diff --git a/config.c b/config.c
index 2b79fe76ad..096f2eae0d 100644
--- a/config.c
+++ b/config.c
@@ -2716,9 +2716,9 @@ void git_config_set(const char *key, const char *value)
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
  * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
  *     (only add a new one)
- * if multi_replace==0, nothing, or only one matching key/value is replaced,
- *     else all matching key/values (regardless how many) are removed,
- *     before the new pair is written.
+ * if (flags & CONFIG_FLAGS_MULTI_REPLACE) == 0, at most one matching
+ *     key/value is replaced, else all matching key/values (regardless
+ *     how many) are removed, before the new pair is written.
  *
  * Returns 0 on success.
  *
@@ -2739,7 +2739,7 @@ void git_config_set(const char *key, const char *value)
 int git_config_set_multivar_in_file_gently(const char *config_filename,
 					   const char *key, const char *value,
 					   const char *value_regex,
-					   int multi_replace)
+					   unsigned flags)
 {
 	int fd = -1, in_fd = -1;
 	int ret;
@@ -2756,7 +2756,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	if (ret)
 		goto out_free;
 
-	store.multi_replace = multi_replace;
+	store.multi_replace = (flags & CONFIG_FLAGS_MULTI_REPLACE) != 0;
 
 	if (!config_filename)
 		config_filename = filename_buf = git_pathdup("config");
@@ -2845,7 +2845,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen_nr == 0 && value == NULL) ||
-		    (store.seen_nr > 1 && multi_replace == 0)) {
+		    (store.seen_nr > 1 && !store.multi_replace)) {
 			ret = CONFIG_NOTHING_SET;
 			goto out_free;
 		}
@@ -2984,10 +2984,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *key, const char *value,
-				     const char *value_regex, int multi_replace)
+				     const char *value_regex, unsigned flags)
 {
 	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
-						    value_regex, multi_replace))
+						    value_regex, flags))
 		return;
 	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
@@ -2996,17 +2996,17 @@ void git_config_set_multivar_in_file(const char *config_filename,
 }
 
 int git_config_set_multivar_gently(const char *key, const char *value,
-				   const char *value_regex, int multi_replace)
+				   const char *value_regex, unsigned flags)
 {
 	return git_config_set_multivar_in_file_gently(NULL, key, value, value_regex,
-						      multi_replace);
+						      flags);
 }
 
 void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_regex, int multi_replace)
+			     const char *value_regex, unsigned flags)
 {
 	git_config_set_multivar_in_file(NULL, key, value, value_regex,
-					multi_replace);
+					flags);
 }
 
 static int section_name_match (const char *buf, const char *name)
diff --git a/config.h b/config.h
index 060874488f..80844604ab 100644
--- a/config.h
+++ b/config.h
@@ -256,9 +256,22 @@ void git_config_set(const char *, const char *);
 
 int git_config_parse_key(const char *, char **, size_t *);
 int git_config_key_is_valid(const char *key);
-int git_config_set_multivar_gently(const char *, const char *, const char *, int);
-void git_config_set_multivar(const char *, const char *, const char *, int);
-int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
+
+/*
+ * The following macros specify flag bits that alter the behavior
+ * of the git_config_set_multivar*() methods.
+ */
+
+/*
+ * When CONFIG_FLAGS_MULTI_REPLACE is specified, all matching key/values
+ * are removed before a new pair is written. If the flag is not present,
+ * then set operations replace only the first match.
+ */
+#define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
+
+int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
+void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
  * takes four parameters:
@@ -276,13 +289,15 @@ int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
  * - the value regex, as a string. It will disregard key/value pairs where value
  *   does not match.
  *
- * - a multi_replace value, as an int. If value is equal to zero, nothing or only
- *   one matching key/value is replaced, else all matching key/values (regardless
- *   how many) are removed, before the new pair is written.
+ * - a flags value with bits corresponding to the CONFIG_FLAG_* macros.
  *
  * It returns 0 on success.
  */
-void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+void git_config_set_multivar_in_file(const char *config_filename,
+				     const char *key,
+				     const char *value,
+				     const char *value_regex,
+				     unsigned flags);
 
 /**
  * rename or remove sections in the config file
-- 
gitgitgadget

