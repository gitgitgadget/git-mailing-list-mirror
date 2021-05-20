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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD786C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2F4611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhETM1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07EC0438E1
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j10so1403037edw.8
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8sCnso70+NgPvXNoV5EF1/eaUMgOY8WIjfJc8vsWvTc=;
        b=QHermpUMXaac0qh/BdYB51xWRKNUExVKRfBl8QNj2ZjKlAT7XvYh2UAe92Y0pikgfE
         attkUCC/bQZveJ+5e1Jj6Z6QgJdXgT+6igQTzuwPfsN3guJXj/uARW2pfJZpPj2jPcGG
         Pa3lBnsJgG905FUgr9idf8CmKsaESVT8ZZa+PiAF0vJPFPZ5SF7KW8180OHuIunjGPQK
         zki+Gxw/swiSrWX/6DzycT2C/VV5Xd0KQnggPX8z27OGXuoWgoEHGPZnqytneiM58IBl
         a/AgjnWYxvHwkwXOnh6M4Xzxav7j6AcFAY8UKZ3CaF2GyPZOQDBMxutYuW8lrxq9hv+O
         PF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8sCnso70+NgPvXNoV5EF1/eaUMgOY8WIjfJc8vsWvTc=;
        b=Ud+B63NhG3dTNQBVvkkf85erx5/bKaCZFwXuwuas2t9DFCJxfVqhkaKTlmwR/3ssBL
         Dg0zD9r9flM6csYi210ZdoPMvfE+IogIR4JK5507SOzF5+QjXI1XiGxIVkBEvnBaZBCq
         K+u6UqrpSE5EhbTv7rgeuyO7w8RIzVO95UG4TDgY3ZleHCqr6JE7K+hD+T9eIxQwL0MI
         eftVmQQ3aOSq86ZwG/YD0S0Z9LDGD/0pfdS88hrSH5BiV3JxJr0ECeZl9tsrHV9MZClM
         LsuhtY/TfMecqP6Pd7FST2d+Q0UlPiH5Ax92i08oY948DNWbTqLsyDuOpysSXsAJqij/
         612Q==
X-Gm-Message-State: AOAM530IaP06FC/OX9ZdW+E/llMuIrdh8rOu4QC7jc/EYaFt75QYjAFh
        As+Xhsv3fxDqECIYLAQOTR/mqTJCC7fzSA==
X-Google-Smtp-Source: ABdhPJyT/VdKZ/6K3U8sOSWEry2hOzdIvijVYGT3lTPlAU9A13QAuW8h+zaQH8DfRJLAtsuG8ov5Fg==
X-Received: by 2002:aa7:d74a:: with SMTP id a10mr4296545eds.311.1621509809162;
        Thu, 20 May 2021 04:23:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/17] fsck: report invalid object type-path combinations
Date:   Thu, 20 May 2021 13:23:11 +0200
Message-Id: <patch-17.17-c5e6686765-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error that's emitted in cases where we find a loose object
we parse, but which isn't at the location we expect it to be.

Before this change we'd prefix the error with a not-a-OID derived from
the path at which the object was found, due to an emergent behavior in
how we'd end up with an "OID" in these codepaths.

Now we'll instead say what object we hashed, and what path it was
found at. Before this patch series e.g.:

    $ git hash-object --stdin -w -t blob </dev/null
    e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
    $ mv objects/e6/ objects/e7

Would emit ("[...]" used to abbreviate the OIDs):

    git fsck
    error: hash mismatch for ./objects/e7/9d[...] (expected e79d[...])
    error: e79d[...]: object corrupt or missing: ./objects/e7/9d[...]

Now we'll instead emit:

    error: e69d[...]: hash-path mismatch, found at: ./objects/e7/9d[...]

Furthermore, we'll do the right thing when the object type and its
location are bad. I.e. this case:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    8315a83d2acc4c174aed59430f9a9c4ed926440f
    $ mv objects/83 objects/84

As noted in an earlier commits we'd simply die early in those cases,
until preceding commits fixed the hard die on invalid object type:

    $ git fsck
    fatal: invalid object type

Now we'll instead emit sensible error messages:

    $ git fsck
    error: 8315[...]: hash-path mismatch, found at: ./objects/84/15[...]
    error: 8315[...]: object is of unknown type 'garbage': ./objects/84/15[...]

In both fsck.c and object-file.c we're using null_oid as a sentinel
value for checking whether we got far enough to be certain that the
issue was indeed this OID mismatch.

In the case of check_object_signature() I don't really trust all the
moving parts there to behave consistently, in the face of future
refactorings. Getting it wrong would mean that we'd potentially emit
no error at all on a failing check_object_signature(), or worse
misreport whatever issue we encountered. So let's use the new bug()
function to ferry and return code up to fsck_loose() in that case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  2 +-
 builtin/fsck.c        | 13 +++++++++----
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  3 ++-
 object-file.c         | 21 ++++++++++++---------
 object-store.h        |  4 +++-
 object.c              |  4 ++--
 pack-check.c          |  3 ++-
 t/t1006-cat-file.sh   |  2 +-
 t/t1450-fsck.sh       |  8 +++++---
 10 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 3c20f164f0..48a3b6a7f8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -312,7 +312,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type)) < 0)
