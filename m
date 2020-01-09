Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA08C33CA2
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD052072E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiJAsL0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgAIKQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:16:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52630 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAIKQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:16:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2253979wmc.2
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8oBhDWlWyOzHbbpQeAdkFN0i+3jb3DNMT4uyPUWAjZk=;
        b=JiJAsL0z++GOBhzWffnRWna0JXNFy4ynX0c9CqWa3j2yQsCBjt9UdL//BJcyRMLHzo
         mWkHQBjefd9xp+BR9mxpyp6hV7IK3/hLOKy9+g0i9ljiBQ5gSw/fv8/yJpG+bMC5HkhZ
         ZCaT+dh1tQ/nbjpoJspDVv88tDUUiQ7MEjX8dTFNzaGQ6FtJmvy2Bv3JcRUGAmiOX14I
         2C3AyI5YS49wnnNB2reDWt6Yed1r1zX9IkePBLF7b4FA2hRTnc7+F0t+fGsCinu2hzXJ
         xHptG5JgCY1RVzI7C5jMhC/BvpxBQ0+55kl4IPMCegMAC+7a1mgxMO/g2RdJ3RhAosVo
         bBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8oBhDWlWyOzHbbpQeAdkFN0i+3jb3DNMT4uyPUWAjZk=;
        b=YEoJVCqN/Hs9ru/pqCSRFCPfOQuYTIfpw3O6YjvU3Wq/ZgfAuvy5edjn7u0KoUjwob
         3S4oFTePHnm41qZQD/6oLgwYgL2kTi0pPjr0dim4Kd7r0NIBENrpuiEIJ1AWtkuExCcd
         oRg0655Iq/pDBLRXmmmPAM8fQ25Of86w8rd4O4L+h0rMvTnHUsuNgivI8QC6TvTfnvh3
         Gj6PaHSbuG8cJXowFhea12ffHtBjwWEQLRBsFoC04AvGr01RoWVaKzEfoGaXl8HLgI/t
         ukBtsRB7k8pEb9YIp8jWOrVUxXUl4bDYCwLJFjfI1JUUMXXfcMrrfX7jdQ6HA/NueExr
         jRCQ==
X-Gm-Message-State: APjAAAUkOKq33tOMaVeRYF8z0gW050pGqYeoiU7Nd3jexUg3FjK598rF
        SVMXQl5VEAsQsTuOEpOhReEnJhBC
X-Google-Smtp-Source: APXvYqy0hsNLss6ef917DFdllcpQfiJt1raQuv+WoLSHdcf/xzDvSyG/yGD8vefojp0mYsu9WvthZA==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr3792716wml.103.1578565005091;
        Thu, 09 Jan 2020 02:16:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm2237028wmc.47.2020.01.09.02.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:16:44 -0800 (PST)
Message-Id: <e8e05f39407365a1bf5008820267d362e0cbffd6.1578565001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 10:16:39 +0000
Subject: [PATCH v2 2/4] config: fix config scope enum
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
two cases.

Additionally we rename what was CONFIG_SCOPE_REPO to CONFIG_SCOPE_LOCAL
to reflect its new, more specific meaning.

The clients of 'current_config_scope()' who cared about
CONFIG_SCOPE_REPO are also modified to similarly care about
CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 7 ++-----
 config.h               | 3 ++-
 remote.c               | 3 ++-
 t/helper/test-config.c | 4 +++-
 upload-pack.c          | 3 ++-
 5 files changed, 11 insertions(+), 9 deletions(-)

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

