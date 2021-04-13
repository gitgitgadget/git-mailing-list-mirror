Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA0DC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A911F613B6
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhDMJnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhDMJnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D5C06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k128so8353393wmk.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukMFMr4TbJ8Fp4KzwuF0hanKOopit00nN2oydgOjVbQ=;
        b=C1gA29m+aWgrQZZ/V2jPk8aasPsuHCxZxNHFRsxz+S6JQk0S+trvvCYZGg4eJ1njNX
         SMbWPaz6jIw8owcDRTVrCRk9z6toSTyiSxUTijqA7GEoyY3NYfy/fi0bj7sqMRpZaHSr
         rWGplI7enYgkY37BfgsmldhXuMRQDaxUJAcm3G3hXfi9jdYYmXvaqo4qA/D4KgOTW36D
         sV8d3tjjzPNhKSjPKt18zdKof0ttSekC7CuuQcQEpXfLucx9oNc3h1p9YPDnDwLgPCkg
         Oi5jWQZOkRTd51rKVutMBE12hrBjh18hS8Kee5PGyaJkXalzHBi3UPQXzK7dNfrAju+v
         oe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukMFMr4TbJ8Fp4KzwuF0hanKOopit00nN2oydgOjVbQ=;
        b=WQEl1S2z3oqXiCtCZlB+8SNpgmSMWOo8KOMZDAOjAvYNuKwVg2dgSobX+Am6QNiohc
         5pUdMW2huo02vjPVVpQjsT2L7fVVIO8NUNo/k68IU5x/QDcPA+tEi7ouajSD57b2MMPs
         yHgndVRKxudWJd2YorUGVfscCIMdcBjvtrre9ggaapxBQ9RLZCcGcFujtk+dB/kdpKzp
         AF2majnABdhRkUTDzeCB8c/TEaikdjezperdj+PER4Ma4eWQOHnJGmi+fmhZ44A6DelH
         jh2N1x0HKBtweIw7mFBPvqCkw2rzHS4ffTL3EaHQRY7+2wxoKUawp2Z4LYMM/BHuDpEN
         jqVw==
X-Gm-Message-State: AOAM532CDOlGPL6k+wibD8OjLdP4f9lMkD8BgZjfTZUiJiw6hhS6WVXb
        +ZP0E7CVFNmfmvfWMVCX103Mk1ZBgzjuKw==
X-Google-Smtp-Source: ABdhPJw6XNpW6dr+ITppZ81TsfKbJMaeDEiIU0NM7NfLFtZThW/bA3U8KuAwvu9h4oK3xwUuuLpTLQ==
X-Received: by 2002:a05:600c:365a:: with SMTP id y26mr3177488wmq.102.1618307005274;
        Tue, 13 Apr 2021 02:43:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm4622877wrn.49.2021.04.13.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:43:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] fsck: report invalid types recorded in objects
Date:   Tue, 13 Apr 2021 11:43:08 +0200
Message-Id: <patch-5.6-5fb6ac4faee-20210413T093734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the work in the preceding commit and improve the error on:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    $ git fsck
    error: hash mismatch for <OID_PATH> (expected <OID>)
    error: <OID>: object corrupt or missing: <OID_PATH>
    [ other fsck output ]

To instead emit:

    $ git fsck
    error: <OID>: object is of unknown type 'garbage': <OID_PATH>
    [ other fsck output ]

The complaint about a "hash mismatch" was simply an emergent property
of how we'd fall though from read_loose_object() into fsck_loose()
when we didn't get the data we expected. Now we'll correctly note that
the object type is invalid.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c |  7 +++++--
 builtin/fsck.c     | 22 ++++++++++++++++++----
 object-file.c      | 31 +++++++++++++++----------------
 object-store.h     |  4 ++--
 t/t1450-fsck.sh    | 23 ++++++++++++++++++++++-
 5 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..1063576a982 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -74,6 +74,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
 	const char *path = force_path;
