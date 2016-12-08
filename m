Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091E41FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbcLHBqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:55 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35364 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbcLHBqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:48 -0500
Received: by mail-pf0-f182.google.com with SMTP id i88so79990561pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FYi8VyTAK8Ei5Q16Vf/hLHeT8Mr/aH05cnddbXDNYJk=;
        b=KXTLpK9+JSL7bWZX5nAeVTevPGG4MTG39DJCwKCEh+u9PICT54rZInD7o9xgR/FisN
         kbWBFeuzGh87F11qfv9A3NewXq4wSQaREzgTayOu+04/6mQ7U0IRiMUKFf0/4MnbuZsZ
         7JZ8a/KhWA5rPBp+YNGHi5MPELs57xDJeeLE6YBFdJx0XFlXhxnCywN+cqR6MVGzORwj
         PFldniMmUkg+BQC6T6Dhq4d2fcDFoKS7jaluHD5mTv0E9/GFLcpbEzxBZuwY3EwE8etL
         0tl+FS7AcUubRC2Kq+UxtseWYa7DCb6pZ8RKdpU7PNXOGctmIInM7UNGOQ70SWyhSen0
         dFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FYi8VyTAK8Ei5Q16Vf/hLHeT8Mr/aH05cnddbXDNYJk=;
        b=Lb/LsqaotUVcQTJf3SSYhVWGVZG6jWmHprly/HsZPKMbokPDsi9OR1z0E8xqT/MCNj
         kUL5eE99gqQbwBmWGvibutsSEMoj9e4mpFJ23D8H1zVZjVdq87DaW8Qv4wnFRClIoCQf
         6X4uClT9btT0wyjbaSdgcUVSDVADIy8Swnj3Dn/uM0TFaSTZ5KlxrUVwWF6RC3w+koa7
         t+VOkDf/hr+J01mndOu9gP5E+aT98tRaE9vZE8dSKIKTNnN0eqTMr6ENFuFKTMZIpGEo
         vg38nTMJH42xDDjvk5EuWTyXFsNGBFIsvN8lRO5ZejshNo5EuYaW+D4LZtb/0/yfuRkI
         tJFQ==
X-Gm-Message-State: AKaTC00XyG7UDDVRZ+HV+dMiDvDohI1RNnRGAjxjyf/AKFlCj/yBNvbUgJvTV4df7G2Ez+0D
X-Received: by 10.84.217.149 with SMTP id p21mr125213888pli.121.1481161607713;
        Wed, 07 Dec 2016 17:46:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id 131sm45222726pfx.92.2016.12.07.17.46.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 6/7] move connect_work_tree_and_git_dir to dir.h
Date:   Wed,  7 Dec 2016 17:46:22 -0800
Message-Id: <20161208014623.7588-7-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
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
 dir.c       | 26 ++++++++++++++++++++++++++
 dir.h       |  1 +
 submodule.c | 26 --------------------------
 submodule.h |  1 -
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a5..8b74997c66 100644
--- a/dir.c
+++ b/dir.c
@@ -2748,3 +2748,29 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+{
+	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf rel_path = STRBUF_INIT;
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
+
+	/* Update gitfile */
+	strbuf_addf(&file_name, "%s/.git", work_tree);
+	write_file(file_name.buf, "gitdir: %s",
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
+
+	/* Update core.worktree setting */
+	strbuf_reset(&file_name);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
+	git_config_set_in_file(file_name.buf, "core.worktree",
+			       relative_path(real_work_tree, real_git_dir,
+					     &rel_path));
+
+	strbuf_release(&file_name);
+	strbuf_release(&rel_path);
+	free(real_work_tree);
+	free(real_git_dir);
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
index 66c5ce5a24..0bb50b4b62 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1222,32 +1222,6 @@ int merge_submodule(unsigned char result[20], const char *path,
 	return 0;
 }
 
-/* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
-{
-	struct strbuf file_name = STRBUF_INIT;
-	struct strbuf rel_path = STRBUF_INIT;
-	char *real_git_dir = xstrdup(real_path(git_dir));
-	char *real_work_tree = xstrdup(real_path(work_tree));
-
-	/* Update gitfile */
-	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(real_git_dir, real_work_tree, &rel_path));
-
-	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", real_git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, real_git_dir,
-					     &rel_path));
-
-	strbuf_release(&file_name);
-	strbuf_release(&rel_path);
-	free(real_work_tree);
-	free(real_git_dir);
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
2.11.0.rc2.30.gc512cbd.dirty

