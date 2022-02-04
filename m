Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B6C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiBDNvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359057AbiBDNvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE99C061741
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r17so2404846wrr.6
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OX4VvC6TZdA7i9Mo5h/ubMaXxxcsZN+A+0j5WjZ564=;
        b=U7t1TdD5Pi1d9ZJd8MxiR3ln11t11uzALE1AolNgHOTJq9lhtINaLJUHrOMo5pYeyp
         CDeiAvFcwjZQETbKwpzqFGHxUohcyUkBDw5mwVm2Iqi15SqJ5Oc9Bv4LylDkIJWD6il6
         d5284zULSoOTmXCqt7sk2SzPYnb/UX53W1vPJ0MBSF+HqfMbeKTTDAtg5+VQcP4czvaF
         odk0k8MACNFQpniu2nKdK5RcZMUpUjercE+1/b+FAKz51qx/e870KDp0JSDhsr/tvFzt
         sIBQL7ZgoEmEoMHwzkQorcF9dSe2QUnY/qpGb2YJJZGI8/EufFtKSigZ9lrFAsCdoyVD
         khwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OX4VvC6TZdA7i9Mo5h/ubMaXxxcsZN+A+0j5WjZ564=;
        b=jQwAX1NdTKTFznok1YIgumbiGKZt7/DzXsfaCsp6ns1GMIOLs8+xU6TLRQV0VmG9lA
         iG0h3Lnvyi1RGTXC+kJD4Ejm33VZVMu8ALs/H3ZNTYcMYU61w0AYIhTKpxhU+G5ey0DE
         +C82lskyw/mUqcdTH5qoVqPZw8SHwqGppxw6ADRlZ69C440VuAJ0H4Oi9wJo5eUi+9Vr
         BvGSuazUyu8lUIkF2hDz5IihX66/ndMuJg6VXYLuKZRNmRjwOQLKNUqSDzSrV+hSn5O/
         59J6GaLqfaUPs6qZn9BDgDBCdXOc1i5pt3gzB4En4K7k0XyvkEyrHG5GtPI3QcmJ+dVC
         EWWg==
X-Gm-Message-State: AOAM530xyajIo/6C/t1NCCT4f+f27Up6uEfl/QTaUCB4DMMkoxHoaQcz
        +u8Qd1o879UFAKfNR8YRtVbIf9QjB0BHxQ==
X-Google-Smtp-Source: ABdhPJwz7khHlSOQhWqGVSFP30y9RcS4xqSiV9McN2QSqAXlsREWpsgeII9/RoGK4xudIViN9CJkYw==
X-Received: by 2002:adf:802a:: with SMTP id 39mr231366wrk.533.1643982696825;
        Fri, 04 Feb 2022 05:51:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] object-file API: split up and simplify check_object_signature()
Date:   Fri,  4 Feb 2022 14:51:21 +0100
Message-Id: <patch-v2-07.11-c38af53e889-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the check_object_signature() function into that non-streaming
version (it accepts an already filled "buf"), and a new
stream_object_signature() which will retrieve the object from storage,
and hash it on-the-fly.

All of the callers of check_object_signature() were effectively
calling two different functions, if we go by cyclomatic
complexity. I.e. they'd either take the early "if (map)" branch and
return early, or not. This has been the case since the "if (map)"
condition was added in 090ea12671b (parse_object: avoid putting whole
blob in core, 2012-03-07).

