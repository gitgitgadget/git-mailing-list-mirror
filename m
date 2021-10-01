Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DAC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A733361A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352938AbhJAJTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbhJAJS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E7C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so6704670wmh.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9X7OW1UDA/WYYzzruAPJ7nNGMj7dQ/7K1KZ17Ee7W0=;
        b=PRb8BjEu2PW1kFVUSev2qlsfgVeM2Iu+7TOX39+hUAe+k/GFq0L8cBZsBMzXRmyXdD
         fa39lVRhpBK5ktHgdYRRXCdELBlRSWr+t7y6L+gBVxTWy2MX4vhe1l95HIDR5TXGIz0y
         PB69mg+3QWOYZbxJ6SyeNA8H5y4ODwQA5MyMTvrspJ4h8/boH/xfNvo1YGDeL7kC9Ncw
         M0S3UNNeiIWg7NFGfTu9iwxIMiu6bgCcLx5WZ6T77UJSoSf1/S32xUNlJAhQvQA3OalR
         nprx/1j3y5cX2JR5/7kzlfBzDvJv7Z2GwbhR8Xo7SZJN+afS7E7uz5YQM7HGUlftRtY9
         //Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9X7OW1UDA/WYYzzruAPJ7nNGMj7dQ/7K1KZ17Ee7W0=;
        b=Ehb/kxjh9vVyVxCN/8ZvMpko/tKVxKcUnpoWL6Iwa5kPTr+aClRSWdDZNhkzHQ3Vbv
         3QWiR5ReAMwwtprtQ/xfsvg7m3RnxTjMA9Qx3KEQWAFtzbVFwSKxuQFIhSQQ97bQxsY8
         BDFibnS4dspQ8RpHXop5XDvwHgxsakdaBDQPsSRwfwB/IXdVkqZH6GMgf2t21cHWKG9l
         BkMLORBTVHxD3cawf1i2P1LCisFePvOs0L9ofM7fj/qfxFIrSlPNs2Zrl/O/qMJUItAk
         LPH5gdlaC8coBBsdTRQPWfEmyGgAdQkmpmsXOSPLBZvmdyysokSUEMF3ygH0CLIlzl8t
         DOEw==
X-Gm-Message-State: AOAM532nltsnmGeWUticu4iFjWfJU7el1IXbZhf2YIY+HMKMJ6bV+o3O
        GKACmPFyzsaew30yReBxJCPowhfFIzQszw==
X-Google-Smtp-Source: ABdhPJx45AqBuvPAZPMOyhCXJzTuxdT5YOrdgDyaAyDDqnmRtpWIG6SUtzUfsUeGi0phQrGyD6ntzQ==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr939848wmq.165.1633079833192;
        Fri, 01 Oct 2021 02:17:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 17/17] fsck: report invalid object type-path combinations
Date:   Fri,  1 Oct 2021 11:16:53 +0200
Message-Id: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
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

We need to add the "object corrupt or missing" special-case to deal
with cases where read_loose_object() will return an error before
completing check_object_signature(), e.g. if we have an error in
unpack_loose_rest() because we find garbage after the valid gzip
content:

    $ git hash-object --stdin -w -t blob </dev/null
    e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
    $ chmod 755 objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
    $ echo garbage >>objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
    $ git fsck
    error: garbage at end of loose object 'e69d[...]'
    error: unable to unpack contents of ./objects/e6/9d[...]
    error: e69d[...]: object corrupt or missing: ./objects/e6/9d[...]

There is currently some weird messaging in the edge case when the two
are combined, i.e. because we're not explicitly passing along an error
state about this specific scenario from check_stream_oid() via
read_loose_object() we'll end up printing the null OID if an object is
of an unknown type *and* it can't be unpacked by zlib, e.g.:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    8315a83d2acc4c174aed59430f9a9c4ed926440f
    $ chmod 755 objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    $ echo garbage >>objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    $ /usr/bin/git fsck
    fatal: invalid object type
    $ ~/g/git/git fsck
    error: garbage at end of loose object '8315a83d2acc4c174aed59430f9a9c4ed926440f'
    error: unable to unpack contents of ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    error: 8315a83d2acc4c174aed59430f9a9c4ed926440f: object corrupt or missing: ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    error: 0000000000000000000000000000000000000000: object is of unknown type 'garbage': ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    [...]

I think it's OK to leave that for future improvements, which would
involve enum-ifying more error state as we've done with "enum
unpack_loose_header_result" in preceding commits. In these
increasingly more obscure cases the worst that can happen is that
we'll get slightly nonsensical or inapplicable error messages.

