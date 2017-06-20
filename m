Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3401FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbdFTBDg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:36 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36116 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTBD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:28 -0400
Received: by mail-pf0-f178.google.com with SMTP id x63so61536193pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Fis+XSLk0l/HRgpcxS+xRH/I5cuAA32mRMGvY7kMLJY=;
        b=ucnZO/Gr7pLW9xP8BXWI+x0+QqZyTxSjHbsU3yQCv4MQfM1sPYKbD6QJX1x/nQEjun
         Cnz3rx7/M/E9PONuoki/+iCD2JxQ3RfuqaOP+Its5jxMr/waojH0wxoXWcclnf9mMcsW
         QDYvbQltkjfurnENUbKEIe/GcitaAyZdQmFQOstDAd7/htuO+TZJ63HnNukU+Lzn+cfl
         qg1tg6BDcb6I8BTOleYI2DccynkxvN0aLER+ny/Vb2tiyCOMr+xqKdI5bxEf4TitoHk1
         W/ySDT9ZiU6zItBzllGq4Czy/SpJ+NQzA2A0lwcwRXPKRNRKuba9tBGKcrOX/zBPp7Fs
         5rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Fis+XSLk0l/HRgpcxS+xRH/I5cuAA32mRMGvY7kMLJY=;
        b=JHCD9MTq0s1kvbwxiy8e0MORJ93iExOp6jgq2Dp1DvF9H2sfrFguN8jF+ky9AXXL2u
         cvefzXMZOpsamCtKolpDBPQjnFM8R9wF/V7U7hBU4ei96YGgS9j6T1Y0ST702xVnv/Ua
         A/N1dyWWOEzFoqylEVabrQUlAq8KtEMGDUSmjQ8UaQz51LL16q/6JGK+AmOTO5or8rjg
         wq/e0VsEXVYQJTjPEcnr12qawzte8cXlGzBWqT/m+sfMOHEvKd8HKH5aVfvxjrEBVPHd
         Ne78V/5omiX1Q8A9oH4kk7vdktGDL4y3+1RcPc9+28Jx+sav2hLL0qGdQB/8J9/5+R6s
         nfdA==
X-Gm-Message-State: AKS2vOzu8qI0EHlWZLS3oMFzZ6BytmII9usQ0oArPSCXcbyplTRTD1Hl
        sdrpiMPMECSJ+KVwAYPoOg==
X-Received: by 10.84.232.141 with SMTP id i13mr32253840plk.172.1497920607650;
        Mon, 19 Jun 2017 18:03:27 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:26 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 4/8] sha1_file: move delta base cache code up
Date:   Mon, 19 Jun 2017 18:03:11 -0700
Message-Id: <5b6815869699e776f04388536aa65064a7b029b1.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
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
index ae44b32f3..a7be45efe 100644
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

