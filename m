Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A76207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755543AbdEETxs (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:53:48 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34713 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdEETxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so7112144pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mnsezoyz3Peh7JzCzCuNFW+jyMdjLemaQNIfEkRgUjg=;
        b=bL45FPViVYgXK70LRxGJ9dgu+HD1FaooOvcAa6eQmF/L2so1pBj1mAciRsry/j7EV3
         6oS0FBmTmkiRNi13OBEfu84kZ4VvfgbblgWtynI8C4+vv3kyy6J7VeHSrVaE5z7bxaW6
         vgrCeO3CngmnpmZc22A3Y8VD5PwIeWv7VHSyTUDxS3NyM4Mdhyuyz+ixq/J7yMWH3TBQ
         E+Ef0WIPNURqPUpEuIf4DVV62kj67Vxit9ODcVDAl9gxXJXG7cBVIR+Ln8eH3BkXR04d
         Hrx918Suh1c7dLcz8vmiltD1yr/Fnvvmn1JROCyNS7e7IT3UpoNVEqqh0gCZICwk2zTc
         XGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mnsezoyz3Peh7JzCzCuNFW+jyMdjLemaQNIfEkRgUjg=;
        b=p9QmR58HuZCx1Ktt7Fvrxu6UeUP8yZZgbgNPVJcdrkV6DAE5pZT8ornnRMO75GEchB
         BGTLvFpkzPkpSUXGB9P831NHbx1014yQy5JgJSujN99UKIX4kC4Y9KnDoaqukVIf819z
         lf7WpMg8hDIAxd+ho4vwm5Tq2Y/zCxlkD/UdIXtOgdehIao1Pm3EcE6Ubzmbbd1ntiE1
         WqEx8/V0h6OOfdcOn9BLSndAtkpQKhoZWPg48oWV2SE8ZYbx2BobIMzh2sdyUjpObaO6
         3na1zblA4zbVLtf+SSKpMqnODbZ+so98AQPRDpZ9K9YrOC7qHkb8+nW1YXynMkZcELax
         xM8g==
X-Gm-Message-State: AN3rC/6tq+Ne/Wg1waonmKAmMWLFK4f1pnGvOH3ayTdv8strs/jYF6x7
        spJ+I87bp4I2i4Qc
X-Received: by 10.98.67.140 with SMTP id l12mr19333612pfi.110.1494014026544;
        Fri, 05 May 2017 12:53:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 01/14] dir: stop using the index compatibility macros
Date:   Fri,  5 May 2017 12:53:21 -0700
Message-Id: <20170505195334.121856-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make it clearer where the_index is being referenced, stop
using the index compatibility macros in dir.c.  This is to make it
easier to identify the functions which need to be convert to taking in a
'struct index_state' as a parameter.

The end goal would be to eliminate the need to reference global index
state in dir.c.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index f451bfa48..97eadd45e 100644
--- a/dir.c
+++ b/dir.c
@@ -7,6 +7,7 @@
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "attr.h"
@@ -596,12 +597,12 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	void *data;
 
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (pos < 0)
 		return NULL;
-	if (!ce_skip_worktree(active_cache[pos]))
+	if (!ce_skip_worktree(the_index.cache[pos]))
 		return NULL;
-	data = read_sha1_file(active_cache[pos]->oid.hash, &type, &sz);
+	data = read_sha1_file(the_index.cache[pos]->oid.hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -609,7 +610,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	*size = xsize_t(sz);
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, active_cache[pos]->oid.hash);
+		hashcpy(sha1_stat->sha1, the_index.cache[pos]->oid.hash);
 	}
 	return data;
 }
@@ -785,12 +786,12 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
-				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
-				 !ce_stage(active_cache[pos]) &&
-				 ce_uptodate(active_cache[pos]) &&
+				 (pos = index_name_pos(&the_index, fname, strlen(fname))) >= 0 &&
+				 !ce_stage(the_index.cache[pos]) &&
+				 ce_uptodate(the_index.cache[pos]) &&
 				 !would_convert_to_git(fname))
 				hashcpy(sha1_stat->sha1,
-					active_cache[pos]->oid.hash);
+					the_index.cache[pos]->oid.hash);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
 			fill_stat_data(&sha1_stat->stat, &st);
@@ -1235,7 +1236,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_file_exists(pathname, len, ignore_case))
+	if (index_file_exists(&the_index, pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -1244,7 +1245,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!cache_name_is_other(pathname, len))
+	if (!index_name_is_other(&the_index, pathname, len))
 		return NULL;
 
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
@@ -1266,10 +1267,10 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
 {
 	struct cache_entry *ce;
 
-	if (cache_dir_exists(dirname, len))
+	if (index_dir_exists(&the_index, dirname, len))
 		return index_directory;
 
-	ce = cache_file_exists(dirname, len, ignore_case);
+	ce = index_file_exists(&the_index, dirname, len, ignore_case);
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return index_gitdir;
 
@@ -1290,11 +1291,11 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 	if (ignore_case)
 		return directory_exists_in_index_icase(dirname, len);
 
-	pos = cache_name_pos(dirname, len);
+	pos = index_name_pos(&the_index, dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
-	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		const struct cache_entry *ce = the_index.cache[pos++];
 		unsigned char endchar;
 
 		if (strncmp(ce->name, dirname, len))
@@ -1460,7 +1461,7 @@ static int get_index_dtype(const char *path, int len)
 	int pos;
 	const struct cache_entry *ce;
 
-	ce = cache_file_exists(path, len, 0);
+	ce = index_file_exists(&the_index, path, len, 0);
 	if (ce) {
 		if (!ce_uptodate(ce))
 			return DT_UNKNOWN;
@@ -1474,12 +1475,12 @@ static int get_index_dtype(const char *path, int len)
 	}
 
 	/* Try to look it up as a directory */
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (pos >= 0)
 		return DT_UNKNOWN;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		if (strncmp(ce->name, path, len))
 			break;
 		if (ce->name[len] > '/')
@@ -1522,7 +1523,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
-	int has_path_in_index = !!cache_file_exists(path->buf, path->len, ignore_case);
+	int has_path_in_index = !!index_file_exists(&the_index, path->buf, path->len, ignore_case);
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
-- 
2.13.0.rc1.294.g07d810a77f-goog

