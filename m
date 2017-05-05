Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475E2207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755621AbdEETyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:02 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33430 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755593AbdEETyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:00 -0400
Received: by mail-pf0-f173.google.com with SMTP id q20so7142741pfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lUUm9G9QwVRuf43EOdKsnfJXnSBl/NU9v1feJC3u2TQ=;
        b=IEIlfRvDpnwFZx6lZSybvuH5dDHr1V48dX3amnBwBrKKv0Wu2RNiEeyJ5i0tqOOMUY
         BVwdudLF4BhZPw6YBmsg8M+67XQL75p7fJsP/1L8wsQqjC3LPcOzipTNAG2WtAPskiQg
         hQwxXybFryuFfP/cFBgs6ifVSSuOYz0yN7Q/a1LsN7Lb5LUuqKtTKIznPnxsraEtV8Fo
         l0JarKZwbeg4HyilGNIF/Jdljl5bqr+UYPBO2JkGifSsPk38JpP5fVPYLg5Zyz2rSQra
         vriXxpZR5AEmQ+M2VDPMMgqFV3qg5V8ANBYv2Xt+xz2NEfyjuPlH9pKrdQzHXWdBXON4
         AhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lUUm9G9QwVRuf43EOdKsnfJXnSBl/NU9v1feJC3u2TQ=;
        b=cC+LtjkNyfSeXaJnNoCD3q9SibuYWTgJxZdQN2Ae+PQd9YA56VSjfAxjUoWiUxN/Uy
         YUyA7DHhRbKZWhENl8nWaXK6YhCxbm07g3+N+yvwFf7KOeylsgtqpldgR4yBH6g0cRjE
         aLmwnd4DOSkQgu40gf4jF52Xl1BDTJMWECH0HHp9njevqMCMuY8ZCBvv1bPRotY/F+8x
         rvj6oxTQC3E52iqHnHnoQGEQiM1x5Bc2E7eqiUHnkqhlXNaLSe/Pcrf9VUhNTuBFBQwJ
         3lwsfT/NX2pE/4g17sxiqsHM6DhWwhS9iYz1PFNsGJ3OlvtQEFlWQvGUdujHRnz1WGMK
         qwjg==
X-Gm-Message-State: AN3rC/6+aVFYNepxvdyj/5pg5hiryizcviB10p7NbK0NcAJSr9psVe+s
        QF5Rl6mOolMtVwFh
X-Received: by 10.98.195.10 with SMTP id v10mr18985380pfg.219.1494014039789;
        Fri, 05 May 2017 12:53:59 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:58 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 10/14] dir: convert is_excluded to take an index
Date:   Fri,  5 May 2017 12:53:30 -0700
Message-Id: <20170505195334.121856-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c          |  2 +-
 builtin/check-ignore.c |  3 ++-
 builtin/clean.c        |  2 +-
 builtin/ls-files.c     |  2 +-
 dir.c                  | 16 +++++++++-------
 dir.h                  |  5 ++++-
 unpack-trees.c         |  2 +-
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index bf5e676e4..0b52aeced 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -436,7 +436,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			     !file_exists(path))) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (is_excluded(&dir, path, &dtype))
+					if (is_excluded(&dir, &the_index, path, &dtype))
 						dir_add_ignored(&dir, &the_index,
 								path, pathspec.items[i].len);
 				} else
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d73d3ca3..d2293b22e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -101,7 +101,8 @@ static int check_ignore(struct dir_struct *dir,
 		full_path = pathspec.items[i].match;
 		exclude = NULL;
 		if (!seen[i]) {
-			exclude = last_exclude_matching(dir, full_path, &dtype);
+			exclude = last_exclude_matching(dir, &the_index,
+							full_path, &dtype);
 		}
 		if (!quiet && (exclude || show_non_matching))
 			output_exclude(pathspec.items[i].original, exclude);
diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..39866afab 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -683,7 +683,7 @@ static int filter_by_patterns_cmd(void)
 		for_each_string_list_item(item, &del_list) {
 			int dtype = DT_UNKNOWN;
 
-			if (is_excluded(&dir, item->string, &dtype)) {
+			if (is_excluded(&dir, &the_index, item->string, &dtype)) {
 				*item->string = '\0';
 				changed++;
 			}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..ccba227e2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -315,7 +315,7 @@ static void show_ru_info(void)
 static int ce_excluded(struct dir_struct *dir, const struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return is_excluded(dir, ce->name, &dtype);
+	return is_excluded(dir, &the_index, ce->name, &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
diff --git a/dir.c b/dir.c
index 50b5e720e..a15da672c 100644
--- a/dir.c
+++ b/dir.c
@@ -1204,19 +1204,20 @@ static void prep_exclude(struct dir_struct *dir,
  * undecided.
  */
 struct exclude *last_exclude_matching(struct dir_struct *dir,
-					     const char *pathname,
-					     int *dtype_p)
+				      struct index_state *istate,
+				      const char *pathname,
+				      int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
-	prep_exclude(dir, &the_index, pathname, basename-pathname);
+	prep_exclude(dir, istate, pathname, basename-pathname);
 
 	if (dir->exclude)
 		return dir->exclude;
 
-	return last_exclude_matching_from_lists(dir, &the_index, pathname, pathlen,
+	return last_exclude_matching_from_lists(dir, istate, pathname, pathlen,
 			basename, dtype_p);
 }
 
@@ -1225,10 +1226,11 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
  * scans all exclude lists to determine whether pathname is excluded.
  * Returns 1 if true, otherwise 0.
  */
-int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+int is_excluded(struct dir_struct *dir, struct index_state *istate,
+		const char *pathname, int *dtype_p)
 {
 	struct exclude *exclude =
-		last_exclude_matching(dir, pathname, dtype_p);
+		last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1573,7 +1575,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	    (directory_exists_in_index(&the_index, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	exclude = is_excluded(dir, path->buf, &dtype);
+	exclude = is_excluded(dir, &the_index, path->buf, &dtype);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
diff --git a/dir.h b/dir.h
index 1bcda0d23..b745f1e5d 100644
--- a/dir.h
+++ b/dir.h
@@ -236,9 +236,12 @@ extern int match_pathname(const char *, int,
 			  const char *, int, int, unsigned);
 
 extern struct exclude *last_exclude_matching(struct dir_struct *dir,
+					     struct index_state *istate,
 					     const char *name, int *dtype);
 
-extern int is_excluded(struct dir_struct *dir, const char *name, int *dtype);
+extern int is_excluded(struct dir_struct *dir,
+		       struct index_state *istate,
+		       const char *name, int *dtype);
 
 extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 					     int group_type, const char *src);
diff --git a/unpack-trees.c b/unpack-trees.c
index 5b19849e4..abdd2922b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1606,7 +1606,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, name, &dtype))
+	    is_excluded(o->dir, &the_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.13.0.rc1.294.g07d810a77f-goog

