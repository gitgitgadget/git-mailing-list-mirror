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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F29C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9C6112D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbhIUDAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbhIUC0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C31C1E3A42
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d21so32543905wra.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDhCyLnuBM/HSiv6/4E472OAQAfaxAUxMXejT46RBto=;
        b=SzauP3VNTACjvvZzWET7O86bHQDGFcVDb81y46h5VPDRG+puW03ppfxv/LOouW/9PJ
         JzdE/38tg3l9TK0sg0kHaNf5BueEBN6Zqk8l/Po9gJzDR5mneglaBOKboHzQOi2sFpZI
         Ckv5WySVKaZ2BHTnR2QHF5b4DZPWb9jNGg8g3AdDXCd91x/B1v3zd8MrBDHgHeDFqAY7
         +OfNfY503ZieyqV5Vdn6ZXjNSTF6PGI7boW/1BBn2rgSA4Ax5at+h2gdJHk2vQwSs0xb
         6vzIT6mJlXu8038rcl29xW1i3sTY9snuAYhDkdKJJuTUTTU4EGVoJNqSsJI5hysdsXZ0
         SQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDhCyLnuBM/HSiv6/4E472OAQAfaxAUxMXejT46RBto=;
        b=RiOeAZx/ZK+kMVEVco4VrznyVsRRoey/poAnFuF5jD2yJVVrmJCoQ4oJ7keJ1at4oV
         6Z5l6tVBJuuIbHC835zGlbTjy662GXJrxuahxzHT0cpUyS8zNp42SB7U1t9ayXzzkrQN
         meDVBhjlDOELPLvWkQehP1D7v0/vzyo6jwXT0g4qa8ZLQ5IT+/F7PrfL7JLIR0WkAtMX
         1Zw53qF5mQSfAfRZ1x4AwGkKhaVOWakgbFtuFyW7CDftpMVRokXkZhpOC8URcLuKojC+
         +Iky/86Ej95A2J3480lzjLQ9Xn4AP6x8yOax99QCt2wr4CDrvwG4lHN5S/XwU8XikObb
         UeRA==
X-Gm-Message-State: AOAM533+RX737q3kG8h8dGLq5bc7gcecaPnocciWXZhpKSxwb2sYIfpC
        gOcfsVAJerrlFh+gckr5Ty1yvmUxPRePHA==
X-Google-Smtp-Source: ABdhPJw3xSETz7JHZpB9ehb/M8nCUNhcKDNheAzULx/wPsIlh/uSnBQTCOywli2fhEsOwvQRmwmlfA==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr619187wmq.122.1632164675721;
        Mon, 20 Sep 2021 12:04:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 11/17] object-file.c: make parse_loose_header_extended() public
Date:   Mon, 20 Sep 2021 21:04:15 +0200
Message-Id: <patch-v7-11.17-f43cfd8a5ed-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index d23de693680..33cacbd22ac 100644
--- a/cache.h
+++ b/cache.h
@@ -1314,7 +1314,9 @@ char *xdg_cache_home(const char *filename);
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
index 774ec8c866f..33a01ac203f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1363,8 +1363,8 @@ static void *unpack_loose_rest(git_zstream *stream,
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
@@ -1424,14 +1424,6 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
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
@@ -1486,10 +1478,10 @@ static int loose_object_info(struct repository *r,
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
@@ -2573,6 +2565,8 @@ int read_loose_object(const char *path,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2587,7 +2581,7 @@ int read_loose_object(const char *path,
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
2.33.0.1098.g29a6526ae47

