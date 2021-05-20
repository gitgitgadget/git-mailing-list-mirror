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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579CC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1695E611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhETM11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhETM0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05724C0AF7BA
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t15so18932390edr.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+gFROMqipHl9DFeImSi02N9eb7dAGLr1iIMb1t87Hs=;
        b=GL9IchQxcQlj3IhAJKi5yIc2581meSnFf4B5JkU/577C83wiQP3XcoHzx+5Uxb+O2m
         VBI6dWSsbVYcvXYo3vvPkGmAxe1jdBGAXxIXaUwfxrg3I3XI6vp1fIfPcfQjkGop6Mwd
         E46QYnw1liHtTG6Cyo6wYN7ayWMQyqFcFwPDbaARg9dn7114bLiV7QydhF9VGodmd8Ig
         lm2rLvFGUribFkHy9UrK8UKuxpgy6AGkM48Z6s+YiU34raplWI3LTLCoL/8kDhLQfKrY
         x6/Ca7+gS3D/R0M8JQb6gh1sWykIqI47JVIvToSb8Tc/DrUqLmKKGT4nQ4Mn/lvuL/Ni
         aZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+gFROMqipHl9DFeImSi02N9eb7dAGLr1iIMb1t87Hs=;
        b=XpXb5a6gjoHpp2ns1k3h+guT+goWlfQLB1ItwjmQ2TY6aoFFL7W2BPSpJfF5luqHKS
         jzmtvQj/zTRQbKzAilhROUkCAH2Ljh+kkJoimusTaxdotLpwNoSfsAtQefby0pAVLjEm
         CrOvk3iTYY2IKbXjgBMsiqCdbtcJs3fdW6/kADf63i5jwaJC7JcPKtI+b4CiWBllcN19
         M0DK/r4hU0Fa4Dk6+WRPte9OEmX0ZdiW5Thz8pokz0D4ph3Q+NuUzJIXPNCdAQq72s0n
         h3hcjZSbKMm1+x+tUtlrtKTvMp19gqe5f9TEALF223z5vXbCs5ItAt12pGPsCHpT/J8J
         OPTA==
X-Gm-Message-State: AOAM530oFJJtZjo8tJuAgWSwdPtrHcW8dvcemmPTDWX+8lly3uyYZwOG
        Qbbx+p50MvyfEjAjQ+6HDeXrs8OLWQnJgg==
X-Google-Smtp-Source: ABdhPJz0zdjEaN/zyJn1P1yQXc5OvC6gahPM9k4MtnPq/QmsSsD+G5KuRfY3tPBvqUmdnzNf7Sb/gw==
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr4478642eda.265.1621509802294;
        Thu, 20 May 2021 04:23:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/17] object-file.c: make parse_loose_header_extended() public
Date:   Thu, 20 May 2021 13:23:03 +0200
Message-Id: <patch-09.17-6a5b78dcad-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 21 ++++++++-------------
 object-store.h |  3 ++-
 streaming.c    |  5 ++++-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/object-file.c b/object-file.c
index f233b440b2..527f435381 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1340,8 +1340,9 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
-				       unsigned int flags)
+int parse_loose_header(const char *hdr,
+		       struct object_info *oi,
+		       unsigned int flags)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1401,14 +1402,6 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
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
@@ -1463,10 +1456,10 @@ static int loose_object_info(struct repository *r,
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
@@ -2549,6 +2542,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2563,7 +2558,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, size);
+	*type = parse_loose_header(hdr, &oi, 0);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
diff --git a/object-store.h b/object-store.h
index 9117115a50..d443964447 100644
--- a/object-store.h
+++ b/object-store.h
@@ -480,7 +480,8 @@ int for_each_packed_object(each_packed_object_fn, void *,
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
 			unsigned long bufsiz);
-int parse_loose_header(const char *hdr, unsigned long *sizep);
+int parse_loose_header(const char *hdr, struct object_info *oi,
+		       unsigned int flags);
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/streaming.c b/streaming.c
index 5f480ad50c..8beac62cbb 100644
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
2.32.0.rc0.406.g73369325f8d

