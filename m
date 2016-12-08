Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DD91FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbcLHS73 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:29 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33368 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbcLHS71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:27 -0500
Received: by mail-pf0-f174.google.com with SMTP id d2so84840194pfd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rMzGfeahayKesYg50xEtKNJdXCA8T8khYTIXXLAMWYQ=;
        b=TIFemrSoFo/TAXpZ5D3i5L01ZUAXb7GHs7ZFFAHxnoTJqBY6vPbOZvK4cYt215ip/b
         nGGmJ4nclEfTLn8nW950SIcbTeqKyPYJKSDFpa6u/D3HmDswwPKQWuU9SAZtk0Hqhc40
         fRq6tOaEDmNS1ji+wuBpSmgS85Rx2qLcrerocoH2MQn/vVToWETe1L7b2dbZy+b0miCW
         uMxnjLmJ8wZOXrZ2+zMsMxYRWuTMUDcckSJctXJ8RLBNSfi0+JixOIrU8gtXoAebWq91
         tA7e51HMoFlH23F7A0xXbXi36LQgBmDFwmBBM4ETwz+nZQoW875ooer1cEqoTi+TkdNa
         JjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rMzGfeahayKesYg50xEtKNJdXCA8T8khYTIXXLAMWYQ=;
        b=My9cb+bmJN/38wbLIh9dp1D53DLxDWBczjvA9gTDJQrFkfxGHmV7Pa/pQDGGn/pJMp
         Ldopxh6lSmb4xQ8LkerqLT5zvtXW75BdBPVAd8SBvRare+PMa3zudIY7NT6xY/kHXQKe
         IRcbzwR5XC8SBXCxGHZ5r6dKtc4BIaf43qL5unj6UmB2PUa+y4KsfbfLmfSODnN6gCQM
         WAs+DxarMaqMGtLC5bvxfM165ZYc2lUH/7cTbK34LZV1SG52pj4e5B2g3ClYeP2BWNe2
         jrH5GXesiOo8aWCSMvNeWo8/SgsVH2qtaTYmyIZdTj9NeNChxpdL2dsMbNiq+6fZJZOw
         JTUQ==
X-Gm-Message-State: AKaTC00c2PCHiV0VzVG2oZmhS5FHsyyqb0aBdf6DlxZWQzaIewwEOVYXtFwTHxUm29Nyi5OH
X-Received: by 10.99.228.5 with SMTP id a5mr135687075pgi.1.1481223566491;
        Thu, 08 Dec 2016 10:59:26 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:25 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 01/16] mv: remove use of deprecated 'get_pathspec()'
Date:   Thu,  8 Dec 2016 10:58:55 -0800
Message-Id: <1481223550-65277-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index 2f43877..4e86dc5 100644
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
2.8.0.rc3.226.g39d4020

