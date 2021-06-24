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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811AC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600FB613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhFXT1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhFXT0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DC1C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o22so3782125wms.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxrwEvNj25outCwmokjWhAMu6HmOrfrGDK2Dbe/lNII=;
        b=Rx/RiK+KHXOFmsfIxjB6DXEAYhKoWzAlXE9D6x1xu33bLAXPIVq8h30er5F44lK5oO
         G8Boqe6ru4MDZXzyXYtN3ZmcYhkE3W6EzDhwmPbk5f5lxkgt/c6HxEeB6mmYX/ZAs4AU
         9EPNPR3DuGxMbSU0x51RVAJf7gHpLDQ+ndRHNki0cmAn15IU0W8zf3y+FoZRnBIClwnL
         PTVs7OpvttHeUIsg2lQXdHUmKQnP55ruMRmE+iDyauPiK8NCzeq0blYM0QnvI85JZ10L
         +I+BOU8a7VEAAxj+cl7H8xEf1JaKn8NGGhE2O5RUHD3f391atsGW7PgiKTv2WkK0o5kS
         6pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxrwEvNj25outCwmokjWhAMu6HmOrfrGDK2Dbe/lNII=;
        b=tk0k7LQ39NnSb5rxN2+QC/AehIYazOVhIJhei+zGMlFcYxX8TN/nWHfknVYpbyfDRW
         0gqAQpK2ignb0d6NxqMsH2GQzzyayfi6txaYxrDFlUFZsTXKQPwAd5yy34yJtkUOZZRX
         nMB46F3jCg0sIG0PzEzR1g6iT1TuDUpnRlLK9YEagsGn6pumSlkF3Ixu8uJ7GwsHxJL3
         FPxxaeoAwIWRP08xplD4EzBzor7+KNUIHsP3XZhx3bsgU8LTTXXQGa7ZjkHBceFu5yTY
         E+9/+iR6+IQ6eiPaHDqxVQqyXnKzsey6hWMjYCrNvoDfzX7dC4VoDp45DCz7K9jRkE4a
         x+yQ==
X-Gm-Message-State: AOAM530pzjjGct/GBUqbxqdPHA8ThNxmdqCOfPvShD3YGuyRb7BCVFN8
        Njt4AgfRvROkDns+5otTJzuL4pvFH5OIRQ==
X-Google-Smtp-Source: ABdhPJxYNSjCvOjUpSIoFXvuzMo5dOwYielL3g4haFGju6TQZaD77yrsWymKjygija9LKKdHpKA7NA==
X-Received: by 2002:a7b:cc99:: with SMTP id p25mr6125458wma.19.1624562656459;
        Thu, 24 Jun 2021 12:24:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/21] object-file.c: stop dying in parse_loose_header()
Date:   Thu, 24 Jun 2021 21:23:52 +0200
Message-Id: <patch-14.21-ea4f446f5b1-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start the libification of parse_loose_header() by making it return
error codes and data instead of invoking die() by itself. For now
we'll move the relevant die() call to loose_object_info() and
read_loose_object() to keep this change smaller, but in subsequent
commits we'll also libify those.

Since the refactoring of parse_loose_header_extended() into
parse_loose_header() in an earlier commit, its interface accepts a
"unsigned long *sizep". Rather it accepts a "struct object_info *",
that structure will be populated with information about the object.

It thus makes sense to further libify the interface so that it stops
calling die() when it encounters OBJ_BAD, and instead rely on its
callers to check the populated "oi->typep".

Because of this we don't need to pass in the "unsigned int flags"
which we used for OBJECT_INFO_ALLOW_UNKNOWN_TYPE, we can instead do
that check in loose_object_info().

This also refactors some confusing control flow around the "status"
variable. In some cases we set it to the return value of "error()",
i.e. -1, and later checked if "status < 0" was true.

In another case added in c84a1f3ed4d (sha1_file: refactor read_object,
2017-06-21) (but the behavior pre-dated that) we did checks of "status
>= 0", because at that point "status" had become the return value of
parse_loose_header(). I.e. a non-negative "enum object_type" (unless
we -1, aka. OBJ_BAD).

Now that parse_loose_header() will return 0 on success instead of the
type (which it'll stick into the "struct object_info") we don't need
to conflate these two cases in its callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 53 ++++++++++++++++++++++++++------------------------
 object-store.h | 13 +++++++++++--
 streaming.c    |  4 +++-
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index e51cf2ca33e..31263335af9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1322,9 +1322,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr,
-		       struct object_info *oi,
-		       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1346,15 +1344,6 @@ int parse_loose_header(const char *hdr,
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
 
@@ -1384,7 +1373,11 @@ int parse_loose_header(const char *hdr,
 	if (*hdr)
 		return -1;
 
-	return type;
+	/*
+	 * The format is valid, but the type may still be bogus. The
+	 * Caller needs to check its oi->typep.
+	 */
+	return 0;
 }
 
 static int loose_object_info(struct repository *r,
@@ -1399,6 +1392,8 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	enum object_type type_scratch;
+	int parsed_header = 0;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1430,6 +1425,8 @@ static int loose_object_info(struct repository *r,
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
+	if (!oi->typep)
+		oi->typep = &type_scratch;
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
@@ -1440,18 +1437,20 @@ static int loose_object_info(struct repository *r,
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	}
-
-	if (status < 0) {
-		/* Do nothing */
-	} else if (hdrbuf.len) {
-		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
-			status = error(_("unable to parse %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
-		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	if (!status) {
+		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
+			/*
+			 * oi->{sizep,typep} are meaningless unless
+			 * parse_loose_header() returns >= 0.
+			 */
+			parsed_header = 1;
+		else
+			status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
+	if (!allow_unknown && parsed_header && *oi->typep < 0)
+		die(_("invalid object type"));
 
-	if (status >= 0 && oi->contentp) {
+	if (parsed_header && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
 						  *oi->sizep, oid);
 		if (!*oi->contentp) {
@@ -1466,6 +1465,8 @@ static int loose_object_info(struct repository *r,
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
+	if (oi->typep == &type_scratch)
+		oi->typep = NULL;
 	oi->whence = OI_LOOSE;
 	return (status < 0) ? status : 0;
 }
@@ -2531,6 +2532,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = type;
 	oi.sizep = size;
 
 	*contents = NULL;
@@ -2547,12 +2549,13 @@ int read_loose_object(const char *path,
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
diff --git a/object-store.h b/object-store.h
index 31327a7f6c3..65a8e4dc6a8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -492,8 +492,17 @@ int for_each_packed_object(each_packed_object_fn, void *,
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
 			unsigned long bufsiz, struct strbuf *hdrbuf);
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags);
+
+/**
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ */
+int parse_loose_header(const char *hdr, struct object_info *oi);
+
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/streaming.c b/streaming.c
index cb3c3cf6ff6..c3dc241d6a5 100644
--- a/streaming.c
+++ b/streaming.c
@@ -225,6 +225,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.sizep = &st->size;
+	oi.typep = type;
 
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -235,7 +236,8 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.hdr,
 				 sizeof(st->u.loose.hdr),
 				 NULL) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
+	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
+	    *type < 0) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
-- 
2.32.0.606.g2e440ee2c94

