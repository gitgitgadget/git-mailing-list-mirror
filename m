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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D98C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBB60F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbhIGK7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbhIGK7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10DC0613A4
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v10so13781799wrd.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMg+jZCaKmvEZeNcC+mhr5NOAfyJxbsOGU6Ug1z/QG4=;
        b=DPDI/vyQrELGfItk/1KXZpyxu/lw3PgB8anJZAk+KMhbzIyUAV59ZySpiBywHdJiIr
         YqiQW6YMybiFiFMSpMChqR2WvQ8Nc7OP7az6XpLND5u0fJLxFW2YbG4NKpi4D2qpKh4T
         ZW5WcAwiDyRKa5oBWksQMX0mnag42/wpKp+LIch6ihBnqkPh863jFULHVlezkHMJshRd
         JfmhGCmR+8EvuqEqELIqUC65y1sCUVM2m6veE4/gk94qhp/8lqhCEiJJ2Q5CaoFslryf
         qRY/8IPVGq2SiTz8FyBNulTiiAtSvp7hjongWTyWbDGNpO4zInc4x0diSy1GfcBMHHLi
         SGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMg+jZCaKmvEZeNcC+mhr5NOAfyJxbsOGU6Ug1z/QG4=;
        b=H6uSUv1NOC7/O8F2s3OgwGK5IWBnudFelnjGTb0qUHBukCltYhCSKvAgNY55d8+/Jf
         ee1bj+ITseibevMmF7HOJcqjtW+gY+R5P2d70i0Gls+J2qlF3gEY0iFWrk0jV3KYMAOL
         QwYTGf/I4DG2KMbZShgHLP3ykJciAI1wBrBZo+U7HfIH9951oR9RCPfihiiHgbzlk0SW
         BAaIsiB32/6mZvSw61mlhxaKGycgD3RPinWgWG77ak0DcjiUadxy2NHMEvipOIRkIlzy
         9j9Rqcy2uJpnXi1Cce3TR7pwLWgejDzStFI0N263cXmQlJKCOUp9h8sABCAG7Azu/Bb6
         v91g==
X-Gm-Message-State: AOAM53369qE97apg2qrxIk80ZfOoGZfO5/VP3WX8h1r0tBNEvb4HZnBW
        Y/f03hcxigtb+KDpi/xfjlnBBs2OC8CimA==
X-Google-Smtp-Source: ABdhPJyLcmUDhNyP+DM0SeGF32+/N01s91zQGxO3rKSHidS93Z2+sHqyAdr2oMa9I2uHS0pTz23K3w==
X-Received: by 2002:adf:b741:: with SMTP id n1mr18148484wre.120.1631012313279;
        Tue, 07 Sep 2021 03:58:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/22] object-file.c: make parse_loose_header_extended() public
Date:   Tue,  7 Sep 2021 12:58:05 +0200
Message-Id: <patch-v6-10.22-b15ad53414b-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
index bda3497d5ca..7a47af68bd8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1363,8 +1363,9 @@ static void *unpack_loose_rest(git_zstream *stream,
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
@@ -1424,14 +1425,6 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
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
@@ -1486,10 +1479,10 @@ static int loose_object_info(struct repository *r,
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
@@ -2573,6 +2566,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2587,7 +2582,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, size);
+	*type = parse_loose_header(hdr, &oi, 0);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
diff --git a/object-store.h b/object-store.h
index eb4876ec983..25e641a606f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -488,7 +488,8 @@ int for_each_packed_object(each_packed_object_fn, void *,
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
2.33.0.815.g21c7aaf6073

