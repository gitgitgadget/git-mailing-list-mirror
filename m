Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1866A20196
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbcGMPo3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34115 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMPo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:27 -0400
Received: by mail-lf0-f67.google.com with SMTP id a10so3970377lfb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhEonzXvoUPSYIq2fBoPOp/ODBeXxAF71Y4Pg7GGk7A=;
        b=SzmLBmQFQYxMVwslgrR0DxgQ8tvSAC5GlDM8FiFXUFQlw1jXiyiO1BkipTBEPBavSs
         zsMkrBVXvZ+kuneGAUWH2U9F/LwUf7m3bxTfsHUv7E0fj7fMxbHAcsAuz5FYQ855Zsy8
         TzDRijB7/6GljBFM3/wewNFUb7hyV0J9VwHv/0nw3m+H/zaejiXKx1TeMZTChUSZSDaa
         ThfdrZjT4ZEBDcCjR0ijMQnX+LHMb1T/tc+dj7cfPzMFpwYmCoSdqzh3SYctcZzV8766
         dCAa6Dkeiz7AYtmffmJ+MGP9QvJ53NJOXbz8ElzGqf+4rrkdzdeo//dPNUn+VONsqXVf
         UJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhEonzXvoUPSYIq2fBoPOp/ODBeXxAF71Y4Pg7GGk7A=;
        b=ZDn1CcPWhYt+zeLgwvDS75cgmAg/y5DOlZKW93F/wxzoTVGSI+IT/Tpi3ZPXmu0yjQ
         5rtPDgWGZnRzdxo/hwWvQgsuoh83xG0BJh8X5wT4W2RT3BbGync3W4HQkgvIa6caadrB
         hhdr9hvod34HAmTX+kBZn8JmOXrL950aFeEIKXeTj7Dpdkg7h/+bjvb9y+fZrRvOyu6c
         by40pOZcw6rSRyJ0PKwgYtClrUFmGOrTvvcNpLn0Ub+ufF/x//9A4bGr+RbsdGX0Pv8Q
         3kVVPEQY924zx+OyLIXhodS50IF/PenAkWD08nv5Dt/7B0bCNrN2cgYxA/4gTza93Xop
         rVGQ==
X-Gm-Message-State: ALyK8tLpNql8cpIFM3iyYGhPmh66IT0QcN0dm/sFmVBkNHbLmU55l6kv9wZ+OVSJNEOFMw==
X-Received: by 10.25.10.208 with SMTP id 199mr4568230lfk.124.1468424655627;
        Wed, 13 Jul 2016 08:44:15 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:14 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/7] index-pack: correct "len" type in unpack_data()
Date:	Wed, 13 Jul 2016 17:44:00 +0200
Message-Id: <20160713154404.22909-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
 <20160713154404.22909-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 32-bit systems with large file support, one entry could be larger
than 4GB and overflow "len". Correct it so we can unpack a full entry.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e8c71fc..cafaab7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -549,13 +549,13 @@ static void *unpack_data(struct object_entry *obj,
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
-	unsigned long len = obj[1].idx.offset - from;
+	off_t len = obj[1].idx.offset - from;
 	unsigned char *data, *inbuf;
 	git_zstream stream;
 	int status;
 
 	data = xmallocz(consume ? 64*1024 : obj->size);
-	inbuf = xmalloc((len < 64*1024) ? len : 64*1024);
+	inbuf = xmalloc((len < 64*1024) ? (int)len : 64*1024);
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
@@ -563,15 +563,15 @@ static void *unpack_data(struct object_entry *obj,
 	stream.avail_out = consume ? 64*1024 : obj->size;
 
 	do {
-		ssize_t n = (len < 64*1024) ? len : 64*1024;
+		ssize_t n = (len < 64*1024) ? (ssize_t)len : 64*1024;
 		n = xpread(get_thread_data()->pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
-			die(Q_("premature end of pack file, %lu byte missing",
-			       "premature end of pack file, %lu bytes missing",
-			       len),
-			    len);
+			die(Q_("premature end of pack file, %"PRIuMAX" byte missing",
+			       "premature end of pack file, %"PRIuMAX" bytes missing",
+			       (unsigned int)len),
+			    (uintmax_t)len);
 		from += n;
 		len -= n;
 		stream.next_in = inbuf;
-- 
2.9.1.564.gb2f7278

