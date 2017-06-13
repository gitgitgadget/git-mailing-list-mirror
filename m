Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AC51FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbdFMVGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:06:16 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36468 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdFMVGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:06:14 -0400
Received: by mail-it0-f47.google.com with SMTP id m47so48410965iti.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dFEE0j5DW7sEMkiWy/4+efmWKeasGtRbTW52MjESnSs=;
        b=Clc3JJrHIZK8/Suy/q+qXs53KIneItK7SJqUZv1wR2NQw14YO4lP3K3kcRuDt9Np2+
         4D8NmOk4NptpeszLEw7P2KHJBWyOv6mKk7bJ3Cn7CwKZZLKQnhaziPKZENIXJR8lg+Dz
         jS63T3Od3sAYJkX8Dp3ORt8EA3p1tGPJOYhaf7X/UU0bOPr9aRv40YcSEEtUvuYFwITX
         zt+uHRDpGYlEEn7/Ao0/7shikff787Hx4rnoGhAQ45OOEgAlw/U1PPiH0kopeopuQi8J
         vDcPQphDZCsLo1iUjfiHSpxpxOLpOICAYbAgr41CocdGNfgS+7YXgvXnBgbCKdd9sx27
         KBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dFEE0j5DW7sEMkiWy/4+efmWKeasGtRbTW52MjESnSs=;
        b=b94lxhxWuic3/QZSVEnGXDnNqBxJboouPwZNRW5iSjQThYj/+xE9ZCit+ZiK6SX646
         olZ0A7oUQihNsKoxKnPnFdg28Mf2tifghw7h4BAmGwJFycSILArptmI7PjEacXiI6wya
         Oimzj+0NQKfK9xFoF7XHucMu2KX0ygoXN+AqRuTX2ez15ybhQ8lOnPg1MGAuMYG5VZtC
         7uc6gdasDWH3Drh0Ph5JlyKzG8NYBgILjnmPqn6OuyPnSdQgT/8fqoF11jOPZXvkb7JB
         wmVTy0Vcd3pDwBosMz2lqdHabsFXbPMw7IGpHsGOcGNAIThS5IVm67KRrlS+GyRc5UMl
         /VxA==
X-Gm-Message-State: AODbwcBtj5ecQjYZfFsFg9wai9rZLz8W+hu1Z+pUPaZgPqLLMLAGUky5
        qGqNjC1dqwiFXnV7DHyrUQ==
X-Received: by 10.36.178.75 with SMTP id h11mr20445752iti.16.1497387973343;
        Tue, 13 Jun 2017 14:06:13 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id d185sm6885228ioe.38.2017.06.13.14.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:06:12 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 2/4] sha1_file: move delta base cache code up
Date:   Tue, 13 Jun 2017 14:05:58 -0700
Message-Id: <36b7984ee85d22800b974a04952c50eef043fa67.1497387714.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497387713.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497387713.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, packed_object_info() will be modified to use the
delta base cache, so move the relevant code to before
packed_object_info().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 226 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 116 insertions(+), 110 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a52b27541..a158907d1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2239,116 +2239,6 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 	goto out;
 }
 
