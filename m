Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9E11F403
	for <e@80x24.org>; Tue, 19 Jun 2018 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937067AbeFSAGY (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 20:06:24 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:45235 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937064AbeFSAGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 20:06:22 -0400
Received: by mail-ua0-f201.google.com with SMTP id n7-v6so6262160uak.12
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jRVYaAlmU228j7YAmO1g3mUko69Wa1UM70ogkNhywTQ=;
        b=YnGXSV5KjlALGuR6kT48ykcBkQ9uuWrVpeFdKgx8UZpbPG/ZZjPvhwKvrxuy6WHlsO
         k2vX9Bnc504vzwhZwTNLEgyC0ZUaPLRGKt73ArfvIstm36fzx07SQO+t8d9KqnwwDTvS
         y3Rfb2Lsi5LeXEeeUNhvtBzSiVOlcMwLQjqPORMB68kLcxBUW+4vbedyuwyC0lC7x/No
         UszuyzLsziOiEqRgPwv+iC0jF9LKKVHFKMwcfeMq3R9gIpCt3WskpteQlTqpMBk/jSbV
         hL1NZjoRGLpMW3oZmf3SAWN34ELo5eLRMSW4vOkwfeX5vXAZZcTtTwUMnEfmeZcn57Zz
         DlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jRVYaAlmU228j7YAmO1g3mUko69Wa1UM70ogkNhywTQ=;
        b=f30fWZYeSuJjwjtQxDtXZL0YfeJb0KYMNG+7tmcm5UUQha0xmZ9ee6usxRIBjzwddc
         QdodVHvS1OBK6LTWC/ohmGTTsq7zwQA/6ZTySfoACkx8c/KgfpaEOKF57VB6OfsUcP6K
         DdydDeTuUViZPlzGKDehNXl9M62VFuvlllEScbf547Oro0lrsAyFqvRiNxa62h63uHOZ
         UClITedGunTT6JJlv04rFC9qGElAYqsGx5y669KNAdr2KpREwXK51xbQoV8LUb9si05N
         Tc6dgTnxEr68Hle7vcO7Akj8rLgkg3zpA1fZzWInUbLXoaTjCNgd4ZYWXtKnTxdibk1r
         9FTg==
X-Gm-Message-State: APt69E1hlTimHr2GrC2tbviiDLdtFNuoeoo0qJejtH3n/yg8tG+Npyum
        aKgs8XunOCJ1HtEUXJUQMtWK6G/JMjTV
X-Google-Smtp-Source: ADUXVKKx2Qa+jFDq41TFoVbxnu75IohHbAohUIKfpdFc9jD18LwX9Cc6LkOMGJbuMGhMMkPy06MXdvmrDwMe
MIME-Version: 1.0
X-Received: by 2002:a1f:aa4b:: with SMTP id t72-v6mr6436245vke.106.1529366781711;
 Mon, 18 Jun 2018 17:06:21 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:06:07 -0700
In-Reply-To: <20180619000608.147422-1-sbeller@google.com>
Message-Id: <20180619000608.147422-3-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com> <20180619000608.147422-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 2/3] submodule: ensure core.worktree is set after update
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
index 78073cd87d1..6bd0db02b33 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -615,6 +615,11 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
+		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
+		then
+			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
+		fi
+
 		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
-- 
2.18.0.rc1.244.gcf134e6275-goog

