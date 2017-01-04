Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E32B20756
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761462AbdADSFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:38 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32913 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761454AbdADSE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:27 -0500
Received: by mail-pg0-f46.google.com with SMTP id g1so190658822pgn.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQCKHwzfZUmwqbzfquvI1DRBeK+kOho4jQjlo7Pc2ik=;
        b=CbJlIq2UZXGNAhf91Q3q7d/+CRB8ET58beqk3Z60Vm54mpKYd3gB1XljJfQ9V1L5K5
         LvybIpK9uF6CEJ/5fAniOjLA7gdtkFxh9rk5FwbbsBB2QI4hjVRGJd9ItLTKcczpv0KS
         Jr1zPNhiDVLiaCzzsW6/F18sqYNVCuDC4zX3u6w4OgOOTZQq++HMB8Vyn5+TFMGyB7hi
         /tUIqjYm1SDF0wnwa2YUdgMBXjTVDS5UeQAwk/bMavTT/u4AyMT/9SpcwupMCaFeGHeE
         XrGJiJdUVb96sFf/rXy/EGtutTAampsgZP00U6OId62i19M5g8MyvQ+Ugsh2r6VOW8m4
         QCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQCKHwzfZUmwqbzfquvI1DRBeK+kOho4jQjlo7Pc2ik=;
        b=uX4kofzdOeXph1TgFB+QG6jmYg6NtuCr4OPhjPa0kPHKPkVz3HDNb0iENcht0jKAi7
         bxYEz0ZzRaEjg4GTZOXrzgy+O5dCVdQoyksCGTFq9H9qvuzK0h20cPGeoQkqpv5LV0cl
         r2LAgJZ0BF5I+6aJ9vj1YO8+9wiJWDnbWcymwRpUxjDXdhwsZR24SqO36xpI24dPvkbE
         kBw99ldq+zCbgawN62fvAhKfKG8/5O73nIWOg47GojSVRoHzvRBCOE7Sy1jlJGZ68wpY
         Xzs7KfjenGFpKMsIqjl/uSdxI0muA0QKRetiNZL2RJaUel+W9sBSiW5WUJpaw9l4Mby5
         qDIg==
X-Gm-Message-State: AIkVDXLur2/SmVQZ0Q9GSwfl62RN8ENZlHoCVLz0F+ZqThd+TYmnw44Hr26GnCXYB8qh0ecC
X-Received: by 10.84.217.216 with SMTP id d24mr147644151plj.101.1483553066569;
        Wed, 04 Jan 2017 10:04:26 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:25 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 05/16] pathspec: remove the deprecated get_pathspec function
Date:   Wed,  4 Jan 2017 10:04:00 -0800
Message-Id: <20170104180411.150000-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index 540e45568..eb1fa9853 100644
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
index a50a61a19..0f80e01bd 100644
--- a/cache.h
+++ b/cache.h
@@ -514,7 +514,6 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/pathspec.c b/pathspec.c
index 22ca74a12..1f918cbae 100644
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
index 59809e479..70a592e91 100644
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
2.11.0.390.gc69c2f50cf-goog

