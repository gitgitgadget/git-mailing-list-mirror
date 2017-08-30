Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D11208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdH3HKk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:10:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35588 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3HKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:10:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id r133so4490754pgr.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sndG4RzzHjIb2U5HIyioPTRL4BCakUtTN/4puRm+efI=;
        b=AENdnPr7IisiPqOC7HhsVy0DVNueFpU6zajGb6ICgv6P2QFQalFZW9csHZsz/ho6mC
         L/Q2jJVBtq6oIi56lLLccrIe+iLH+Lvz/aBPvBkmM8wfESZsVA19bngjsfWbeAJ56vxV
         vN+4T54pqxC9K1+lkhJgq1NkQAaW+veQAQ1WjI/kEnsPrQX8/VUNb5y/gBP8Mk6NSPpX
         1Gso+/qW2sK+Rj2yOytqlnrS8h5bJJMKQmchsXbJ3dpqtBzqpdcz3Hdk72NGg6g32srS
         fgWD/9QqDnp7hdw/tfSC/0Wgp0yHmnFKdTGp6F84eWQLpsywhHfGJOLBk6OrX/Ysu07u
         L3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sndG4RzzHjIb2U5HIyioPTRL4BCakUtTN/4puRm+efI=;
        b=NkcvTF8RVSjF9MoGNaOi5yezakzvO0vLAcUa2ED2L4AxnTEzYizdfI2f3xVusHSNvQ
         PHRPyjh+tzhXS1JfzqpQGqiMJZFwFak47/XOmHJkDWaXGmoVVKkrwmCiGa4TtHfTGPsr
         nZGdaJftLbicaHEGvrrcwc9W4pNZeKucmuGCxVOsmKAY2zVOVujOI61PSjaWSUEyVF6s
         w/Yyx60DlQLw5Djf+suw8BloJ0jIxrc0NADRMIYehD301xterS2J0gJJREK+yxP364lg
         /q+/tm82X9JNE1FTkQcSdWj8EXa9/W8DjvPqslnLci7PhqSZGRWrGDp8SkNyU6BZsp/r
         tkfA==
X-Gm-Message-State: AHYfb5go75ilVBxnwfJEFyhCHZIATE+TV9DFET/dYHYczseIlS4/jS0h
        RKdKb8gQHaIQyzwWUW4=
X-Received: by 10.84.194.228 with SMTP id h91mr747167pld.413.1504077038776;
        Wed, 30 Aug 2017 00:10:38 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id g68sm8390472pfj.33.2017.08.30.00.10.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:10:38 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:10:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 26/39] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
Message-ID: <20170830071036.GA153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h        |  4 ++++
 object-store.h |  3 +--
 sha1_file.c    | 65 ++++++++++++++++++++++++++++++----------------------------
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/cache.h b/cache.h
index 454cfb50c4..d204048d3d 100644
--- a/cache.h
+++ b/cache.h
@@ -1512,6 +1512,10 @@ struct alternate_object_database {
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
index b854cad970..452c8f0bbd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -326,11 +326,10 @@ static int alt_odb_usable(struct repository *r, struct strbuf *path,
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
@@ -356,7 +355,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(the_repository, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(r, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -364,12 +363,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
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
@@ -404,12 +403,8 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-#define link_alt_odb_entries(r, a, l, s, rb, d) \
-	link_alt_odb_entries_##r(a, l, s, rb, d)
-static void link_alt_odb_entries_the_repository(const char *alt, int len,
-						int sep,
-						const char *relative_base,
-						int depth)
+static void link_alt_odb_entries(struct repository *r, const char *alt, int len,
+				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -420,7 +415,7 @@ static void link_alt_odb_entries_the_repository(const char *alt, int len,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -429,15 +424,16 @@ static void link_alt_odb_entries_the_repository(const char *alt, int len,
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
 	char *map;
 	size_t mapsz;
@@ -458,7 +454,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	link_alt_odb_entries(the_repository, map, mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(r, map, mapsz, '\n', relative_base, depth);
 
 	munmap(map, mapsz);
 }
@@ -622,22 +618,29 @@ int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
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
 
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-	if (!alt) alt = "";
-
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, alt, strlen(alt),
-			     PATH_SEP, NULL, 0);
+	if (!r->ignore_env) {
+		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+		if (!alt)
+			alt = "";
+
+		/*
+		 * Paths in alt are relative to the cwd. We ignore environment
+		 * settings like this for all repositories except for
+		 * the_repository, so we don't have to worry about transforming
+		 * the path to be relative to another repository.
+		 */
+		link_alt_odb_entries(r, alt, strlen(alt),
+				     PATH_SEP, NULL, 0);
+	}
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.14.1.581.gf28d330327

