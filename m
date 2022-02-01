Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C1CC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiBAOxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiBAOx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4EC061757
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u15so32583603wrt.3
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFXOdfGCqyBDNrZ6+h/fCwoYY60e2HMCpK3xuGxEg+8=;
        b=qaw/GkVeBJ9W9Y0DgVEDx5X0IOUy0+N2D4kG21zodOUbc7+HUSL2nX7S+ylquvBUbO
         de7F46hqH/yxiTo5wT4yChjSJki/MxpGctdCpztzwYCz2vHPh5D2E422u8MmG6JmsVsz
         8AVSouY6fXRnLd5/40iPcWukTYVUaXf78kVi0E49O0G803aw/PVieTTOLTTNXBZVvy1P
         KWgt52tssT+QBBkpKwaPTOjNsCNY8kChYrSRXDgl5NbinDiZFdVsYuAOKqj9kF1FOBM9
         6YDorW3ZsvH5/KwdLXzxSmLqmmcHaUpbRxU3+LjU0wO05IEF8lQv/wfEs1nGrpJZjfJ5
         Iuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFXOdfGCqyBDNrZ6+h/fCwoYY60e2HMCpK3xuGxEg+8=;
        b=HKNSQkqKeUy/6tbGVtei0A7zQLAPmsrEuquVA1DYN1ukVKEQAUAtPnp2OtURAb54U1
         5hw07cRwKat3zcQdNhOW2kDI7TCXfI1qenWfzdrGTq95IahGGl2TuAL+nogzWp0zcR2k
         GxufmWj4ZOv0Gdkh+LOjHWvAvW2Y7ta2NZxgMGeu+S5bMYdocePP0zLdxBYT/B6wImEl
         KeG2HdxgEW/3g4YohWqzkCQ+wn/6vGdts5+F9Zvks7ll9/jt3GjIZdNjDvvlGTo+z/C/
         n0tJJjmQQuKOJAiQ6r0FXp2Fd2JWZ7q89mbQz4QzNOC2iCQz0ISLDsFdjF23ioilicIh
         wweg==
X-Gm-Message-State: AOAM531htJKyJfKVEhamlBp1RqZvzVP1hoD3nVCMjjlUswoxGS68SavG
        nu1kZrgZkbzDnE/jzrwFpZ1K0ExxTEl2Pw==
X-Google-Smtp-Source: ABdhPJzBEjWOiI8vj2fPsMQFhKOhQDBZhkxQEBALuX3sV4OecSQh87qADjVH46D9yozkQhhlEK/7SA==
X-Received: by 2002:adf:ebc2:: with SMTP id v2mr22346899wrn.498.1643727207497;
        Tue, 01 Feb 2022 06:53:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:26 -0800 (PST)
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
Subject: [PATCH 09/10] object-file.c: add a literal version of write_object_file_prepare()
Date:   Tue,  1 Feb 2022 15:53:11 +0100
Message-Id: <patch-09.10-009b6604d6f-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off a *_literally() variant of the write_object_file_prepare()
function. To do this create a new "hash_object_body()" static helper.

We now defer the type_name() call until the very last moment in
format_object_header() for those callers that aren't "hash-object
--literally".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 27f587d1dcd..0a6d56db39f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1775,21 +1775,40 @@ void *read_object_with_reference(struct repository *r,
 	}
 }
 
+static void hash_object_body(const struct git_hash_algo *algo, git_hash_ctx *c,
+			     const void *buf, unsigned long len,
+			     struct object_id *oid,
+			     char *hdr, int *hdrlen)
+{
+	algo->init_fn(c);
+	algo->update_fn(c, hdr, *hdrlen);
+	algo->update_fn(c, buf, len);
+	algo->final_oid_fn(oid, c);
+}
+
 static void write_object_file_prepare(const struct git_hash_algo *algo,
 				      const void *buf, unsigned long len,
-				      const char *type, struct object_id *oid,
+				      enum object_type type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
+	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
 
 	/* Sha1.. */
-	algo->init_fn(&c);
-	algo->update_fn(&c, hdr, *hdrlen);
-	algo->update_fn(&c, buf, len);
-	algo->final_oid_fn(oid, &c);
+	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
+}
+
+static void write_object_file_prepare_literally(const struct git_hash_algo *algo,
+				      const void *buf, unsigned long len,
+				      const char *type, struct object_id *oid,
+				      char *hdr, int *hdrlen)
+{
+	git_hash_ctx c;
+
+	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
+	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
 /*
@@ -1849,7 +1868,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
-	write_object_file_prepare(algo, buf, len, type_name(type), oid, hdr, &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
 static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
@@ -1859,7 +1878,7 @@ static void hash_object_file_literally(const struct git_hash_algo *algo, const v
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	write_object_file_prepare_literally(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
 int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
@@ -2036,7 +2055,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type_name(type), oid, hdr,
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
@@ -2053,8 +2072,8 @@ int hash_write_object_file_literally(const void *buf, unsigned long len,
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
-				  &hdrlen);
+	write_object_file_prepare_literally(the_hash_algo, buf, len, type,
+					    oid, header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-- 
2.35.0.913.g12b4baa2536

