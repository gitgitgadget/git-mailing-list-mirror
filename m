Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1C91FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbcLFVxq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:46 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33614 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so72484540pfd.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B7FYI7EScM9ig3P3iZ+dcm6eMj2/6x9w+56SqOyAOrM=;
        b=LeRYZzx5xllzLkgO7pw/RpdxlImWmg829h5oWm9TLEyouu+2ghfJJorBMBdARY0TwP
         UxLhwb4dn9FUSn13ghDqbifgi2xPxMyeXdVXlaP0q4AVLAkFCAlex4b9sF4/wNsH/CB1
         LIlBtO/dwFRhB89zF/QH6NqMMhvrPfW+5LtZuNEqiCsYX1jMbCfZP2E1MfFDpB3QRJYE
         EKpiLtG0HtYC+0uhELbeSucTxbzNdcHQhDUx14gwNygAiheRBqM8WP73+IOE6gCWuML/
         K2sXCHpWsQ56pO+4URd3wlE9mbDuGmhC5X5hp14+9U+tPOPxmDc+dOYDNoylRcjV6v/N
         m2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B7FYI7EScM9ig3P3iZ+dcm6eMj2/6x9w+56SqOyAOrM=;
        b=bVqi3E2D/W1v1KiaEE2b+NcDLZqXfv2BO8mfQRY3/6KWIeoj8m4koSmE9m7hA1WvQs
         h3Li/4gy5B1+ti7n7siemRYq/A3PEF4yEcJFP+HdnFXvcBdxYjZPExyUeejMvJxkvf9S
         cATr5kqsN673vN6kzeurzmldTyLhxtxxXUrmfvIMkE99TYVMqi9ewTE/vSYKyUFooI6R
         2njDTNoHKyOgSasjtNdWRkfw7prJHDQTfilifAF2liXX8AjCUXgWARGMkytZuzjGZ7kx
         bwCe9vnURF10zxAeanbBM5XpuI5d9Q03jNsUEdccJMXS/AsLjXmoJRyUwdzfpmzOiovj
         GnWA==
X-Gm-Message-State: AKaTC001lqBrTH4ZfshKvBwAFBUKYo9kguOiOE2XDTKrKaG5zSHEuLGIY/Ffcg5uclRWj/Ls
X-Received: by 10.99.127.16 with SMTP id a16mr87496233pgd.60.1481061143670;
        Tue, 06 Dec 2016 13:52:23 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:22 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/17] pathspec: remove the deprecated get_pathspec function
Date:   Tue,  6 Dec 2016 13:51:34 -0800
Message-Id: <1481061106-117775-6-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all callers of the old 'get_pathspec' interface have been
migrated to use the new pathspec struct interface it can be removed
from the codebase.

Since there are no more users of the '_raw' field in the pathspec struct
it can also be removed.  This patch also removes the old functionality
of modifying the const char **argv array that was passed into
parse_pathspec.  Instead the constructed 'match' string (which is a
pathspec element with the prefix prepended) is only stored in its
corresponding pathspec_item entry.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/api-setup.txt |  2 --
 cache.h                               |  1 -
 pathspec.c                            | 42 +++--------------------------------
 pathspec.h                            |  1 -
 4 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/Documentation/technical/api-setup.txt b/Documentation/technical/api-setup.txt
index 540e455..eb1fa98 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -27,8 +27,6 @@ parse_pathspec(). This function takes several arguments:
 
 - prefix and args come from cmd_* functions
 
-get_pathspec() is obsolete and should never be used in new code.
-
 parse_pathspec() helps catch unsupported features and reject them
 politely. At a lower level, different pathspec-related functions may
 not support the same set of features. Such pathspec-sensitive
diff --git a/cache.h b/cache.h
index a50a61a..0f80e01 100644
--- a/cache.h
+++ b/cache.h
@@ -514,7 +514,6 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/pathspec.c b/pathspec.c
index 22ca74a..1f918cb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -103,7 +103,7 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
  */
 static unsigned prefix_pathspec(struct pathspec_item *item,
 				unsigned *p_short_magic,
-				const char **raw, unsigned flags,
+				unsigned flags,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
@@ -240,7 +240,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		if (!match)
 			die(_("%s: '%s' is outside repository"), elt, copyfrom);
 	}
-	*raw = item->match = match;
+	item->match = match;
 	/*
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
@@ -381,8 +381,6 @@ void parse_pathspec(struct pathspec *pathspec,
 
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
-		static const char *raw[2];
-
 		if (flags & PATHSPEC_PREFER_FULL)
 			return;
 
@@ -394,10 +392,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		item->original = prefix;
 		item->nowildcard_len = item->len = strlen(prefix);
 		item->prefix = item->len;
-		raw[0] = prefix;
-		raw[1] = NULL;
 		pathspec->nr = 1;
-		pathspec->_raw = raw;
 		return;
 	}
 
@@ -415,7 +410,6 @@ void parse_pathspec(struct pathspec *pathspec,
 	pathspec->nr = n;
 	ALLOC_ARRAY(pathspec->items, n);
 	item = pathspec->items;
-	pathspec->_raw = argv;
 	prefixlen = prefix ? strlen(prefix) : 0;
 
 	for (i = 0; i < n; i++) {
@@ -423,7 +417,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		entry = argv[i];
 
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
-						argv + i, flags,
+						flags,
 						prefix, prefixlen, entry);
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
@@ -457,36 +451,6 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
 
-/*
- * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
- * based interface - see pathspec.c:parse_pathspec().
- *
- * Arguments:
- *  - prefix - a path relative to the root of the working tree
- *  - pathspec - a list of paths underneath the prefix path
- *
- * Iterates over pathspec, prepending each path with prefix,
- * and return the resulting list.
- *
- * If pathspec is empty, return a singleton list containing prefix.
- *
- * If pathspec and prefix are both empty, return an empty list.
- *
- * This is typically used by built-in commands such as add.c, in order
- * to normalize argv arguments provided to the built-in into a list of
- * paths to process, all relative to the root of the working tree.
- */
-const char **get_pathspec(const char *prefix, const char **pathspec)
-{
-	struct pathspec ps;
-	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC &
-		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
-		       PATHSPEC_PREFER_CWD,
-		       prefix, pathspec);
-	return ps._raw;
-}
-
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst = *src;
diff --git a/pathspec.h b/pathspec.h
index 59809e4..70a592e 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -19,7 +19,6 @@
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
 struct pathspec {
-	const char **_raw; /* get_pathspec() result, not freed by clear_pathspec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
-- 
2.8.0.rc3.226.g39d4020

