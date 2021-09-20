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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2AA61050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348601AbhIUDAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349458AbhIUC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8BC1E3A49
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d21so32544000wra.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GigY7gpiGAm1xnK5QvKmahCwWxqwOs4NVCBncTxLzug=;
        b=kbO4Eu6Qup51kcxZay8vVh9XsVITmZhlQznub9oJoJiEQWd5tVHZmBgX9u70OUrf6W
         khN4zLYDgfXCJvCt2rcevnWnDFBT3Xo0prfTLonVmBRj7N1hoLtZ3LMwKT+BOlWkpjec
         VW4LKk+37DME1nZSC8caoxSB8zukwDZ/Ebgm6qlbkFLsgvncFGLjRnE7zyhcPoPsJFGU
         UU8MosBkmq26F4TpCRB+miXA3mU+Aro2J8yl+WBFbolwDCgHcku+IceoWpXkka8LDemW
         4mtaqUY+2EUU1UZe9RU28nfljw0x1Se29PSXWn3Jop+xAvOFmZPEHajrxgfTNHSeBv1d
         JXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GigY7gpiGAm1xnK5QvKmahCwWxqwOs4NVCBncTxLzug=;
        b=xWIEU/NcE/b1m9MwBQIWOs9gdowHO3z8Cl56aODs+y8Nq2DmypqjSiDFCYOEVvGwIn
         ncgUmZKwQidPFjA7aGrQsZzlbJBcw+t/Ow/nZNnmxNfkr7SwHR5yOE+ZSWIUkJ6YqICh
         wtkjL83jA5kcq3EJuzDt58pSgdrgzJRUFqc/YE+LiCXPE5/NYBz6Vp4JFpWlB1nrtyzV
         KSteAXT6jrPYlddK2v476HF1kBRVpQcx7B1t6xAFrz4ZhPzrTECvjl1SI9E4uA53A+Qj
         foGTjxXZoTLoGM7nibjYfwIZWPQBnjEt+RbUSC6Sk0nzsqmajgKZiF4XC1/exIdfnBDb
         qbgA==
X-Gm-Message-State: AOAM530UCd8sK968t1sbJ4OYYzarXKh04wb71+bonjNoqPtd7nfVpA6H
        G8bBHxSjDoH5DJ06eqWM9rO7SFgOCEBUDQ==
X-Google-Smtp-Source: ABdhPJyNOS8j+EjtWVQ3lgCiGh106SycjVsdzfNYde6+o8/3ON5mAUXyfmTj3zOsYIMXIsR/TrPg0g==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr591867wmq.168.1632164676576;
        Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.35
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
Subject: [PATCH v7 12/17] object-file.c: simplify unpack_loose_short_header()
Date:   Mon, 20 Sep 2021 21:04:16 +0200
Message-Id: <patch-v7-12.17-50d938f7f3c-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the unpack_loose_short_header(),
unpack_loose_header_to_strbuf() and unpack_loose_header() functions
into one.

The unpack_loose_header_to_strbuf() function was added in
46f034483eb (sha1_file: support reading from a loose object of unknown
type, 2015-05-03).

Its code was mostly copy/pasted between it and both of
unpack_loose_header() and unpack_loose_short_header(). We now have a
single unpack_loose_header() function which accepts an optional
"struct strbuf *" instead.

I think the remaining unpack_loose_header() function could be further
simplified, we're carrying some complexity just to be able to emit a
garbage type longer than MAX_HEADER_LEN, we could alternatively just
say "we found a garbage type <first 32 bytes>..." instead. But let's
leave the current behavior in place for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 17 ++++++++++++++-
 object-file.c | 58 ++++++++++++++++++---------------------------------
 streaming.c   |  3 ++-
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 33cacbd22ac..9ad81d452ad 100644
--- a/cache.h
+++ b/cache.h
@@ -1313,7 +1313,22 @@ char *xdg_cache_home(const char *filename);
 
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+
+/**
+ * unpack_loose_header() initializes the data stream needed to unpack
+ * a loose object header.
+ *
+ * Returns 0 on success. Returns negative values on error.
+ *
+ * It will only parse up to MAX_HEADER_LEN bytes unless an optional
+ * "hdrbuf" argument is non-NULL. This is intended for use with
+ * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
+ * reporting. The full header will be extracted to "hdrbuf" for use
+ * with parse_loose_header().
+ */
+int unpack_loose_header(git_zstream *stream, unsigned char *map,
+			unsigned long mapsize, void *buffer,
+			unsigned long bufsiz, struct strbuf *hdrbuf);
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi,
 		       unsigned int flags);
diff --git a/object-file.c b/object-file.c
index 33a01ac203f..8dd35f768bb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1233,11 +1233,12 @@ void *map_loose_object(struct repository *r,
 	return map_loose_object_1(r, NULL, oid, size);
 }
 
-static int unpack_loose_short_header(git_zstream *stream,
-				     unsigned char *map, unsigned long mapsize,
-				     void *buffer, unsigned long bufsiz)
+int unpack_loose_header(git_zstream *stream,
+			unsigned char *map, unsigned long mapsize,
+			void *buffer, unsigned long bufsiz,
+			struct strbuf *header)
 {
-	int ret;
+	int status;
 
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1248,35 +1249,8 @@ static int unpack_loose_short_header(git_zstream *stream,
 
 	git_inflate_init(stream);
 	obj_read_unlock();
-	ret = git_inflate(stream, 0);
+	status = git_inflate(stream, 0);
 	obj_read_lock();
-
-	return ret;
-}
-
-int unpack_loose_header(git_zstream *stream,
-			unsigned char *map, unsigned long mapsize,
-			void *buffer, unsigned long bufsiz)
-{
-	int status = unpack_loose_short_header(stream, map, mapsize,
-					       buffer, bufsiz);
-
-	if (status < Z_OK)
-		return -1;
-
-	/* Make sure we have the terminating NUL */
-	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-		return -1;
-	return 0;
-}
-
-static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					 unsigned long mapsize, void *buffer,
-					 unsigned long bufsiz, struct strbuf *header)
-{
-	int status;
-
-	status = unpack_loose_short_header(stream, map, mapsize, buffer, bufsiz);
 	if (status < Z_OK)
 		return -1;
 
@@ -1286,6 +1260,14 @@ static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 		return 0;
 
+	/*
+	 * We have a header longer than MAX_HEADER_LEN. The "header"
+	 * here is only non-NULL when we run "cat-file
+	 * --allow-unknown-type".
+	 */
+	if (!header)
+		return -1;
+
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
 	 * result out to header, and then append the result of further
@@ -1435,6 +1417,7 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid);
@@ -1468,11 +1451,9 @@ static int loose_object_info(struct repository *r,
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
-		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
-			status = error(_("unable to unpack %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				allow_unknown ? &hdrbuf : NULL) < 0)
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	if (status < 0)
@@ -2576,7 +2557,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
diff --git a/streaming.c b/streaming.c
index 8beac62cbb7..cb3c3cf6ff6 100644
--- a/streaming.c
+++ b/streaming.c
@@ -233,7 +233,8 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.mapped,
 				 st->u.loose.mapsize,
 				 st->u.loose.hdr,
-				 sizeof(st->u.loose.hdr)) < 0) ||
+				 sizeof(st->u.loose.hdr),
+				 NULL) < 0) ||
 	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
-- 
2.33.0.1098.g29a6526ae47

