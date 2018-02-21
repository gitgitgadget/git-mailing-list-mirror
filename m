Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648C21F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBUBzI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:08 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45713 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeBUBzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:03 -0500
Received: by mail-pl0-f66.google.com with SMTP id p5so79485plo.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haPKyfmRAsXV2FUmknuviNgtdSKHQmqD6rgy6ysdMKA=;
        b=qQJeEzeWQUdu0q+OOBMpgVOLVEYdRBVF3Ym5RIytubsK+JOJ3VyJjsUyaoKkcS5QQG
         AhCWgBVAKZNTmYyhg6QkeeBpWjpUGJ5wzgMK4DC+rSLDn3FxkY4BI7DeLzcU8Swb8j+w
         xwPSwmba4vCUoyvJrepzh5cIpN/y/o8wVjsTMovqxODk1u2wNgC6x+559mPK0bbbUqwK
         c34LZixxh/NJa44ADZdfi1nOohI6i4bSyZVhIynJnrPkakpshZ9IaubB9mUoTCMhBVSb
         WNpXG0y9X7GByybYotS6o1Khxj5osKODf4KBIzlBG7DezBkEMSHXgIt4Q/sTljQrWSVZ
         KmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=haPKyfmRAsXV2FUmknuviNgtdSKHQmqD6rgy6ysdMKA=;
        b=pcgqFVngqtLPR2PN5ETjc4r9YCMPaNq6anD9zcO2YeomC/Wcbu+GiThuR3hZdH0wYi
         6uYEGmGwjApznfiMMGQvzppx3hX2Lg3BfJi9e9wThnRz09TbKivJkUpHN+1QlROwsUF5
         OibxDJr7uIi+cGP/axE1PRtxY5lRvrqJb7l5fdzrPXXi43lqY7ZENjI8TKGZMibBlLwZ
         H1v/BPjHSn3HonvrEkiVRszvwKrpCXfu+M6lTi+7N1Ub2b5/xCnvbQbvxiuBvE+BmoXS
         ajZDynBEOkFIM/Jn2pcbrK+SjT03n7v/jQ8UismvYGi+4tZJXgoDCVrG261NLnar6pHB
         RX4g==
X-Gm-Message-State: APf1xPBPH8ZLyh2lQ1t+NUl71w3CsSev9k+F+ofwwGq4Pyh0lfBwOkxZ
        rP2meMNhdjQLK9YJtzjHNl1JlQ==
X-Google-Smtp-Source: AH8x225ri9vbZyBDReuEP9s9ZQgDkkxfQVdDqlvS8y8M8dNMkzRyYhv3jTsjJBck4kn5qlVm+blnZg==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10-v6mr1532347plr.223.1519178102504;
        Tue, 20 Feb 2018 17:55:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x4sm27220728pgv.84.2018.02.20.17.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/27] sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:17 -0800
Message-Id: <20180221015430.96054-15-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
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
 object-store.h |  4 ++++
 sha1_file.c    | 36 ++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/object-store.h b/object-store.h
index 514ad94287..f283fbdba9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -18,6 +18,10 @@ struct alternate_object_database {
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
 
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
 	char path[FLEX_ARRAY];
 };
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
diff --git a/sha1_file.c b/sha1_file.c
index c26921df4a..6e5105a252 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,11 +390,10 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -420,7 +419,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -428,12 +427,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
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
@@ -468,12 +467,8 @@ static const char *parse_alt_odb_entry(const char *string,
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
@@ -487,7 +482,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -496,15 +491,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
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
@@ -516,7 +512,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
-- 
2.16.1.291.g4437f3f132-goog

