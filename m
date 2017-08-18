Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4D2208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdHRWVB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:01 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33626 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdHRWU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:56 -0400
Received: by mail-pg0-f43.google.com with SMTP id t3so44139288pgt.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=12krvPgC7+WDHL7GK0w6Owg21m6zU0gpQx2arDtIhBc=;
        b=TEFMK2nDa1CyRDesSvUVaVy/ix+OvaQKKsUCs7Fajd1tvu1JRCvu5sA4QEM4p2sHfe
         TcDgHCy2rzWTE2dkAaHVZ/u2ULpJgzHhKDVsvskeil7ZAYMbcVQQgF+V7o1VqleTduK4
         GpI8rCoK1z5HGrU7A7lo+GHVK2jRV3Zc9XEqB+XjisXQK2EDij2t0uSved5gHex4me5O
         FQy+OMvlVth6MzZhBQdfPPXsLtVvyskkl20AfgfoI1+NV4umv6GHgGsZqzK8pQk7rfuW
         JNnccXrsGyopsvhbdJWgnFmBlEcxuW4lUQNeovdzweqJEa/eLpqZDaQWj4Qrsk2MgZWH
         35oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=12krvPgC7+WDHL7GK0w6Owg21m6zU0gpQx2arDtIhBc=;
        b=PJ+xxPEcLq33y188w99r8LmhKVnww0DgEeeQbhulAdksy91wjmupKaYdFDq/ENbaAZ
         SfHmH/Fu3XI4zkuU8MIxfyYcPV6KcVrnfRIs3QKW686l4nJp/jDiAj/m5Jy/A5GSVAVk
         34G4uIpBs21O0VVgtije2d8bsKJVd+rZVXAy1TJF/856d7pE0daPgyVixNI4H7CTHxHo
         W7o7Vb7fz7SCSA3a4N0QLG75i60JfjjYMspgHslKLqdXAe3vZOs3t9DADNgxP/sxDbtG
         +scVOrN2kbuGqxSK6ePfD6aWkD12vsytQ7wjs/X1X6oaMPalisyQsnWpFTeM1F4d52pZ
         EMSQ==
X-Gm-Message-State: AHYfb5hjoZ6h26TqCsjc4NHt1wW2DQWd2C/iq6zRB4ib2x9C621Sb6LL
        0GtNu6iKkFWqdPdhkS85MA==
X-Received: by 10.84.134.34 with SMTP id 31mr10953038plg.57.1503094855312;
        Fri, 18 Aug 2017 15:20:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 09/23] pack: move add_packed_git()
Date:   Fri, 18 Aug 2017 15:20:24 -0700
Message-Id: <e791430c6a3926bb807a44c034e383e839cd0975.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 connected.c |  1 +
 packfile.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h  |  1 +
 sha1_file.c | 61 -------------------------------------------------------------
 5 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/cache.h b/cache.h
index 0313b0b8d..3625509f9 100644
--- a/cache.h
+++ b/cache.h
@@ -1646,7 +1646,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
 extern int odb_pack_keep(const char *name);
 
 extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
diff --git a/connected.c b/connected.c
index 136c2ac16..3e3f0148c 100644
--- a/connected.c
+++ b/connected.c
@@ -3,6 +3,7 @@
 #include "sigchain.h"
 #include "connected.h"
 #include "transport.h"
+#include "pack.h"
 
 /*
  * If we feed all the commits we want to verify to this command
diff --git a/packfile.c b/packfile.c
index 0c97c3a1a..d1433d8c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -605,3 +605,56 @@ void unuse_pack(struct pack_window **w_cursor)
 		*w_cursor = NULL;
 	}
 }
+
+static void try_to_free_pack_memory(size_t size)
+{
+	release_pack_memory(size);
+}
+
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+{
+	static int have_set_try_to_free_routine;
+	struct stat st;
+	size_t alloc;
+	struct packed_git *p;
+
+	if (!have_set_try_to_free_routine) {
+		have_set_try_to_free_routine = 1;
+		set_try_to_free_routine(try_to_free_pack_memory);
+	}
+
+	/*
+	 * Make sure a corresponding .pack file exists and that
+	 * the index looks sane.
+	 */
+	if (!strip_suffix_mem(path, &path_len, ".idx"))
+		return NULL;
+
+	/*
+	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * the use xsnprintf double-checks that)
+	 */
+	alloc = st_add3(path_len, strlen(".pack"), 1);
+	p = alloc_packed_git(alloc);
+	memcpy(p->pack_name, path, path_len);
+
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
+	if (!access(p->pack_name, F_OK))
+		p->pack_keep = 1;
+
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
+	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
+		free(p);
+		return NULL;
+	}
+
+	/* ok, it looks sane as far as we can check without
+	 * actually mapping the pack file.
+	 */
+	p->pack_size = st.st_size;
+	p->pack_local = local;
+	p->mtime = st.st_mtime;
+	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
+		hashclr(p->sha1);
+	return p;
+}
diff --git a/packfile.h b/packfile.h
index b5db490ab..1e932a49e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -46,6 +46,7 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
+extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 extern void release_pack_memory(size_t);
 
diff --git a/sha1_file.c b/sha1_file.c
index 84d96d0ab..0929fc10e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,67 +718,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-static struct packed_git *alloc_packed_git(int extra)
-{
-	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
-	memset(p, 0, sizeof(*p));
-	p->pack_fd = -1;
-	return p;
-}
-
-static void try_to_free_pack_memory(size_t size)
-{
-	release_pack_memory(size);
-}
-
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
-{
-	static int have_set_try_to_free_routine;
-	struct stat st;
-	size_t alloc;
-	struct packed_git *p;
-
-	if (!have_set_try_to_free_routine) {
-		have_set_try_to_free_routine = 1;
-		set_try_to_free_routine(try_to_free_pack_memory);
-	}
-
-	/*
-	 * Make sure a corresponding .pack file exists and that
-	 * the index looks sane.
-	 */
-	if (!strip_suffix_mem(path, &path_len, ".idx"))
-		return NULL;
-
-	/*
-	 * ".pack" is long enough to hold any suffix we're adding (and
-	 * the use xsnprintf double-checks that)
-	 */
-	alloc = st_add3(path_len, strlen(".pack"), 1);
-	p = alloc_packed_git(alloc);
-	memcpy(p->pack_name, path, path_len);
-
-	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
-	if (!access(p->pack_name, F_OK))
-		p->pack_keep = 1;
-
-	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
-	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
-		free(p);
-		return NULL;
-	}
-
-	/* ok, it looks sane as far as we can check without
-	 * actually mapping the pack file.
-	 */
-	p->pack_size = st.st_size;
-	p->pack_local = local;
-	p->mtime = st.st_mtime;
-	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
-		hashclr(p->sha1);
-	return p;
-}
-
 void install_packed_git(struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
-- 
2.14.1.480.gb18f417b89-goog

