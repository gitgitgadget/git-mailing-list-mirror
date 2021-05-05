Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBEC43462
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8C6613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhEEMen (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhEEMej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:34:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE56C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:33:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d4so1641180wru.7
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek6G0MydXgGdu/+TAt33SAdsI0PRSiHLVrE+3DvM2pI=;
        b=UChTKcBRuYGd0MjyUBFvsQrjVnnpSHMjII9Wdcq4Q6B4yajRmIX/7YJNYiUkIZ/ntA
         KB9lpCAweebXkowdfniUlG4f6BYqltNjCTDWvsPUqZcaTkDySGYp6XYQurKJ+AxxYfNM
         N3xS0KbblI5uQl9fjegCFVpYKl+Ui+8txR2v4bdf0bqfWHH17VXwIRMl114zPZ4yGrLn
         /h/UKn+qOivVLNg4KIB4beLrZAUbiBtJpo2Fd0q/liL35jRz6Xq5lOepKSUbw1UcWeG9
         tFNsOKIyhM+L7u3OKYYClyE5C2zqtbf0zLZ9LpM7S4+3KnO6sOcPesl6ow/IjJTAINDG
         /+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek6G0MydXgGdu/+TAt33SAdsI0PRSiHLVrE+3DvM2pI=;
        b=e+6/xDmTQk8a0zkcW5pMJ3zeyUX+tObDw1C4DeEUvqsc7UaogDxiolPW+cXfCZGviP
         gnPJHfrz1RkG7zfYIKCo+TBr3y/23E9DU3zjiviWYnLcVBfR1ED3WWAttrj4iPM7BRUP
         FT5ww6w5NwUe1xaIJNtcZQ5aycvC1iRGR8Wu86yylVJ1TlpC3o7gQ67jqXJhMcXioy+D
         TmDlB6l1/QfwwhBfbZCqylF05TUH3DSaDt5nF00pufbxVIu4JqEpaE5RF+eTfux7V2vP
         g/ze+81LSQ9bhCdgp96yiAo08ZP7svM2tFcHmx0Nfd2O/ONb+HB5Uu9jg81i9lpBWx1K
         gXyQ==
X-Gm-Message-State: AOAM530SFLjUXX9C1AAi9rhv+9T9DjJB0BDdwfPvDGlAP64sKXVROFdL
        0IjhsD8gpp0JerLOz7aApZw5kJRyz8UtRg==
X-Google-Smtp-Source: ABdhPJwg2tgEnpP9kiMKjeMHCVFpb39JjGDDc6AXxarbxm6/jyN2uV7yNDAT7CfSi5LcVOkyFgrYQg==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr38812181wru.235.1620218021135;
        Wed, 05 May 2021 05:33:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q16sm5858755wmj.24.2021.05.05.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:33:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] streaming.c: move {open,close,read} from vtable to "struct git_istream"
Date:   Wed,  5 May 2021 14:33:32 +0200
Message-Id: <patch-5.5-52606cd72ac-20210505T122816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of the structure around the open/close/read
functions introduced in 46bf043807c (streaming: a new API to read from
the object store, 2011-05-11) to instead populate "close" and "read"
members in the "struct git_istream".

This gets us rid of an extra pointer deference, and I think makes more
sense. The "close" and "read" functions are the primary interface to
the stream itself.

