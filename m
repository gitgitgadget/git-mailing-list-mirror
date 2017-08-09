Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F8D20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbdHIBYE (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:24:04 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32921 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdHIBXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id h68so21349779pfk.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0Jn16nkxQEFmkqYYryRrFsO2l0FHMiAjFZqLNdmAB/E=;
        b=sXyEwipAA4vPk0XMLf/sYoKf/X16XhFe+GcaVLlBDR3g98engjRXXnGn1t0Rhhf7Rh
         VyHe+peVWInjqs+zDzumMaKOhnT2yqB0oUqNJ40owyc6tw0z+scQMVpisYof11RJqFNr
         RxWBbSBzfmcosddFt3QiwuDxgxMUB58b9eMMEcAtWDkui0CwNfyDS4Si5V7aPEP5/sU3
         uzQ/YarVtd0HEkMmkpOHuwBP63/eqPK49Y+sDJRe7K2AWDyoFg/C/bdWQGsDDDT011p9
         G9KyWmPoJCjscYG+1aPcrUqmuJrt88uj0Fo4N3ggcBz5HWm66imIojrn3lDAedlPb94P
         qGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0Jn16nkxQEFmkqYYryRrFsO2l0FHMiAjFZqLNdmAB/E=;
        b=h2Zp9eLDcluPhhHqIjF06pfY1VEfXf2/6EoUswATEnhcxAMhKzUjVOQYy6vyuZJq6V
         xLbV218Nx4G1tTw6AJ6ZxyZ+wmtSzYyk/TTTqi+UjRVbhpCT51g9jdlgdJLE1Jl1FCbF
         BVsXVipOBgEP6zc5HfayAFNhxQH5ZevSDSEWQdSzA/1BMGo5z1iGoJ+f0g3T3JE6vhmA
         csOtjVOWG78X9pObT7ozI5n2xtvgBcFiVTmePE3aP2IJ3KqM3CQwMlOh2Q7joQMbf158
         Inx4rE4WUDp5NLt2uakH4hgzLUEupPczzuUb+xJQ3zqYyE1ZAGXanV2Hhm/CiB/8Yknp
         WXTg==
X-Gm-Message-State: AHYfb5j3ljcmD+kYnondMrOSlwspWXwzRQxymQi87NhAWYc/7kX5SOVn
        FmwTtqBjwSdz2tWbyMHEwg==
X-Received: by 10.98.1.9 with SMTP id 9mr6355741pfb.223.1502241792776;
        Tue, 08 Aug 2017 18:23:12 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:11 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 09/25] pack: move add_packed_git()
Date:   Tue,  8 Aug 2017 18:22:41 -0700
Message-Id: <c5c1c653bde97f5488e0595a51776ced35ea272b.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 connected.c |  1 +
 pack.h      |  1 +
 packfile.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 61 -------------------------------------------------------------
 5 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/cache.h b/cache.h
index 4812f3a63..bf93477e8 100644
--- a/cache.h
+++ b/cache.h
@@ -1638,7 +1638,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
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
diff --git a/pack.h b/pack.h
index 3876e9ae6..c1f3ff32d 100644
--- a/pack.h
+++ b/pack.h
@@ -150,5 +150,6 @@ extern int open_packed_git(struct packed_git *p);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void unuse_pack(struct pack_window **);
+extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 93526ea7b..efe0ed3e8 100644
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
diff --git a/sha1_file.c b/sha1_file.c
index 12501ef06..7f12b1ee0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,67 +717,6 @@ void *xmmap(void *start, size_t length,
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
2.14.0.434.g98096fd7a8-goog

