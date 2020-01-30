Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E0C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998C9214AF
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Jw0KWK4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgA3Ud6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46523 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgA3Ud6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so4268500qke.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Edn93+Vhzlnnwnhkrb+f/jdc3rLUGFDFoiKL0V14Fw=;
        b=Jw0KWK4TF6O3oPsWKLfGbXUKBpJIy3dWu+w8dgJaqFynA9PZJ0ir4SQs+KhS85L7rj
         jtQrTk3NaaInmvt5gZlwI9R9ND2VGMiFjVd8nHeNHkEiktBVEBiOFL9Jbkk6u/m76bEF
         ItB04U2R+vRZAtqVIwFEV71ZpHWB+WuRHhsCYd0cTs5QP9gj1lqmNlUkmMrANeTtxoCl
         fqZFbCoAxdD5eEF3tV3RJUuzYK6RbCO/F3dO63itUeEB0KLBUMKXK7HyslOfH7VfjHiG
         rEHVRrF02Rs7vGM2QI/quSgd1aGtSwGk0H7Y5VUwnd464iWcMWIBfxGSJ12esA4F+9dx
         ZdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Edn93+Vhzlnnwnhkrb+f/jdc3rLUGFDFoiKL0V14Fw=;
        b=PYEckPFYbCWq68R0oR6nUO+mqQPc84rX64+BOoXb+mhyAZGBEsYi8ksZ8ccJcZzCeB
         ZN/O82rn0ygsOe4yzqANpIbC1H5zJmN8rDhMr0Q1MyR04LVGHTE9qzEJ2fqsMqu5vIke
         5Y+xhLXdUusWuv3JaJJjABojBcP3PD4Hwh/d/qsUOOU/sGuvhkFZIDOitS4p5wUoMQIl
         2NksEmTdV3XAIVlZiPwso+C1vyadYiMR5T/zehlXO+SJMPIW7XXb317oi6aH08dwhMhc
         9kIC7bX7tB3ZnWX0yoovCSWiJo1w4YlxDBIEJy09ZXM0531OiDepkcyuPv9XeyoRNUfF
         7Sjg==
X-Gm-Message-State: APjAAAVpAQurUObUNUI9/LJ+eleUMpi9vJOJAm3a/JYQnZq2HEwaJSMo
        m6cccY5IPs1fqZcy3/kdJDozZCfkSR4=
X-Google-Smtp-Source: APXvYqzJPOJk75y0pbamS2pOvNVhLY0Yes+w6j7XoYuUDX673KxWqEW6RKBrzRFZ0HgjnpkWQEFZcQ==
X-Received: by 2002:a37:9f57:: with SMTP id i84mr7220296qke.29.1580416437341;
        Thu, 30 Jan 2020 12:33:57 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:56 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 5/7] sha1-file: pass git_hash_algo to write_object_file_prepare()
Date:   Thu, 30 Jan 2020 17:32:21 -0300
Message-Id: <f256d2058736091c3d9662788762849e8df794b0.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow write_object_file_prepare() to receive arbitrary 'struct
git_hash_algo's instead of always using the_hash_algo. The added
parameter will be used in the next commit to make hash_object_file() be
able to work with arbitrary git_hash_algo's, as well.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 sha1-file.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 13b90b1cb1..e789bfd153 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1647,7 +1647,8 @@ void *read_object_with_reference(struct repository *r,
 	}
 }
 
-static void write_object_file_prepare(const void *buf, unsigned long len,
+static void write_object_file_prepare(const struct git_hash_algo *algo,
+				      const void *buf, unsigned long len,
 				      const char *type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
@@ -1657,10 +1658,10 @@ static void write_object_file_prepare(const void *buf, unsigned long len,
 	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
 
 	/* Sha1.. */
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, *hdrlen);
-	the_hash_algo->update_fn(&c, buf, len);
-	the_hash_algo->final_fn(oid->hash, &c);
+	algo->init_fn(&c);
+	algo->update_fn(&c, hdr, *hdrlen);
+	algo->update_fn(&c, buf, len);
+	algo->final_fn(oid->hash, &c);
 }
 
 /*
@@ -1718,7 +1719,8 @@ int hash_object_file(const void *buf, unsigned long len, const char *type,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
-	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
+				  &hdrlen);
 	return 0;
 }
 
@@ -1876,7 +1878,8 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
+				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
@@ -1892,7 +1895,8 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
-	write_object_file_prepare(buf, len, type, oid, header, &hdrlen);
+	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
+				  &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-- 
2.25.0

