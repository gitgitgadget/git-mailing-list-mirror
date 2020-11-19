Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A5C64E69
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C68A22256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqOtTzke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgKSPw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgKSPw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363BC0613D4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so6893812wrf.12
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j0EWcNhXtYXBhpcUDgl/YsH4xrUwg2LxDGZ4CpK31tI=;
        b=SqOtTzkee1oHtd3f/KbkC86tPM3MofLp9HzJ9wlDcXa0sPau6uPZt03OlfLx3PNORX
         KjmjUXYVX6oz2PsUUn7fVQIsYyNoCbg4iqbnOJJOg3qcrWzCmwX/e8Xe/JX5eCdAq2Qz
         c01WWqjBXJXaB3+l6CniAa2cZCQWt/vdUCfJCQCQaHlFCVTKZXDioxDlDgY28dGDeC0S
         hrt9VC++ubPuh29Bc76aT2reEDqAhoBgyxp6YGyaRtuzACnbPakpISPuiGfIwv8Ejioc
         1n4JPqgcpTE4RCGRt+ESgMXxzberPy82O657lqxcs0q5EPF6zblJfyJtC3fAhZ+9wLn3
         2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j0EWcNhXtYXBhpcUDgl/YsH4xrUwg2LxDGZ4CpK31tI=;
        b=Mh5hFk6d70FWUcVWWkZbgnjWNdY118wHKXzRQjR2tjPunzzTcmFQPzjYcjletx4RAB
         3vxl2rgsQDGkd31u/arHqWjS36ydCUBbhglVNa6WzlMyPE7BZrkDq31vyzkq95fdd4t8
         +5MvEL+Q5cdU0h3Vh2s+8RRoq5KUh3P6I9JGUGYF/qMOB8WMWUYwAJ6MjtKhlFnRWdK+
         yAYgZH3Vq0NRNd3LyOCjnL8N0XJtRFmjgBAdi2GYY3p+v5Pl4Y1RiT9I2LloVL2py3JR
         m7WOPi7Yf/vdXvi7MPU22TIbsV7+96g1sdS8aDFgw8M6pnA5Nh3XhcR0mbBDIIIHRKgm
         UAsw==
X-Gm-Message-State: AOAM530rF4mJtQUJVUzw/iVnDqKDqSssAMBSb6sMB69jrbIrruoiNg56
        NunYQft5Tk3F8mNXW/KFLn8tY5O4pg8=
X-Google-Smtp-Source: ABdhPJybwD/D/Pt3DIj2vHP/mzNf9fjRP23keAv4HM4Is6lBY9a8JIQuB2yf35+qtW3dsbptVV83xQ==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr11105121wrr.343.1605801146517;
        Thu, 19 Nov 2020 07:52:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm229129wrp.21.2020.11.19.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:26 -0800 (PST)
Message-Id: <c9caed3854cfe694f105b19657cf57f73412ad4a.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:19 +0000
Subject: [PATCH 3/7] config: convert multi_replace to flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will extend the flexibility of the config API. Before doing so, let's
take an existing 'int multi_replace' parameter and replace it with a new
'int flags' parameter that can take multiple options as a bit field.

Update all callers that specified multi_replace to now specify the
CONFIG_FLAGS_MULTI_REPLACE flag. To add more clarity, extend the
documentation of git_config_set_multivar_in_file() including a clear
labeling of its arguments. Other config API methods in config.h do not
require a change to their prototypes, but they have an equivalent update
to their implementations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/branch.c |  4 ++--
 builtin/config.c |  6 ++++--
 builtin/remote.c |  8 +++++---
 config.c         | 24 ++++++++++++------------
 config.h         | 17 +++++++++++++----
 5 files changed, 36 insertions(+), 23 deletions(-)

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
index 2b79fe76ad..4841c68a91 100644
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
+					   int flags)
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
+				     const char *value_regex, int flags)
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
+				   const char *value_regex, int flags)
 {
 	return git_config_set_multivar_in_file_gently(NULL, key, value, value_regex,
-						      multi_replace);
+						      flags);
 }
 
 void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_regex, int multi_replace)
+			     const char *value_regex, int flags)
 {
 	git_config_set_multivar_in_file(NULL, key, value, value_regex,
-					multi_replace);
+					flags);
 }
 
 static int section_name_match (const char *buf, const char *name)
diff --git a/config.h b/config.h
index 060874488f..266eb22e46 100644
--- a/config.h
+++ b/config.h
@@ -70,6 +70,13 @@ enum config_event_t {
 	CONFIG_EVENT_ERROR
 };
 
+/*
+ * When CONFIG_FLAGS_MULTI_REPLACE is specified, all matching key/values
+ * are removed before a new pair is written. If the flag is not present,
+ * then set operations replace only the first match.
+ */
+#define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
+
 /*
  * The parser event function (if not NULL) is called with the event type and
  * the begin/end offsets of the parsed elements.
@@ -276,13 +283,15 @@ int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
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
+				     int flags);
 
 /**
  * rename or remove sections in the config file
-- 
gitgitgadget

