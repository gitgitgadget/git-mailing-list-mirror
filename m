Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F3BC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359095AbiBDNwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359106AbiBDNvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7532C061758
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j25so10763650wrb.2
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IMVPDMfqLzYQtQ0XCwJw9tM7y3TAfj6XmtBZusbCdw=;
        b=PaoDvCpCHk9bkRL8VxUjW1gFG++fGILsnDDiMjJLoL8X4H09fjkED6TGmVBIPHGyO9
         NYjGJGcT9gpPfxxbYYqURpKVtOr1jHXfqv3bdcV2Y8/I5CAch4vgmu3QZjUg08ICoEw2
         yGISXkJpUZJDS2+zLugyNNzAF0XGw6rFTt75LigVD59Ix3ciV6pY+9ajIfeU4POghSVp
         ecwckFG7wueCgk8m0V56S2uWWlyxRRbtdtCvP/UUvPhgwzYI5va9wVfGLq4aX6/uausU
         kelx5ZcIcRDOrN1P0gPhuxJkj4Xr5rNLEtK/eif+HocIuXTZVQjv/u3lZ5EpvEM4nEgI
         GR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IMVPDMfqLzYQtQ0XCwJw9tM7y3TAfj6XmtBZusbCdw=;
        b=pKrMwMYmFVcY+5ShEy7MU3dOk1EJE5lTPhdKHnOc74d3IMsoBGXfwEF4xABcjx3bxD
         D/mISNBKcGSF3n1+w8Dy6Iu5acG7Le4BIFo7AXxNfzxT/KssKWRPcpDdDUGoE37Hud8o
         g4v/kuMBBPLEvIt9EGhRD8jIia1DCdxgSlJMqY6Btocs9ZfzuAUFW0n1DfB7tkSG9P2v
         LpND1RyG5a4/ZeGb1ZqoJElDCx/Q5yd+TcaRCnIjVi2N0yX2SuT79AeYYKakrZP9Of6p
         qWmz34knZoM2OwWYWze83QT1ozCK3BBTHmQVYglor3+u39AC+08ZsvB9jk4kYxdSz6Ao
         mAEQ==
X-Gm-Message-State: AOAM532RS/u965WnNxf0Xd8xzcgbHZYU7JqnP9XNcEqjfb8y+BwFirLZ
        i9CuhsU8JAeJFIg9BIPTzJZFuUa2QI7SwQ==
X-Google-Smtp-Source: ABdhPJyCq9n/aVcNU2O4z4Z12Kj5cbcfVzwDMVl5S9esu+T5qFpXwpONK3kphvx9p1sd9ccymWuHIA==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr2539861wro.110.1643982700061;
        Fri, 04 Feb 2022 05:51:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:39 -0800 (PST)
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
Subject: [PATCH v2 10/11] object-file.c: add a literal version of write_object_file_prepare()
Date:   Fri,  4 Feb 2022 14:51:24 +0100
Message-Id: <patch-v2-10.11-e39edfbce05-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
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
 object-file.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 97a3493f5fb..cba33b25197 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1784,21 +1784,40 @@ void *read_object_with_reference(struct repository *r,
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
@@ -1858,7 +1877,7 @@ static void hash_object_file_literally(const struct git_hash_algo *algo,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	write_object_file_prepare_literally(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
@@ -2029,7 +2048,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type_name(type), oid, hdr,
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
@@ -2046,8 +2065,8 @@ int write_object_file_literally(const void *buf, unsigned long len,
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
2.35.1.940.ge7a5b4b05f2

