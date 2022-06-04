Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E6EC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiFDKKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiFDKKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2201F63B
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l2-20020a05600c1d0200b0039c35ef94c4so3280084wms.4
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrw2PhCnUqkOE/JD0VzYcglHW4qkJCcZ9155hsdXwpw=;
        b=gmRIMkUoTX0JE0NXH+XsCwugDVZ5Oj//tvr4MwL9uNs3UjAS2X5+eXoqmaJS3nv0PR
         vWVRlhJfbd7LZwVq3Z5BzomQTF8PrUm5OzLjAIsvQHlNHz0cvBb47FiNemZWmKazLVMx
         go6J+KZzvR43K1bN4NqydUwxdltVvoUA5Y3l8A3fiq5A6WePZi4O1ZzVImVN7LcPVvjc
         lDoF01ZxtLckHJBK9Pr0/gHIUCweHoiwo0QB1WVdS1tIE9l9aqj4dbhMl/w14XCyL8Iw
         daEYEnFHjsETE4W2PW74X2nce0vLLdiFdNJAVNoTUOjgKzuGR9H4dtKLxPmmco5m10Dh
         Gi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrw2PhCnUqkOE/JD0VzYcglHW4qkJCcZ9155hsdXwpw=;
        b=q5HnzZqKlpftqpl3PF6sc1rpzFHt1+cLF4FyNquPjZdfcRY8ZjVS6QZKvee25bOK7V
         wW1sVqIYPHOTgWX9PZcLy174N1+CI9X9P0KQ6PIkGNtFReliv/oLv9RXO9oGRqqIktGB
         Iv/rTnUYdxoUif56AxBFQVOzqNU+gnbJBPSeL4YT7wMejMYAMmilGTLG7+uQ5DCGW0DH
         V/24D9fiOwsq++hEoRS+Gbyex67+b2rL2zlwhGZD/cd/Pur++2pRYi7wTY8zRK65gBKH
         ZF8Mykyg47672LdZ4RXpcCLAL1ksI4lSXWYzlI691J/RJ02bC4DsO4v+R9pBdJ5Amxpn
         gNZA==
X-Gm-Message-State: AOAM5309uTAIkH/ZA0TKwbNWWnC6O66rqbjHnQf8R9gW/64/GkvJSGfe
        St2DJRUdXw35V530JVkjfz7xFFiz8/GeJg==
X-Google-Smtp-Source: ABdhPJz1AQW9cBMiZrbl9I8nq07YyrY7xC64uQLdMPRYGRUhonqMWSNrFEC1WB+Mj+vB1MLMyzLTNg==
X-Received: by 2002:a05:600c:4787:b0:397:4891:2c3a with SMTP id k7-20020a05600c478700b0039748912c3amr12939472wmo.37.1654337436254;
        Sat, 04 Jun 2022 03:10:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 3/7] object-file.c: refactor write_loose_object() to several steps
Date:   Sat,  4 Jun 2022 12:10:24 +0200
Message-Id: <patch-v13-3.7-9dc0f56878a-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When writing a large blob using "write_loose_object()", we have to pass
a buffer with the whole content of the blob, and this behavior will
consume lots of memory and may cause OOM. We will introduce a stream
version function ("stream_loose_object()") in later commit to resolve
this issue.

Before introducing that streaming function, do some refactoring on
"write_loose_object()" to reuse code for both versions.

Rewrite "write_loose_object()" as follows:

 1. Figure out a path for the (temp) object file. This step is only
    used in "write_loose_object()".

 2. Move common steps for starting to write loose objects into a new
    function "start_loose_object_common()".

 3. Compress data.

 4. Move common steps for ending zlib stream into a new function
    "end_loose_object_common()".

 5. Close fd and finalize the object file.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 102 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index e4a83012ba4..ce8b52a8dc3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1951,6 +1951,75 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+/**
+ * Common steps for loose object writers to start writing loose
+ * objects:
+ *
+ * - Create tmpfile for the loose object.
+ * - Setup zlib stream for compression.
+ * - Start to feed header to zlib stream.
+ *
+ * Returns a "fd", which should later be provided to
+ * end_loose_object_common().
+ */
+static int start_loose_object_common(struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     git_hash_ctx *c,
+				     char *hdr, int hdrlen)
+{
+	int fd;
+
+	fd = create_tmpfile(tmp_file, filename);
+	if (fd < 0) {
+		if (flags & HASH_SILENT)
+			return -1;
+		else if (errno == EACCES)
+			return error(_("insufficient permission for adding "
+				       "an object to repository database %s"),
+				     get_object_directory());
+		else
+			return error_errno(
+				_("unable to create temporary file"));
+	}
+
+	/*  Setup zlib stream for compression */
+	git_deflate_init(stream, zlib_compression_level);
+	stream->next_out = buf;
+	stream->avail_out = buflen;
+	the_hash_algo->init_fn(c);
+
+	/*  Start to feed header to zlib stream */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	the_hash_algo->update_fn(c, hdr, hdrlen);
+
+	return fd;
+}
+
+/**
+ * Common steps for loose object writers to end writing loose objects:
+ *
+ * - End the compression of zlib stream.
+ * - Get the calculated oid to "oid".
+ * - fsync() and close() the "fd"
+ */
+static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
+				   struct object_id *oid)
+{
+	int ret;
+
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		return ret;
+	the_hash_algo->final_oid_fn(oid, c);
+
+	return Z_OK;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1968,28 +2037,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
-	if (fd < 0) {
-		if (flags & HASH_SILENT)
-			return -1;
-		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
-		else
-			return error_errno(_("unable to create temporary file"));
-	}
-
-	/* Set it up */
-	git_deflate_init(&stream, zlib_compression_level);
-	stream.next_out = compressed;
-	stream.avail_out = sizeof(compressed);
-	the_hash_algo->init_fn(&c);
-
-	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (git_deflate(&stream, 0) == Z_OK)
-		; /* nothing */
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -2007,11 +2059,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = git_deflate_end_gently(&stream);
+	ret = end_loose_object_common(&c, &stream, &parano_oid);
 	if (ret != Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
 	close_loose_object(fd, tmp_file.buf);
 
 	if (!oideq(oid, &parano_oid))
-- 
2.36.1.1124.g52838f02905