Let's also populate a "open" callback in the same struct. That's now
used by open_istream() after istream_source() decides what "open"
function should be used. This isn't needed to get rid of the
"stream_vtbl" variables, but makes sense for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 streaming.c | 72 +++++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/streaming.c b/streaming.c
index f6059ee828e..5f480ad50c4 100644
--- a/streaming.c
+++ b/streaming.c
@@ -15,11 +15,6 @@ typedef int (*open_istream_fn)(struct git_istream *,
 typedef int (*close_istream_fn)(struct git_istream *);
 typedef ssize_t (*read_istream_fn)(struct git_istream *, char *, size_t);
 
-struct stream_vtbl {
-	close_istream_fn close;
-	read_istream_fn read;
-};
-
 #define FILTER_BUFFER (1024*16)
 
 struct filtered_istream {
@@ -33,7 +28,10 @@ struct filtered_istream {
 };
 
 struct git_istream {
-	const struct stream_vtbl *vtbl;
+	open_istream_fn open;
+	close_istream_fn close;
+	read_istream_fn read;
+
 	unsigned long size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;
@@ -146,18 +144,14 @@ static ssize_t read_istream_filtered(struct git_istream *st, char *buf,
 	return filled;
 }
 
-static struct stream_vtbl filtered_vtbl = {
-	close_istream_filtered,
-	read_istream_filtered,
-};
-
 static struct git_istream *attach_stream_filter(struct git_istream *st,
 						struct stream_filter *filter)
 {
 	struct git_istream *ifs = xmalloc(sizeof(*ifs));
 	struct filtered_istream *fs = &(ifs->u.filtered);
 
-	ifs->vtbl = &filtered_vtbl;
+	ifs->close = close_istream_filtered;
+	ifs->read = read_istream_filtered;
 	fs->upstream = st;
 	fs->filter = filter;
 	fs->i_end = fs->i_ptr = 0;
@@ -225,11 +219,6 @@ static int close_istream_loose(struct git_istream *st)
 	return 0;
 }
 
-static struct stream_vtbl loose_vtbl = {
-	close_istream_loose,
-	read_istream_loose,
-};
-
 static int open_istream_loose(struct git_istream *st, struct repository *r,
 			      const struct object_id *oid,
 			      enum object_type *type)
@@ -251,8 +240,9 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
 	st->z_state = z_used;
+	st->close = close_istream_loose;
+	st->read = read_istream_loose;
 
-	st->vtbl = &loose_vtbl;
 	return 0;
 }
 
@@ -328,11 +318,6 @@ static int close_istream_pack_non_delta(struct git_istream *st)
 	return 0;
 }
 
-static struct stream_vtbl pack_non_delta_vtbl = {
-	close_istream_pack_non_delta,
-	read_istream_pack_non_delta,
-};
-
 static int open_istream_pack_non_delta(struct git_istream *st,
 				       struct repository *r,
 				       const struct object_id *oid,
@@ -358,7 +343,9 @@ static int open_istream_pack_non_delta(struct git_istream *st,
 		break;
 	}
 	st->z_state = z_unused;
-	st->vtbl = &pack_non_delta_vtbl;
+	st->close = close_istream_pack_non_delta;
+	st->read = read_istream_pack_non_delta;
+
 	return 0;
 }
 
@@ -389,17 +376,13 @@ static ssize_t read_istream_incore(struct git_istream *st, char *buf, size_t sz)
 	return read_size;
 }
 
-static struct stream_vtbl incore_vtbl = {
-	close_istream_incore,
-	read_istream_incore,
-};
-
 static int open_istream_incore(struct git_istream *st, struct repository *r,
 			       const struct object_id *oid, enum object_type *type)
 {
 	st->u.incore.buf = read_object_file_extended(r, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
-	st->vtbl = &incore_vtbl;
+	st->close = close_istream_incore;
+	st->read = read_istream_incore;
 
 	return st->u.incore.buf ? 0 : -1;
 }
@@ -408,10 +391,10 @@ static int open_istream_incore(struct git_istream *st, struct repository *r,
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static open_istream_fn istream_source(struct git_istream *st,
-				      struct repository *r,
-				      const struct object_id *oid,
-				      enum object_type *type)
+static int istream_source(struct git_istream *st,
+			  struct repository *r,
+			  const struct object_id *oid,
+			  enum object_type *type)
 {
 	unsigned long size;
 	int status;
@@ -421,20 +404,23 @@ static open_istream_fn istream_source(struct git_istream *st,
 	oi.sizep = &size;
 	status = oid_object_info_extended(r, oid, &oi, 0);
 	if (status < 0)
-		return NULL;
+		return status;
 
 	switch (oi.whence) {
 	case OI_LOOSE:
-		return open_istream_loose;
+		st->open = open_istream_loose;
+		return 0;
 	case OI_PACKED:
 		if (!oi.u.packed.is_delta && big_file_threshold < size) {
 			st->u.in_pack.pack = oi.u.packed.pack;
 			st->u.in_pack.pos = oi.u.packed.offset;
-			return open_istream_pack_non_delta;
+			st->open = open_istream_pack_non_delta;
+			return 0;
 		}
 		/* fallthru */
 	default:
-		return open_istream_incore;
+		st->open = open_istream_incore;
+		return 0;
 	}
 }
 
@@ -444,14 +430,14 @@ static open_istream_fn istream_source(struct git_istream *st,
 
 int close_istream(struct git_istream *st)
 {
-	int r = st->vtbl->close(st);
+	int r = st->close(st);
 	free(st);
 	return r;
 }
 
 ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 {
-	return st->vtbl->read(st, buf, sz);
+	return st->read(st, buf, sz);
 }
 
 struct git_istream *open_istream(struct repository *r,
@@ -462,14 +448,14 @@ struct git_istream *open_istream(struct repository *r,
 {
 	struct git_istream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
-	open_istream_fn open_fn = istream_source(st, r, real, type);
+	int ret = istream_source(st, r, real, type);
 
-	if (!open_fn) {
+	if (ret) {
 		free(st);
 		return NULL;
 	}
 
-	if (open_fn(st, r, real, type)) {
+	if (st->open(st, r, real, type)) {
 		if (open_istream_incore(st, r, real, type)) {
 			free(st);
 			return NULL;
-- 
2.31.1.838.g7ac6e98bb53

