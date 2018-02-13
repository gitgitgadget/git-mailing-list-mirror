Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2434C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbeBMBXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:53 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46937 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933215AbeBMBXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:07 -0500
Received: by mail-pl0-f68.google.com with SMTP id x2so1873456plr.13
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Gz7KLzKkeW8I+UXD6iX8mkb+fIDvyHMcc+7cvMNuIo=;
        b=JhQSbFHVPUiC8dXsnGlAX3s4lUgrnOF3af9fDrf3cx1u+/+fjFPoHscghnD0vCYJzB
         +O3TaMNYjK08JlhSDnbgCwvimlt7UA9wwGEYjR+Gdc2lG3xkPMdgiWJJLk6KZ50qUqFU
         mvg86TsIi0ib5toaJoVWA1l2R10E1C1bQCDJWLd0jDl86r/TyMGUa34YgLZw+n0RN8j/
         ABmQe9jotJl9pT9qb9cxm8DanGB5a+I1/hSzV4ENBiKjbNBM4avKFKnt2epjZFHCA8/5
         pS1RvVByvE1xs25SUWKFB5JWRDPB1KbsX4dg6x0kJIAGAe4rpNPqljxzA72a4eWAI6sP
         +y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Gz7KLzKkeW8I+UXD6iX8mkb+fIDvyHMcc+7cvMNuIo=;
        b=HL9mmf+cJI8hncrQh5vt90rkH8lUh2WUZc7vt2D+fOj93dLhvm+OyTIOQW10UznrgP
         hEIoV3f6DfMwIHlkPecL1w2U7bST0p0kxTHG3j+Q/5qxdW0nOchDdrtluDDO1hFz2PYB
         xwuZWXbMsnZJW4SFh9f4Ywpy5DWO+OTBESwcZZDoCYYhM5JE9YaWqL5ez4wlhRN0HqJJ
         e6EV8dP52YhadTX/DeCUMETHIvgXtOEWtMplH48IxD09OlHryW8MOWx2a5vuAb6hgJHP
         tclMw7D9gRPZDJAA6y8hSMss33FBRE8z9wQ/LOVblUah6cqeYay03fKjMvvq6SA7wNhG
         QAQw==
X-Gm-Message-State: APf1xPDNCZviIFwshIaWg/D5O50VU2Cju6K2RUsfh5MjsNIe9zE2w4lp
        GcAx2Q32cQbysD5/G2kI2Al3aQ==
X-Google-Smtp-Source: AH8x227IDRAH2bkt40/6TF83HNav0kBsi2dt1jR6/ZhFrsXGVmetqkrlBoEQb3GOTW2YEzg6ILY7Dw==
X-Received: by 2002:a17:902:860b:: with SMTP id f11-v6mr12598758plo.135.1518484986018;
        Mon, 12 Feb 2018 17:23:06 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 4sm7270961pfn.174.2018.02.12.17.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/26] sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:28 -0800
Message-Id: <20180213012241.187007-14-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually this also allows read_info_alternates and link_alt_odb_entry to
handle arbitrary repositories, but link_alt_odb_entries is the most
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
 sha1_file.c | 36 ++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 70518e24ce..09d37cb651 100644
--- a/cache.h
+++ b/cache.h
@@ -1590,6 +1590,10 @@ struct alternate_object_database {
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
 
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
 	char path[FLEX_ARRAY];
 };
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
diff --git a/sha1_file.c b/sha1_file.c
index d7f271fe6e..d18ce3aeba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -394,11 +394,10 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -424,7 +423,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -432,12 +431,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
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
@@ -472,12 +471,8 @@ static const char *parse_alt_odb_entry(const char *string,
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
@@ -491,7 +486,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -500,15 +495,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
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
@@ -520,7 +516,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
-- 
2.16.1.73.ga2c3e9663f.dirty

