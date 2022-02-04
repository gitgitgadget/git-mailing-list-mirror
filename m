Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A16C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377990AbiBDXtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378304AbiBDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DBFE00951D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h6so1027330wrb.9
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRBYgCiTCMIwKE5VUsHTcHEgDSJNmhABMKwhFQpfx8Q=;
        b=RCY1MCj4oSR/UFNY3ytuhMEH0lLgjNjIGmruTF0dP0ahsQJYduSKXbjy7/OTVSaiQG
         Wv/z5wstJXT1PwB9j2bGRnolIF/BV+dMXy+Tb4RuB4ktefXHXqSwMFQ8BC5Advtwm8On
         LP6zZdKdsuH3dtnvlAEcNUAjc+afPKIePSf+cMSiwIIquh/MAqm25nTPoyBsevddWPIg
         Z3N8hHaf//hRm/6hOFm9Tov7gnhKmS5Vj233od0RDmornsa6paPH3ZEyt9Jg65Ny2hsj
         0g0YdGAucuKiFZQsLruvGkD8P0NhESw9SFUOfDeZPSz+Q8Jne6F2IwITgXwm2SSSn8Jx
         pAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRBYgCiTCMIwKE5VUsHTcHEgDSJNmhABMKwhFQpfx8Q=;
        b=H9MmE1XGRJe8FTQkBm05tJurf9EC3k+7xqUs/JJiv02hGTUzXO2SdausYrsx82mAmr
         GuQbK69HAX+NIGpuWydSVlldJpqLPJlW5FSj9CsE5kUZ+LLS00DKT3N/sV6zCDNGDF8B
         N7m+AJTC+bC7N5Nj8PcGVuktdD0iAxLydR+tHDBsg+c8/+IlR4K7sT9sRrGt6AmOeOi+
         eVlmBuPA2i7x1EeaJ18AYrtzE0xXMrMwC5drjHFLYCbH0IxfEsNbyPsZ1AkZFmqHGS8t
         q5NvTHVfrAiLHSi8bL8jXziDDlRAl1ZpA7rIUCwNThavnmmhqjqpIooEfRki21bqAMHR
         vaug==
X-Gm-Message-State: AOAM531Ky5ikM0PKTxj4fl4rq/MDB4lZFTbYzlKn9dvYt0knTGJRjTVc
        GRkB5oG5HRY/BjDCFVHZIQ9FyqLjUpOXyg==
X-Google-Smtp-Source: ABdhPJzRyAlSCXqVnmszSLKQhDWKnEfkY1OItkhfetkeVm0Bqf94HTOUOnmKIh14GvdezoEStLaJBA==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr976673wri.310.1644018530137;
        Fri, 04 Feb 2022 15:48:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:49 -0800 (PST)
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
Subject: [PATCH v3 11/12] object-file.c: add a literal version of write_object_file_prepare()
Date:   Sat,  5 Feb 2022 00:48:33 +0100
Message-Id: <patch-v3-11.12-ad1a777f454-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
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
index b1cb78c4419..c75c12dd0ba 100644
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

