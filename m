Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A201F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbeAXLMo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:44 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33579 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933175AbeAXLM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:27 -0500
Received: by mail-lf0-f68.google.com with SMTP id t139so4749841lff.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=09UBcZxKcosoHPD3uReQJufL0Hq5fDdpzmHnfyEyQHE=;
        b=LZAyFJ8QPGWU25uzGLqXliHLwV7I/yZr7vdN8WYbwAv8BM77yS/TVjRiydCYF72k5l
         iVEwEUZ5Qz0TeWqsnK9W+mNdIPifrTNXwbkuyGBUfls8k7c72GS49ldmdv6G5kPnje+C
         bP4at5c9dKqGo2TQsluiWTGTzvnWlBB1pxCp6tMAmOdOF725Bk3bH6UxvkGtxIczWcO5
         p1EVDFn6KiP7xYjmAuSmarhgK/BI+RvVDjA6uaflP4U/7Ss38arFsfNnLEvDMGQo5t19
         8aRYo71xJg/8TX8AJC2XmR2cEAA39S3/7Aj5ryQMRPd82P5N98k2b90F9qdCEzB/+zyf
         gnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=09UBcZxKcosoHPD3uReQJufL0Hq5fDdpzmHnfyEyQHE=;
        b=UlX0Ocqf8S3YnSg+EOHoNChho4HLQ5tjZoVqTs/reg0GqB3R3mCrrm3p1NvPdVBxuj
         4ijYqvMvjHAfFiPh2/kcX6uF6NEmkMyOuu4Qf/KA9ioZe77vBciGFuheLL929vtxmKvs
         EqAJoYYyd+bcDfLKrnxCKxyCY12tPrflADIau+LXVOuLRuJv+KgwPr7hzKf2C1bzdXFw
         PWjmpQcz1y2h72epvWMkfNQVoxlJYgVTt7OrzzMaLPyKkZhSpkUKuaNVOZ4Vo8+egp+w
         DQjrsY6xlLOWwFFbJHCJGZU01tqgtGsVR0bvFAtmCh37xry8uwc9/BOqNS5UMwAHJmc1
         aoXw==
X-Gm-Message-State: AKwxyteOMC+Yc94SedE7R0zl7jUpW/K1UsbDlhV3idwLhzAZ7FWd86dn
        vZ5uLw8Q4i7OZ0qLB/bHAgQlhZSF
X-Google-Smtp-Source: AH8x226ftES2OenDtPQHtaUegADZeCQhi5CkbwhKpmGJZ94o59F/fDAFhN3VbSWpLd6+KpSiwgy2bQ==
X-Received: by 10.25.222.147 with SMTP id i19mr3408622lfl.75.1516792345736;
        Wed, 24 Jan 2018 03:12:25 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:24 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 13/14] sha1_file: convert write_loose_object to object_id
Date:   Wed, 24 Jan 2018 12:12:05 +0100
Message-Id: <6e4c38ccef5fd1cc5fd57b6894e0d9fb4d0f012e.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of statis write_loose_object
function to struct object_id.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d9ee966d74..59238f5bea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1548,16 +1548,17 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
-static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      const void *buf, unsigned long len, time_t mtime)
+static int write_loose_object(const struct object_id *oid, char *hdr,
+			      int hdrlen, const void *buf, unsigned long len,
+			      time_t mtime)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_SHA_CTX c;
-	unsigned char parano_sha1[20];
+	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	const char *filename = sha1_file_name(oid->hash);
 
 	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
@@ -1594,13 +1595,16 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+		die("unable to deflate new object %s (%d)", oid_to_hex(oid),
+		    ret);
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
-	git_SHA1_Final(parano_sha1, &c);
-	if (hashcmp(sha1, parano_sha1) != 0)
-		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
+		die("deflateEnd on object %s failed (%d)", oid_to_hex(oid),
+		    ret);
+	git_SHA1_Final(parano_oid.hash, &c);
+	if (oidcmp(oid, &parano_oid) != 0)
+		die("confused by unstable object source data for %s",
+		    oid_to_hex(oid));
 
 	close_sha1_file(fd);
 
@@ -1645,7 +1649,7 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		return 0;
-	return write_loose_object(oid->hash, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
@@ -1663,7 +1667,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 		goto cleanup;
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		goto cleanup;
-	status = write_loose_object(oid->hash, header, hdrlen, buf, len, 0);
+	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
 
 cleanup:
 	free(header);
@@ -1685,7 +1689,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(oid->hash, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
 	return ret;
-- 
2.14.3

