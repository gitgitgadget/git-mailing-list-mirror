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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF2CC49EA7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3DB613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhFXT0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFXT0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4AC061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so6340180wms.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6NA/UVcf0adcfESeY4lgyK8Qe2pAuuV0fkikuaB1ac=;
        b=RI4HXtwD6F8ZGBtpSEIRVqPz4gcgD7HTlGCy8ZVBB75AvSFKvk9bg4Z2vY9x2Mnvwc
         cW1Dw+MrELi/D0h5Xev2pX7nsH/zE6dazyoREasU8vuAiy/tRHDwuCDCcZQE22FtvE1F
         j4UjH6VIN7tGDMT/HM00k2B5s00Fb2sBtniTldRR9CFrN20WV8maPWgts8kikKIjvBzg
         JSAjImDyf3KwvIkaOp6HgtNqBRkHE5/maGyixu4iW7kWXTjYreLJuM9IK35b6LcwAmsM
         8WT90OiInnGSIJZ+knbuQh2a3fdZO6TnKfcaeMJg0hvHKWIzBtGZlPFDkVMrYYRYjwM2
         jfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6NA/UVcf0adcfESeY4lgyK8Qe2pAuuV0fkikuaB1ac=;
        b=cKxAhDwtiGtMUhUlkUDNiL39mfqnrhKGJLNlmzyaZgC3aiqRPlS/DmrNKF37MSe+av
         XTShFiQ31hOXAlfDdD1DeYwccq8xI0L5J6/Wlt4lkgSMUuHOSbe/XaDd0b7LvV9EoiSx
         /uWD+gK2TrD1F/tsyGhuUXXsMhP4L3wfPRckgtWEniFE2EK6XEncHxbTY6iH3t+YE4Vc
         CaIZf41ukoD0FLakNR9n16q8oR8EorYL0hgSbF1ftoHha+qqQY1/k1+NsTYdJw8UWRoQ
         N4GhujowFJ5tFGsst8p2cS85Fu+xZD0lfrvynsZObur2r/JiDGGNMsVWWIyOEHwdPhUY
         OC4w==
X-Gm-Message-State: AOAM532qv7uwuKQLyBI3gsRkmdCwoHSed/JqqY0P9nu1Ar8g6Tx9iQ4B
        RvebDMmM/6MINLAfVeg8DklJfNc3xdCrOg==
X-Google-Smtp-Source: ABdhPJyv/qkSENr4IY5mxhcYRIz1vRUY8hGRFzx+3bonLwwD69l7hJamdlWiu0bMnNZILfMFaPt9pg==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr6337148wmm.185.1624562652698;
        Thu, 24 Jun 2021 12:24:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/21] object-file.c: make parse_loose_header_extended() public
Date:   Thu, 24 Jun 2021 21:23:48 +0200
Message-Id: <patch-10.21-9d36fcbc44a-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
index 9210e2e6fe4..e0ba1842272 100644
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
@@ -2547,6 +2540,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2561,7 +2556,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, size);
+	*type = parse_loose_header(hdr, &oi, 0);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
diff --git a/object-store.h b/object-store.h
index 9117115a50c..d443964447c 100644
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
2.32.0.606.g2e440ee2c94