+	int ret;
 
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
@@ -92,7 +93,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.type_name = &sb;
-		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
+		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
+		if (!unknown_type && ret < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -103,7 +105,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
+		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
+		if (!unknown_type && ret < 0)
 			die("git cat-file: could not get object info");
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 686f7cdfea0..878191e53ca 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -599,12 +599,26 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	unsigned long size;
 	void *contents;
 	int eaten;
-
-	if (read_loose_object(path, oid, &type, &size, &contents,
-			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
-		errors_found |= ERROR_OBJECT;
+	struct strbuf sb = STRBUF_INIT;
+	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
+	struct object_info oi;
+	int found = 0;
+	oi.type_name = &sb;
+	oi.sizep = &size;
+	oi.typep = &type;
+
+	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
+		found |= ERROR_OBJECT;
 		error(_("%s: object corrupt or missing: %s"),
 		      oid_to_hex(oid), path);
+	}
+	if (type < 0) {
+		found |= ERROR_OBJECT;
+		error(_("%s: object is of unknown type '%s': %s"),
+		      oid_to_hex(oid), sb.buf, path);
+	}
+	if (found) {
+		errors_found |= ERROR_OBJECT;
 		return 0; /* keep checking other objects */
 	}
 
diff --git a/object-file.c b/object-file.c
index 26560a6281c..e744a06637b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1323,9 +1323,7 @@ int parse_loose_header(const char *hdr,
 	 * we're obtaining the type using '--allow-unknown-type'
 	 * option.
 	 */
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
-		type = 0;
-	else if (type < 0)
+	if (type < 0 && !(flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE))
 		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
@@ -1407,14 +1405,17 @@ static int loose_object_info(struct repository *r,
 	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
+	if (status < 0) {
 		; /* Do nothing */
-	else if (hdrbuf.len) {
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
-		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	} else {
+		status = parse_loose_header(hdr, oi, flags);
+		if (status < 0 && !(flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE))
+			error(_("unable to parse %s header"), oid_to_hex(oid));
+	}
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -2488,9 +2489,8 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags)
 {
 	int ret = -1;
@@ -2498,8 +2498,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	struct object_info oi = OBJECT_INFO_INIT;
-	oi.sizep = size;
+	enum object_type *type = oi->typep;
+	unsigned long *size = oi->sizep;
 
 	*contents = NULL;
 
@@ -2514,9 +2514,9 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, &oi, oi_flags);
-	if (*type < 0) {
-		error(_("unable to parse header of %s"), path);
+	*type = parse_loose_header(hdr, oi, oi_flags);
+	if (*type < 0 && !(oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
+		error(_("unable to parse header %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
@@ -2532,8 +2532,7 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size,
-					   type_name(*type))) {
+					   *contents, *size, oi->type_name->buf)) {
 			error(_("hash mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
diff --git a/object-store.h b/object-store.h
index 4680dc68ee4..3d88b8a7cd3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -376,6 +376,7 @@ int oid_object_info_extended(struct repository *r,
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
@@ -383,9 +384,8 @@ int oid_object_info_extended(struct repository *r,
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags);
 
 /*
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 025dd1b491a..214278e134a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -66,6 +66,25 @@ test_expect_success 'object with hash mismatch' '
 	)
 '
 
+test_expect_success 'object with hash and type mismatch' '
+	test_create_repo hash-type-mismatch &&
+	(
+		cd hash-type-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv .git/objects/$old .git/objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+		test_must_fail git fsck 2>out &&
+		grep "^error: hash mismatch for " out &&
+		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
@@ -868,7 +887,9 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
 	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
 	test_must_fail git -C garbage-type fsck >out 2>err &&
-	grep "$garbage_blob: object corrupt or missing:" err &&
+	grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
+	grep error: err >err.errors &&
+	test_line_count = 1 err.errors &&
 	grep "dangling blob $empty_blob" out
 '
 
-- 
2.31.1.645.g989d83ea6a6

