Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B4FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D0961247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhI1CVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbhI1CU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFB5C06177A
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so55287858wrq.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpeBDOTlXCZ9NStOSfP4z4EuvUo4a2+iq9PlGEXAQ3A=;
        b=KVCCfkwvkjKi/Qt2V8PUjVO+Xo9gfFBZ5N7/0ZtrOKhwxJJ2Ram5eFTljsp5PXGe16
         4u9BrBBDBFG6mJDRXVParaJAS21kjujY+coxH0Bc9kOBKBSdqy7o2/8BOiVdLsxrAuti
         sdrVfOXW5TWSONP67tMMPc9+RZyax9+4TrMYL4DB7sB1kRQbPN14fBNFtLNBMafwuotA
         /i+xAiRYFY/kaD2OcmU9Zq11fe+LVcpfB1CqSAD6HvWb8Hvad38Jz2If6oFrPBAeLJoE
         kSxHVnmIZJxnivTywTr/qa11Uem85E3qtPvXmXkzvBb2c74DJ5lDFOceO07owvu6P+gE
         BjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpeBDOTlXCZ9NStOSfP4z4EuvUo4a2+iq9PlGEXAQ3A=;
        b=pt5Id/axgWlEOcdZSfUmwP2pdrUYAYp1yFaWEzPPj6nHHv2ySkZZ8n7bRKIig+qdcO
         BPO22zxh/Ip77BYbRZHX0XnLZhcfzkLwol7fa/m67l9tBRF0F4KY6OmQbDM2Cz3LU119
         4A2+wmVsfGhDmHnB3aE+vqtOkLfSUQr5s3hp5HK4d/aP+BeNC8V4crfD0qoxFj9HEabd
         CTM0sjWYBPH7PdPTYe1lrlC45BEwCCbScrHh4ANhPLwkUXZbtg914SFY+yHG+lqk1Nze
         J7z6x3fSOxUaM057/Q0G6lVEjduAGDyMws572Tdf8VANLiMz17GwtVyDxY1ik52tIz5K
         iq1w==
X-Gm-Message-State: AOAM533HapqhJbzfOUxFOnnpjjy95Sbjw15yeXj1E2kN/5bVXEtvYAbo
        sDCRLA3iVSNHV6ZmwAMIyjDohqeIJ115vg==
X-Google-Smtp-Source: ABdhPJxFpXwXFkBPJVSUS4D2M1puVlJcnulx/ggv+3D+ZF4Qloj8VCU69WEK3nM/WBD6WV2YgSS6rQ==
X-Received: by 2002:a5d:4579:: with SMTP id a25mr3617993wrc.222.1632795552104;
        Mon, 27 Sep 2021 19:19:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 15/17] object-file.c: stop dying in parse_loose_header()
Date:   Tue, 28 Sep 2021 04:18:56 +0200
Message-Id: <patch-v8-15.17-106b7461ce9-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make parse_loose_header() return error codes and data instead of
invoking die() by itself.

For now we'll move the relevant die() call to loose_object_info() and
read_loose_object() to keep this change smaller. In a subsequent
commit we'll make read_loose_object() return an error code instead of
dying. We should also address the "allow_unknown" case (should be
moved to builtin/cat-file.c), but for now I'll be leaving it.

For making parse_loose_header() not die() change its prototype to
accept a "struct object_info *" instead of the "unsigned long *sizep"
it accepted before. Its callers can now check the populated populated
"oi->typep".

Because of this we don't need to pass in the "unsigned int flags"
which we used for OBJECT_INFO_ALLOW_UNKNOWN_TYPE, we can instead do
that check in loose_object_info().

This also refactors some confusing control flow around the "status"
variable. In some cases we set it to the return value of "error()",
i.e. -1, and later checked if "status < 0" was true.

Since 93cff9a978e (sha1_loose_object_info: return error for corrupted
objects, 2017-04-01) the return value of loose_object_info() (then
named sha1_loose_object_info()) had been a "status" variable that be
any negative value, as we were expecting to return the "enum
object_type".

