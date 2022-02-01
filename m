Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8978C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiBAOxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiBAOxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF37C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so2170440wms.3
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBtmnYDl0fiOkPBBFn+NE6P3pDJUDzSq0rNX3Wr2X/4=;
        b=qF8eyisPao0w8zfOuQ5R1zVyPL4SAwXS+kwf5x3fO3P+aCTWfSeOU7Dcp6+muFkOa+
         UaSgLJjTh2XvrogOdtSkJESwSGBJyzbWrYyXea0xLhJPGqMWCxPFKskgkSRMo26v1OVn
         5RqLHGfNbtDHKlOW69fVO7GwI9Aq1jTnbAqQs0Lj0AuRzlNKN9QpKA4yJFNabDcV6z1O
         boNVKgKipesal9TMG+fRiGD9AWSp5qt+DXzYN28NNalDsI/E8fJNH1qACV5bv/h3zfqm
         461PFgBthQmmSiAjwJ0vRHPaPMgfSAjMCjJduKD+NY5VO4nYAigp+LVe93Be12tX+Han
         9msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBtmnYDl0fiOkPBBFn+NE6P3pDJUDzSq0rNX3Wr2X/4=;
        b=FG8IHQbN4zf1fP14f8LICmFoQbjUPXMiLKXAKeGet0ZJWzVl6BSTOAr8EV9K5LiE1V
         wpSWtmHC0aEp4C/nmLHUhvUqCXStvGP9uGDdRg6hXKUyehQKFG1Inteu6XxhuoIxf/mA
         WcsCmyH5O0kdsjx7kRhoPT6fYoZnA5NS63vMHH0JGHUGv6x3QVZemYHehhszhRQaz7o7
         PcZH22z0+GaquBbsj8B24KwqnSJftzEc8WSqtqO6DcBAUvL2gawktdJXSB8Le8obdtMo
         Jny0uTNFZp9gwxXl3essP5sIU1OdNcEZ8oL9eeF6MJewxUM5i3SVrFJbMSj7Kx5arttx
         NNpw==
X-Gm-Message-State: AOAM5320o/ALj7stjsZtzZtdpsHDRijv/zv4DxT4EoCSBk22Y6oggdFk
        Y+637hg/SWC/wLv7hR2wKX+IpYsw3X7i6w==
X-Google-Smtp-Source: ABdhPJx32elmkU8Q+vaRjCVYIaLpxYtnlUEWJ++6f3fykiP884pzeqm1x85IczVBYZQsAUUENjfFwA==
X-Received: by 2002:a05:600c:250:: with SMTP id 16mr750585wmj.47.1643727198374;
        Tue, 01 Feb 2022 06:53:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:17 -0800 (PST)
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
Subject: [PATCH 02/10] object-file API: return "void", not "int" from hash_object_file()
Date:   Tue,  1 Feb 2022 15:53:04 +0100
Message-Id: <patch-02.10-ab1d204f49b-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
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
2.35.0.913.g12b4baa2536

