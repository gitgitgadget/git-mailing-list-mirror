Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5D81F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdGaXLs (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:11:48 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33061 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdGaXLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:11:46 -0400
Received: by mail-pf0-f170.google.com with SMTP id d67so233563pfc.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aWw4sDFuydjFaFSSSjg71Upttq3glaRrDEaqqR50/Ww=;
        b=fmLNEEXNH8RX7zkg+rEEyVQyDj3o4VgEnl8zHyxvX8S35JuFtXu9mu2vhtNCZ6GlIj
         1dw/01tUV1+keCfKzwCV48+Yyw0gQrfQvwNscgzuyqKGG01qN3/nDJlYoKVam4o27MJ+
         KuPhxebuMStjWk3e/O3rHioU0KiQ7mSGvQFtTinmFtcJcVciCAGSiY59LBaEcmfYIJUM
         vnjZsMTy/cI7ECcHmFcqsRic3hz4ZJykST6VsxPKFNrN4hB6uyr8oc7er9sH1MMVjRYw
         qjD/OH6YmIrWGyEOCdRmCoFJDNqF7XlL+VaYlKSVp3L1vY2H7qXe+Hf+qYM9RUbvRncB
         CrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aWw4sDFuydjFaFSSSjg71Upttq3glaRrDEaqqR50/Ww=;
        b=i+4e+Jgh0Ws6mwkPbS5ON2CiPty+3sM52f70Yax39aCPYxHfIJl/jsOkhZb1riQqpj
         zg4rtDV4sX3UfJwerNnXQeHppjDJCsV642lf7Un1MTW1lt42HJmsT20YVs57RnDM39qA
         TAjYvN5Ql2L6+FoMLJDurNovm/VlxvcbgPSW/xhJH+aWeXwAB7CJzJjv51FF+XzczW3c
         8FhrOtINIP7j16rNTTsG5CBy/nmuv33BCkcjPYxX3uX/NERwtJf0wGhNSSuHjnn3QFFJ
         RpcIzYfAAA4wlx5iuKYzcjXUiCu8qMASm8W7DjuiX78UyxvXGd8nCxlwpl8xs2OXtjGg
         YcyQ==
X-Gm-Message-State: AIVw110yj2IHDk/Mg7mrw9b+UJ5zF8uqdGoe9fGeu30RSFEtome8mylp
        SwR1bS0zmq2F1FSF
X-Received: by 10.99.109.197 with SMTP id i188mr16956823pgc.373.1501542705377;
        Mon, 31 Jul 2017 16:11:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d56:e53e:b2c6:81ed])
        by smtp.gmail.com with ESMTPSA id y11sm53403284pfd.144.2017.07.31.16.11.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 16:11:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        sbeller@google.com
Subject: [PATCH] convert any hard coded .gitmodules file string to the MACRO
Date:   Mon, 31 Jul 2017 16:11:42 -0700
Message-Id: <20170731231142.15053-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170718190527.78049-4-bmwill@google.com>
References: <20170718190527.78049-4-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I used these commands:
  $ cat sem.cocci
  @@
  @@
  - ".gitmodules"
  + GITMODULES_FILE

  $ spatch --in-place --sp-file sem.cocci builtin/*.c *.c *.h

Feel free to regenerate or squash it in or have it as a separate commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c    | 18 +++++++++---------
 unpack-trees.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 37f4a92872..b75d02ba7b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,7 +63,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (gitmodules_is_unmerged)
@@ -77,7 +77,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file_gently(".gitmodules", entry.buf, newpath) < 0) {
+	if (git_config_set_in_file_gently(GITMODULES_FILE, entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), entry.buf);
 		strbuf_release(&entry);
@@ -97,7 +97,7 @@ int remove_path_from_gitmodules(const char *path)
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
+	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (gitmodules_is_unmerged)
@@ -110,7 +110,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
@@ -122,7 +122,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(void)
 {
-	if (add_file_to_cache(".gitmodules", 0))
+	if (add_file_to_cache(GITMODULES_FILE, 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
@@ -233,18 +233,18 @@ void gitmodules_config(void)
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
 		if (read_cache() < 0)
 			die("index file corrupt");
-		pos = cache_name_pos(".gitmodules", 11);
+		pos = cache_name_pos(GITMODULES_FILE, 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos = -1 - pos;
 			if (active_nr > pos) {  /* there is a .gitmodules */
 				const struct cache_entry *ce = active_cache[pos];
 				if (ce_namelen(ce) == 11 &&
-				    !memcmp(ce->name, ".gitmodules", 11))
+				    !memcmp(ce->name, GITMODULES_FILE, 11))
 					gitmodules_is_unmerged = 1;
 			}
 		} else if (pos < active_nr) {
 			struct stat st;
-			if (lstat(".gitmodules", &st) == 0 &&
+			if (lstat(GITMODULES_FILE, &st) == 0 &&
 			    ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
 				gitmodules_is_modified = 1;
 		}
@@ -264,7 +264,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 void repo_read_gitmodules(struct repository *repo)
 {
-	char *gitmodules_path = repo_worktree_path(repo, ".gitmodules");
+	char *gitmodules_path = repo_worktree_path(repo, GITMODULES_FILE);
 
 	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
 	free(gitmodules_path);
diff --git a/unpack-trees.c b/unpack-trees.c
index dd535bc849..05335fe5bf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -286,7 +286,7 @@ static void reload_gitmodules_file(struct index_state *index,
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 		if (ce->ce_flags & CE_UPDATE) {
-			int r = strcmp(ce->name, ".gitmodules");
+			int r = strcmp(ce->name, GITMODULES_FILE);
 			if (r < 0)
 				continue;
 			else if (r == 0) {
-- 
2.14.0.rc0.3.g6c2e499285

