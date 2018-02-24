Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D571F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeBXAtD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:49:03 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45465 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeBXAsS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:18 -0500
Received: by mail-pl0-f66.google.com with SMTP id v9-v6so3846117plp.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OlfAWs5IrnaX/WUViEJ667+w9zVcilHfoAaJ6/HGcw=;
        b=j9tmhHjEhsuOakrm6PTpMFXb4NtDavMuoLzTte0jjeNApnnbrZPxAgmslsBjQsLv8J
         M0K557Na/mtD/iqomD8OopFs6PiWYlXaoyEEjAshQnPwbOx1v/j2xujE2um/EItKuzOj
         8JSSF2gOqEvOZhQH57H3uD3cCs8hcRLakM/0XCSXlztY+sqOQkVaGDNkACShoeyWTMCg
         ArKsuKdKjF91PghDWtEhbAq0SWP4miR9spNlgkUNY1wOB4uGvHepcYwJ/YvkiRVNGLFl
         mD5NTpVdUThCja50oZO8rlCf98NNP8waERxpmhHprThFhPHjZ8aUu/OmdCyn4uV6YejA
         oIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OlfAWs5IrnaX/WUViEJ667+w9zVcilHfoAaJ6/HGcw=;
        b=Eze2foC1XJhFBv6VLAgGCXjk4MIZcdO3ZosquHl+IOiE6XTLwwV4bvozTf4JIFZrvA
         ydTKcquFZKwQeFGDh9TbmA4tWbF8DVxp4JZ1jTvXikBHWhP+0e0WayOANRwdohwrgq21
         T8nBriqdKV6n8OqXOSJj8OgDS0tIJPQmDDat/lBYNlrtd7vCBWvX2Le7kA8lYMLCVrDK
         VmjPWSZelyN5noeet/IrMW7VApcu76DD9isBwh3lxOvL6Ey6Sv7YP+mVuRMR2HYa0udF
         m7aNRYFzVdOvqPXWJbCD62vaOTmxKjLDJYBNLSG656g74hisMgZWNMokj6/KT6zPxB6w
         2gsA==
X-Gm-Message-State: APf1xPBjykpuE8TINLUO3DI1Djp5dgOgiYQXPJu23wI0cTZ9KvrDwQbH
        9U3C4p/Ob4USeRxCltwpboQ1Aw==
X-Google-Smtp-Source: AH8x224GTRhUHzd183cUjdkS2Dfp6BfOf7D3PS1CDqwZJ0fvsXKxjXbB+A38xfIOdfdeWpPFSNquTg==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20-v6mr3366200plo.74.1519433298031;
        Fri, 23 Feb 2018 16:48:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h16sm7012611pfd.64.2018.02.23.16.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 14/27] sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:41 -0800
Message-Id: <20180224004754.129721-15-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
index 95f328482aa..08cd48ade11 100644
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
index 381eaf8221d..ab42d430b8a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,11 +388,10 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -418,7 +417,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -426,12 +425,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
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
@@ -466,12 +465,8 @@ static const char *parse_alt_odb_entry(const char *string,
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
@@ -485,7 +480,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -494,15 +489,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
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
@@ -514,7 +510,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
-- 
2.16.1.291.g4437f3f132-goog

