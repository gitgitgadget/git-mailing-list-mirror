Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C37E209B3
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbcLLTEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:52 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35722 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbcLLTEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:48 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so38159819pga.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I//XHx886JxyAQjDlc3RzYQHSp/T5zChLUdfOk5zAs8=;
        b=O0Yp51ZG8z6fR0INBc5VWq6M4uv9JnW/ZqiC7Hfi5dDOVulqYLKjeGyxUwu641mg46
         fXAG0sJw9nugXbohxvnsGrdfZwtKIEc9OPurnN6YcfEG/I1inBMHKGjZIihUOTzxeKzt
         tcMxScsTSP1Yn64+V3KqTGdRMj9ANa7rMzMSbZ4Pnhtafs89nvUOpllm9eeneB2jPVas
         LsdFzuiHOgIIBXcvL3O695LG5A323LLOGKXK1zmpJs8kqb/2iiwdfXZ7t9TWGm2/91+o
         Y3j5ml1Piud6MLvwNh5pEgYu9XpoN/+4inAQWYmVJdhiahp1gUa2yzDNdOfNQ4RLwZ+X
         xURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I//XHx886JxyAQjDlc3RzYQHSp/T5zChLUdfOk5zAs8=;
        b=aCketitFos2bxAA9awFKGZ05cQJ1nKGgrdKvcINUbbZyLCFOAS3CxIjC2x3FOyQYBY
         oLF/EJo4ioh9zgU4HZnPFIsU8wutsNFnx0soigywVJPSceNc30FErGg5AAYEigh3xHmg
         TebHLHcc6TPyBoQYJYUtuA2KMuLdOrkEuedtciRF+d3rp1OIJ3hxf2ICiFhF23KSukhp
         q6qQFVxlXrQDAFagCqMsgeZL5NkfEYjhFbHc7LBTUpoSUoEDERf388NQ66pFsFAO27WO
         Z2jXzIG2chHpu1wCpWZhdjKugjvJd9EocM9/IfWFAq3vyc9bF+WzS4VazAgD43Eb7xsl
         /PlA==
X-Gm-Message-State: AKaTC02vUfn8Y0bOzZWdWEGVYIG9kKXQifuPWc/+cV3GRVbLKl7Xgzixc8N/IHkn9sdx0MQv
X-Received: by 10.84.218.79 with SMTP id f15mr187275456plm.155.1481569486893;
        Mon, 12 Dec 2016 11:04:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id y2sm77213543pff.82.2016.12.12.11.04.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 5/6] move connect_work_tree_and_git_dir to dir.h
Date:   Mon, 12 Dec 2016 11:04:34 -0800
Message-Id: <20161212190435.10358-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That function was primarily used by submodule code, but the function
itself is not inherently about submodules. In the next patch we'll
introduce relocate_git_dir, which can be used by worktrees as well,
so find a neutral middle ground in dir.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c       | 25 +++++++++++++++++++++++++
 dir.h       |  1 +
 submodule.c | 25 -------------------------
 submodule.h |  1 -
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a5..e0efd3c2c3 100644
--- a/dir.c
+++ b/dir.c
@@ -2748,3 +2748,28 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
+{
+	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf rel_path = STRBUF_INIT;
+	char *git_dir = xstrdup(real_path(git_dir_));
+	char *work_tree = xstrdup(real_path(work_tree_));
+
+	/* Update gitfile */
+	strbuf_addf(&file_name, "%s/.git", work_tree);
+	write_file(file_name.buf, "gitdir: %s",
+		   relative_path(git_dir, work_tree, &rel_path));
+
+	/* Update core.worktree setting */
+	strbuf_reset(&file_name);
+	strbuf_addf(&file_name, "%s/config", git_dir);
+	git_config_set_in_file(file_name.buf, "core.worktree",
+			       relative_path(work_tree, git_dir, &rel_path));
+
+	strbuf_release(&file_name);
+	strbuf_release(&rel_path);
+	free(work_tree);
+	free(git_dir);
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..051674a431 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 #endif
diff --git a/submodule.c b/submodule.c
index d4f7afe2f1..0bb50b4b62 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1222,31 +1222,6 @@ int merge_submodule(unsigned char result[20], const char *path,
 	return 0;
 }
 
-/* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
-{
-	struct strbuf file_name = STRBUF_INIT;
-	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = xstrdup(real_path(git_dir_));
-	char *work_tree = xstrdup(real_path(work_tree_));
-
-	/* Update gitfile */
-	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, work_tree, &rel_path));
-
-	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(work_tree, git_dir, &rel_path));
-
-	strbuf_release(&file_name);
-	strbuf_release(&rel_path);
-	free(work_tree);
-	free(git_dir);
-}
-
 int parallel_submodules(void)
 {
 	return parallel_jobs;
diff --git a/submodule.h b/submodule.h
index d9e197a948..4e3bf469b4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,7 +65,6 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
 /*
-- 
2.11.0.rc2.49.ge1f3b0c.dirty

