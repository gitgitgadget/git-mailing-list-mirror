Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44880C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhLULyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLULyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C8C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g2so9546580pgo.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3urYzHYUkeKMa/G9nrDCMMil6jsiAeI2j0Zt4p2eys=;
        b=JJ8Tn52SqDqKZLfEdc45oWkt0xL28NPwfpoYcuFytTx7L5+Nhol1VWs1iQ35cpOB9g
         CIV9oyW6KHF3jazp3hEjykfKI8EEnwFxvF9R0Hna5i9Jzb0+sf6h78BigItucfs92GHO
         sWGL5/7qZA+tteS4uW26ltw/vdRhER0ls19ZJP9vgtmDS3ZfYSKRVWDUIS9ZlZkUvhQm
         HE8zVNMLFfItG3KVm4cxN1enfAL+KmFvarH9hxGR8qBtcwEtSiSgsUWsP2KabgUu9WHk
         CdmM2NgRtp7Smo08mbykwlVEgr9RXJk2LDj+ltZwmyxDDmv6k/g5iki/dG3jie6UIaCO
         Lu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3urYzHYUkeKMa/G9nrDCMMil6jsiAeI2j0Zt4p2eys=;
        b=e4N0GGMve13o1DosMXKIFwb30AG0yhAS4t9xS6isBOCa5CpeN0x8LZo8gLbJCrWhNE
         XdFk6qYXuKAJuSG4mkUpC8QwQqkWVCxzRoHizfEpeD/0jQW9B433ymRZk7tGtpJK5uDD
         Zqh2ML7IaiIksz/tCH+03qHrhP08awi/wJ10j0ajuOPEein8WkvAfcx8+VQZQLwVjkkk
         AJs77NHcEBKqvPjc+7hxBIHWPzP8ww37DratGhQkLUFLiS38QUE/gAg31Me9bGVeLHus
         tUQMjRTZ9TNE0hwoALhruBUz3eREBTc1SEy9mNzHhJnX3b4pz4y4vFS6thj/cA0bxHeA
         1Cpg==
X-Gm-Message-State: AOAM530unVx+/BEO5eR8mGg1kDM4GJAWFcEIK/gjwOudWy8tUw/nF1Py
        6+xHZQwgOuqWRbRJ486Wmd4=
X-Google-Smtp-Source: ABdhPJwzplHRj9r3vjwNwYXrNWxTqqn+lo5UD7FOlRLCsCAwT+q4YO6O2TAIirzKU+YiQVoBQrpuVg==
X-Received: by 2002:a63:9143:: with SMTP id l64mr360365pge.495.1640087662576;
        Tue, 21 Dec 2021 03:54:22 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:22 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 2/5] object-file API: add a format_object_header() function
Date:   Tue, 21 Dec 2021 19:51:58 +0800
Message-Id: <20211221115201.12120-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g80008efde6.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add a convenience function to wrap the xsnprintf() command that
generates loose object headers. This code was copy/pasted in various
parts of the codebase, let's define it in one place and re-use it from
there.

All except one caller of it had a valid "enum object_type" for us,
it's only write_object_file_prepare() which might need to deal with
"git hash-object --literally" and a potential garbage type. Let's have
the primary API use an "enum object_type", and define an *_extended()
function that can take an arbitrary "const char *" for the type.

See [1] for the discussion that prompted this patch, i.e. new code in
object-file.c that wanted to copy/paste the xsnprintf() invocation.

1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/index-pack.c |  3 +--
 bulk-checkin.c       |  4 ++--
 cache.h              | 21 +++++++++++++++++++++
 http-push.c          |  2 +-
 object-file.c        | 14 +++++++++++---
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7d..4a765ddae6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -449,8 +449,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
-				   type_name(type),(uintmax_t)size) + 1;
+		hdrlen = format_object_header(hdr, sizeof(hdr), type, (uintmax_t)size);
 		the_hash_algo->init_fn(&c);
 		the_hash_algo->update_fn(&c, hdr, hdrlen);
 	} else
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac80..1733a1de4f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
-			       type_name(type), (uintmax_t)size) + 1;
+	header_len = format_object_header((char *)obuf, sizeof(obuf),
+					 type, (uintmax_t)size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
diff --git a/cache.h b/cache.h
index cfba463aa9..64071a8d80 100644
--- a/cache.h
+++ b/cache.h
@@ -1310,6 +1310,27 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned long bufsiz,
 						    struct strbuf *hdrbuf);
 
+/**
+ * format_object_header() is a thin wrapper around s xsnprintf() that
+ * writes the initial "<type> <obj-len>" part of the loose object
+ * header. It returns the size that snprintf() returns + 1.
+ *
+ * The format_object_header_extended() function allows for writing a
+ * type_name that's not one of the "enum object_type" types. This is
+ * used for "git hash-object --literally". Pass in a OBJ_NONE as the
+ * type, and a non-NULL "type_str" to do that.
+ *
+ * format_object_header() is a convenience wrapper for
+ * format_object_header_extended().
+ */
+int format_object_header_extended(char *str, size_t size, enum object_type type,
+				 const char *type_str, size_t objsize);
+static inline int format_object_header(char *str, size_t size,
+				      enum object_type type, size_t objsize)
+{
+	return format_object_header_extended(str, size, type, NULL, objsize);
+}
+
 /**
  * parse_loose_header() parses the starting "<type> <len>\0" of an
  * object. If it doesn't follow that format -1 is returned. To check
diff --git a/http-push.c b/http-push.c
index 3309aaf004..f55e316ff4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -363,7 +363,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_object_file(&request->obj->oid, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, (uintmax_t)len);
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/object-file.c b/object-file.c
index eb1426f98c..6bba4766f9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1006,6 +1006,14 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
+int format_object_header_extended(char *str, size_t size, enum object_type type,
+				 const char *typestr, size_t objsize)
+{
+	const char *s = type == OBJ_NONE ? typestr : type_name(type);
+
+	return xsnprintf(str, size, "%s %"PRIuMAX, s, (uintmax_t)objsize) + 1;
+}
+
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
@@ -1034,7 +1042,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
@@ -1734,7 +1742,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
+	*hdrlen = format_object_header_extended(hdr, *hdrlen, OBJ_NONE, type, len);
 
 	/* Sha1.. */
 	algo->init_fn(&c);
@@ -2006,7 +2014,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
-- 
2.34.1.52.g80008efde6.agit.6.5.6

