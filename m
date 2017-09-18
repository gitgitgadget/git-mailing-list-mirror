Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4632047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbdIRRYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:24:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34268 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbdIRRYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:24:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id u18so458375pgo.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+XUBszggGS9ea7ieNLIFCfVwnBmHG8Ld7v24obOzmw=;
        b=Zs+zbj7xHjKuQ2PfNHg+Fwtq+Ady9Z4QjFKD/hmJfUKI9GULajJ379wt7VpfC8qaQR
         VAQFCjamcEY2Snx1lnX0huqyXPbHC8n9UoCnr4S2bDvjWKRfHMYS6jLqDT58TWWKS1z6
         9XkgMgFzboqBlFjGfKeEStxa1uc706osZbtSJQd0lQJgnd7ndCyeye4Krjqdt+zX7tIs
         QG7tfcpdiyNubID/4E13tAnL04+W5EFTALoxMenkfjlnkcPeHrts2zst85KK41bO63IC
         zR34JKdxd6RH9ON9JNOOrMuPk+v1rMUOk4vnfaylNcWqYhGZcUgZVXQoP2zUSJJu4/sA
         kdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+XUBszggGS9ea7ieNLIFCfVwnBmHG8Ld7v24obOzmw=;
        b=sX+17MXRFyFSOlDiVhO12xo4+vYxnykoRwIhq6UchIexI1vfreB4tUUCiTaI+L60hn
         W+FZGwyYHLRVG3xxU8PpN8U/edUYHLlhOMpIILMbtbOucLqidxvI465q3k3pujGH7Thj
         zCfHbdkPXitpMKhrCRg8jbFYr+YQJPIst5/W+uB0xa0e/ji1d8aucYNcWORFVa6Ug/yt
         GVHgLaRMxug0Ulrb+FnCTYTbukPWPvTvOuxEN3/fu+2lZM4TzfN3zGoMfeLl1yJBXUuh
         9RlGuMFRcErZzZ+1EKwch4aZ5kXQ1fsVDX8uMbCb5Vdhc22+DZFTiwkPw4+SnF3oncLW
         nAyg==
X-Gm-Message-State: AHPjjUhZ+K77p6oON8NHpO5gMFjUMAIZMAVhZAR8hSJbgk4fjFjR7xNF
        JgmlOlKIUKZf/Q==
X-Google-Smtp-Source: ADKCNb7e7uhzOA54PZ4Mm5JrdS7tKjO1z30xbqnJ7g37R02aFCQ0+nusisBkfTh/HiYkFqtABEh6Jg==
X-Received: by 10.84.210.7 with SMTP id z7mr36297205plh.371.1505755480563;
        Mon, 18 Sep 2017 10:24:40 -0700 (PDT)
Received: from jamill-1.corp.microsoft.com ([2001:4898:8010::75a])
        by smtp.gmail.com with ESMTPSA id s184sm14912311pfb.123.2017.09.18.10.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 10:24:40 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sxlijin@gmail.com
Subject: [PATCH v2] Improve performance of git status --ignored
Date:   Mon, 18 Sep 2017 13:24:33 -0400
Message-Id: <1505755473-6720-2-git-send-email-jamill@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1505755473-6720-1-git-send-email-jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
 <1505755473-6720-1-git-send-email-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the performance of the directory listing logic when it wants to list
non-empty ignored directories. In order to show non-empty ignored directories,
the existing logic will recursively iterate through all contents of an ignored
directory. This change introduces the optimization to stop iterating through
the contents once it finds the first file. This can have a significant
improvement in 'git status --ignored' performance in repositories with a large
number of files in ignored directories.

For an example of the performance difference on an example repository with
196,000 files in 400 ignored directories:

| Command                    |  Time (s) |
| -------------------------- | --------- |
| git status                 |   1.2     |
| git status --ignored (old) |   3.9     |
| git status --ignored (new) |   1.4     |

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 dir.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 1c55dc3..1d17b80 100644
--- a/dir.c
+++ b/dir.c
@@ -49,7 +49,7 @@ struct cached_dir {
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *path, int len,
 	struct untracked_cache_dir *untracked,
-	int check_only, const struct pathspec *pathspec);
+	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
 static int get_dtype(struct dirent *de, struct index_state *istate,
 		     const char *path, int len);
 
@@ -1404,8 +1404,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
+
+	/*
+	 * If this is an excluded directory, then we only need to check if
+	 * the directory contains any files.
+	 */
 	return read_directory_recursive(dir, istate, dirname, len,
-					untracked, 1, pathspec);
+					untracked, 1, exclude, pathspec);
 }
 
 /*
@@ -1633,7 +1638,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, pathspec);
+						cdir->ucd, 1, 0, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1793,12 +1798,20 @@ static void close_cached_dir(struct cached_dir *cdir)
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  *
+ * If 'stop_at_first_file' is specified, 'path_excluded' is returned
+ * to signal that a file was found. This is the least significant value that
+ * indicates that a file was encountered that does not depend on the order of
+ * whether an untracked or exluded path was encountered first.
+ *
  * Returns the most significant path_treatment value encountered in the scan.
+ * If 'stop_at_first_file' is specified, `path_excluded` is the most
+ * significant path_treatment value that will be returned.
  */
+
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *base, int baselen,
 	struct untracked_cache_dir *untracked, int check_only,
-	const struct pathspec *pathspec)
+	int stop_at_first_file, const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1832,12 +1845,34 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			subdir_state =
 				read_directory_recursive(dir, istate, path.buf,
 							 path.len, ud,
-							 check_only, pathspec);
+							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 		}
 
 		if (check_only) {
+			if (stop_at_first_file) {
+				/*
+				 * If stopping at first file, then
+				 * signal that a file was found by
+				 * returning `path_excluded`. This is
+				 * to return a consistent value
+				 * regardless of whether an ignored or
+				 * excluded file happened to be
+				 * encountered 1st.
+				 *
+				 * In current usage, the
+				 * `stop_at_first_file` is passed when
+				 * an ancestor directory has matched
+				 * an exclude pattern, so any found
+				 * files will be excluded.
+				 */
+				if (dir_state >= path_excluded) {
+					dir_state = path_excluded;
+					break;
+				}
+			}
+
 			/* abort early if maximum state has been reached */
 			if (dir_state == path_untracked) {
 				if (cdir.fdir)
@@ -2108,7 +2143,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		 */
 		dir->untracked = NULL;
 	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
-		read_directory_recursive(dir, istate, path, len, untracked, 0, pathspec);
+		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
-- 
2.7.4

