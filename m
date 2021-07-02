Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87576C11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6790961410
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhGBKHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhGBKHt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7BC0613DC
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l26so8100186oic.7
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WJBm4AAzHwFBD2kds6dj3B0NkdDQuBVqpAR8YvPnU0=;
        b=CI+QC63diEFNNi3jPj05WTb8m2QqV3btHkNpora1DBYnX+MdKEcFU5PaStIem1MNay
         VhujeR/xPf0qCPtm/UHBHRflGbmQAZeprsr7cjQhTr9QurzVjPmJZv/n5y9VAbIpB87u
         psHrc6Y3fnJuMf16tjjI2hKcfqD5epIkGKA+yPbeiziHP63Gwvf17FAXllJR+DmVQTIX
         9UySP9VTw2DHyz7T9gBbLUuA7zo8bTSPpqb9VGkedVdhI8kU6WsSDBOIoD0m7j5Bk/lV
         p4K2My/mVVmdgTKdSsJRqdZkJMtg2Dnz1PEhloNuZRHUQ1BS+F7QgXH9oTlUZyDUajrQ
         tEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WJBm4AAzHwFBD2kds6dj3B0NkdDQuBVqpAR8YvPnU0=;
        b=rtM2hhsaezlsoiOLBfYAJCifznZjhdOyVw4EYf8MqjgJfuWeCFAor4YWDVWy3TCw1q
         g2iS+zD03iZ7u8KnzFSiFQiBsokSXwt9XRwghRcRoB/iMh0t+XAt4Ex21CXGyacURXtJ
         20+B2xyttc/cWRzKMoiAjqQPwNH3fueKINv2DEhkCQiFcYTrF37YpJ7o7OmIZzA1xu1k
         z/fPXUjSq4cft3OupyxH3SHLKKK/Bae2CNOlzCLG5o26K2TIYY7u/k6j6qpROwW4S90Y
         QKaJoXeM+PY/sKpaelJsP6sAt2tprEQUoJhAzeufpKD1/6K0uBqQ8yzw1UWRa2ehRbKt
         EClg==
X-Gm-Message-State: AOAM533KiSaSFEvetgKwHq/N25HwH/p4pAoVNAHf3fFFvp5Hnv0lg1oo
        mMEMz6nhcSb9DebfGMclYV6876N5xFXGew==
X-Google-Smtp-Source: ABdhPJxV5n4tqw2H/7nKJ0cJ6cjJ+w2765I91rgZA0FzGGKN/CBko59nXi0421W4Pj79rP2fyuihgw==
X-Received: by 2002:aca:cf15:: with SMTP id f21mr3206449oig.131.1625220316802;
        Fri, 02 Jul 2021 03:05:16 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t15sm384656oiw.16.2021.07.02.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] config: add default aliases
Date:   Fri,  2 Jul 2021 05:05:06 -0500
Message-Id: <20210702100506.1422429-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
In-Reply-To: <20210702100506.1422429-1-felipe.contreras@gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are all the aliases everyone agrees are essential.

Virtually all VCS in the world have aliases, except git, so let's change
that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt      |  4 ++++
 Documentation/git-cherry-pick.txt |  4 ++++
 Documentation/git-commit.txt      |  4 ++++
 Documentation/git-mergetool.txt   |  4 ++++
 Documentation/git-rebase.txt      |  4 ++++
 Documentation/git-status.txt      |  4 ++++
 config.c                          | 29 +++++++++++++++++++++++++++++
 config.h                          |  3 ++-
 t/test-lib.sh                     |  2 ++
 9 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..fbf5ebd27a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -24,6 +24,10 @@ SYNOPSIS
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
 
+ALIAS
+~~~~~
+'git br'
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d750314b2..b43b1a3a30 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 		  [-S[<keyid>]] <commit>...
 'git cherry-pick' (--continue | --skip | --abort | --quit)
 
+ALIAS
+~~~~~
+'git pi'
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 340c5fbb48..32b1fdba45 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -17,6 +17,10 @@ SYNOPSIS
 	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
 	   [--] [<pathspec>...]
 
+ALIAS
+~~~~~
+'git co'
+
 DESCRIPTION
 -----------
 Create a new commit containing the current contents of the index and
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e587c7763a..59708a1f3e 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
 
+ALIAS
+~~~~~
+'git mt'
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e..21f5ae9d0e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	--root [<branch>]
 'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
 
+ALIAS
+~~~~~
+'git rb'
+
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 83f38e3198..fcc89fa8d4 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git status' [<options>...] [--] [<pathspec>...]
 
+ALIAS
+~~~~~
+'git st'
+
 DESCRIPTION
 -----------
 Displays paths that have differences between the index file and the
diff --git a/config.c b/config.c
index 666fb2c689..c42f41599c 100644
--- a/config.c
+++ b/config.c
@@ -501,6 +501,30 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
 
+static int git_config_default(config_fn_t fn, void *data)
+{
+	int ret = 0;
+	struct config_source source;
+
+	if (getenv("GIT_NO_DEFAULT_ALIASES"))
+		return 0;
+
+	memset(&source, 0, sizeof(source));
+	source.prev = cf;
+	source.origin_type = CONFIG_ORIGIN_DEFAULT;
+	cf = &source;
+
+	ret += fn("alias.co", "commit", data);
+	ret += fn("alias.rb", "rebase", data);
+	ret += fn("alias.st", "status", data);
+	ret += fn("alias.br", "branch", data);
+	ret += fn("alias.pi", "cherry-pick", data);
+	ret += fn("alias.mt", "mergetool", data);
+
+	cf = source.prev;
+	return ret;
+}
+
 static int config_parse_pair(const char *key, const char *value,
 			  config_fn_t fn, void *data)
 {
@@ -1897,6 +1921,9 @@ static int do_git_config_sequence(const struct config_options *opts,
 		repo_config = NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
+
+	git_config_default(fn, data);
+
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
@@ -3497,6 +3524,8 @@ const char *current_config_origin_type(void)
 		return "submodule-blob";
 	case CONFIG_ORIGIN_CMDLINE:
 		return "command line";
+	case CONFIG_ORIGIN_DEFAULT:
+		return "default";
 	default:
 		BUG("unknown config origin type");
 	}
diff --git a/config.h b/config.h
index 9038538ffd..bc3ecca313 100644
--- a/config.h
+++ b/config.h
@@ -58,7 +58,8 @@ enum config_origin_type {
 	CONFIG_ORIGIN_FILE,
 	CONFIG_ORIGIN_STDIN,
 	CONFIG_ORIGIN_SUBMODULE_BLOB,
-	CONFIG_ORIGIN_CMDLINE
+	CONFIG_ORIGIN_CMDLINE,
+	CONFIG_ORIGIN_DEFAULT
 };
 
 enum config_event_t {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 49b80a4eb5..a15965e2f4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -456,6 +456,8 @@ GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
 GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
 export GIT_TEST_MERGE_ALGORITHM
+GIT_NO_DEFAULT_ALIASES=1
+export GIT_NO_DEFAULT_ALIASES
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
-- 
2.32.0.94.g4574ca548c

