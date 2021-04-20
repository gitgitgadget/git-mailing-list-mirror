Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471EBC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09297613CF
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhDTNBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhDTNBH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DEC06138D
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k128so20103871wmk.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5IR85Zbhk3RxGB4qf7GIQlLLpRfIwXG3f59kPTx4fM=;
        b=Qg2nVr2kWvheAd52kQcN98g6Iu5OyfGi8GwbA5Y+RY2cY5t4CIjypeQPhIC7T4b1O5
         63tfUnxitac4O9hcrjdIi09uFwKiD+y2HU5V2hl6Pr1vwWOz2TqRU2gM0dtT24edi5pn
         SDdhDtvb6Msbz7Uh2WSOeB0/okzMHXmSwcRihVifR393eVJQH5sg2lxUSZ/ZCkiNQW0t
         Q9fXMxOzvUeMvZivIRDIaASR2rRKZWem6OcYLvV+fTrD3DOJEEwT64VvAhevKsGSW5fB
         AVIXi1JNMWVtWz3CfXG6bcXOxenk74Nmh7dOqpzvm0CYcBwvys3oRjz+Vb71IvehN2TN
         4wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5IR85Zbhk3RxGB4qf7GIQlLLpRfIwXG3f59kPTx4fM=;
        b=eMgMOzFKI3IL1LcFGjYCZ90Sih+0v4Y4+I9n3f26gunL8kAMJ3FiBQEHn82834CSjB
         TdzMsjHIABLLB9sySgb8DUxqj5EOfByEH4OpicJboY/kB1JsGwq5bRIk0z9j0/gFoVun
         iYjfNo5d9O/jTcID4pRWkylUNWpVnUBtyZYcjl5jDjkWBklVdZ17TGl+g6hvIT6k8AWN
         bUYKE1hJ4upCzv1h/0Mj3kR6EnxvjBiuXgyoqJA1GP54h6QmfNODCKzN1TSyNJ+8MTHe
         4Lv4hcE8XhDiMqDDSYICAS2Fb7wevHt8u3r5jz79HOKGYhvAcmqcYi/rqYL6vp42si3+
         JbjQ==
X-Gm-Message-State: AOAM531BqM327f/1lr6bqRVXy0B5eOJO6aK5K+mR9WDLiMrszAbLKGFy
        d5120FpH2PaSs24TlaH6PB/bSg4976luTg==
X-Google-Smtp-Source: ABdhPJyLLK7TnFPNDIn0HE6gfpkO2S2L1iRzyWTYD7ZKfQHnouG0yKVNjQZ4XgSLMngoDoxmckP12w==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr4463455wmc.114.1618923634120;
        Tue, 20 Apr 2021 06:00:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] hash-object: pass along type length to object.c
Date:   Tue, 20 Apr 2021 15:00:13 +0200
Message-Id: <patch-07.10-a5ac9f1dd8-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the functions to do with passing the type down to
hash_object_file_literally() to pass the length of the type as well as
the "const char *" type name.

The immediate motivation for this is to move hash-object.c over to
type_from_string_gently() to emit a better error message, but it will
also allow us in the future to craft an invalid object with a "\0" in
the type name.

We'd need to learn a --type-file=* option or similar (we can't of
course, pass a string with "\0" on the command-line). Right now such
an object can be manually crafted, but we can't test for it with
--literally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c | 31 +++++++++++++++++--------------
 object-file.c         | 26 +++++++++++++++-----------
 object-store.h        |  4 ++--
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 640ef4ded5..4d3b8c49d2 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -25,14 +25,14 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
-						 flags);
+		ret = hash_object_file_literally(buf.buf, buf.len, type,
+						 strlen(type), oid, flags);
 	strbuf_release(&buf);
 	return ret;
 }
 
-static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
-		    int literally)
+static void hash_fd(int fd, const char *type, size_t type_len,
+		    const char *path, unsigned flags, int literally)
 {
 	struct stat st;
 	struct object_id oid;
@@ -49,31 +49,32 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
-static void hash_object(const char *path, const char *type, const char *vpath,
-			unsigned flags, int literally)
+static void hash_object(const char *path, const char *type, size_t type_len,
+			const char *vpath, unsigned flags, int literally)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, vpath, flags, literally);
+	hash_fd(fd, type, type_len, vpath, flags, literally);
 }
 
-static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
-			     int literally)
+static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
+			     unsigned flags, int literally)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
+		const char *vpath;
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&unquoted);
 			if (unquote_c_style(&unquoted, buf.buf, NULL))
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally);
+		vpath = no_filters ? NULL : buf.buf;
+		hash_object(buf.buf, type, type_len, vpath , flags, literally);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -87,6 +88,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	const char *type = blob_type;
+	size_t type_len;
 	int hashstdin = 0;
 	int stdin_paths = 0;
 	int no_filters = 0;
@@ -141,8 +143,9 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		usage_with_options(hash_object_usage, hash_object_options);
 	}
 
+	type_len = strlen(type);
 	if (hashstdin)
-		hash_fd(0, type, vpath, flags, literally);
+		hash_fd(0, type, type_len, vpath, flags, literally);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -150,13 +153,13 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
-		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
+		hash_object(arg, type, type_len, no_filters ? NULL : vpath ? vpath : arg,
 			    flags, literally);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags, literally);
+		hash_stdin_paths(type, type_len, no_filters, flags, literally);
 
 	return 0;
 }
diff --git a/object-file.c b/object-file.c
index 398f2b60f9..b27ed57e0b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1715,13 +1715,15 @@ void *read_object_with_reference(struct repository *r,
 
 static void write_object_file_prepare(const struct git_hash_algo *algo,
 				      const void *buf, unsigned long len,
-				      const char *type, struct object_id *oid,
-				      char *hdr, int *hdrlen)
+				      const char *type, size_t type_len,
+				      struct object_id *oid, char *hdr,
+				      int *hdrlen)
 {
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
+	*hdrlen = xsnprintf(hdr, *hdrlen, "%.*s %"PRIuMAX,
+			    (int)type_len, type, (uintmax_t)len) + 1;
 
 	/* Sha1.. */
 	algo->init_fn(&c);
@@ -1786,7 +1788,8 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, strlen(type), oid, hdr,
+				  &hdrlen);
 	return 0;
 }
 
@@ -1940,29 +1943,30 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+	size_t type_len = strlen(type);
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
-				  &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, type_len, oid,
+				  hdr, &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags)
+			       const char *type, size_t type_len,
+			       struct object_id *oid, unsigned flags)
 {
 	char *header;
 	int hdrlen, status = 0;
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
-	hdrlen = strlen(type) + MAX_HEADER_LEN;
+	hdrlen = type_len + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
-				  &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, type_len, oid,
+				  header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
diff --git a/object-store.h b/object-store.h
index eab9674d08..8f043a6069 100644
--- a/object-store.h
+++ b/object-store.h
@@ -220,8 +220,8 @@ int write_object_file(const void *buf, unsigned long len,
 		      const char *type, struct object_id *oid);
 
 int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags);
+			       const char *type, size_t type_len,
+			       struct object_id *oid, unsigned flags);
 
 /*
  * Add an object file to the in-memory object store, without writing it
-- 
2.31.1.723.ga5d7868e4a

