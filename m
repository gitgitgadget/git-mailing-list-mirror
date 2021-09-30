Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F227C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12E1611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbhI3Njj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351657AbhI3NjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0CC061771
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so10134926wrg.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bx73upVw5nERs8Wbb3A2jfMxeUw5sLzo19AD+T7vgb0=;
        b=NPKzHwOXRn8ZYinGDYWVXi1cMY/E/qX9pLy7xVHDJFPap+AKhvNS2Rz5WYacGJVgoe
         nk67rxXOasaWr1kW8gvxoGwjPf4HuokYZoWxHoxWzArefnQkB2FWGtbuWime0ZpzL0uB
         yL95UghCFGQaJRaZqinhFo/4vjft2LQ2i6l1PBLThm5cgUpragR9q87WgBXC0psfN+35
         LJOTXs6Y4oLboTA+n/BfJIgYLXgC1VJS0OWvdYb3Fkocy253rI1/jGkzmxZ+w62pjKY2
         6KZrU2rQxbAcxvS5WPPOVbI0YB3vJGqaCdKJi6dIYhO50c0V9HoG+Tni36eZua+EPoVY
         P3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bx73upVw5nERs8Wbb3A2jfMxeUw5sLzo19AD+T7vgb0=;
        b=dxga9uGpw8MSAv79b6LD5bEIOH/YCMOsJwt1SW9RPFhpWAYKNgiLex7oDuUSbsjWks
         g1fpqcSneAdpJp6Q6Xpy64zet18MyT4PdmXhl06MakhFRjOcZuBfOn569QIeqotc2i/T
         wofv/hqXsh+8QkhlEo2RxS2uXFW9iGqD35SPLNenmwudiPryksJXlLuOsfIGebpzT6ND
         m9lJKcM38iPoyly1KnIYxzATOxD5Vx11gNrodCI282scKvFkMV1TGy239Wi5fI8S3d4c
         fL28TRyE5WkVm8hkohAssYKQCs1kwvJQwo0U79EOCM4mUEEiB6vN5hSdGq+14O2gA1y2
         yWYw==
X-Gm-Message-State: AOAM530SRpV0mktiHlu/JjK3kG7GdvU5YR7G+2pi/wJmnZyVoO7FSsAR
        cfBMCjmPOP6uwtMPc18uMitIlQKuDFmOquCQ
X-Google-Smtp-Source: ABdhPJzH4CI842+uCiJ3vGW7iomPj6VGDbYzuGjWh7TMkIpK7CcsfP0BndWKWbzCQb1uWxxzn1YndQ==
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr6469350wrz.363.1633009057032;
        Thu, 30 Sep 2021 06:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 11/17] object-file.c: make parse_loose_header_extended() public
Date:   Thu, 30 Sep 2021 15:37:16 +0200
Message-Id: <patch-v9-11.17-51db08ebbae-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the parse_loose_header_extended() function public and remove the
parse_loose_header() wrapper. The only direct user of it outside of
object-file.c itself was in streaming.c, that caller can simply pass
the required "struct object-info *" instead.

This change is being done in preparation for teaching
read_loose_object() to accept a flag to pass to
parse_loose_header(). It isn't strictly necessary for that change, we
could simply use parse_loose_header_extended() there, but will leave
the API in a better end state.

It would be a better end-state to have already moved the declaration
of these functions to object-store.h to avoid the forward declaration
of "struct object_info" in cache.h, but let's leave that cleanup for
some other time.

1. https://lore.kernel.org/git/patch-v6-09.22-5b9278e7bb4-20210907T104559Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       |  4 +++-
 object-file.c | 20 +++++++-------------
 streaming.c   |  5 ++++-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index f6295f3b048..35f254dae4a 100644
--- a/cache.h
+++ b/cache.h
@@ -1320,7 +1320,9 @@ char *xdg_cache_home(const char *filename);
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-int parse_loose_header(const char *hdr, unsigned long *sizep);
+struct object_info;
+int parse_loose_header(const char *hdr, struct object_info *oi,
+		       unsigned int flags);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
diff --git a/object-file.c b/object-file.c
index 8475b128944..6b91c4edcf6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1385,8 +1385,8 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
-				       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi,
+		       unsigned int flags)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1446,14 +1446,6 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }
 
-int parse_loose_header(const char *hdr, unsigned long *sizep)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-
-	oi.sizep = sizep;
-	return parse_loose_header_extended(hdr, &oi, 0);
-}
-
 static int loose_object_info(struct repository *r,
 			     const struct object_id *oid,
 			     struct object_info *oi, int flags)
@@ -1508,10 +1500,10 @@ static int loose_object_info(struct repository *r,
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
-		if ((status = parse_loose_header_extended(hdrbuf.buf, oi, flags)) < 0)
+		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header_extended(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 
 	if (status >= 0 && oi->contentp) {
@@ -2599,6 +2591,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2613,7 +2607,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, size);
+	*type = parse_loose_header(hdr, &oi, 0);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
diff --git a/streaming.c b/streaming.c
index 5f480ad50c4..8beac62cbb7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -223,6 +223,9 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 			      const struct object_id *oid,
 			      enum object_type *type)
 {
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = &st->size;
+
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
@@ -231,7 +234,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.mapsize,
 				 st->u.loose.hdr,
 				 sizeof(st->u.loose.hdr)) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &st->size) < 0)) {
+	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
-- 
2.33.0.1374.g05459a61530

