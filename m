Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3255C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AE3214D8
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="KFwdDWe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgA3UeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:34:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37272 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgA3UeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:34:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so4342178qky.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlIfW7HKBKxoTynCquzM4VgMJyBVJaX2dTNAXLz+jFg=;
        b=KFwdDWe7xWHw+v8Vmva5Kt0b3oDON07XGyviBJHvp/8C03xWw2fhoVnXfm3zW4MyeY
         iItdyVXZZxbKQ2EE9VSKDOeqQKaD8979sUyx7x61rBBipDlnU38EGkE2/pMaSRfJVpkf
         TzeXL8UKl3uEyk+/gQ+Y4IbM1cNQBjUCEO7UwUZ7jbzW2XEdMqnsDuvQs/ToCsDPB9UE
         peB6c4kZoj9j/p9ijMEURcvkk+JFF73kUwHISOeHU6YrqBQooUB0S4kZack446A4Pxa3
         2LScKnM1rL5vTwxggY4fBiT1eBrzIE2Ds0BIYZwyHyafjXAH3UXy9I1vqUo7ivwcrEN7
         dCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlIfW7HKBKxoTynCquzM4VgMJyBVJaX2dTNAXLz+jFg=;
        b=S/dv1hWckCzYE4k37rv2aov7AV6P6DwCPRsaDAuMEl8+XUiDfeFv74xzLWLwVDA4GG
         +WJek7A/Djxn5ZFpyxHuXLmJ1kew/ZHcimXWxYVc2fCXAWzLcZ3wzeuCtjAFEah1SZPt
         9LiG/6wLfVd0suxU9Qz237HOBmSiLMyOFpKmcAi+Lmr6kdWBuekuCP8Ywrbz0wvLkR6Q
         K5aeBEinmyLES9sOUyel5Uw/oqK5HyXkXSz2UshJQS1ri/z4hXNfdFog9LrzT1lz+z4i
         G+etbubUXWutGL8WpDQ9tNkFXMcH8jpb9LWmTqCAMWEE8eNJlv3kmzWhPcuRHZha3j4W
         Kd8A==
X-Gm-Message-State: APjAAAVnqZ9I6uvZuvS9Wi+I/TbVT3z10vRfQxWMWN+SgPF1kr2w6RVw
        4m6w77OeNaRQZ2VVCk/MjuDJZyC78Ds=
X-Google-Smtp-Source: APXvYqzfx8O6pv0NFkJOrBLa5wKkDLGtbjwjhcHLsK0nzAQ8XZZCOd+18vdCNhxPHHehgFLcy9i8wg==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr7188359qkg.236.1580416449508;
        Thu, 30 Jan 2020 12:34:09 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:34:08 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 7/7] sha1-file: allow check_object_signature() to handle any repo
Date:   Thu, 30 Jan 2020 17:32:23 -0300
Message-Id: <ab935929bd934ca7a52e69d532d098dfec3508c5.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers of check_object_signature() can work on arbitrary
repositories, but the repo does not get passed to this function.
Instead, the_repository is always used internally. To fix possible
inconsistencies, allow the function to receive a struct repository and
make those callers pass on the repo being handled.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/fast-export.c |  3 ++-
 builtin/index-pack.c  |  5 +++--
 builtin/mktag.c       |  7 +++++--
 cache.h               |  3 ++-
 object.c              |  5 +++--
 pack-check.c          |  2 +-
 sha1-file.c           | 21 +++++++++++----------
 7 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index dbec4df92b..25386b34d3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -293,7 +293,8 @@ static void export_blob(const struct object_id *oid)
 		buf = read_object_file(oid, &type, &size);
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
-		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
+		if (check_object_signature(the_repository, oid, buf, size,
+					   type_name(type)) < 0)
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0183610a76..acdda17d84 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1384,8 +1384,9 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (!base_obj->data)
 			continue;
 
-		if (check_object_signature(&d->oid, base_obj->data,
-				base_obj->size, type_name(type)))
+		if (check_object_signature(the_repository, &d->oid,
+					   base_obj->data, base_obj->size,
+					   type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
 					base_obj->data, base_obj->size, type);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 6fb7dc8578..4982d3a93e 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -29,8 +29,11 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	const struct object_id *repl = lookup_replace_object(the_repository, oid);
 
 	if (buffer) {
-		if (type == type_from_string(expected_type))
-			ret = check_object_signature(repl, buffer, size, expected_type);
+		if (type == type_from_string(expected_type)) {
+			ret = check_object_signature(the_repository, repl,
+						     buffer, size,
+						     expected_type);
+		}
 		free(buffer);
 	}
 	return ret;
diff --git a/cache.h b/cache.h
index cbfaead23a..40ae160991 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,7 +1363,8 @@ int git_open_cloexec(const char *name, int flags);
 int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 int parse_loose_header(const char *hdr, unsigned long *sizep);
 
-int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
+int check_object_signature(struct repository *r, const struct object_id *oid,
+			   void *buf, unsigned long size, const char *type);
 
 int finalize_object_file(const char *tmpfile, const char *filename);
 
diff --git a/object.c b/object.c
index 142ef69399..81f5820fc3 100644
--- a/object.c
+++ b/object.c
@@ -262,7 +262,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -272,7 +272,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
+		if (check_object_signature(r, repl, buffer, size,
+					   type_name(type)) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 0fb3b365c7..e4ef71c673 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -144,7 +144,7 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(entries[i].oid.oid, data, size, type_name(type)))
+		else if (check_object_signature(r, entries[i].oid.oid, data, size, type_name(type)))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name);
 		else if (fn) {
diff --git a/sha1-file.c b/sha1-file.c
index d545e8b882..e2f608ac08 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -971,8 +971,8 @@ void *xmmap(void *start, size_t length,
  * With "map" == NULL, try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
-int check_object_signature(const struct object_id *oid, void *map,
-			   unsigned long size, const char *type)
+int check_object_signature(struct repository *r, const struct object_id *oid,
+			   void *map, unsigned long size, const char *type)
 {
 	struct object_id real_oid;
 	enum object_type obj_type;
@@ -982,11 +982,11 @@ int check_object_signature(const struct object_id *oid, void *map,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(the_hash_algo, map, size, type, &real_oid);
+		hash_object_file(r->hash_algo, map, size, type, &real_oid);
 		return !oideq(oid, &real_oid) ? -1 : 0;
 	}
 
-	st = open_istream(the_repository, oid, &obj_type, &size, NULL);
+	st = open_istream(r, oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
@@ -994,8 +994,8 @@ int check_object_signature(const struct object_id *oid, void *map,
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
 
 	/* Sha1.. */
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	r->hash_algo->init_fn(&c);
+	r->hash_algo->update_fn(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
@@ -1006,9 +1006,9 @@ int check_object_signature(const struct object_id *oid, void *map,
 		}
 		if (!readlen)
 			break;
-		the_hash_algo->update_fn(&c, buf, readlen);
+		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	the_hash_algo->final_fn(real_oid.hash, &c);
+	r->hash_algo->final_fn(real_oid.hash, &c);
 	close_istream(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
@@ -2454,8 +2454,9 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_object_signature(expected_oid, *contents,
-					 *size, type_name(*type))) {
+		if (check_object_signature(the_repository, expected_oid,
+					   *contents, *size,
+					   type_name(*type))) {
 			error(_("hash mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
-- 
2.25.0

