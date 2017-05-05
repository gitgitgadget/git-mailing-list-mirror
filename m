Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A13207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbdEETx4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:53:56 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35798 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdEETxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id v14so7091280pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbv6WXAbOtUpqQTbyZxyln9EBHuKQ7Uas8fHmLYTphU=;
        b=mHlK14PEpdKos5X05jdal4ub/KZdx3tmFQcI/NdBpctXaJnyRuQ6friYcI85cBGfp1
         uW4wDenPX41Xl5WJ21zb37LY+ZpYns98BOe0eHsHQ+GB4eDuXa9kf35xsIusdQ9oKops
         7TxRCdor5wiSb3teA4ZgCoGpStEHo3iKlMXYv+N50+BEEq7If5mMLkPvohyIzo8o5JPD
         IDcDULM9YUybFz/eW/3e3UTS5JjsKM1DhoDLPd7Xcn1G0XCimLGLWGh8vp3mvgYwdUpT
         QwzvCv0Opu1HTDrNYAHA0QqpgsAX26PoMLQlrWZdp3wyU+kXz+gSBLQcJL9eiez+QCxC
         ARyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbv6WXAbOtUpqQTbyZxyln9EBHuKQ7Uas8fHmLYTphU=;
        b=ZW693ii/HnDyivR8KNGyj45xrcffIlO55Xu1IBDsph4kobfi+vyLqut4jPdSDo9WUc
         RrJfusR7dK5vlk4bxyq9af7yfXGkjUY4sBfrJJXLqQlgGEmwyEAdg70ZZvj85DSg8Ywm
         7R/QPJrEIUKAg5FCaVS1EkS/fEAsyRzqNR//kteQhmprDLNrHKGhO867hgY3XqVSi/8T
         tzOf/OXraRl7e1i864qpVgZqE2TEKfCR/pKVafH6lvfaLLgPZnq7fjzvJyI7Pt+pgC2P
         rLROUO/j69Imv2mBUufZ4rW1deO5xNiuBs6A5sqieBV9zQ+8nFU8urYy0cb1ZB04aOkz
         5+aw==
X-Gm-Message-State: AN3rC/4VLqc7+D+VdIgah3A76HZFgBziF5bHSNRUm8sk4gnXHU83l3Qx
        pBpEdlOg/Y/3etmn
X-Received: by 10.84.168.131 with SMTP id f3mr67776075plb.160.1494014032460;
        Fri, 05 May 2017 12:53:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 05/14] dir: convert dir_add* to take an index
Date:   Fri,  5 May 2017 12:53:25 -0700
Message-Id: <20170505195334.121856-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c |  3 ++-
 dir.c         | 18 +++++++++++-------
 dir.h         |  4 +++-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d..bf5e676e4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -437,7 +437,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
 					if (is_excluded(&dir, path, &dtype))
-						dir_add_ignored(&dir, path, pathspec.items[i].len);
+						dir_add_ignored(&dir, &the_index,
+								path, pathspec.items[i].len);
 				} else
 					die(_("pathspec '%s' did not match any files"),
 					    pathspec.items[i].original);
diff --git a/dir.c b/dir.c
index 4515f0083..a508e8076 100644
--- a/dir.c
+++ b/dir.c
@@ -1236,18 +1236,22 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 	return ent;
 }
 
-static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
+static struct dir_entry *dir_add_name(struct dir_struct *dir,
+				      struct index_state *istate,
+				      const char *pathname, int len)
 {
-	if (index_file_exists(&the_index, pathname, len, ignore_case))
+	if (index_file_exists(istate, pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+struct dir_entry *dir_add_ignored(struct dir_struct *dir,
+				  struct index_state *istate,
+				  const char *pathname, int len)
 {
-	if (!index_name_is_other(&the_index, pathname, len))
+	if (!index_name_is_other(istate, pathname, len))
 		return NULL;
 
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
@@ -1819,18 +1823,18 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		switch (state) {
 		case path_excluded:
 			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, path.buf, path.len);
+				dir_add_name(dir, &the_index, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
 							 pathspec)))
-				dir_add_ignored(dir, path.buf, path.len);
+				dir_add_ignored(dir, &the_index, path.buf, path.len);
 			break;
 
 		case path_untracked:
 			if (dir->flags & DIR_SHOW_IGNORED)
 				break;
-			dir_add_name(dir, path.buf, path.len);
+			dir_add_name(dir, &the_index, path.buf, path.len);
 			if (cdir.fdir)
 				add_untracked(untracked, path.buf + baselen);
 			break;
diff --git a/dir.h b/dir.h
index bf23a470a..a9f809983 100644
--- a/dir.h
+++ b/dir.h
@@ -219,7 +219,9 @@ extern int read_directory(struct dir_struct *, const char *path, int len, const
 
 extern int is_excluded_from_list(const char *pathname, int pathlen, const char *basename,
 				 int *dtype, struct exclude_list *el);
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
+struct dir_entry *dir_add_ignored(struct dir_struct *dir,
+				  struct index_state *istate,
+				  const char *pathname, int len);
 
 /*
  * these implement the matching logic for dir.c:excluded_from_list and
-- 
2.13.0.rc1.294.g07d810a77f-goog

