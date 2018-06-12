Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297371F403
	for <e@80x24.org>; Tue, 12 Jun 2018 23:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934859AbeFLX6k (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 19:58:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45613 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbeFLX6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 19:58:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id c23-v6so393394plz.12
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C+Ha03gKt7TNMs4+FYxzWiv6eCVOIfMABN96KspXTKk=;
        b=vw0+HnyH6nSvMyqRFr4OkwXPe8I3lQuVEWGCd0Vbj3jNPy5bqtxgQQj391Q+p9aiwI
         YodXG/o7FbAWRErlk3gUM4Ls/uxZxMphzWEKhIW3vc9++lGqHg7GBeeIQZNLKLtYbEtl
         vaOxql3vYfttXm31WxoWxbN4L4vJYa+JjB/r1qRarjw8HPDu6wcHpenXIfC0wXNA62L+
         4xy8EDoAKoBBxUYy3Orhs1uSDBUHrAtR27OvB7FD6dpqvFvOHvbbFvIZzCqWJGTC1Qr5
         kt3gzF3rJfpUd71jDNtNVD+fIsvzvhNCUjHBmpsQ+V+tdZ4/L1lpDH+x9JSb/CT2aUaH
         kUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C+Ha03gKt7TNMs4+FYxzWiv6eCVOIfMABN96KspXTKk=;
        b=bPiBmWchL7sYddpreNNI84GMhVwkOgXYQcfax75aWJss/BJdbAfRP6znFGfUqCM/+/
         KdGumkNWpq/uHOCx6T3x7c9LYS4pMOc7889K0iThDU25qfGDGLNWTw4HEZaIB+a0U+8t
         8Fjxe3T6/HxyvtwU5jBWiB9WF7+aui75hxnncEgBdYvkBXXYMC2XGKy0TJwwgcGmk80r
         b12aqFbAGDeCg2TqSKM14/OvIpHpINP+/M2KL37pO/lzN+AiAuZ1tDMxRtetGRiZTkNl
         2+eFcPpTyLh3sU1gX03dSTftLB5GjOARzbZQi6a2U4mSd7ExNEsS/u+OXqilVhiqSLKn
         TBGg==
X-Gm-Message-State: APt69E2VPzEWdm7YY/iYCVtFTWxsMBBiGaMs1NA7PInb3kI1H2SeLoIG
        a/knx+uPIz4kD/Yez7LXcrbq9d8/giQ=
X-Google-Smtp-Source: ADUXVKIp5Y4MQdApNehQ7F/q0cYEIRzoPryBis+dhILNZXk7DlTInJA55IyfrkszrO40vu1uQOJCpg==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr2539978plr.264.1528847917653;
        Tue, 12 Jun 2018 16:58:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r188-v6sm1309615pgr.78.2018.06.12.16.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:58:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule: ensure core.worktree is set after update
Date:   Tue, 12 Jun 2018 16:58:24 -0700
Message-Id: <20180612235825.12271-3-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180612235825.12271-1-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 24 ++++++++++++++++++++++++
 git-submodule.sh            |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bd250ca2164..dffc55ed8ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1860,6 +1860,29 @@ static int check_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *name, *path;
+	char *sm_gitdir;
+
+	if (argc != 3)
+		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
+
+	name = argv[1];
+	path = argv[2];
+
+	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	sm_gitdir = absolute_pathdup(sb.buf);
+
+	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
+
+	strbuf_release(&sb);
+	free(sm_gitdir);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1873,6 +1896,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
+	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 78073cd87d1..6596a77c5ef 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -615,6 +615,11 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
+		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
+		then
+			git submodule--helper connect-gitdir-workingtree $name $sm_path
+		fi
+
 		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
-- 
2.18.0.rc1.244.gcf134e6275-goog

