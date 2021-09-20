Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C581C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EBA60E9B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbhIUDAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349467AbhIUC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E3C1E3A4F
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so24468115wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rsym80GlWe9syuSJcJIUbO0cpzz6ZXgN45AD0ydMUUQ=;
        b=HG0au+UJMXsvWWgqWKOW933NWmuvifuZt1/hDmJk+/v0GojyMPLmlD1aTDB5LKANbr
         Txw08DiCAOWucUlnc2Af+bZLj6VytqUy2+Uj+H0grjCHfxFhsnSIyZV1pZoDqkHmh+dT
         vygH7WifmWZmCrdwni6ePiWXh+dCIJiuTamwPHVdnKdyG81NdbP1Z7BSsLKgpJbGIXzf
         yeGWr2KRHMolN0tY53l+vL9yNoez9fcDHFvCUNPaVG/OdYHC3Ow+XiMLQVQn5D4zDxx2
         i9lx92+aqM00UkMop9mVyyoIR9Pr01IAnhpQypWkE7cZef8ujdjpt4R+cYwqnOFqmAJo
         JQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rsym80GlWe9syuSJcJIUbO0cpzz6ZXgN45AD0ydMUUQ=;
        b=ticzIH4gXrLOTHTm2feq1tdNHqCARr2NlnPj16uMi3nRYEAsalu8uqMLM1UnIKAANn
         vnIEwJ16fmZ5Jt88+mUIeFWQvmNGg/C/Mv/kwmvOoeH9Y2D0ug6Op/SM6lIWbCMF4sjg
         WLCkQXCNCEc5lNUDtHU5vhzoOekH9noHohEjon+owhBOphp8QL+qGUtEES/Fcj12zfA1
         DmYyFgfw7wMt000FQSK1WypKpfpwp4QfI4drqVZtxvXoMPti9sETEIX/u24sM+kK5+pH
         k9BY7m8zXzjd8meQhOkRFQkGNpjWDBHjsCc2Dp37FSlYB+VyBdOPw7vOSBZczA3R8yhx
         LNFA==
X-Gm-Message-State: AOAM530IMiAIswr+rBX0lARXsiZNofm9zADfj/qhyEV9peJNMARk8QQf
        GjnLEGWsIPgwkYztEhRAOxXmFH39LzNpbg==
X-Google-Smtp-Source: ABdhPJxH5ZrKMM+F3NidQC9u2oNZ9FB3ET2LOVSneoqVdIZOjZV6f32bcB+dCU0mcsLEWjKQTUS2Nw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr633948wmi.70.1632164679354;
        Mon, 20 Sep 2021 12:04:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 15/17] object-file.c: stop dying in parse_loose_header()
Date:   Mon, 20 Sep 2021 21:04:19 +0200
Message-Id: <patch-v7-15.17-1ca875395c1-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index 49b18f2755c..23f0534b70e 100644
--- a/cache.h
+++ b/cache.h
@@ -1343,9 +1343,16 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
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
index ca4abe172ce..1af914c19c6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1347,8 +1347,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1370,15 +1369,6 @@ int parse_loose_header(const char *hdr, struct object_info *oi,
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
 
@@ -1405,7 +1395,14 @@ int parse_loose_header(const char *hdr, struct object_info *oi,
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
@@ -1419,6 +1416,7 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	enum object_type type_scratch;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1450,6 +1448,8 @@ static int loose_object_info(struct repository *r,
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
+	if (!oi->typep)
+		oi->typep = &type_scratch;
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
@@ -1457,6 +1457,18 @@ static int loose_object_info(struct repository *r,
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
@@ -1468,31 +1480,16 @@ static int loose_object_info(struct repository *r,
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
@@ -2559,6 +2556,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = type;
 	oi.sizep = size;
 
 	*contents = NULL;
@@ -2575,12 +2573,13 @@ int read_loose_object(const char *path,
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
2.33.0.1098.g29a6526ae47

