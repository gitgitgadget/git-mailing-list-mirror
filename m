Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CFC3B185
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32E921835
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRwMMYlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJAbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37746 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBJAbK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so5425809wru.4
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6lGSAu2hIRsMF6TsIrkM4TjHN1gtyu5I6B9upUlgho=;
        b=HRwMMYlwjfUspFzmbNmfQE9ik2QHgouXRVeFWWVCEfelZlPgU3FWCR7hsC3MpGl34q
         x2CnQKQlpkpT6SWGRgy3+1jIhbC0FQopicfL28KudePn0RzjcbVPDBuJNmMuyS42sesf
         DaJD2Kj6bxqpnf2T7/CCY0FsyKIVjZHbZmkm2WjcN1CDi+ihDdVSgzGimTcwsUm5FAmx
         u3GXJ1kDwHwfgZsmcTjBZy8BfpKuA+rnWBg0nfqLUg3qNcc5pO8ZK+SxVQxjiGJXmSz2
         tOz/Jt7V6tMZtnseWIzjbss49WIESWSitjOk3aCkfPTsM8HxibOFmPhgqAUdAC/wzNpa
         2Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u6lGSAu2hIRsMF6TsIrkM4TjHN1gtyu5I6B9upUlgho=;
        b=iL5gbFxUjNyYXhU5YQ6uxQFhRFi6d6wUjmgZ2rxF2EAR8fnu/lYbbT5u9Trq+mKDTO
         Pzhv7NG+xgzBWlhdQlHRW3+iHk5m8GSUnzjaLFXx+q6xgkDcntCebOe9TmpaM29mRSS6
         KSr8l+3oc4+TXJPz0XVbjmMC+5AcIGwZMF4ZAMJLgugQXmVU4zocQiVK9hzqhId//xea
         b5T0adey+aYt1r2FiMSyyePMki0BanUos9yV3h37fOONiB2PAkIYeOvPvJNWZccpWzmf
         0ABfCG0991BFJ7LVZuY9FjoOLPlcmL5LRdeOSb8y6CJL6H7j8b6PxgQaNlBWmBgi0F62
         yoNA==
X-Gm-Message-State: APjAAAWEWV/vhO2J7cWjPYLdAM+CLqhOV0s4v7CEl2GUSahaM3xSlB/G
        rJH/j2klgTqmepsPCvdqKnTLorCt
X-Google-Smtp-Source: APXvYqw6Ezk1jMaILre/2oX7s2M7KMzqz48xr+CYcN1RsFk4BnC4RL7RYGb+IZLdm16HbcbxhX775Q==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr13020599wrp.63.1581294667813;
        Sun, 09 Feb 2020 16:31:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm14235689wrt.84.2020.02.09.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:07 -0800 (PST)
Message-Id: <6c59c5cace7e1f8fc16737c2c9dcf2016397caa1.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:57 +0000
Subject: [PATCH v7 08/10] config: teach git_config_source to remember its
 scope
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

There are many situations where the scope of a config command is known
beforehand, such as passing of '--local', '--file', etc. to an
invocation of git config.  However, this information is lost when moving
from builtin/config.c to /config.c.  This historically hasn't been a big
deal, but to prepare for the upcoming --show-scope option we teach
git_config_source to keep track of the source and the config machinery
to use that information to set current_parsing_scope appropriately.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 builtin/config.c | 16 +++++++++++++---
 config.c         |  3 +++
 config.h         | 20 ++++++++++----------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 52a904cfb1..0a9778b714 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -622,6 +622,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			!strcmp(given_config_source.file, "-")) {
 		given_config_source.file = NULL;
 		given_config_source.use_stdin = 1;
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
 	if (use_global_config) {
@@ -637,6 +638,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 */
 			die(_("$HOME not set"));
 
+		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
+
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
 			given_config_source.file = xdg_config;
@@ -646,11 +649,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			free(xdg_config);
 		}
 	}
-	else if (use_system_config)
+	else if (use_system_config) {
 		given_config_source.file = git_etc_gitconfig();
-	else if (use_local_config)
+		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
+	} else if (use_local_config) {
 		given_config_source.file = git_pathdup("config");
-	else if (use_worktree_config) {
+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
+	} else if (use_worktree_config) {
 		struct worktree **worktrees = get_worktrees(0);
 		if (repository_format_worktree_config)
 			given_config_source.file = git_pathdup("config.worktree");
@@ -662,13 +667,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			      "section in \"git help worktree\" for details"));
 		else
 			given_config_source.file = git_pathdup("config");
+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
 		free_worktrees(worktrees);
 	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				prefix_filename(prefix, given_config_source.file);
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
+	} else if (given_config_source.blob) {
+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
+
 	if (respect_includes_opt == -1)
 		config_options.respect_includes = !given_config_source.file;
 	else
diff --git a/config.c b/config.c
index 0e2c693e78..9b6afca210 100644
--- a/config.c
+++ b/config.c
@@ -1763,6 +1763,9 @@ int config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
+	if (config_source)
+		current_parsing_scope = config_source->scope;
+
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
diff --git a/config.h b/config.h
index b570f4ce43..165cacb7da 100644
--- a/config.h
+++ b/config.h
@@ -35,11 +35,21 @@ struct object_id;
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
+enum config_scope {
+	CONFIG_SCOPE_UNKNOWN = 0,
+	CONFIG_SCOPE_SYSTEM,
+	CONFIG_SCOPE_GLOBAL,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
+	CONFIG_SCOPE_COMMAND,
+};
+const char *config_scope_name(enum config_scope scope);
 
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
 	const char *blob;
+	enum config_scope scope;
 };
 
 enum config_origin_type {
@@ -295,16 +305,6 @@ int config_error_nonbool(const char *);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-enum config_scope {
-	CONFIG_SCOPE_UNKNOWN = 0,
-	CONFIG_SCOPE_SYSTEM,
-	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_LOCAL,
-	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_COMMAND,
-};
-const char *config_scope_name(enum config_scope scope);
-
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
-- 
gitgitgadget

