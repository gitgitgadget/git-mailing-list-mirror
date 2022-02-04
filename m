Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF1C4332F
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359082AbiBDNvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359092AbiBDNvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610BC061744
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w11so11480811wra.4
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dK5jNmVJ4rq+0btDdbLjErBgSAghCq4PC5Gnh2GK+tM=;
        b=JhXajN3FnheOljk8CnhsfeMScSOIqM63dib0Nw5MvtB5gGgtd15YFQ3jNQXmnr88fS
         wYafQ/620Xu1Hw0b4l1/443H3FXdhLXFEQR8/TM476YnM/4J3sH8Ut9eXn7AjtebaJJU
         8v42+AFYum24cUFUGLe8GopUtmwLQr0/eBI6aBXyNr/kr1KsgtW8jlqxBfNagwK/0Vvz
         dz2W873G0VcWd1LqdjMqI0QdqBQ6HKxobWTf80IXKR2WH5dBOwZbs+mcvnj4klSL/YnM
         p6IwvMeFr920uAWHTsnjOhXRLtt2qLB0Z5OOu5uEHL6Pbwj4KvnHTu6srgkHTqxV5Z/2
         7a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK5jNmVJ4rq+0btDdbLjErBgSAghCq4PC5Gnh2GK+tM=;
        b=A3ngM4TDBNhew8DWJr7QTS0pDqx5nFtFS2XCNfFD3h++EY8D2mDt1RfG3IR5N9dpaX
         L2JxLhnU7lcydRMyLy/BmkJB7EA3nkHt7ze31TffVUduN+Yd0Ivxu68DHX5cQimPYAT/
         MJSSOHbsxWgPI6NGXyVP/DudPVjr3wb8lgqzCsEisS/yghAHT4u8AXUsYYf0HoqX0Te/
         wdfH/+kB+IganCWYP1pULcOTAJxBWu0H6nXVIfsPhJiiifDu4EREZvjN/2VoLs2y2c2L
         5FC/CkRQnhfeuDOB0jnIR70QpprzhNrDivuhMpL36wBc0Hhcm+rhC4qqk6O0cZ/1jl7f
         DH5A==
X-Gm-Message-State: AOAM5316qtmqkeYqy0GEsFokULE6JbKifaXYNxgi5YWDRj6Qj4GcwBBO
        7DJ7fb+TqzIR4VN3TkzL0g3yHE/kKGrYXg==
X-Google-Smtp-Source: ABdhPJwUZKPeGuzYIZfNcQMM1Ol17w48qB+wzLgL+RrvDzWUYOAM1BuMMO/M58BBPAOFu6eWLRpN7w==
X-Received: by 2002:adf:f905:: with SMTP id b5mr2571617wrr.173.1643982691754;
        Fri, 04 Feb 2022 05:51:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:30 -0800 (PST)
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
Subject: [PATCH v2 02/11] object-file API: return "void", not "int" from hash_object_file()
Date:   Fri,  4 Feb 2022 14:51:16 +0100
Message-Id: <patch-v2-02.11-5ba49778ac1-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hash_object_file() function added in abdc3fc8421 (Add
hash_sha1_file(), 2006-10-14) did not have a meaningful return value,
and it never has.

One was seemingly added to avoid adding braces to the "ret = "
assignments being modified here. Let's instead assign "0" to the "ret"
variables at the beginning of the relevant functions, and have them
return "void".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 16 ++++++++--------
 object-store.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index ecc77973292..eeb6814780a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1836,14 +1836,13 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_object_file(const struct git_hash_algo *algo, const void *buf,
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
 		     struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	return 0;
 }
 
 /* Finalize a file on disk, and close it. */
@@ -2118,7 +2117,7 @@ static int index_mem(struct index_state *istate,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
-	int ret;
+	int ret = 0;
 	int re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;
 
@@ -2148,8 +2147,9 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type_name(type), oid);
 	else
-		ret = hash_object_file(the_hash_algo, buf, size,
-				       type_name(type), oid);
+		hash_object_file(the_hash_algo, buf, size, type_name(type),
+				 oid);
+
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2161,7 +2161,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 				     const char *path,
 				     unsigned flags)
 {
-	int ret;
+	int ret = 0;
 	const int write_object = flags & HASH_WRITE_OBJECT;
 	struct strbuf sbuf = STRBUF_INIT;
 
@@ -2175,8 +2175,8 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
 					oid);
 	else
-		ret = hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
-				       type_name(OBJ_BLOB), oid);
+		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
+				 type_name(OBJ_BLOB), oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
diff --git a/object-store.h b/object-store.h
index 6f89482df03..44f6868cc9c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,9 +245,9 @@ static inline void *repo_read_object_file(struct repository *r,
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
-int hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		     unsigned long len, const char *type,
-		     struct object_id *oid);
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		      unsigned long len, const char *type,
+		      struct object_id *oid);
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
-- 
2.35.1.940.ge7a5b4b05f2

