Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195B61F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162392AbeBPRqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:51 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37865 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162383AbeBPRqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:48 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so2054362plb.4
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DW77hXZQUG9Y8NMVuAuBCXzZ9NXiZ+O39IObgU6kBGc=;
        b=mfG7hAmRgeXkFlL5oUpe6l/p2/Vb7SVnbI+U120dvSeHQCb68y2wMP/gmqDUzgcJsM
         J+gSYyzUMGi9YVrE+qPdDBu/HbIfkLcCiDWBMDHllYUSkLErlHKQ3hZfdUTUgm0Yqt5d
         k7yes80kMZMsgSWcCathiZqZoZPMeYPPxF5HlIvekjs46UAdjNSHDunvaPKz73a1/YgK
         RiAA+SZSBDL0OozDXzagMlbkL4bVvB3HLi9HY+HX0Nlvvs1Xl2amcbFTLBEzz1/ETzaM
         8+LyRyWLToC/kZvgbFCo2zIDNGL19YfLn4grwX8vhk2HXz6g70RG+OZ7peThZmq8CyEa
         3Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DW77hXZQUG9Y8NMVuAuBCXzZ9NXiZ+O39IObgU6kBGc=;
        b=Uyxth8lA2t3osNlIYqfPvDLC0P/qglv4+ht8fR98GKJY1ElzcWsl2DPMCREEODkG0n
         WU1nSYNRw/YqeKVHvV1USPp87dgQTZeDdRxktliE7xzuPSeejF53EscRDLkM1pWNJlXi
         n8A47TGK6c85mTKhiuvGug4q6+WGX4LwydAk0MbneIPksxdPNrZF3/BnrQr0HvYTV9yT
         SIRsHhHH0FRWG2Vsok7u2oqNrX4O2bavmBoyLv/CafSoHAOqVnUdMqc3slKGBa5Q7ngU
         Vzcx8+141Fk+06Gg+I7FGwQI2+bZ9FcTjmUDex69z72NUIrm2+dD++OYZfzapsmyzgPA
         4iQA==
X-Gm-Message-State: APf1xPB3mzQmtBe3Wi8is7qRzN0XHhGd9eIOIQGD4mv9ZupTnuWZ0KOp
        6JQ8AgpwbVE6q+R5M2XE9hDfZw==
X-Google-Smtp-Source: AH8x2259SN5Or6R2VOHjdwtV4c93uWtFlbPJYrGJ4wMV94KAxr3ZeoI5ha7gY0jCsqRD9J8Rp4FYxw==
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13-v6mr6670561plr.215.1518803207540;
        Fri, 16 Feb 2018 09:46:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n7sm39202787pgd.28.2018.02.16.09.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/16] sha1_file: allow link_alt_odb_entries to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:19 -0800
Message-Id: <20180216174626.24677-10-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually this also allows read_info_alternates and link_alt_odb_entry to
handle arbitrary object stores, but link_alt_odb_entries is the most
interesting function in this set of functions, hence the commit subject.

These functions span a strongly connected component in the function
graph, i.e. the recursive call chain might look like

  -> link_alt_odb_entries
    -> link_alt_odb_entry
      -> read_info_alternates
        -> link_alt_odb_entries

That is why we need to convert all these functions at the same time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h     |  4 ++++
 sha1_file.c | 42 +++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index 018a297e10..12bb42f951 100644
--- a/cache.h
+++ b/cache.h
@@ -1593,6 +1593,10 @@ struct alternate_object_database {
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
 
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
 	char path[FLEX_ARRAY];
 };
 extern void prepare_alt_odb(void);
diff --git a/sha1_file.c b/sha1_file.c
index a8e23bd2f8..c4255a2da6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -389,9 +389,11 @@ static int alt_odb_usable(struct raw_object_store *o,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+static void read_info_alternates(struct raw_object_store *o,
+				 const char *relative_base,
+				 int depth);
+static int link_alt_odb_entry(struct raw_object_store *o, const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -416,7 +418,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(o, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -424,12 +426,12 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*the_repository->objects.alt_odb_tail = ent;
-	the_repository->objects.alt_odb_tail = &(ent->next);
+	*o->alt_odb_tail = ent;
+	o->alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(o, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -464,8 +466,8 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+static void link_alt_odb_entries(struct raw_object_store *o, const char *alt,
+				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -479,7 +481,7 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, o->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -488,13 +490,16 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(o, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates(struct raw_object_store *o,
+				 const char *relative_base,
+				 int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -506,7 +511,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(o, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -560,7 +565,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(&the_repository->objects, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -573,7 +579,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(&the_repository->objects, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -676,9 +683,10 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(&the_repository->objects, alt,
+			     PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(&the_repository->objects, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.291.g4437f3f132-goog

