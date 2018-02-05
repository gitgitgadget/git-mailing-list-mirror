Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A08C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBEX6r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:58:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35286 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeBEX6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:39 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so124987pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihUK+1+LcTWjf0CvucyxkhsHfDjkMgPxW4tNgIPx8sE=;
        b=N5buWvU9MMizJX5nDhJ/RpBkbCF6t7lc3mGHpLEgn3nUdpmvS7XtVT77Ed9r+157gQ
         S+8G09YDH9k977qmIg7BMsCqs8cvbFA+x+iqWpDEugWL7VIlllbMBLBSBrZqQTDkHj5c
         HJ2RgWNN0VBnCdkaJX4TbsDTTupg+ogq4BBmZ5UR1V73EuKzSEllwGViKtZbCDFej4GA
         e+Ex5J+vkOou2/tzoOi7IxAI6JWMx6HS83CZDMHiROt9GA5nqoKEh9nX0gaduAu7cWF4
         Zwph/1FqrF15dYpyU4ng8XBDoJ4MS5b0zUC69dsRMRAiSeU45tRZjhaLes/5yMlS/FCB
         aB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihUK+1+LcTWjf0CvucyxkhsHfDjkMgPxW4tNgIPx8sE=;
        b=gjovWEr+t+pyua5omuub8TJs60uhsAVNNv2cbX5vliA5WwoiWljitmLmFqib+/69yu
         6lQLOd3L44EyNtaEz5eE94VhRT1Mdujkn1vHcQtAMpmd3cRUWc66deVSm7v24Lyy5UU5
         eQDvM8sy/zL1K79r2NNCRDiLzCYSnC7Ca5Jlb8n9nVe3zxSsKzcrMq38cSb+cGkdxSn9
         NM4n9wiiY9QTz7lz2V3QzxQ2TM8cWOg/PzIYUCKEnyHCTtWkttTqOomcxymUmUvb6pI7
         rHTqdYR368hm1ahJbshuXNp7kBTi5y1n5/qsreyPqUIwg2TvwCsf3j05f1n481m1hmNq
         0Uvw==
X-Gm-Message-State: APf1xPAbJZM+895Z/B29r4/FshWaMZCCiMLmLWc6oNm6TNUpdGzH/p/r
        aLXfWkXX2XU85T3waXlQVgvgyLa6y1c=
X-Google-Smtp-Source: AH8x226MQIlOJ7p7tqJ/ObiK2SoCeZvAWkTSP80sOU0+2ZCD1KAtvH79prGB0tVCveJ3dOa5ItNM/g==
X-Received: by 10.98.223.80 with SMTP id u77mr501570pfg.186.1517875118633;
        Mon, 05 Feb 2018 15:58:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o2sm14857023pgq.87.2018.02.05.15.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:58:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 025/194] object-store: allow prepare_alt_odb to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:46 -0800
Message-Id: <20180205235735.216710-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        |  4 ++++
 object-store.h |  3 +--
 sha1_file.c    | 63 ++++++++++++++++++++++++++++++----------------------------
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/cache.h b/cache.h
index 051a77c49a..ce309cfe3f 100644
--- a/cache.h
+++ b/cache.h
@@ -1581,6 +1581,10 @@ struct alternate_object_database {
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
 
+	/*
+	 * Path to the alternate object database, relative to the
+	 * current working directory.
+	 */
 	char path[FLEX_ARRAY];
 };
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
diff --git a/object-store.h b/object-store.h
index 92fbf4a9ca..fcf36c7370 100644
--- a/object-store.h
+++ b/object-store.h
@@ -65,8 +65,7 @@ extern const char *sha1_file_name_the_repository(const unsigned char *sha1);
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
-#define prepare_alt_odb(r) prepare_alt_odb_##r()
-extern void prepare_alt_odb_the_repository(void);
+extern void prepare_alt_odb(struct repository *r);
 
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 #define foreach_alt_odb(r, fn, cb) foreach_alt_odb_##r(fn, cb)
diff --git a/sha1_file.c b/sha1_file.c
index c639c52f5f..be67c69c75 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -396,11 +396,10 @@ static int alt_odb_usable(struct repository *r, struct strbuf *path,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
-static void read_info_alternates_the_repository(const char *relative_base,
-						int depth);
-#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
-static int link_alt_odb_entry_the_repository(const char *entry,
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth);
+static int link_alt_odb_entry(struct repository *r, const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
@@ -426,7 +425,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(the_repository, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(r, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -434,12 +433,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*the_repository->objects.alt_odb_tail = ent;
-	the_repository->objects.alt_odb_tail = &(ent->next);
+	*r->objects.alt_odb_tail = ent;
+	r->objects.alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
+	read_info_alternates(r, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -474,12 +473,8 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-#define link_alt_odb_entries(r, a, s, rb, d) \
-	link_alt_odb_entries_##r(a, s, rb, d)
-static void link_alt_odb_entries_the_repository(const char *alt,
-						int sep,
-						const char *relative_base,
-						int depth)
+static void link_alt_odb_entries(struct repository *r, const char *alt,
+				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -493,7 +488,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -502,15 +497,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(the_repository, entry.buf,
+		link_alt_odb_entry(r, entry.buf,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates_the_repository(const char *relative_base,
-						int depth)
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -522,7 +518,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -683,21 +679,28 @@ int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
-	const char *alt;
-
-	if (the_repository->objects.alt_odb_tail)
+	if (r->objects.alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+
+	if (!r->ignore_env) {
+		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+		if (!alt)
+			alt = "";
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, alt,
-			     PATH_SEP, NULL, 0);
+		/*
+		 * Paths in alt are relative to the cwd. We ignore environment
+		 * settings like this for all repositories except for
+		 * the_repository, so we don't have to worry about transforming
+		 * the path to be relative to another repository.
+		 */
+		link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
+	}
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.15.1.433.g936d1b9894.dirty

