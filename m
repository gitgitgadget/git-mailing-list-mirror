Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318E9C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D8D6198F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhC1C64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhC1C6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660DC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so9361656wrs.9
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOq9FV++O0UITKdmyvFvJ23AE8rg9PQF3PXsYJ/CdCo=;
        b=W96MJDC/5pATOnbczbEXNSb2SHkkDISi5fqwWxX87dM1SOwMkC6fFq4EpcbSvBT5xn
         QTgJglLmW8dqNgCOG18+1297OA5IGSiyP99oC3QVgUd60woOTnu9ALRjopCslVY2omf1
         X+FpjkoukvDAZJHFgDxh5Mb/VipoI9iesgAl8z7vIY9J7Yw9E06ktuUB0dnR3sp6/Qvx
         Y5LAXV3woUnhyCATgVoG7Eq+XphzWSmyKBeyIbSrnImgiV8pyF4D69cFBiP1MK4uOBk7
         gz9hKYKoPae4py/f/gJET+OCw87tNz69ip2ASnzY2YGO+uFg3zJdKDB9ypcv1xSQAtlE
         iWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOq9FV++O0UITKdmyvFvJ23AE8rg9PQF3PXsYJ/CdCo=;
        b=AVXri91xaBXGRZjqQHCOt//HfmgNV362x0lCXrT47nrLLNclrTyZcGaj+BITjoK3Il
         E9aFfo1kz9S2TB9f/Sic05WzeyjsCJJCgJlEvND/41gnvaHIYMrrelD4TAdxwJ6q7a/v
         RJ6Bn9/CmpA7slVqrrPGXR2WQSMENCQ+NdNJ1loHj0XdyZjI6Ibi7aVXP4ALryefvrcK
         lo0BNlDRlOPy5EDvO9z2y9uEMQ4KAfattf6TVmXVIgaT2vhceN2QC80rv9C9P2P1oHza
         6VnOG2Givn4l3TTrpYjmrWSqa+Hc6HGFSoCuIV6kF03BDCu1xdGI5kZq7my+uedfFFuh
         HjAg==
X-Gm-Message-State: AOAM532MfVaV89LQCe8WCMXI3ejerhRevQTsZg+DejioOlc+aSHcrReb
        HD9tdrZbiiM+691fcgRqqhAH4myfKTSz+Q==
X-Google-Smtp-Source: ABdhPJztu/40gQotE1x8tCmDrcZSw94caeBJrI7ZZk+5oh5IK25p7pKa6tj1295KNhpNSsG1MzuQAw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr21891177wrn.346.1616900319458;
        Sat, 27 Mar 2021 19:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] fsck: improve the error on invalid object types
Date:   Sun, 28 Mar 2021 04:58:32 +0200
Message-Id: <patch-4.6-d23fb5cd039-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com> <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
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
index d92c530863d..c8ab14d1545 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -601,12 +601,26 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
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
index ab86c8bf32c..786c5c34704 100644
--- a/object-store.h
+++ b/object-store.h
@@ -241,11 +241,11 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
  *
  * Returns 0 on success, negative on error (details may be written to stderr).
  */
+struct object_info;
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags);
 
 /* Retry packed storage after checking packed and loose storage */
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
2.31.1.445.g91d8e479b0a

