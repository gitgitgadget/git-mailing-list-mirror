Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B0E20401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbdFVAkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:55 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33804 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdFVAkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so897342pfs.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9+qWCcWpSzZzgteWSYwISBukcLiR0+ptllADiD40ma0=;
        b=k01S1NTC1shS9uXalUnEAVQaUYN4RGD5r45TtnxLQXan01aivTM24mj2ti7KKDyUTE
         d7p3N/sriMcEeTBXwMiR3Zxr+e3KIPlTf20XhXyPZ7+ne1S8FwkesOoZ1q6aqRahkwok
         m/tJV7NIbMGOPE0WP4fIKHQM4rTz8GHlECYwKxYOOxEV1w0WuLYiY+dv/NkrFVS4fY6D
         ym3Rut09vA+Appmz3TwFmg8ODusDcn+JtwIx2DceY784tp/il0hT9J29wLbOq2Lm2TaL
         3TRmkZMTWTgCmPcMkz1gDFlWS5Rh8QysIxbHImupbR6KMDE9Y+jKyKaIEFJ6ySRCY4LE
         Fs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9+qWCcWpSzZzgteWSYwISBukcLiR0+ptllADiD40ma0=;
        b=CUJbifBsY8oL1eEcja+l3HZ1uMRdYCcz0wGW3PV1oeH6eTcTOfNEWbLH4s4cMQkUn4
         In8tG1Wx82hP6Bi2E9TjtWVUrdDItgg5aRil8/MsdlyzOu8XSl8E9QLIEJ32w6NDJEsU
         fbOQ2GYaT75uKgOXZDGccpbxZYL+GIR5dU/dEu7VhgWYty7ynwCZFh0om+uyi5Ap5tMY
         voMtDCP0W1za382zI6NCxccl+FgM/OiTpBdq6hd3KXtsUpVI8VoG1sL83bJzJaVmMrc8
         AKMACnkJ9Qdq3fhlbaHvf9Zi0lozUrmfXHpBxILe+fc4IKrJqvl2mSGDzhwA2TGYZsAe
         SsbA==
X-Gm-Message-State: AKS2vOz3B5IShFCF2bNoNsUasRbamQuf5bu1CikEO/ulo+FzBB/qoi6v
        EqbCCmd3NSyYPIGA7R/63A==
X-Received: by 10.84.185.106 with SMTP id e39mr44890506plg.181.1498092037203;
        Wed, 21 Jun 2017 17:40:37 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:36 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 4/8] sha1_file: move delta base cache code up
Date:   Wed, 21 Jun 2017 17:40:20 -0700
Message-Id: <08c57e7283d648218701fd1c2cbc40c3df0f9e35.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, packed_object_info() will be modified to use the
delta base cache, so move the relevant code to before
packed_object_info().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 220 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 71296e6cd..0c996370d 100644
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
 
@@ -2486,6 +2376,116 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
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
2.13.1.611.g7e3b11ae1-goog

