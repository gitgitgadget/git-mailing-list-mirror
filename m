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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B2DC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE6860200
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhETM2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05528C0438E0
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s22so24456259ejv.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WoFbxzc6Mm6zb3PPvGLqk/s2Dpx8PSpK7WfJal56ls=;
        b=N/zQuGoxGNY6N4U6VBQaB0I9RGkWW1KxTxFWq4NQlveWSKfBZQq+hEAKQWOX8m0VOd
         i5Pxw6BcWJsZqEycE6erE1y7kNb21rIYMQDFVpL1PRh7QIqGchaOLbCtdgrMQy7snOcH
         vkcqwfDrK+hrJYyMIRo9ip/+dOodkcw0iWcl0w0DpXJ/2PQJDn4Uum00W5Pw1x3cYFTI
         RoqP8c1+Xd9K3Guk08/cid/ax7ALg/oH5LMi+tNnCKp3Ohl4jVxKedM2SOIU9Q4hTTNk
         rNegpb0rKcMpch0RbXp8jnwVvX+tLfF/PehviFye2wsMOqVsDSh/L05hTHbSnod3J8nW
         DznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WoFbxzc6Mm6zb3PPvGLqk/s2Dpx8PSpK7WfJal56ls=;
        b=aIYJZ5zZiqfQnjJB2SNq426bmBQHwhZAvScQsmSNitihTfQFqkU1xKr+TDyIMqbZ3h
         6QfhLr4ccdaZNR7gZXUz1tBdJrY157HOqaOTh2RCP08eTvEi9hjXv5FUYdhL5Ky1550w
         Aw8od8iL6JOhF8k2UvGXJWWaW10nlzaRyjuM1ELpJWbNrSObptJRaM0Tb5KXbrxT5tsi
         6EMX412x6PpYITS16bxdajxl+barQ+P1Xk9fI1Y7XFSByEzjeRaDJ/Zt6D8BChuc2Hr3
         W5o/KHhjJazfKzKqq0f4OJHVhBXyRtX09ihNhNMjpDdol4upY6zDpudgv3TWCxuirciv
         8lTg==
X-Gm-Message-State: AOAM530dbmYe8a5GG5wacTMFLxYbxTo1CvsIxcfvBjJcna6tWxR9M/AI
        XzI3syx9Y/QDvjfNgFFfSM7R3dR21xPyVQ==
X-Google-Smtp-Source: ABdhPJziEaMjA24Re49PyZsLoqprNL3VtbYzzbpKm2ammqrBylcz/nFzxyfSoA3iHf6nK+cRmXqgCA==
X-Received: by 2002:a17:906:1cc3:: with SMTP id i3mr4323755ejh.87.1621509808266;
        Thu, 20 May 2021 04:23:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/17] fsck: report invalid types recorded in objects
Date:   Thu, 20 May 2021 13:23:10 +0200
Message-Id: <patch-16.17-328f05c51b-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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
index 38b515deb6..32f11dc1fe 100644
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
index 0e8a024eb3..f24fa2fe4a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2520,9 +2520,8 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags)
 {
 	int ret = -1;
@@ -2530,10 +2529,9 @@ int read_loose_object(const char *path,
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
 
@@ -2549,7 +2547,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (parse_loose_header(hdr, &oi) < 0) {
+	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
@@ -2571,8 +2569,7 @@ int read_loose_object(const char *path,
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
index 698a701d70..ba6e5d76c0 100644
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
index e7e8decebb..bc541af2cf 100755
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
2.32.0.rc0.406.g73369325f8d

