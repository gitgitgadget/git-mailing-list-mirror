Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF541FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760643AbdACSuJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:50:09 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35413 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbdACSuH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:50:07 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so77786698pfk.2
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NTZ/qnSa+vyrM+Ke01feHCyVndyNBct0urUOCvp/XQ=;
        b=uypiqPlsXICrUBrJRoB58uqBWYzDMzyTXFpkSAzk0bAvhWbeUnaRgPzd6tXCeHSogM
         N3RTHBDzu4THLExbp0Hvyj1lTxn+6Dtd58ML6C4bKVKT4lopALr38uJm9UGFmEmthYBc
         UPoaLQcR2/b+Vq9T4Z7OEvFz8gEbPC908MlqTcpkmWvfcJNPZXfilgM1ZUTvmxvKkk6i
         v0sxL7lvcZfdIp1NAFst5H7lxuRkmtrbCeJiYWDyVTQJQm42jtKPDwLbDEGVWA5Q1Dw6
         exuwryqE+kTUNHPB9twA8Xd+aX3XY1bi7w/QRldg5OOhSiYxqr2HXPX5nKtx+mytqHL3
         ThEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NTZ/qnSa+vyrM+Ke01feHCyVndyNBct0urUOCvp/XQ=;
        b=U4iQJ78DK3PL8QuoUtTLVMg9IrlGzWydkw67mOtwNoH/X5TBf8g1CwiT4KOiUOvOLa
         umvdW/hpkhIPemsIPOHaIfusYjP+PmgzSq3H284Cb8IQCWmKXYzU1NBYaepc25QdFu8Y
         reIVmegW8kXmZU5pNMuASHaSd1XWuLNvrJexBKlOr3qE8INkhZim9grDkfmSG8zWnYj0
         BepCUYnaEpuIcj0U9ceBoqUNmrnhf/ruIuqM4JQ9b9bvrgMed1MKwyp8XyygJg/vlTMx
         A33uCiGpLk7f75LtuGxpe8j61/DX3tdhVbjzm5+SGS7gXqcnD496z720zwFhg/6kerlz
         bkMw==
X-Gm-Message-State: AIkVDXKEWBENGhdjXXTMRZG/xcITL05K0CjrjWsBYuHtJEsinSqaIJ+TmQP1Ixa7ahnIwt7V
X-Received: by 10.99.51.76 with SMTP id z73mr116127748pgz.173.1483468978940;
        Tue, 03 Jan 2017 10:42:58 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:42:57 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 01/16] mv: remove use of deprecated 'get_pathspec()'
Date:   Tue,  3 Jan 2017 10:42:26 -0800
Message-Id: <20170103184241.128409-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the 'internal_copy_pathspec()' function to 'prefix_path()'
instead of using the deprecated 'get_pathspec()' interface.  Also,
rename 'internal_copy_pathspec()' to 'internal_prefix_pathspec()' to be
more descriptive of what the funciton is actually doing.

In addition to this, fix a memory leak caused by only duplicating some
of the pathspec elements.  Instead always duplicate all of the the
pathspec elements as an intermediate step (with modificationed based on
the passed in flags).  This way the intermediate strings can then be
freed after getting the result from 'prefix_path()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/mv.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2f43877bc..4e86dc523 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Johannes Schindelin
  */
 #include "builtin.h"
+#include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
@@ -19,31 +20,42 @@ static const char * const builtin_mv_usage[] = {
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
-static const char **internal_copy_pathspec(const char *prefix,
-					   const char **pathspec,
-					   int count, unsigned flags)
+static const char **internal_prefix_pathspec(const char *prefix,
+					     const char **pathspec,
+					     int count, unsigned flags)
 {
 	int i;
 	const char **result;
+	int prefixlen = prefix ? strlen(prefix) : 0;
 	ALLOC_ARRAY(result, count + 1);
-	COPY_ARRAY(result, pathspec, count);
-	result[count] = NULL;
+
+	/* Create an intermediate copy of the pathspec based on the flags */
 	for (i = 0; i < count; i++) {
-		int length = strlen(result[i]);
+		int length = strlen(pathspec[i]);
 		int to_copy = length;
+		char *it;
 		while (!(flags & KEEP_TRAILING_SLASH) &&
-		       to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
+		       to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
 			to_copy--;
-		if (to_copy != length || flags & DUP_BASENAME) {
-			char *it = xmemdupz(result[i], to_copy);
-			if (flags & DUP_BASENAME) {
-				result[i] = xstrdup(basename(it));
-				free(it);
-			} else
-				result[i] = it;
+
+		it = xmemdupz(pathspec[i], to_copy);
+		if (flags & DUP_BASENAME) {
+			result[i] = xstrdup(basename(it));
+			free(it);
+		} else {
+			result[i] = it;
 		}
 	}
-	return get_pathspec(prefix, result);
+	result[count] = NULL;
+
+	/* Prefix the pathspec and free the old intermediate strings */
+	for (i = 0; i < count; i++) {
+		const char *match = prefix_path(prefix, prefixlen, result[i]);
+		free((char *) result[i]);
+		result[i] = match;
+	}
+
+	return result;
 }
 
 static const char *add_slash(const char *path)
@@ -130,7 +142,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	source = internal_copy_pathspec(prefix, argv, argc, 0);
+	source = internal_prefix_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	/*
 	 * Keep trailing slash, needed to let
@@ -140,16 +152,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	flags = KEEP_TRAILING_SLASH;
 	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
 		flags = 0;
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, flags);
+	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die(_("destination '%s' is not a directory"), dest_path[0]);
-- 
2.11.0.390.gc69c2f50cf-goog

