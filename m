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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17680C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E3161050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhIUDAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349469AbhIUC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE8C1E3A52
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w29so32593313wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9nL+vhlbp5uEg8zinIJxPwi6bXN8vgV0Ajgo4TUWVY=;
        b=iR2mMnNxWs6owfSIRTCFHeRLRPNtvsNxor9JxgFN9iYfodsmWn4qMXClCle/COXFNs
         JVaBX1dguU4bDr/JeMw9djaTKpfiwLQY21aFuSgkDnjq9Rp/96QOqMJd1feBeTDPl9Ag
         6LPfjbkdq7r1IeX71GPrGOFeaBrYP7gSZXf+JweQjtWOmbNwv3E1rdInTAOUY2Q0NTca
         OeMboASI4DzdWpk8f5rdBz7M2g9o7EQoiAyyIH3Fc/X4PtDqIhJSOSMLIQV51F58PB3D
         tbrlTjWvo8YRXlgZTlYNBfJGkr+X+3xxAuh24zgROtOUjSIb2U707oYNb4deA38vVSvE
         44KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9nL+vhlbp5uEg8zinIJxPwi6bXN8vgV0Ajgo4TUWVY=;
        b=C9poGj943gVUFlFjYwIXkI4LQzcMZAHlH6tj0OpnK7RNwh8z+l/OnTF4S51nB3VTYB
         4KDCWWXjAwuC6xdoE6nfDRnh3YyVvMN3GJITJMdY+JHqHNu9y24uw9Rog/kEqD9/U479
         14dwHjJhfJjD0UtP2+biqxuqxNH4b84lOYvJuijnl6YIEHrcafhxn3sVQLioWvXhQSvz
         iRA0yBdelwNqZx+QUZIwVWxIiomaPVSHLVUoUjKU1OrvgBENDSVuCM42T5qWDIHRYCNB
         f0sQZESI3yaLT6UWzOdJvIjIltvdAeffi1XpC9Ms9LyyyNw721SjgE4tHetiUJ9wWXIp
         RnOw==
X-Gm-Message-State: AOAM533mFvuqUYOtWO224JnQRBYOkLzd1FC1MOcTTOj6xpY0lWphlw70
        5HAcLLcgzENz8ouFD2CIBC12QSjbdGkCEw==
X-Google-Smtp-Source: ABdhPJxhorTp4wUoaOqsww4GHp9NxDBwnSku3qnLzPVyyC3rdApoEihD6Q+dnyF6OzBYale+nznG7Q==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr605888wmj.182.1632164680413;
        Mon, 20 Sep 2021 12:04:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 16/17] fsck: don't hard die on invalid object types
Date:   Mon, 20 Sep 2021 21:04:20 +0200
Message-Id: <patch-v7-16.17-d38067feab3-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index 1af914c19c6..be568ade95b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2546,18 +2546,15 @@ static int check_stream_oid(git_zstream *stream,
 
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
 
@@ -2573,15 +2570,13 @@ int read_loose_object(const char *path,
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
@@ -2592,8 +2587,7 @@ int read_loose_object(const char *path,
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
index b4dc6668aa2..e8b4d87b898 100644
--- a/object-store.h
+++ b/object-store.h
@@ -244,6 +244,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
@@ -251,9 +252,8 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
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
2.33.0.1098.g29a6526ae47