The only negative type happens to be OBJ_BAD, but the code still
assumed that more might be added. This was then used later in
e.g. c84a1f3ed4d (sha1_file: refactor read_object, 2017-06-21). Now
that parse_loose_header() will return 0 on success instead of the
type (which it'll stick into the "struct object_info") we don't need
to conflate these two cases in its callers.

Since parse_loose_header() doesn't need to return an arbitrary
"status" we only need to treat its "ret < 0" specially, but can
idiomatically overwrite it with our own error() return. This along
with having made unpack_loose_header() return an "enum
unpack_loose_header_result" in an earlier commit means that we can
move the previously nested if/else cases mostly into the "ULHR_OK"
branch of the "switch" statement.

We should be less silent if we reach that "status = -1" branch, which
happens if we've got trailing garbage in loose objects, see
f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
for a better way to handle it. For now let's punt on it, a subsequent
commit will address that edge case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 11 +++++++--
 object-file.c | 67 +++++++++++++++++++++++++--------------------------
 streaming.c   |  3 ++-
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/cache.h b/cache.h
index 8e05392fda8..6c5f00c82d5 100644
--- a/cache.h
+++ b/cache.h
@@ -1349,9 +1349,16 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned long bufsiz,
 						    struct strbuf *hdrbuf);
 
+/**
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ */
 struct object_info;
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags);
+int parse_loose_header(const char *hdr, struct object_info *oi);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
diff --git a/object-file.c b/object-file.c
index 3589c5a2e33..a70669700d0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1369,8 +1369,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1392,15 +1391,6 @@ int parse_loose_header(const char *hdr, struct object_info *oi,
 	type = type_from_string_gently(type_buf, type_len, 1);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
-	/*
-	 * Set type to 0 if its an unknown object and
-	 * we're obtaining the type using '--allow-unknown-type'
-	 * option.
-	 */
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
-		type = 0;
-	else if (type < 0)
-		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -1427,7 +1417,14 @@ int parse_loose_header(const char *hdr, struct object_info *oi,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	if (*hdr)
+		return -1;
+
+	/*
+	 * The format is valid, but the type may still be bogus. The
+	 * Caller needs to check its oi->typep.
+	 */
+	return 0;
 }
 
 static int loose_object_info(struct repository *r,
@@ -1441,6 +1438,7 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	enum object_type type_scratch;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1472,6 +1470,8 @@ static int loose_object_info(struct repository *r,
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
+	if (!oi->typep)
+		oi->typep = &type_scratch;
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
@@ -1479,6 +1479,18 @@ static int loose_object_info(struct repository *r,
 	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				    allow_unknown ? &hdrbuf : NULL)) {
 	case ULHR_OK:
+		if (parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0)
+			status = error(_("unable to parse %s header"), oid_to_hex(oid));
+		else if (!allow_unknown && *oi->typep < 0)
+			die(_("invalid object type"));
+
+		if (!oi->contentp)
+			break;
+		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
+		if (*oi->contentp)
+			goto cleanup;
+
+		status = -1;
 		break;
 	case ULHR_BAD:
 		status = error(_("unable to unpack %s header"),
@@ -1490,31 +1502,16 @@ static int loose_object_info(struct repository *r,
 		break;
 	}
 
-	if (status < 0) {
-		/* Do nothing */
-	} else if (hdrbuf.len) {
-		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
-			status = error(_("unable to parse %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
-		status = error(_("unable to parse %s header"), oid_to_hex(oid));
-
-	if (status >= 0 && oi->contentp) {
-		*oi->contentp = unpack_loose_rest(&stream, hdr,
-						  *oi->sizep, oid);
-		if (!*oi->contentp) {
-			git_inflate_end(&stream);
-			status = -1;
-		}
-	} else
-		git_inflate_end(&stream);
-
+	git_inflate_end(&stream);
+cleanup:
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
+	if (oi->typep == &type_scratch)
+		oi->typep = NULL;
 	oi->whence = OI_LOOSE;
-	return (status < 0) ? status : 0;
+	return status;
 }
 
 int obj_read_use_lock = 0;
@@ -2585,6 +2582,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = type;
 	oi.sizep = size;
 
 	*contents = NULL;
@@ -2601,12 +2599,13 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, &oi, 0);
-	if (*type < 0) {
+	if (parse_loose_header(hdr, &oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
+	if (*type < 0)
+		die(_("invalid object type"));
 
 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
diff --git a/streaming.c b/streaming.c
index bd89c50e7b3..fe54665d86e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -225,6 +225,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.sizep = &st->size;
+	oi.typep = type;
 
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -238,7 +239,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	case ULHR_TOO_LONG:
 		goto error;
 	}
-	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
+	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
 		goto error;
 
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
-- 
2.33.0.1327.g9926af6cb02

