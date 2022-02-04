Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378315AbiBDXtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378244AbiBDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D14E00950B
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so10431431wms.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5GdwUvnO2vryohVO8V4djuZnwr3r6buy88HdjH5ZiQ=;
        b=hOFdNHnC+YHmces2Ds9nlDtGeaWFm9zt1gPPAmTH82lxQhiEqMnuqmx7X0SM6GyJOv
         8I04WdeoWUKZvSf12fA45W7AGIZv1ot+xSa/0a6knZ9skayWPT4GKrf/tWnTjHmzLBS6
         Ylo2amNQS5Lx4sFZPWJOn+7mLQOquc6tN3g9E4zlCsFusXT/g6rymm9jk0tpraLcWgae
         SGfP2F8kBi92qQo59nbSKVzXhZj9gVo+QBq7OUUZ7qIwkcG0PizxObVnixX58ZKxyh4R
         196iv8IjtQnOTyTHnbvW6IQphiaZCnM193/K9ahMtG069j1nIDPpHKdgJ3zL6lkWz70w
         O19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5GdwUvnO2vryohVO8V4djuZnwr3r6buy88HdjH5ZiQ=;
        b=aeeQeXcypZL0F7nd2PuiizrcU+z/ZMWeb9mJJ1KkoyZ87Zod1RFHxnjmGVHrTp/W9b
         xmlydtKCYZhR7opmW0e2TEg4g+fplmbqCLPuXy3fCeSnn9Vz54AmiWDx1buaeBgVY0dO
         w6hFML9QJb2r1tTHbzvzLQ9voissUyU7jAzVclHW7Zf6cEo9Xl8Joc+0Y5zUM9207n0j
         hexMoVxcoImwHmj1/K9eSPIQG0fRmG3ks1C5Qojha2Jx8mxjohWQeFw+mDf+qroiKljB
         ivUSROSTowsgOSEnd2pMLWwDGV3r0m9saY3Hr57HxmaBlYFKqbO9TPNmN6JL+1C4jyIK
         Eb1A==
X-Gm-Message-State: AOAM533v85Ofg7XmP/ExpNfBV084W8aAGbwjBDMaE4VjqtSwqIE0DQOK
        ufFwqrvPSpJRDLcpj+9XaVVB4+VOHJBRYQ==
X-Google-Smtp-Source: ABdhPJz6Df6t6l6r+ot5RZ5R3dzt+dSwZMiu47duzCCedYDiymOZhdjsXXr84t4jV8X7qLNmwYe44g==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr4209341wmh.38.1644018527412;
        Fri, 04 Feb 2022 15:48:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:46 -0800 (PST)
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
Subject: [PATCH v3 08/12] object-file API: split up and simplify check_object_signature()
Date:   Sat,  5 Feb 2022 00:48:30 +0100
Message-Id: <patch-v3-08.12-478d2915731-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
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
 builtin/mktag.c       |  5 ++---
 cache.h               | 12 ++++++++----
 object-file.c         | 32 ++++++++++++++++++--------------
 object.c              |  4 ++--
 pack-check.c          |  9 ++++++---
 7 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f1c730e587..319859db30e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -300,7 +300,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type), NULL) < 0)
+					   type_name(type)) < 0)
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 416f60a98c1..e1927205a7b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1413,7 +1413,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 			continue;
 
 		if (check_object_signature(the_repository, &d->oid, data, size,
-					   type_name(type), NULL) < 0)
+					   type_name(type)) < 0)
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 98d1e66f327..4d28eceeba6 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -61,9 +61,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 		    type_name(*tagged_type), type_name(type));
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
-	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type),
-				     NULL);
+	ret = check_object_signature(the_repository, repl, buffer, size,
+				     type_name(*tagged_type));
 	free(buffer);
 
 	return ret;
diff --git a/cache.h b/cache.h
index 5d081952121..c068f99c793 100644
--- a/cache.h
+++ b/cache.h
@@ -1322,15 +1322,19 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
 /**
  * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
- * With "buf" == NULL, try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
  *
  * A negative value indicates an error, usually that the OID is not
  * what we expected, but it might also indicate another error.
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
index d628f58c0d2..f9854922741 100644
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
+	return !oideq(oid, &real_oid) ? -1 : 0;
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
-		return !oideq(oid, real_oid) ? -1 : 0;
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
-	return !oideq(oid, real_oid) ? -1 : 0;
+	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2611,9 +2614,10 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size,
-					   oi->type_name->buf, real_oid) < 0)
+		hash_object_file(the_repository->hash_algo,
+				 *contents, *size, oi->type_name->buf,
+				 real_oid);
+		if (!oideq(expected_oid, real_oid))
 			goto out;
 	}
 
diff --git a/object.c b/object.c
index c37501fc120..d07678ef6da 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
+		if (stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -290,7 +290,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type), NULL) < 0) {
+					   type_name(type)) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 48d818ee7b4..d8d8f91de6b 100644
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
-		else if (check_object_signature(r, &oid, data, size,
-						type_name(type), NULL) < 0)
+		else if (data && check_object_signature(r, &oid, data, size,
+							type_name(type)) < 0)
+			err = error("packed %s from %s is corrupt",
+				    oid_to_hex(&oid), p->pack_name);
+		else if (!data && stream_object_signature(r, &oid) < 0)
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.1.940.ge7a5b4b05f2

