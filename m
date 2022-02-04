Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE61C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377637AbiBDXst (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348347AbiBDXsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309AE0090BB
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so14015876wrg.11
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGNwgYaF7rBLtewDvY2Hit0j+5W6weuy8LmWr1ewfIo=;
        b=UAbOz3zO1OhgpkEZUKlGh8+PD+MM8PbjCEkNKgxmouSgIWUNFN0txIqQ36naW8t7Jd
         BPjyv/AzVW6/ktVIr6OxIW79mFt4zbHenOcsmT5eaHO9hjUnHLFyPDyf2ZqOvzGE0xxU
         Pg2D6i2REy8NMrZLJi7gFKk3g3G/JgckASL9hSwWCbkCMAFn8DoyQNmnLmEbmfB6E2jh
         RY2cyFxxKNQ4nsRhN8YB05c1Hd2E1gT4BfbM1bcrq5t/QBTkqFGOXsaI7fBKUj+a4+wX
         RB1WvZb7W4787sN4x5FyYMR+8FdSKSLwC/xhMcJO2+hyIpgSUhHfNtnwfLJC1RHioDnb
         390A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGNwgYaF7rBLtewDvY2Hit0j+5W6weuy8LmWr1ewfIo=;
        b=IBccFVYaHNvt8uZJaitCchJSAqzkO5fHj+Z1wEywHYsnifqfSFeGroPHTSktRNHltS
         +wGZ6eprpEOcH0UhMNKp3fvil/56R9JbcyoaL5Vz+LIYSS4Oit3lFdPry+5/7C/LBBsU
         2Cy8aBBmnHkRjevIqkS19ikzXHM9TrMkNJOvNESm/fb3kL3wOyH0GgNig1V+f+i2bu4S
         5y5X0He0UZvor1vF+olkzfhQ1vViyes2y1Y0KQG9B9EDuLaeA1zqx8UtHK4Jo/YWaPF8
         6jUZgK8fiD7Ri0C0C44FwKZEPV6Pv2o+caZC4risvRrmBkqAQNmN000h0nJhJOY+02im
         +iJA==
X-Gm-Message-State: AOAM533Cdj/tYu6CBtuQNNJE9soLU11dm7bfvh/d9pHY066oaTBRxAMD
        kpev0mxpezOO5WNr47rF6WW3gpBTtPM70A==
X-Google-Smtp-Source: ABdhPJyxO+pwf5IqhxoEn65uU0CRVq98IMdgQI3NshmpQwxcnSD+VPBKLeIGYEHYr4qblSFDhvx89A==
X-Received: by 2002:a05:6000:2a6:: with SMTP id l6mr987408wry.681.1644018523027;
        Fri, 04 Feb 2022 15:48:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/12] object-file API: add a format_object_header() function
Date:   Sat,  5 Feb 2022 00:48:25 +0100
Message-Id: <patch-v3-03.12-92fd020d199-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a convenience function to wrap the xsnprintf() command that
generates loose object headers. This code was copy/pasted in various
parts of the codebase, let's define it in one place and re-use it from
there.

All except one caller of it had a valid "enum object_type" for us,
it's only write_object_file_prepare() which might need to deal with
"git hash-object --literally" and a potential garbage type. Let's have
the primary API use an "enum object_type", and define a *_literally()
function that can take an arbitrary "const char *" for the type.

See [1] for the discussion that prompted this patch, i.e. new code in
object-file.c that wanted to copy/paste the xsnprintf() invocation.

In the case of fast-import.c the callers unfortunately need to cast
back & forth between "unsigned char *" and "char *", since
format_object_header() ad encode_in_pack_object_header() take
different signedness.

1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c |  6 +++---
 builtin/index-pack.c  |  3 +--
 bulk-checkin.c        |  4 ++--
 http-push.c           |  2 +-
 object-file.c         | 23 ++++++++++++++++++++---
 object-store.h        |  8 ++++++++
 6 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2b2e28bad79..123df7d9a53 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -937,8 +937,8 @@ static int store_object(
 	git_hash_ctx c;
 	git_zstream s;
 
-	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
-			   type_name(type), (unsigned long)dat->len) + 1;
+	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
+				      dat->len);
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 	the_hash_algo->update_fn(&c, dat->buf, dat->len);
@@ -1091,7 +1091,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
-	hdrlen = xsnprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
+	hdrlen = format_object_header((char *)out_buf, out_sz, OBJ_BLOB, len);
 
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, out_buf, hdrlen);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..01574378ce2 100644
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
index 8785b2ac806..85b3ebaf971 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
-			       type_name(type), (uintmax_t)size) + 1;
+	header_len = format_object_header((char *)obuf, sizeof(obuf),
+					  type, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
diff --git a/http-push.c b/http-push.c
index 3309aaf004a..f0c044dcf76 100644
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
index eeb6814780a..3fcd46cf9ed 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1049,6 +1049,23 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
+static int format_object_header_literally(char *str, size_t size,
+					  const char *type, size_t objsize)
+{
+	return xsnprintf(str, size, "%s %"PRIuMAX, type, (uintmax_t)objsize) + 1;
+}
+
+int format_object_header(char *str, size_t size, enum object_type type,
+			 size_t objsize)
+{
+	const char *name = type_name(type);
+
+	if (!name)
+		BUG("could not get a type name for 'enum object_type' value %d", type);
+
+	return format_object_header_literally(str, size, name, objsize);
+}
+
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
@@ -1077,7 +1094,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
@@ -1777,7 +1794,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
+	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
 
 	/* Sha1.. */
 	algo->init_fn(&c);
@@ -2051,7 +2068,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
diff --git a/object-store.h b/object-store.h
index 44f6868cc9c..8b4413d0ce7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -331,6 +331,14 @@ int repo_has_object_file_with_flags(struct repository *r,
  */
 int has_loose_object_nonlocal(const struct object_id *);
 
+/**
+ * format_object_header() is a thin wrapper around s xsnprintf() that
+ * writes the initial "<type> <obj-len>" part of the loose object
+ * header. It returns the size that snprintf() returns + 1.
+ */
+int format_object_header(char *str, size_t size, enum object_type type,
+			 size_t objsize);
+
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*
-- 
2.35.1.940.ge7a5b4b05f2

