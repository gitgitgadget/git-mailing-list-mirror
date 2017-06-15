Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A80320401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdFOUkI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:40:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34246 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdFOUjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:39:47 -0400
Received: by mail-pf0-f178.google.com with SMTP id s66so12476980pfs.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8XREwhP75ab/GI/hclN5R63IpA/ZdVWsLIcZ/DH/3V4=;
        b=N7RheGpQgNLLEgQmjsCwZTFWPm23+phL88oKK7ssH1QH/RYAwFrEzCGGrF9Jnm4knw
         L0OCboNOnGMJWelUtkwQRyXMQuU4kjZCPcnKKPemWeAc9R93PJPVIlSHYJJPMTyUSyY0
         7z4R+jridOtsr/lTYZawTXtOsB5GCfR5N4cR0ZiVdntw24U9oFu35m/PypJsazQ5LGuP
         emghHR0FyUFrkW0d/83ES5RHQznLYf3pZICa0o+PD6N1InsjmOTNJ7gWSPQQr6percRK
         VXNarQ0q7h8WxbGlMhmwk1Jt5eZr4Hp7CB4+GdROKMMe4PG1A1uJQXZomostNPoWach9
         jl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8XREwhP75ab/GI/hclN5R63IpA/ZdVWsLIcZ/DH/3V4=;
        b=dbHgCWsDmL4ha4VXo19jltqpt9neKzJ3CQoSVG8EKqu8IEbsMK8oTnGni45PEDM+8d
         HHYCW/r+t4SHnHoO8OYfv9Wiv+Dpywo3DJ63plE5vbVAQikmN/58WIX+Eg2LGnNBWJQg
         JOu+Doi23GQEq2jQlIU8ouFKk/or0JzAdWuT6fzciWAEfAVH3bU2y8EIrMFpyyaAiKMS
         nkH/VpHoYvWqng1RLZyEZeTBSTccbVoVtfjuw6JmiHudNYQWHaQmqigyF7e0lH8m1XaC
         BBrWRnqm1WPODeZFo3UguacGr9LMHOVk35xBBd8OWZpf6AJT8EuMGBgqZg2pIA42Wyvn
         +cUA==
X-Gm-Message-State: AKS2vOx4F4ydZyiXzPKR3SFt9EIgMoj4pGnPlM4bwe14g8QDP6CVrT0j
        J0dPOIXk7w8iAx5f1YDUpA==
X-Received: by 10.84.132.66 with SMTP id 60mr8313766ple.174.1497559180742;
        Thu, 15 Jun 2017 13:39:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id i2sm274226pfe.89.2017.06.15.13.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:39:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 2/4] sha1_file: move delta base cache code up
Date:   Thu, 15 Jun 2017 13:39:29 -0700
Message-Id: <691edc66828b6f377862c8e3c982753dbcf85c0b.1497558850.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497558850.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497558850.git.jonathantanmy@google.com>
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
index a52b27541..a38319443 100644
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
2.13.1.518.g3df882009-goog