-int packed_object_info(struct packed_git *p, off_t obj_offset,
-		       struct object_info *oi)
-{
-	struct pack_window *w_curs = NULL;
-	unsigned long size;
-	off_t curpos = obj_offset;
-	enum object_type type;
-
-	/*
-	 * We always get the representation type, but only convert it to
-	 * a "real" type later if the caller is interested.
-	 */
-	type = unpack_object_header(p, &w_curs, &curpos, &size);
-
-	if (oi->sizep) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			off_t tmp_pos = curpos;
-			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
-							   type, obj_offset);
-			if (!base_offset) {
-				type = OBJ_BAD;
-				goto out;
-			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
-				goto out;
-			}
-		} else {
-			*oi->sizep = size;
-		}
-	}
-
-	if (oi->disk_sizep) {
-		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*oi->disk_sizep = revidx[1].offset - obj_offset;
-	}
-
-	if (oi->typep || oi->typename) {
-		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
-		if (oi->typep)
-			*oi->typep = ptot;
-		if (oi->typename) {
-			const char *tn = typename(ptot);
-			if (tn)
-				strbuf_addstr(oi->typename, tn);
-		}
-		if (ptot < 0) {
-			type = OBJ_BAD;
-			goto out;
-		}
-	}
-
-	if (oi->delta_base_sha1) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			const unsigned char *base;
-
-			base = get_delta_base_sha1(p, &w_curs, curpos,
-						   type, obj_offset);
-			if (!base) {
-				type = OBJ_BAD;
-				goto out;
-			}
-
-			hashcpy(oi->delta_base_sha1, base);
-		} else
-			hashclr(oi->delta_base_sha1);
-	}
-
-out:
-	unuse_pack(&w_curs);
-	return type;
-}
-
-static void *unpack_compressed_entry(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t curpos,
-				    unsigned long size)
-{
-	int st;
-	git_zstream stream;
-	unsigned char *buffer, *in;
-
-	buffer = xmallocz_gently(size);
-	if (!buffer)
-		return NULL;
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = buffer;
-	stream.avail_out = size + 1;
-
-	git_inflate_init(&stream);
-	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
-		stream.next_in = in;
-		st = git_inflate(&stream, Z_FINISH);
-		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
-		curpos += stream.next_in - in;
-	} while (st == Z_OK || st == Z_BUF_ERROR);
-	git_inflate_end(&stream);
-	if ((st != Z_STREAM_END) || stream.total_out != size) {
-		free(buffer);
-		return NULL;
-	}
-
-	return buffer;
-}
-
 static struct hashmap delta_base_cache;
 static size_t delta_base_cached;
 
@@ -2486,6 +2376,122 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, ent);
 }
 
+int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       struct object_info *oi)
+{
+	struct pack_window *w_curs = NULL;
+	unsigned long size;
+	off_t curpos = obj_offset;
+	enum object_type type;
+
+	/*
+	 * We always get the representation type, but only convert it to
+	 * a "real" type later if the caller is interested.
+	 */
+	type = unpack_object_header(p, &w_curs, &curpos, &size);
+
+	if (oi->sizep) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			off_t tmp_pos = curpos;
+			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
+							   type, obj_offset);
+			if (!base_offset) {
+				type = OBJ_BAD;
+				goto out;
+			}
+			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*oi->sizep == 0) {
+				type = OBJ_BAD;
+				goto out;
+			}
+		} else {
+			*oi->sizep = size;
+		}
+	}
+
+	if (oi->disk_sizep) {
+		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+		*oi->disk_sizep = revidx[1].offset - obj_offset;
+	}
+
+	if (oi->typep || oi->typename) {
+		enum object_type ptot;
+		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
+					     curpos);
+		if (oi->typep)
+			*oi->typep = ptot;
+		if (oi->typename) {
+			const char *tn = typename(ptot);
+			if (tn)
+				strbuf_addstr(oi->typename, tn);
+		}
+		if (ptot < 0) {
+			type = OBJ_BAD;
+			goto out;
+		}
+	}
+
+	if (oi->delta_base_sha1) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			const unsigned char *base;
+
+			base = get_delta_base_sha1(p, &w_curs, curpos,
+						   type, obj_offset);
+			if (!base) {
+				type = OBJ_BAD;
+				goto out;
+			}
+
+			hashcpy(oi->delta_base_sha1, base);
+		} else
+			hashclr(oi->delta_base_sha1);
+	}
+
+	oi->whence = OI_PACKED;
+	oi->u.packed.offset = obj_offset;
+	oi->u.packed.pack = p;
+	oi->u.packed.is_delta = (type == OBJ_REF_DELTA ||
+				 type == OBJ_OFS_DELTA);
+
+out:
+	unuse_pack(&w_curs);
+	return type;
+}
+
+static void *unpack_compressed_entry(struct packed_git *p,
+				    struct pack_window **w_curs,
+				    off_t curpos,
+				    unsigned long size)
+{
+	int st;
+	git_zstream stream;
+	unsigned char *buffer, *in;
+
+	buffer = xmallocz_gently(size);
+	if (!buffer)
+		return NULL;
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = buffer;
+	stream.avail_out = size + 1;
+
+	git_inflate_init(&stream);
+	do {
+		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		stream.next_in = in;
+		st = git_inflate(&stream, Z_FINISH);
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be */
+		curpos += stream.next_in - in;
+	} while (st == Z_OK || st == Z_BUF_ERROR);
+	git_inflate_end(&stream);
+	if ((st != Z_STREAM_END) || stream.total_out != size) {
+		free(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
 static void *read_object(const unsigned char *sha1, enum object_type *type,
 			 unsigned long *size);
 
-- 
2.13.1.518.g3df882009-goog

