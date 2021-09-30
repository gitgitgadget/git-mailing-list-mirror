Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B44CC433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2040C6136A
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351644AbhI3Njq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351676AbhI3Nj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BDFC0613E4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so10135370wrg.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24ZpABOSqzF3qXtX1Tlaz3EGa+3Dtz7mj85LvmOEkvA=;
        b=FSADGTEScas0Cj/QwJz/YzL3cA8qJVLNm9NIWWnA+kq/vek7fUkWhV0f5GmTIqbxN9
         GQN5JSD0YVqcuaFmT5x2rY3Wzt14mF9Rh8aPH7IwedIeGvLJxgTIFpVWcAEFbsOJdwlT
         xjSel1aM9QnD/xTvv8MJFXT+0I6Y1uivefXD+cbmZuPDI/3tUiLtJ4Bg+vBZbHTtUbtR
         B2qgHKWlZHKx2BXxgZR5nxZ41P+rv04nkbDLlWFg27KRCAjMZyyNL3DdE8WgKK99t/7h
         omsPu8PSTnlPaYGgm7bbTNC/DSNiAOyqVW7+r9494Jk7QWH2+1zcO8nnsdpvx8hoCf2p
         a7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24ZpABOSqzF3qXtX1Tlaz3EGa+3Dtz7mj85LvmOEkvA=;
        b=haOQ9Zx370ofzFqGTFKIAofvFtRKz/jwFQoYmYErfigGiXyEHDeSmnjC9pT7NtSiDV
         ZMXbERmqNJd+rb558ZIgSjkzMqK6AUizt7c45aI52arjY71Nil4L9gceIu3DteQV0D7I
         erFZRywGOHA+d4uIj7xT/jvbRj+6kPPzHvNisoR8RIAxVmBbllZ7MAWBDsbYn9moV8K/
         hJQd+oG/lVudljl8gOlURnEqv2ZhJBy1odPxa2qDNog5rUBjdq1jyxAr8fPib2ctv9N8
         007HK8edKGIobfJ5aqxYvr6gSbovqvgNpAHZDgEV2IKI5/EyfSv3JNw2ULYz8eDZcuTz
         61FQ==
X-Gm-Message-State: AOAM532NDX8pePdSRtRIVAurElPdDFYnVzd1LjIpAWLL1rJkDeukd2VY
        LY+C+I94/oElXOGXIfdtBPLezmftbgD7cpA0
X-Google-Smtp-Source: ABdhPJxuoaHHuA6PVN6H1+HgohXtH57MJnClSem+DQoikVg7UYejGwy9rEmGds/jJAbYl1DJy5MNkQ==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr6503774wrp.279.1633009061979;
        Thu, 30 Sep 2021 06:37:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 16/17] fsck: don't hard die on invalid object types
Date:   Thu, 30 Sep 2021 15:37:21 +0200
Message-Id: <patch-v9-16.17-6ce0414b2b7-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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

Since we're now passing in a "oi.type_name" we'll have to clean up the
allocated "strbuf sb". That we're doing it right is asserted by
e.g. the "fsck notices broken commit" test added in 03818a4a94c
(split_ident: parse timestamp from end of line, 2013-10-14). To do
that switch to a "goto cleanup" pattern, and while we're at it factor
out the already duplicated free(content) to use that pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  | 26 +++++++++++++++++++-------
 object-file.c   | 18 ++++++------------
 object-store.h  |  6 +++---
 t/t1450-fsck.sh | 17 +++++++++--------
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f7..623f8fc3194 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -600,12 +600,23 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
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
-		return 0; /* keep checking other objects */
+		goto cleanup;
 	}
 
 	if (!contents && type != OBJ_BLOB)
@@ -618,9 +629,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 		errors_found |= ERROR_OBJECT;
 		error(_("%s: object could not be parsed: %s"),
 		      oid_to_hex(oid), path);
-		if (!eaten)
-			free(contents);
-		return 0; /* keep checking other objects */
+		goto cleanup_eaten;
 	}
 
 	obj->flags &= ~(REACHABLE | SEEN);
@@ -628,8 +637,11 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	if (fsck_obj(obj, contents, size))
 		errors_found |= ERROR_OBJECT;
 
+cleanup_eaten:
 	if (!eaten)
 		free(contents);
+cleanup:
+	strbuf_release(&sb);
 	return 0; /* keep checking other objects, even if we saw an error */
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
2.33.0.1374.g05459a61530