There's other such potential edge cases, all of which might produce
some confusing messaging, but still be handled correctly as far as
passing along errors goes. E.g. if check_object_signature() returns
and oideq(real_oid, null_oid()) is true, which could happen if it
returns -1 due to the read_istream() call having failed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  2 +-
 builtin/fsck.c        | 15 +++++++++++----
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  3 ++-
 cache.h               |  3 ++-
 object-file.c         | 21 ++++++++++-----------
 object-store.h        |  1 +
 object.c              |  4 ++--
 pack-check.c          |  3 ++-
 t/t1006-cat-file.sh   |  2 +-
 t/t1450-fsck.sh       |  8 +++++---
 11 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 95e8e89e81f..8e2caf72819 100644
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
index 260210bf8a1..30a516da29e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -608,6 +608,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	void *contents;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id real_oid = *null_oid();
 	int err = 0;
 
 	strbuf_reset(&cb_data->obj_type);
@@ -615,12 +616,18 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(path, oid, &contents, &oi) < 0)
-		err = error(_("%s: object corrupt or missing: %s"),
-			    oid_to_hex(oid), path);
+	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
+		if (contents && !oideq(&real_oid, oid))
+			err = error(_("%s: hash-path mismatch, found at: %s"),
+				    oid_to_hex(&real_oid), path);
+		else
+			err = error(_("%s: object corrupt or missing: %s"),
+				    oid_to_hex(oid), path);
+	}
 	if (type != OBJ_NONE && type < 0)
 		err = error(_("%s: object is of unknown type '%s': %s"),
-			    oid_to_hex(oid), cb_data->obj_type.buf, path);
+			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
+			    path);
 	if (err < 0) {
 		errors_found |= ERROR_OBJECT;
 		return 0; /* keep checking other objects */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7ce69c087ec..15ae406e6b7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1415,7 +1415,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (check_object_signature(the_repository, &d->oid,
 					   data, size,
-					   type_name(type)))
+					   type_name(type), NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index dddcccdd368..3b2dbbb37e6 100644
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
diff --git a/cache.h b/cache.h
index 6c5f00c82d5..e2a203073ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1361,7 +1361,8 @@ struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
+			   void *buf, unsigned long size, const char *type,
+			   struct object_id *real_oidp);
 
 int finalize_object_file(const char *tmpfile, const char *filename);
 
diff --git a/object-file.c b/object-file.c
index fe95285f405..49561e31551 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1084,9 +1084,11 @@ void *xmmap(void *start, size_t length,
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
@@ -1094,8 +1096,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, &real_oid);
-		return !oideq(oid, &real_oid) ? -1 : 0;
+		hash_object_file(r->hash_algo, map, size, type, real_oid);
+		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
 	st = open_istream(r, oid, &obj_type, &size, NULL);
@@ -1120,9 +1122,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
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
@@ -2572,6 +2574,7 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi)
 {
@@ -2582,8 +2585,6 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	*contents = NULL;
-
 	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
@@ -2613,9 +2614,7 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size, oi->type_name->buf)) {
-			error(_("hash mismatch for %s (expected %s)"), path,
-			      oid_to_hex(expected_oid));
+					   *contents, *size, oi->type_name->buf, real_oid)) {
 			free(*contents);
 			goto out;
 		}
diff --git a/object-store.h b/object-store.h
index c90c41a07f7..17b072e5a19 100644
--- a/object-store.h
+++ b/object-store.h
@@ -253,6 +253,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi);
 
diff --git a/object.c b/object.c
index 4e85955a941..23a24e678a8 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -290,7 +290,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type)) < 0) {
+					   type_name(type), NULL) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index c8e560d71ab..3f418e3a6af 100644
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
index a5e7401af8b..0f52ca9cc82 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -512,7 +512,7 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 		# Swap the two to corrupt the repository
 		mv -f "$other_path" "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "hash mismatch" err.fsck &&
+		grep "hash-path mismatch" err.fsck &&
 
 		# confirm that cat-file is reading the new swapped-in
 		# blob...
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index faf0e98847b..6337236fd82 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -54,6 +54,7 @@ test_expect_success 'object with hash mismatch' '
 		cd hash-mismatch &&
 
 		oid=$(echo blob | git hash-object -w --stdin) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -65,7 +66,7 @@ test_expect_success 'object with hash mismatch' '
 		git update-ref refs/heads/bogus $cmt &&
 
 		test_must_fail git fsck 2>out &&
-		grep "$oid.*corrupt" out
+		grep "$oldoid: hash-path mismatch, found at: .*$new" out
 	)
 '
 
@@ -75,6 +76,7 @@ test_expect_success 'object with hash and type mismatch' '
 		cd hash-type-mismatch &&
 
 		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -87,8 +89,8 @@ test_expect_success 'object with hash and type mismatch' '
 
 
 		test_must_fail git fsck 2>out &&
-		grep "^error: hash mismatch for " out &&
-		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
+		grep "^error: $oldoid: hash-path mismatch, found at: .*$new" out &&
+		grep "^error: $oldoid: object is of unknown type '"'"'garbage'"'"'" out
 	)
 '
 
-- 
2.33.0.1375.g5eed55aa1b5

