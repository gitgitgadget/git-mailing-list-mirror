Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6AC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351425AbhLCJji (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351436AbhLCJjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F650C061758
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2040816pjb.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gScyMy5WEdyKHwcbjQF64X523jAtZMtpE/tzSykJIf8=;
        b=UCTFbUtD0tKLMZ/YKFdTc6n/ESPx1v4BDOcjd7gcjv/XVeKx+0uO554XUPVvLPSdRd
         FRt8/vXDKrOAWFqYTH700gBj5DEEZnBMDiI2LYekhfT52eIcl18r9jhAqaLjMq5+oyPt
         aRUGPoA3gp52x9LQZv1IMh69OWiugtgt/4XOb5vkQ1aTgK2bWJngVI8mhTo2wmxM35L3
         geRkRlB1ZvDZZVwfyGNlu4nhGQqXQZB0Uf9yrNeQNoPwQYprQDTjF4bGIWRw88VDW8Nc
         dHC/T0edW+fANh6xhW7Gh742gZ7hyiTpiGGlTrcdfrABhdPjejWXFqEEEeLzvakQZIjk
         jFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gScyMy5WEdyKHwcbjQF64X523jAtZMtpE/tzSykJIf8=;
        b=Rzucr7sxAy16R15/cpBZX78+IvLG8RhNNgDnD/sM3Bcd/Zae+1iMPAIpD+OaiKqbjA
         0S8PDSYMU2YEpVCY/0VkxfjIX46bmnp/V1kyMch3JJ9UiEXaeI0PSKTwfZtLTgmRvl63
         stJfXR4kMmuCRGZW1HqSOyk3yc7qsxvu8w+LktR2TAMuL7V4t/0DxeB8uz4QaPOBQ2Ly
         rjpsQTKSHI9tuVF4R7bZ+rxJT+rWTdh0AQv6ziMTrXFjcmzxf8z+CDainBvh37wvc7Ez
         fNrxgLXNJdj/nfKrPLUlmAGd4PUPe7H82UhhrMI1wRQZS0W7NdRpKP8g28JKVOipRUws
         wJ9g==
X-Gm-Message-State: AOAM532beIGEg4iL2E0izJQNUbiqA1rWAgtfgn6HQqNVYpc7qPHwSBrt
        LQt68tJvu/zAKywLecdN+Fs=
X-Google-Smtp-Source: ABdhPJy1aNHCHlM8oAzRPc5hSaNnmfs990MmM7SqP18nzHrxWB40BthpUXkzCZGjwx8I9viP9kIhvA==
X-Received: by 2002:a17:902:e852:b0:142:19fe:982a with SMTP id t18-20020a170902e85200b0014219fe982amr22157645plg.13.1638524173404;
        Fri, 03 Dec 2021 01:36:13 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:12 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 3/5] object-file.c: read stream in a loop in write_loose_object()
Date:   Fri,  3 Dec 2021 17:35:28 +0800
Message-Id: <20211203093530.93589-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In order to prepare the stream version of "write_loose_object()", read
the input stream in a loop in "write_loose_object()", so that we can
feed the contents of large blob object to "write_loose_object()" using
a small fixed buffer.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1c41587bfb..fa54e39c2c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1890,7 +1890,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 	const void *buf;
-	unsigned long len;
+	int flush = 0;
 
 	if (is_null_oid(oid)) {
 		/* When oid is not determined, save tmp file to odb path. */
@@ -1925,18 +1925,23 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	buf = in_stream->read(in_stream, &len);
-	stream.next_in = (void *)buf;
-	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
+		if (!stream.avail_in) {
+			buf = in_stream->read(in_stream, &stream.avail_in);
+			stream.next_in = (void *)buf;
+			in0 = (unsigned char *)buf;
+			/* All data has been read. */
+			if (in_stream->size + hdrlen == stream.total_in + stream.avail_in)
+				flush = Z_FINISH;
+		}
+		ret = git_deflate(&stream, flush);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die(_("unable to write loose object file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
-	} while (ret == Z_OK);
+	} while (ret == Z_OK || ret == Z_BUF_ERROR);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-- 
2.34.0

