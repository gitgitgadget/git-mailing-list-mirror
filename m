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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14286C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19EE6120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhFXT1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhFXT0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E053C06124C
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so5222153wms.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRwRbvJhEBFA5zS03594VDhbGFJtQsvjl5v6DRykdxo=;
        b=lVarqgWGSiADEitXwEaa6uccwEuKTzprVDW3JKODgw38b26aqp7pawhy24g5tmodxS
         vjpZmdGxCNtfwtfdNv+K0/vqF3XkPTvHxSsRhopW9qGryhKHckdbYqoG3n2W+Z+z/0xA
         N2tcYaM8S8QCm7H24XbwxutTKsW5ZslH8tjxsndUyNJbpz7upyu2ginHDvCVkQEx6lOS
         T176QhFgF251dfnie68IEpX6PkTGIiC9w5zo/LOQHBf71Y7Kxe4gTXLdkR0GJB3XHLR6
         p2n16dHlJniKguL1Lt8D8P1ju9+79yrSvbqwKDrrJKCMUQckSVR7dSKLlO21x8LapBjN
         QzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRwRbvJhEBFA5zS03594VDhbGFJtQsvjl5v6DRykdxo=;
        b=nQaYKZ4xyghc0GpDw5v4zCdL2U+aAo9kBDe54QoaAmG1YBCnRVN714Ix457p1ZNK2X
         ktSyIrVTZTs6WM+/SC4wSKLVSw/drrf6MqQ3ElmUvZ3DH8sqzvMcmQkusVdcDKGM2bA0
         4WCXh6tAQLW1i66Ss3z0tyJNS/SrS/KXDQyssebBNvfKE6Lb8yED/3LCR44PwwjtZZ2R
         VLVUQjRQ45uBLI/vmA+IiNgyLoLSYCjSmalDTji429nasrj+mzXFekcF4f9vKJ4BPJna
         YVE6BfvBkfCqCXU50Qkf/uEVLwYzNDzuY6I24HN8Eptv18kK0OTZTbXigb4yDDcvGK23
         eg+Q==
X-Gm-Message-State: AOAM5313SeCdZ3vfetIIQj9J48HLfIuyxf0W8jnWe7Yl7Zz+RrJ0ARs9
        Kky8y8A9PLFwhwk7ipucOqy5Qw54xXiZHA==
X-Google-Smtp-Source: ABdhPJxhIu5ioavV9c2OM3fZAzC1vZa1L7UpF612O3nXJldEYNamHrfovb+HtowiMkocn63AN1BL4w==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr6194159wml.87.1624562661575;
        Thu, 24 Jun 2021 12:24:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/21] fsck: report invalid types recorded in objects
Date:   Thu, 24 Jun 2021 21:23:58 +0200
Message-Id: <patch-20.21-edc28de229d-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
 builtin/fsck.c  | 22 ++++++++++++++++++----
 object-file.c   | 13 +++++--------
 object-store.h  |  4 ++--
 t/t1450-fsck.sh | 24 +++++++++++++++++++++---
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 082dadd5629..07af0434db6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -600,12 +600,26 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
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
index 8fb55fc6f58..e550ea0c7cf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2534,9 +2534,8 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags)
 {
 	int ret = -1;
@@ -2544,10 +2543,9 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	struct object_info oi = OBJECT_INFO_INIT;
 	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
-	oi.typep = type;
-	oi.sizep = size;
+	enum object_type *type = oi->typep;
+	unsigned long *size = oi->sizep;
 
 	*contents = NULL;
 
@@ -2563,7 +2561,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (parse_loose_header(hdr, &oi) < 0) {
+	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
@@ -2585,8 +2583,7 @@ int read_loose_object(const char *path,
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
index 72d668b1674..96a5970f314 100644
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
index e7e8decebbd..bc541af2cfc 100755
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
@@ -869,9 +888,8 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
 	test_must_fail git -C garbage-type fsck >out 2>err &&
 	grep -e "^error" -e "^fatal" err >errors &&
-	test_line_count = 2 errors &&
-	grep "error: hash mismatch for" err &&
-	grep "$garbage_blob: object corrupt or missing:" err &&
+	test_line_count = 1 errors &&
+	grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
 	grep "dangling blob $empty_blob" out
 '
 
-- 
2.32.0.606.g2e440ee2c94

