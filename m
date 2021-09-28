Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5542FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F97361260
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhI1CU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbhI1CUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CEC06176A
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so2118072wmh.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEiiMNLeWhHpkPeWI7AgqY35zAw9fM7TjvheilTsgNg=;
        b=aPMETPDnW7IoIHliC7Me0zXIHZgri4rLKgwTtlJBNKlGYOtcBQMHga2X7TL+BdOlHI
         K4WaqqLS4hRkF4qK2xjqAzX9WbRJRbuMDXa/TezeftKJmHp1XPBFetAXLchqAjhNdRnH
         lvYOZ9R0augbui9lQDn6P9RJ+ezHoKd4Nd2tOiF44XxLXAkWQrvpdql2e8eItaJnYwH1
         rNziR1xHuHEHR7BBwiWHbd7eIc6Y6Wl3TeRi40QyLMhA1Y6s+TsYPlpuVuQVknC+3uKL
         1TtdyW+Qs74Xo8KQv+GTS5xeuCjBITfOEfWJ5fL3plStEM3/2sNkDiYSMQBWfHwdryU/
         fhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEiiMNLeWhHpkPeWI7AgqY35zAw9fM7TjvheilTsgNg=;
        b=l+7oISu7YoMOak+QcpgqqTEOTx5FPKJTG6RyOttg/woEKDW81/ISBpi6Khsq7vFdzp
         mvCqRIeXWyghW0tj8IaeaZdagtQ5kH3UFGnpGl6m6cbCyyVo/vLexNkWUOedahYgRaTH
         LULg+aZUqaRr4olRUS9eOBfdDYOxFd2zZmoFbIh34G/oHxfuuKVymTUSexgP50p8Cunm
         TvYZjDV9dUrpmIq6mG1BMc5yZ8bUVkR+4eodXSZBHhY3V2VAR0TpfyJdpfbqUDLOcblZ
         puHMp13ViDgQH6GnX8uZzY/IQvmPgdT5I0mmON5aun4QErKF18lDK4Ep56wi5lMV5Pg3
         twhg==
X-Gm-Message-State: AOAM532OeLysUc7e2Fh6IdjiHLcf/8yCYnwFdcOBf2qEYUQ6aCVSFj0e
        N5BXyd+9mlEnApoRkjClwQFxb3f6O0JwDg==
X-Google-Smtp-Source: ABdhPJyMv+h9l1r+GJa0skXVXxVQkHjbbWkZ7zJygUEcL+6y8B46MBoFietJhRN1qaEWhq1xpgBnuQ==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr2193135wmp.173.1632795548583;
        Mon, 27 Sep 2021 19:19:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 11/17] object-file.c: make parse_loose_header_extended() public
Date:   Tue, 28 Sep 2021 04:18:52 +0200
Message-Id: <patch-v8-11.17-273acb45517-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
2.33.0.1327.g9926af6cb02

