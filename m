Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FCC2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666572073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL1CLFON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgAYAjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32815 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbgAYAjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so4546990wmc.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6NRzuQmbNQuX3qumUbsbslbMePVYQw4AO29iqnS59bU=;
        b=qL1CLFONAy2aPJWN/k6EwUOrmjdKuryRkXAK/CYrPa3YuDfd6jfuniq4/FTUAaAT6R
         V/ccVPBVCmuKU7LiWALhWo31XkC8Jz8Yyxo4/uqJLeCifCgZqSxs9JBR8JMdHRx/JfYw
         15cg+42xAPzn2y6vzz6aU06aDNdUT4Q/5rKv+ncXToZV1PCjUjycKbGRf3g3M9ejIz2v
         PS/JeR1MlTAuKFm5ZxKxztsk6hqmaVcSMtEhHyL2ZrbHa6CfYZsyC+V8pK4nH27za8/G
         3WqAAK5olnWh35O+87xmKhnVlfxDh4LKqIckqQQLlRSSNpM33FUNiS3rw163oZm92g6p
         fUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6NRzuQmbNQuX3qumUbsbslbMePVYQw4AO29iqnS59bU=;
        b=B07mhY9wuQQ+mepOEvwH5PxpejCIYEkaJuJG0pxqFYdX0NuwKTopYWwRiBBMPp51ZQ
         7j9ZqKRBbJY5v1G55586BlOf0TDkCJIq6zDnorXCBMlra9T1yT69fnDogqNDV8tPQsmI
         jY2j0jlauj1fJ7TZIb0jgabehtXz/GhXzKSu3Mk8YBuu2hB17dLn99fJRYDA+AzAabwP
         GbGLIfEgfW4wHVKVxJc8apjpN2YqDu7QyWspA7ANU4uAjUKVDaMy/2935pCEhdlGQxZf
         UzDgTjx4xoXfCEfNHAgOVQF+kLD99dnrvDtgRrO1UIIk1iZl4OjfYYxhUlBaVV8/wzyp
         Mf4A==
X-Gm-Message-State: APjAAAWbVQI9B+IzarnNL3HFXk7aF6wSU+hVJzHv++i32FovrkqhiWgv
        5WdwPGrPkJX5kT/gncdLDvQjlFVG
X-Google-Smtp-Source: APXvYqzjGmadqTt+JLJB/6pLjik7u62mzHNh41++R/NfEpM3dmtcV3iXHSgJ12/lBmiH5LoOKUgNTg==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr1612958wme.82.1579912769343;
        Fri, 24 Jan 2020 16:39:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm8428667wmm.15.2020.01.24.16.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 16:39:28 -0800 (PST)
Message-Id: <9f160e281a984ea7578f8fbe244adc77c6585e44.1579912764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Jan 2020 00:39:22 +0000
Subject: [PATCH v5 4/6] config: split repo scope to local and worktree
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

Previously when iterating through git config variables, worktree config
and local config were both considered "CONFIG_SCOPE_REPO".  This was
never a problem before as no one had needed to differentiate between the
two cases, but future functionality may care whether or not the config
options come from a worktree or from the repository's actual local
config file.  For example, the planned feature to add a '--show-scope'
to config to allow a user to see which scope listed config options come
from would confuse users if it just printed 'repo' rather than 'local'
or 'worktree' as the documentation would lead them to expect.  As well
as the additional benefit of making the implementation look more like
how the documentation describes the interface.

To accomplish this we split out what was previously considered repo
scope to be local and worktree.

The clients of 'current_config_scope()' who cared about
CONFIG_SCOPE_REPO are also modified to similarly care about
CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 7 ++-----
 config.h               | 3 ++-
 remote.c               | 3 ++-
 t/helper/test-config.c | 4 +++-
 t/t1308-config-set.sh  | 2 +-
 upload-pack.c          | 3 ++-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index d75f88ca0c..447a013a15 100644
--- a/config.c
+++ b/config.c
@@ -1724,15 +1724,12 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
 
-	current_parsing_scope = CONFIG_SCOPE_REPO;
+	current_parsing_scope = CONFIG_SCOPE_LOCAL;
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
-	/*
-	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
-	 * But let's not complicate things before it's actually needed.
-	 */
+	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
diff --git a/config.h b/config.h
index 91fd4c5e96..284d92fb0e 100644
--- a/config.h
+++ b/config.h
@@ -298,7 +298,8 @@ enum config_scope {
 	CONFIG_SCOPE_UNKNOWN = 0,
 	CONFIG_SCOPE_SYSTEM,
 	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_REPO,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_CMDLINE,
 };
 
diff --git a/remote.c b/remote.c
index 5c4666b53a..593ce297ed 100644
--- a/remote.c
+++ b/remote.c
@@ -369,7 +369,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
-	if (current_config_scope() == CONFIG_SCOPE_REPO)
+	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
+	current_config_scope() == CONFIG_SCOPE_WORKTREE)
 		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 214003d5b2..6695e463eb 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
 		return "system";
 	case CONFIG_SCOPE_GLOBAL:
 		return "global";
-	case CONFIG_SCOPE_REPO:
+	case CONFIG_SCOPE_LOCAL:
 		return "repo";
+	case CONFIG_SCOPE_WORKTREE:
+		return "worktree";
 	case CONFIG_SCOPE_CMDLINE:
 		return "cmdline";
 	default:
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7b4e1a63eb..90196e2862 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-repo
 	origin=file
 	name=.git/config
-	scope=repo
+	scope=local
 
 	key=foo.bar
 	value=from-cmdline
diff --git a/upload-pack.c b/upload-pack.c
index a00d7ece6b..c53249cac1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1073,7 +1073,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		precomposed_unicode = git_config_bool(var, value);
 	}
 
-	if (current_config_scope() != CONFIG_SCOPE_REPO) {
+	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
+	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
 	}
-- 
gitgitgadget

