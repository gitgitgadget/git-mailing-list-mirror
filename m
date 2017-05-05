Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9466C20820
	for <e@80x24.org>; Fri,  5 May 2017 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755609AbdEETx7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:53:59 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33387 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755586AbdEETx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:57 -0400
Received: by mail-pg0-f48.google.com with SMTP id y4so7704252pge.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cKptu4IUNalR9fCPuunv3Ld+za/7I6aszZYlILnakx8=;
        b=frFWZFQCz+CKZqbcQiZulnqXBviGzDq/reGjb7DJbrTSCbxNXa3eU/hkZzKBLs0Dah
         jnYD5OzQB72VoqYPF43K2s88fYKYTVr6Y0UycE8gtCTjSlgHmaxruZ6axGAnHRxrHClL
         71FegFCvER8RlmDZ65nKRLzAfqgp/bKIBGAkwKz4EVh0aHCXRiFazQXtuNN7/aJtW2oj
         yZISdLon1nXy7b1K22Mnup3VFymK5e2CqZhh1mZNHAihNh6zQI7hhg04I9NDhrxfubWL
         Re7AlOPFSQdqlfUn90Wo5L7Q/ACFq/6l38rnG8E/njjXoHCEoQtDkPplqZgQTjoPbctf
         585w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cKptu4IUNalR9fCPuunv3Ld+za/7I6aszZYlILnakx8=;
        b=SQBSjcJMvnuTfRpxBQkZornY02UZn6IFAiUrxB8aElTahz/IrqpgYwR2b7YB9+g431
         TUEnmOwpDYh7Q5ZY6CJMt6n36XSw36ilO0bA4iogcirlQJOI/6dX5idNcrYFNSbl+CWq
         Qqm6vhUOSlvEZBVxjr3rtbf/D1TKhJ8NSv/Bk6y/StgNGkVYRWutgK5GJht7qsrMVq2/
         qrkPkVmcf7SnA1XK3Cfu/dK99pgWfKNSIzRShvDkdt8Dwmw+wtIljtaKzSiiJ+tUn4Dv
         rCeMsNLh8ozZutm5yIpmdhIA+rm25MXOaJ0dtoSkYa3iLqUYt1RobgTGhYOQWabYycoQ
         e9GA==
X-Gm-Message-State: AN3rC/7jufUdhnwxX7pQzEONxUSGMzxAmN82JW3/mpJC5wFS+iNE0Ch/
        0F3wHzedK7NqlDlH
X-Received: by 10.99.124.75 with SMTP id l11mr5339105pgn.211.1494014036882;
        Fri, 05 May 2017 12:53:56 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 08/14] dir: convert add_excludes to take an index
Date:   Fri,  5 May 2017 12:53:28 -0700
Message-Id: <20170505195334.121856-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c          | 29 +++++++++++++++--------------
 dir.h          |  2 +-
 unpack-trees.c |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 497a2db85..b86d02ff9 100644
--- a/dir.c
+++ b/dir.c
@@ -730,7 +730,7 @@ static void invalidate_directory(struct untracked_cache *uc,
 
 /*
  * Given a file with name "fname", read it (either from disk, or from
- * the index if "check_index" is non-zero), parse it and store the
+ * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "el".
  *
  * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
@@ -738,7 +738,8 @@ static void invalidate_directory(struct untracked_cache *uc,
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
-			struct exclude_list *el, int check_index,
+			struct exclude_list *el,
+			struct index_state *istate,
 			struct sha1_stat *sha1_stat)
 {
 	struct stat st;
@@ -752,8 +753,8 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			warn_on_inaccessible(fname);
 		if (0 <= fd)
 			close(fd);
-		if (!check_index ||
-		    (buf = read_skip_worktree_file_from_index(&the_index, fname, &size, sha1_stat)) == NULL)
+		if (!istate ||
+		    (buf = read_skip_worktree_file_from_index(istate, fname, &size, sha1_stat)) == NULL)
 			return -1;
 		if (size == 0) {
 			free(buf);
@@ -785,15 +786,15 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (sha1_stat) {
 			int pos;
 			if (sha1_stat->valid &&
-			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
+			    !match_stat_data_racy(istate, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
-			else if (check_index &&
-				 (pos = index_name_pos(&the_index, fname, strlen(fname))) >= 0 &&
-				 !ce_stage(the_index.cache[pos]) &&
-				 ce_uptodate(the_index.cache[pos]) &&
+			else if (istate &&
+				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
+				 !ce_stage(istate->cache[pos]) &&
+				 ce_uptodate(istate->cache[pos]) &&
 				 !would_convert_to_git(fname))
 				hashcpy(sha1_stat->sha1,
-					the_index.cache[pos]->oid.hash);
+					istate->cache[pos]->oid.hash);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
 			fill_stat_data(&sha1_stat->stat, &st);
@@ -824,9 +825,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 
 int add_excludes_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct exclude_list *el,
-				   int check_index)
+				   struct index_state *istate)
 {
-	return add_excludes(fname, base, baselen, el, check_index, NULL);
+	return add_excludes(fname, base, baselen, el, istate, NULL);
 }
 
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
@@ -858,7 +859,7 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
 	el = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes(fname, "", 0, el, 0, sha1_stat) < 0)
+	if (add_excludes(fname, "", 0, el, NULL, sha1_stat) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
@@ -1166,7 +1167,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
-			add_excludes(el->src, el->src, stk->baselen, el, 1,
+			add_excludes(el->src, el->src, stk->baselen, el, &the_index,
 				     untracked ? &sha1_stat : NULL);
 		}
 		/*
diff --git a/dir.h b/dir.h
index 64254c7e7..1bcda0d23 100644
--- a/dir.h
+++ b/dir.h
@@ -243,7 +243,7 @@ extern int is_excluded(struct dir_struct *dir, const char *name, int *dtype);
 extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 					     int group_type, const char *src);
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  struct exclude_list *el, int check_index);
+					  struct exclude_list *el, struct  index_state *istate);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
diff --git a/unpack-trees.c b/unpack-trees.c
index 9bcb13e4f..5b19849e4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1223,7 +1223,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
-		if (add_excludes_from_file_to_list(sparse, "", 0, &el, 0) < 0)
+		if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->el = &el;
-- 
2.13.0.rc1.294.g07d810a77f-goog