+					   type_name(type), NULL) < 0)
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 32f11dc1fe..96df1aadbf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -602,20 +602,25 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	struct strbuf sb = STRBUF_INIT;
 	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 	struct object_info oi;
+	struct object_id real_oid = *null_oid();
 	int found = 0;
 	oi.type_name = &sb;
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
+	if (read_loose_object(path, oid, &real_oid, &contents, &oi, oi_flags) < 0) {
 		found |= ERROR_OBJECT;
-		error(_("%s: object corrupt or missing: %s"),
-		      oid_to_hex(oid), path);
+		if (!oideq(&real_oid, oid))
+			error(_("%s: hash-path mismatch, found at: %s"),
+			      oid_to_hex(&real_oid), path);
+		else
+			error(_("%s: object corrupt or missing: %s"),
+			      oid_to_hex(oid), path);
 	}
 	if (type < 0) {
 		found |= ERROR_OBJECT;
 		error(_("%s: object is of unknown type '%s': %s"),
-		      oid_to_hex(oid), sb.buf, path);
+		      oid_to_hex(&real_oid), sb.buf, path);
 	}
 	if (found) {
 		errors_found |= ERROR_OBJECT;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3fbc5d7077..bf860b6555 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1421,7 +1421,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (check_object_signature(the_repository, &d->oid,
 					   data, size,
-					   type_name(type)))
+					   type_name(type), NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index dddcccdd36..3b2dbbb37e 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -62,7 +62,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type));
+				     buffer, size, type_name(*tagged_type),
+				     NULL);
 	free(buffer);
 
 	return ret;
diff --git a/object-file.c b/object-file.c
index f24fa2fe4a..bf9ac38d73 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1039,9 +1039,11 @@ void *xmmap(void *start, size_t length,
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, const char *type)
+			   void *map, unsigned long size, const char *type,
+			   struct object_id *real_oidp)
 {
-	struct object_id real_oid;
+	struct object_id tmp;
+	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_hash_ctx c;
@@ -1049,8 +1051,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, &real_oid);
-		return !oideq(oid, &real_oid) ? -1 : 0;
+		hash_object_file(r->hash_algo, map, size, type, real_oid);
+		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
 	st = open_istream(r, oid, &obj_type, &size, NULL);
@@ -1075,9 +1077,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			break;
 		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	r->hash_algo->final_oid_fn(&real_oid, &c);
+	r->hash_algo->final_oid_fn(real_oid, &c);
 	close_istream(st);
-	return !oideq(oid, &real_oid) ? -1 : 0;
+	return !oideq(oid, real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2520,6 +2522,7 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags)
@@ -2569,9 +2572,9 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size, oi->type_name->buf)) {
-			error(_("hash mismatch for %s (expected %s)"), path,
-			      oid_to_hex(expected_oid));
+					   *contents, *size, oi->type_name->buf, real_oid)) {
+			if (oideq(real_oid, null_oid()))
+				BUG("should only get OID mismatch errors with mapped contents");
 			free(*contents);
 			goto out;
 		}
diff --git a/object-store.h b/object-store.h
index ba6e5d76c0..60b566a63b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -384,6 +384,7 @@ int oid_object_info_extended(struct repository *r,
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags);
@@ -505,7 +506,8 @@ int unpack_loose_header(git_zstream *stream, unsigned char *map,
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
+			   void *buf, unsigned long size, const char *type,
+			   struct object_id *real_oidp);
 int finalize_object_file(const char *tmpfile, const char *filename);
 int check_and_freshen_file(const char *fn, int freshen);
 
diff --git a/object.c b/object.c
index 14188453c5..5467ead328 100644
--- a/object.c
+++ b/object.c
@@ -261,7 +261,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -272,7 +272,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type)) < 0) {
+					   type_name(type), NULL) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 4b089fe8ec..e6aa4442c9 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -142,7 +142,8 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(r, &oid, data, size, type_name(type)))
+		else if (check_object_signature(r, &oid, data, size,
+						type_name(type), NULL))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f12b06150e..0bb5ee97de 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -490,7 +490,7 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 		# Swap the two to corrupt the repository
 		mv -v "$other_path" "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "hash mismatch" err.fsck &&
+		grep "hash-path mismatch" err.fsck &&
 
 		# confirm that cat-file is reading the new swapped-in
 		# blob...
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bc541af2cf..d76293c495 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -53,6 +53,7 @@ test_expect_success 'object with hash mismatch' '
 	(
 		cd hash-mismatch &&
 		oid=$(echo blob | git hash-object -w --stdin) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -62,7 +63,7 @@ test_expect_success 'object with hash mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 		test_must_fail git fsck 2>out &&
-		test_i18ngrep "$oid.*corrupt" out
+		grep "$oldoid: hash-path mismatch, found at: .*$new" out
 	)
 '
 
@@ -71,6 +72,7 @@ test_expect_success 'object with hash and type mismatch' '
 	(
 		cd hash-type-mismatch &&
 		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -80,8 +82,8 @@ test_expect_success 'object with hash and type mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 		test_must_fail git fsck 2>out &&
-		grep "^error: hash mismatch for " out &&
-		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
+		grep "^error: $oldoid: hash-path mismatch, found at: .*$new" out &&
+		grep "^error: $oldoid: object is of unknown type '"'"'garbage'"'"'" out
 	)
 '
 
-- 
2.32.0.rc0.406.g73369325f8d

