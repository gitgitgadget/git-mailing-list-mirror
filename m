Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE4F207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755707AbdEETyJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:09 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36519 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755660AbdEETyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id q66so7064936pfi.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOIt5I4l9euLmKpvGJsuJBXGrRS20VkL9h7pTd8tLQM=;
        b=OEj4cRfkcRlfDiuyZabPgud70mAfFWC969+HiBAFZymDV+2JGPzgiAIEEk4lKU4THz
         PCNxPWdDpk/I97aHjOH6kIktRDlIFoBNoESfQIadAQ/GDAZ8pUguVP2TmZPRYMjMRKZH
         2wvfvoWVUY08jovjSv6W36dHHK88KZvtR42AIG2QwbcdUirHOaYxW/b1E+B77xDN3TFN
         xAVKqdzGz+wOn8JMIM0qDvK7ttvkxLM1DFLWrk+WvYVkwwsiF1BSbrLlybu3rXIyr8rB
         jvq+H7F8gVD3svfKwzDxSPh00EmLEahbBEkewmBuG1tNDTvugqzXBgIFkZ0ZOTdWviLx
         I5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOIt5I4l9euLmKpvGJsuJBXGrRS20VkL9h7pTd8tLQM=;
        b=StCD1jj2X9jVkfcHUXANwkl+aWwER7tgKd9Kw2DsCvcuRyjJE7NAQM4iOxS5Q3MU6s
         epMuWqe/LNPNUQ17iveH2wqjeFd5e27vWXb0A84ecpYZZM2HFZ+YJH64u1dWDxV8+7ec
         l03i3/POcR/roZhzlUdjAZLXPU2NiiVLgi52rK95J8tDVl8GugKWzS4fdjF/T/7gpzoo
         6ofWcicjMzuCJ1nRrglHvhc7XQQnnbGrSEPxFml5/rfFpfRrSPhwEiaMDnSXlcbawRgB
         D7JdPjfFzMw61nu1PVR9b9vV8ofPLNyaZ2daNQ/n3nKuWD4MFW4BsatyyF3Yqk/ZE2h7
         a0WA==
X-Gm-Message-State: AN3rC/6x2Ub8w8CfeM8mLLgXN/jhjJ5n4rahU7RktBdHsues74kuUckk
        624L24aBygF1Ysno
X-Received: by 10.84.133.132 with SMTP id f4mr67987474plf.94.1494014044282;
        Fri, 05 May 2017 12:54:04 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:54:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 13/14] dir: convert read_directory to take an index
Date:   Fri,  5 May 2017 12:53:33 -0700
Message-Id: <20170505195334.121856-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c          | 16 ++++++++--------
 dir.h          |  4 +++-
 unpack-trees.c |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 3318ebbcb..4eb8cb6a2 100644
--- a/dir.c
+++ b/dir.c
@@ -190,7 +190,7 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 	prefix = prefix_len ? pathspec->items[0].match : "";
 
 	/* Read the directory and prune it */
-	read_directory(dir, prefix, prefix_len, pathspec);
+	read_directory(dir, &the_index, prefix, prefix_len, pathspec);
 
 	return prefix_len;
 }
@@ -2071,8 +2071,8 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	return root;
 }
 
-int read_directory(struct dir_struct *dir, const char *path,
-		   int len, const struct pathspec *pathspec)
+int read_directory(struct dir_struct *dir, struct index_state *istate,
+		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
 
@@ -2086,8 +2086,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, &the_index, path, len, pathspec))
-		read_directory_recursive(dir, &the_index, path, len, untracked, 0, pathspec);
+	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
+		read_directory_recursive(dir, istate, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
 	if (dir->untracked) {
@@ -2101,12 +2101,12 @@ int read_directory(struct dir_struct *dir, const char *path,
 				 dir->untracked->gitignore_invalidated,
 				 dir->untracked->dir_invalidated,
 				 dir->untracked->dir_opened);
-		if (dir->untracked == the_index.untracked &&
+		if (dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||
 		     dir->untracked->gitignore_invalidated ||
 		     dir->untracked->dir_invalidated))
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		if (dir->untracked != the_index.untracked) {
+			istate->cache_changed |= UNTRACKED_CHANGED;
+		if (dir->untracked != istate->untracked) {
 			free(dir->untracked);
 			dir->untracked = NULL;
 		}
diff --git a/dir.h b/dir.h
index b745f1e5d..a23bcd005 100644
--- a/dir.h
+++ b/dir.h
@@ -215,7 +215,9 @@ extern int report_path_error(const char *ps_matched, const struct pathspec *path
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
-extern int read_directory(struct dir_struct *, const char *path, int len, const struct pathspec *pathspec);
+extern int read_directory(struct dir_struct *, struct index_state *istate,
+			  const char *path, int len,
+			  const struct pathspec *pathspec);
 
 extern int is_excluded_from_list(const char *pathname, int pathlen,
 				 const char *basename, int *dtype,
diff --git a/unpack-trees.c b/unpack-trees.c
index abdd2922b..48d9cf921 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1564,7 +1564,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
-- 
2.13.0.rc1.294.g07d810a77f-goog

