Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B5C433FE
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 08:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiAHI4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 03:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiAHI4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 03:56:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41979C061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 00:56:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id p37so7263383pfh.4
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6EaJY25k8TGr6OPOF//g4RelKv2TzOdaMRp6nlc9uI=;
        b=YlEhyGTFKzPNdiB56QsnjsEU681zXzsKy85GliN6ooLkpmRCT4AZO529BHb3IXYrVS
         IvRdVPilJlosiSIqSV35stEtQifsTwO1Hq5yxJs3Zzluza9v0lo0pqXb8rkB1mH2ruHd
         yHKdKxIfwnK+VlNFjyejnRUlxM+Tr64hEeVKsgwiEl81zCwfoBffXs5phROZTn4jPGzB
         /iyVTgl0xTqJV+F4L5gJeGDZSkyF+nVRn25KqOgYhEgf3s/K2SFiaqEAhZXdfHIVDXY5
         8/ZF7AUChzmO5NDG+CJwmh9CH8d7GEWMNgv30dtAfJcyOdMGPlBmlbo7hZk84q+icyg1
         THLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6EaJY25k8TGr6OPOF//g4RelKv2TzOdaMRp6nlc9uI=;
        b=25rQP3LgxSiWnPR6v15jR9bMpI4zd/fRKPuaZVu69kE8hHbjtRMd61ybdQvNP8uFHP
         /CDxhn3ZD1mEK7PDiA0W8W9PT1dKq9xwlNDkxIgt8qw9+Ecj8+59E+HQ0drqV5zrloMA
         pO6I3Na34Frs+EUoN7viqGPqCLzPz4BnZGYv9rcnjS1ujXKMU/mHDdifQvI23xn4c1OL
         s1HvqhVhIZxOppwpf4hYPCWYmRY4vWCFbjFRnBQqzMOCESpydMcLPz7L/K6r8byD4ZgG
         3BaZcedYUmJaFYlPN/BNSYLsyIpMcB2o42cfXYEYNk3J7jdp2h9Njtck5a3llN8CGnzn
         K/3Q==
X-Gm-Message-State: AOAM531YUwR9wZKyOY5OyVF2rVeRRfMpvzFQN0b8tnHIzyXi+Q2SLmfo
        tMefakTP2k5oTMAyXJa1Fko=
X-Google-Smtp-Source: ABdhPJxO2F4iUXg1XgzS4fVFjp2o/mBk7P7C4lNMoiEfdOUgIXzIfqf/FHOtjEVe4LZyPa/yhsXSxw==
X-Received: by 2002:a63:8c:: with SMTP id 134mr14232911pga.599.1641632204768;
        Sat, 08 Jan 2022 00:56:44 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x25sm1240990pfu.113.2022.01.08.00.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 00:56:44 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v8 6/6] object-file API: add a format_object_header() function
Date:   Sat,  8 Jan 2022 16:54:19 +0800
Message-Id: <20220108085419.79682-7-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
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
 object-file.c        | 16 ++++++++++++----
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7d..8a6ce77940 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -449,8 +449,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
-				   type_name(type),(uintmax_t)size) + 1;
+		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
 		the_hash_algo->init_fn(&c);
 		the_hash_algo->update_fn(&c, hdr, hdrlen);
 	} else
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac80..9e685f0f1a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
-			       type_name(type), (uintmax_t)size) + 1;
+	header_len = format_object_header((char *)obuf, sizeof(obuf),
+					 type, size);
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
index 3309aaf004..f0c044dcf7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -363,7 +363,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_object_file(&request->obj->oid, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/object-file.c b/object-file.c
index a462a21629..d384ef2952 100644
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
@@ -2027,7 +2035,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", get_object_directory());
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
 
 	/* Common steps for write_loose_object and stream_loose_object to
 	 * start writing loose oject:
@@ -2168,7 +2176,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

