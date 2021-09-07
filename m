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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18E4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3118610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbhIGLAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbhIGK7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C5C0617AD
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i3so6502699wmq.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9T4WSYs3xOrsCqjo4p19wvv6PfuLLE3X8q7P1KXmO8=;
        b=hf1nAQ3grQI1m/PUFtDUu8FRDYDhUpDFEfAsl/G/Jdf4MXXktCRNVIv+pAiBRBTFZg
         coHv6pG6Q+y/xgKEOhDW589+PpTRXwQzsTZ8byCH2WgK1VwwKTdFHFJ9FTCMBvG4abb6
         /HuqpEAuP2uOyK7fWfXYOpBlAr7mMEqYPzarTiCnl1LX1ry67e3IxJzMiwHZuj7wwY83
         AOvm8h7CFke1mLFZiLS7MMuHqxA6R71xpn5soO2nOJ4mQ4hzJ0kGz9aYVnc9Lw7BlDr8
         c6eCUEsMo0A+uF1Kvu611LwLn1OxBsvq1wa51f6Y+VYVs2rRo+4OaWbA3ZJg5es3iiFb
         M8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9T4WSYs3xOrsCqjo4p19wvv6PfuLLE3X8q7P1KXmO8=;
        b=E0BbsjQ9JD/PByvFJzlTJO1AUjkwAEUE+d2foDN4o2FFCMABjRMggwLTVvkaYPbleT
         n9KZdWLE5L3P883q/oc/NAGBKChcNTpI4KgkkARzFXsGrN1ZJeOkqdUDRTjrbKOY4WXh
         xdbSdp4oW1nKM9d/jmyahGSrASoEk0JvqCtAcWN9bc4O7ziWIA9yZaiQMvI0JCQxEd+s
         OjE5oIuMNl/qeOAbYTgOeGfyztoVyTchwPKg9IeZJeckuP6vb6Lmaox0muMhUTkHq8aI
         Bh6Jc5dI85fUAKaplNwdoUh+ICYuTcjn3E++fLAxFylqbeAlz8h5vdnXTlaVJLbBbzVi
         DEOQ==
X-Gm-Message-State: AOAM5303SNh7+hxqzwUKQmgpUHOYPrqVcogUqjvyek99tDw1AQ7GyJ3u
        JP8pPif43ehqHXz/EOC5HsDdqAvJcRdmdg==
X-Google-Smtp-Source: ABdhPJzNyojkN2kyygE1K1PVHchlCTvxGEkXYVlX3hn9BwNXD5NgHNXWEvkjNzlERyNzG4gNd9H1bg==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr3283302wme.100.1631012324057;
        Tue, 07 Sep 2021 03:58:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 21/22] fsck: report invalid types recorded in objects
Date:   Tue,  7 Sep 2021 12:58:16 +0200
Message-Id: <patch-v6-21.22-974f650cddf-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
index 0e6937fad73..f4850ba62b4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2560,9 +2560,8 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
 		      void **contents,
+		      struct object_info *oi,
 		      unsigned int oi_flags)
 {
 	int ret = -1;
@@ -2570,10 +2569,9 @@ int read_loose_object(const char *path,
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
 
@@ -2589,7 +2587,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (parse_loose_header(hdr, &oi) < 0) {
+	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
@@ -2611,8 +2609,7 @@ int read_loose_object(const char *path,
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
index dc638335e7d..f3045148b89 100644
--- a/object-store.h
+++ b/object-store.h
@@ -384,6 +384,7 @@ int oid_object_info_extended(struct repository *r,
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
@@ -391,9 +392,8 @@ int oid_object_info_extended(struct repository *r,
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
index d8303db9709..da2658155c7 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -66,6 +66,25 @@ test_expect_success 'object with hash mismatch' '
 	)
 '
 
+test_expect_success 'object with hash and type mismatch' '
+	git init --bare hash-type-mismatch &&
+	(
+		cd hash-type-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv objects/$old objects/$new &&
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
2.33.0.815.g21c7aaf6073

