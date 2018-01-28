Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6B11F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeA1ANp (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:45 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44127 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeA1ANk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:40 -0500
Received: by mail-lf0-f66.google.com with SMTP id v188so5004137lfa.11
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=6oaq8gZ234IKgvgE0oN13kzcAr9Zuibqnij5aluG1/M=;
        b=I7b8ney2XwVw8dtX26aJ1190PTQbkHcz4+RESs4IlZQj2wnAM2+r39d7Z3NMtumSPX
         Z75f2RU4uQ8g68iXPzl43DcqnJD0070F2N0a9OToK5M1udtVr6B1Il4TnC8z8cAN+MfJ
         hr35edagTPst/PYb81JnNpcGPz72ADtKLb4m6pzWRM7SllSE3+qUycKGEJXfWsniI1N3
         Gb5WTavL10Dhf6rosNblNgO2Za/Aigne55ubVDcL29DtRtVntdpydi6s6nQbUcZeFO5z
         c3zIx9sh8eOb9zRMgN8uUowAVojBXkSQVKRXQYa1l15u0g+L8dXB63NlApepvPB4D3CM
         HwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6oaq8gZ234IKgvgE0oN13kzcAr9Zuibqnij5aluG1/M=;
        b=HpFBP+9MKhne7LihlYNYWVmqvSdRTwImGHPrjSi1a5zo9V+joqGfOyTQAfBi89BI7L
         jcaIeojCnSfPca32HYYoU7yhMKKuTU3YL/rf89VsRjWa1nN2Rv5lVHV0DiS0sBOTsYf9
         RMaSJ784V8GBGu8V68gkgQKPRNXMEd+eSV09vZt4nzUgF4+OtrVMGRLo6wFOGlJErp2z
         Y2FW2WV7Rh9wDaa2UX9nsknHc32paszaKEI8SvdLruFAp5UeVEVb6k8YFAzEYsRVFI5Q
         AncIRzjhwGvBGaKLUsgwZoBgNNasp9ZnYy8hwM+BEnfrtBg9v7aT1c1fOXOqJG/XeJ1o
         X42Q==
X-Gm-Message-State: AKwxytf44OuzVU5Qfwb0vMVfuvhDst0OB7ZeF1IwI4i+Qa6MEXpksyUm
        hZ+kk0xuEXG66u4eWVAWGwvFBJrn
X-Google-Smtp-Source: AH8x224QF6rh3hT8wW9jrP4piXzNYtyK+M45lT87D8WGbFU2wzNC4Rg4alK2ynNCx/OWBVFYffjxJQ==
X-Received: by 10.25.92.13 with SMTP id q13mr10223576lfb.69.1517098418613;
        Sat, 27 Jan 2018 16:13:38 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:37 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 11/12] sha1_file: convert write_loose_object to object_id
Date:   Sun, 28 Jan 2018 01:13:21 +0100
Message-Id: <24cb733eaa949af55d9e48c22d6f540217fa28c1.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of static write_loose_object
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

