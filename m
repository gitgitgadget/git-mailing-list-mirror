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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44558C433E4
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FB76199E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhC1C65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhC1C6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0FDC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo4907646wmq.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=do4DX5Y5Vnto4ZWfC1Xp2F0jdHldUd3EKwMFBriJTqo=;
        b=SfTNBlQzVyw0XM+TJkWgMmEUEhZj5ixslsL/je1pwqVTyI/pPlY11vI2FxrB7j+9h7
         KymHt3M1x3LbrTDRNec6Gw5Y5ZGO3SfuX2C7dEDJ9/RBH0kFMTJUzUbyRknUpcfitOm+
         N1BANu/XDlOMcYVhd3+SrKfACrloGe1ZRatqkybPYqhc/qE3DE0rxWilDhVtJg1X4ANy
         BaxisgzXu9bnfumfCWp0/rEnGMzzuLz76JUuB7CYfc0A4+fJ/t0XqCTaAAQVjwdwpS9x
         ATXbL5+OPNq5HTnEl5VduGHO+aYylyw8obJuOB92aAJPguRVAS3kGZGXV1uluP/TPIQo
         Owaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=do4DX5Y5Vnto4ZWfC1Xp2F0jdHldUd3EKwMFBriJTqo=;
        b=otcTI5OmdzYwf7arXKE2kw3zuYhM0xle3MjPLLxPm9a5JzpP7y/o0tVoR964gJGcDY
         WK7uw+u/HptAY/c6piRXrG41vVJjYH64sqGYzkHj2fKqSyCVYBfjzyymx1dsJvtKB7P1
         vqJeUztMYIPNPrqWDWQaAYD4xUvFOgiKljmntdS0y/JynMYDsULWd3I8JyiFln2nQObU
         cGQ9kz0wCqF0Za7qYKDy1uWvfnwkZikV3dhoDYlhXpDd796UvakXRlUB6h+eWSV3A+0q
         Kyfm65im9sbMYWMBIA9I2VVIGvtcxvVzDSSx3rcLaO+UIjvuHx8h6MhFeDxJ3QDlyjtr
         D13A==
X-Gm-Message-State: AOAM5335LOKOLAMpqtwsUJNitgEovSy3TxTjVbil2Z3spLfPZ9jazl2P
        /Q9hKwHYWTNVRVogVfDufpSmpyYgiF4jkA==
X-Google-Smtp-Source: ABdhPJy/wyEfg+457i7jAItyYSixQ/5JeKBD2/eQNAB/CJKwiOKMz5NBFwInDsVZJLqgpwl2FLDhnQ==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr18901249wmk.117.1616900320302;
        Sat, 27 Mar 2021 19:58:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] fsck: improve error on loose object hash mismatch
Date:   Sun, 28 Mar 2021 04:58:33 +0200
Message-Id: <patch-5.6-bcec536b0f6-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com> <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
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
 object-file.c         | 28 +++++++++++++++++++---------
 object-store.h        |  4 +++-
 object.c              |  4 ++--
 pack-check.c          |  3 ++-
 t/t1450-fsck.sh       |  8 +++++---
 9 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85a76e0ef8b..bf0e266d83a 100644
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
index c8ab14d1545..365b9124bdc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -604,20 +604,25 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	struct strbuf sb = STRBUF_INIT;
 	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 	struct object_info oi;
+	struct object_id real_oid = null_oid;
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
index 21899687e2c..93044e9e618 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1420,7 +1420,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (check_object_signature(the_repository, &d->oid,
 					   data, size,
-					   type_name(type)))
+					   type_name(type), NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 41a399a69e4..cfecbcd664e 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -65,7 +65,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type));
+				     buffer, size, type_name(*tagged_type),
+				     NULL);
 	free(buffer);
 
 	return ret;
diff --git a/object-file.c b/object-file.c
index e744a06637b..7aa80701aa7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -993,9 +993,11 @@ void *xmmap(void *start, size_t length,
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
@@ -1003,8 +1005,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, &real_oid);
-		return !oideq(oid, &real_oid) ? -1 : 0;
+		hash_object_file(r->hash_algo, map, size, type, real_oid);
+		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
 	st = open_istream(r, oid, &obj_type, &size, NULL);
@@ -1029,9 +1031,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			break;
 		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	r->hash_algo->final_fn(real_oid.hash, &c);
+	r->hash_algo->final_fn(real_oid->hash, &c);
 	close_istream(st);
-	return !oideq(oid, &real_oid) ? -1 : 0;
+	return !oideq(oid, real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2489,6 +2491,7 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags)
@@ -2532,9 +2535,16 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size, oi->type_name->buf)) {
-			error(_("hash mismatch for %s (expected %s)"), path,
-			      oid_to_hex(expected_oid));
+					   *contents, *size, oi->type_name->buf, real_oid)) {
+			if (oideq(real_oid, &null_oid))
+				/*
+				 * Not a plain BUG() because if it
+				 * does happen we're in the middle of
+				 * an fsck we'd like to see to the
+				 * end.
+				 */
+				bug("BUG trying to compute hash for object at %s (expected %s)",
+				    path, oid_to_hex(expected_oid));
 			free(*contents);
 			goto out;
 		}
diff --git a/object-store.h b/object-store.h
index 786c5c34704..340b0f51f08 100644
--- a/object-store.h
+++ b/object-store.h
@@ -244,6 +244,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
 struct object_info;
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags);
@@ -484,7 +485,8 @@ int unpack_loose_header(git_zstream *stream, unsigned char *map,
 int parse_loose_header(const char *hdr, struct object_info *oi,
 		       unsigned int flags);
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
+			   void *buf, unsigned long size, const char *type,
+			   struct object_id *real_oidp);
 int finalize_object_file(const char *tmpfile, const char *filename);
 int check_and_freshen_file(const char *fn, int freshen);
 
diff --git a/object.c b/object.c
index 78343781ae7..1cb4b30acd7 100644
--- a/object.c
+++ b/object.c
@@ -262,7 +262,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -273,7 +273,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type)) < 0) {
+					   type_name(type), NULL) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 4b089fe8ec0..e6aa4442c90 100644
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
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 214278e134a..c7b084364b7 100755
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
2.31.1.445.g91d8e479b0a

