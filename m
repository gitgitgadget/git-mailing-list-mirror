Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55A01F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeHNB1P (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:15 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:38592 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:15 -0400
Received: by mail-ua1-f73.google.com with SMTP id z17-v6so8493549uap.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+FaJFRj+Hq2HUpVIor7nTQNanPvlTmd1Zv069gqEqy8=;
        b=Weu+LJ+GlSwadTVw/fTCCCht9/xj6DAz74nxvbvBgtegCk+lEC6raIG/0uyICFZ7vL
         diaKDJwzpf87Rahv30AxS/qhSCEr6bSYNF0aGtsVQVvdtTiO7MLdox++LbPR4OTUfY14
         rZJR6JKIWpSFCkJ7rX1A7HoXeUQykqt0Ep2ez7mDgXhVemZHSU+fJ/XtYNuGTStxvxxj
         iGq5tQZjBNYg150eChn2iKN7y6ci0S4EsmF3k+w46+nTEF+8DPYVtYACi/E2V0/eiYsu
         joUztUX6qYnd9aA7CO2W28/770fIQR+PMn0cEkAn8KLWeJqRgt9yeVpVb4DYK9oR8MNv
         CFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+FaJFRj+Hq2HUpVIor7nTQNanPvlTmd1Zv069gqEqy8=;
        b=ELb+9vHSsky1mssoNgz5HABTJP/vH+fUjbKn9SZ6E1h24I6NxA/6j8/QpX1DHdiu/T
         zcVkbYv8SYqf81CxlIMvaE/00RN455cdTq5imdDnj/K9wFYOekZszU9+hd6hV2c7iNx5
         5NypFpFBye7JddBxLDlqxBbJACbg21YFyt8s+dsYccFDy1oQnRutMIOpMvwfx/O9LhkC
         6yTLE4Zb/Ctnh0qSizqAh0pyIzZk64+bTX8YWm4w2d6REQymArWhkAOAAZd8PZGS+Pj/
         KtkzX+GPSh5GxVg1J1h5UUC3LVSWwgUVYIq9jgSg7xi5xtUmwr/+GKi5WXIjO8j8tR+C
         lleg==
X-Gm-Message-State: AOUpUlHSFnW4bfXlDc9BX0JTJ8R/mNti6OqzztIBUiyGuOcG/KF3/QQ6
        L4OR13iI9zWCN/yWpClfHJYj+np4apoQ
X-Google-Smtp-Source: AA+uWPwQHpOkR/v8av9dxTEof/07cTT6Ntroy9DDEOBGtSO9S58AcJuzdOaWkha+00lKohZDj8bhRWhmL8tc
X-Received: by 2002:a1f:804c:: with SMTP id b73-v6mr11003718vkd.12.1534200178362;
 Mon, 13 Aug 2018 15:42:58 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:34 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 6/7] submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e98317508c0 (submodule: ensure core.worktree is set after update,
2018-06-18) was overly aggressive in calling connect_work_tree_and_git_dir
as that ensures both the 'core.worktree' configuration is set as well as
setting up correct gitlink file pointing at the git directory.

We do not need to check for the gitlink in this part of the cmd_update
in git-submodule.sh, as the initial call to update-clone will have ensured
that. So we can reduce the work to only (check and potentially) set the
'core.worktree' setting.

While at it move the check from shell to C as that proves to be useful in
a follow up patch, as we do not need the 'name' in shell now.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 64 +++++++++++++++++++++++--------------
 git-submodule.sh            |  7 ++--
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8b1088ab58a..648e1330c15 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1964,6 +1964,45 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+{
+	const struct submodule *sub;
+	const char *path;
+	char *cw;
+	struct repository subrepo;
+
+	if (argc != 2)
+		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
+
+	path = argv[1];
+
+	sub = submodule_from_path(the_repository, &null_oid, path);
+	if (!sub)
+		BUG("We could get the submodule handle before?");
+
+	if (repo_submodule_init(&subrepo, the_repository, path))
+		die(_("could not get a repository handle for submodule '%s'"), path);
+
+	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
+		char *cfg_file, *abs_path;
+		const char *rel_path;
+		struct strbuf sb = STRBUF_INIT;
+
+		cfg_file = repo_git_path(&subrepo, "config");
+
+		abs_path = absolute_pathdup(path);
+		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
+
+		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
+
+		free(cfg_file);
+		free(abs_path);
+		strbuf_release(&sb);
+	}
+
+	return 0;
+}
+
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -2029,29 +2068,6 @@ static int check_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	const char *name, *path;
-	char *sm_gitdir;
-
-	if (argc != 3)
-		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
-
-	name = argv[1];
-	path = argv[2];
-
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = absolute_pathdup(sb.buf);
-
-	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
-
-	strbuf_release(&sb);
-	free(sm_gitdir);
-
-	return 0;
-}
-
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2065,7 +2081,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
-	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
+	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 8caaf274e25..19d010eac06 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -535,6 +535,8 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
+		git submodule--helper ensure-core-worktree "$sm_path"
+
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
 		then
@@ -577,11 +579,6 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
-		then
-			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
-		fi
-
 		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
-- 
2.18.0.865.gffc8e1a3cd6-goog