We can then further simplify the resulting check_object_signature()
function since only one caller wanted to pass a non-NULL "buf" and a
non-NULL "real_oidp". That "read_loose_object()" codepath used by "git
fsck" can instead use hash_object_file() followed by oideq().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  2 +-
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  2 +-
 cache.h               | 12 ++++++++----
 object-file.c         | 33 +++++++++++++++++++--------------
 object.c              |  4 ++--
 pack-check.c          |  9 ++++++---
 7 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7a79cb186b1..1878ec34960 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -300,7 +300,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (!check_object_signature(the_repository, oid, buf, size,
-					    type_name(type), NULL))
+					    type_name(type)))
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6db3e728ff4..eaa7b6698d1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1413,7 +1413,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 			continue;
 
 		if (!check_object_signature(the_repository, &d->oid, data,
-					    size, type_name(type), NULL))
+					    size, type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index a715bf53cf0..1282e8cd9e2 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -62,7 +62,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = !check_object_signature(the_repository, repl, buffer, size,
-				      type_name(*tagged_type), NULL);
+				      type_name(*tagged_type));
 	free(buffer);
 
 	return ret;
diff --git a/cache.h b/cache.h
index 3a156dcb37b..5a13bbfd904 100644
--- a/cache.h
+++ b/cache.h
@@ -1322,15 +1322,19 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
 /**
  * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
- * With "buf" == NULL, try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
  *
  * Treat the return value like oideq() (which is like memcmp()),
  * except that negative values might also indicate a generic error.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type,
-			   struct object_id *real_oidp);
+			   void *buf, unsigned long size, const char *type);
+
+/**
+ * A streaming version of check_object_signature().
+ * Try reading the object named with "oid" using
+ * the streaming interface and rehash it to do the same.
+ */
+int stream_object_signature(struct repository *r, const struct object_id *oid);
 
 int finalize_object_file(const char *tmpfile, const char *filename);
 
diff --git a/object-file.c b/object-file.c
index 4c38ddad5dc..937a107c5ab 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1067,22 +1067,25 @@ int format_object_header(char *str, size_t size, enum object_type type,
 }
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type,
-			   struct object_id *real_oidp)
+			   void *buf, unsigned long size, const char *type)
 {
-	struct object_id tmp;
-	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
+	struct object_id real_oid;
+
+	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
+
+	return oideq(oid, &real_oid);
+}
+
+int stream_object_signature(struct repository *r, const struct object_id *oid)
+{
+	struct object_id real_oid;
+	unsigned long size;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	if (buf) {
-		hash_object_file(r->hash_algo, buf, size, type, real_oid);
-		return oideq(oid, real_oid);
-	}
-
 	st = open_istream(r, oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
@@ -1105,9 +1108,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			break;
 		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	r->hash_algo->final_oid_fn(real_oid, &c);
+	r->hash_algo->final_oid_fn(&real_oid, &c);
 	close_istream(st);
-	return oideq(oid, real_oid);
+	return oideq(oid, &real_oid);
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2611,9 +2614,11 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (!check_object_signature(the_repository, expected_oid,
-					    *contents, *size,
-					    oi->type_name->buf, real_oid))
+
+		hash_object_file(the_repository->hash_algo,
+				 *contents, *size, oi->type_name->buf,
+				 real_oid);
+		if (!oideq(expected_oid, real_oid))
 			goto out;
 	}
 
diff --git a/object.c b/object.c
index b778b32407d..b3f9cd5c8cd 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
+		if (!stream_object_signature(r, repl)) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -290,7 +290,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (!check_object_signature(r, repl, buffer, size,
-					    type_name(type), NULL)) {
+					    type_name(type))) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 35cca10057c..4a27e77704b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -127,7 +127,7 @@ static int verify_packfile(struct repository *r,
 
 		if (type == OBJ_BLOB && big_file_threshold <= size) {
 			/*
-			 * Let check_object_signature() check it with
+			 * Let stream_object_signature() check it with
 			 * the streaming interface; no point slurping
 			 * the data in-core only to discard.
 			 */
@@ -142,8 +142,11 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (!check_object_signature(r, &oid, data, size,
-						 type_name(type), NULL))
+		else if (data && !check_object_signature(r, &oid, data, size,
+							 type_name(type)))
+			err = error("packed %s from %s is corrupt",
+				    oid_to_hex(&oid), p->pack_name);
+		else if (!data && !stream_object_signature(r, &oid))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.1.940.ge7a5b4b05f2

