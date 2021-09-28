Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBC5C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3120E61266
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbhI1CVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbhI1CU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DFC06177F
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so1501175wme.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UGB+LJv0lA4yyi5RP+Vv9G3QlWK9EHxD2pmw37V0oE=;
        b=XX6bNeqbpcDD8YlhmU7s9lthSpQV8aZ26i9BjxbEDRSAfLRX6CvMEtzH7UgzpWsFYS
         0txsj2XuHEIANnFKUP6ZbUqbmasAbKeRXcuvKTGmBNEpEVTljsYWrXGkIBhqTgh65ex6
         zJSb4OMICuPC+1M6XgJKvPRsTyIutzNv5slhscfRmwnt3rRgGQC6o5oZAYsTRMvoM1Vn
         Qnu4FOMuMHq4v7SwykGAS5t9NP5i04tLe548VJQrZcQpAXTfOIknoA4oMyHOEs4exS6c
         PNMaZcpvmVFHRa3Kur0GIf8ZOY7G1st7UU+l/S35tM0GHPxnUxUEy4PaPB5iCs2bHzJj
         sV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UGB+LJv0lA4yyi5RP+Vv9G3QlWK9EHxD2pmw37V0oE=;
        b=KUnRFRv2PuL+ZsO4DsmdeDGeaIlEtBlenLvujpGG0S8G+EPQtnPMa57cv++7Ljm0Y5
         /En4bDw+bEox05uzwvSfwObToQUMHjRnnyuToRdvjZoV3MbvLDIn7l4VXVFReSI2ExWv
         RIRtgQ1tb6BH3ifEWl+cktuyC+GOwg8ToRQDUXo7woHvP4mLOQSnAjD7IC9/l5QlUiQT
         q016Jex6ZYIvk1t3fowZZpoVCKKk+kXI2C12ccBVoPXtntdAjOHT+tvpKIH9H874dg90
         hu7IMQ7gqsG6nTMEVaWS/9yUDs+KBX2oF0UK2xe3h4h4DQvWONfMhk7jUms4TYsNbux7
         9Qdg==
X-Gm-Message-State: AOAM531VGkLu1x/STVBIfg7SOAtSJfLKUr/duGaoAR4bM5XnJIFbq2/D
        KgkutQfzYYYbPIvNWkuA+eOz4tNIpKbd2A==
X-Google-Smtp-Source: ABdhPJzfO7mCv0P5n5qT4Un75+NCPFWGjtmLtSGFY8TQyZDtg4x3XoaFMZN32xclo1DnmbyyETCryA==
X-Received: by 2002:a1c:95:: with SMTP id 143mr2232282wma.29.1632795552910;
        Mon, 27 Sep 2021 19:19:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 16/17] fsck: don't hard die on invalid object types
Date:   Tue, 28 Sep 2021 04:18:57 +0200
Message-Id: <patch-v8-16.17-d01223ae322-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error fsck emits on invalid object types, such as:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    <OID>

From the very ungraceful error of:

    $ git fsck
    fatal: invalid object type
    $

To:

    $ git fsck
    error: <OID>: object is of unknown type 'garbage': <OID_PATH>
    [ other fsck output ]

We'll still exit with non-zero, but now we'll finish the rest of the
traversal. The tests that's being added here asserts that we'll still
complain about other fsck issues (e.g. an unrelated dangling blob).

To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
flag from read_loose_object() through to parse_loose_header(). Since
the read_loose_object() function is only used in builtin/fsck.c we can
simply change it to accept a "struct object_info" (which contains the
OBJECT_INFO_ALLOW_UNKNOWN_TYPE in its flags). See
f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
for the introduction of read_loose_object().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  | 17 ++++++++++++++---
 object-file.c   | 18 ++++++------------
 object-store.h  |  6 +++---
 t/t1450-fsck.sh | 17 +++++++++--------
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f7..3b046820750 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -600,11 +600,22 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	unsigned long size;
 	void *contents;
 	int eaten;
+	struct strbuf sb = STRBUF_INIT;
+	struct object_info oi = OBJECT_INFO_INIT;
+	int err = 0;
 
-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
+	oi.type_name = &sb;
+	oi.sizep = &size;
+	oi.typep = &type;
+
+	if (read_loose_object(path, oid, &contents, &oi) < 0)
+		err = error(_("%s: object corrupt or missing: %s"),
+			    oid_to_hex(oid), path);
+	if (type < 0)
+		err = error(_("%s: object is of unknown type '%s': %s"),
+			    oid_to_hex(oid), sb.buf, path);
+	if (err) {
 		errors_found |= ERROR_OBJECT;
-		error(_("%s: object corrupt or missing: %s"),
-		      oid_to_hex(oid), path);
 		return 0; /* keep checking other objects */
 	}
 
diff --git a/object-file.c b/object-file.c
index a70669700d0..fe95285f405 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2572,18 +2572,15 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents)
+		      void **contents,
+		      struct object_info *oi)
 {
 	int ret = -1;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	struct object_info oi = OBJECT_INFO_INIT;
-	oi.typep = type;
-	oi.sizep = size;
+	unsigned long *size = oi->sizep;
 
 	*contents = NULL;
 
@@ -2599,15 +2596,13 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (parse_loose_header(hdr, &oi) < 0) {
+	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
-	if (*type < 0)
-		die(_("invalid object type"));
 
-	if (*type == OBJ_BLOB && *size > big_file_threshold) {
+	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
 	} else {
@@ -2618,8 +2613,7 @@ int read_loose_object(const char *path,
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
index c5130d8baea..c90c41a07f7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,6 +245,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
@@ -252,9 +253,8 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents);
+		      void **contents,
+		      struct object_info *oi);
 
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bd696d21dba..167c319823a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -85,11 +85,10 @@ test_expect_success 'object with hash and type mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 
-		cat >expect <<-\EOF &&
-		fatal: invalid object type
-		EOF
-		test_must_fail git fsck 2>actual &&
-		test_cmp expect actual
+
+		test_must_fail git fsck 2>out &&
+		grep "^error: hash mismatch for " out &&
+		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
 	)
 '
 
@@ -910,7 +909,7 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
-test_expect_success 'fsck hard errors on an invalid object type' '
+test_expect_success 'fsck error and recovery on invalid object type' '
 	git init --bare garbage-type &&
 	(
 		cd garbage-type &&
@@ -922,8 +921,10 @@ test_expect_success 'fsck hard errors on an invalid object type' '
 		fatal: invalid object type
 		EOF
 		test_must_fail git fsck >out 2>err &&
-		test_cmp err.expect err &&
-		test_must_be_empty out
+		grep -e "^error" -e "^fatal" err >errors &&
+		test_line_count = 1 errors &&
+		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
+		grep "dangling blob $empty_blob" out
 	)
 '
 
-- 
2.33.0.1327.g9926af6cb02

