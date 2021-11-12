Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCEFC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46515600CC
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhKLJpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhKLJo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:44:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E3C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:05 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5861988pjj.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/6iXnqxfJ6pUit3Gd/WT6piNiAGRGDrqssqtaQL7Iw=;
        b=khrEwNw3GN+OyYBasLXUwHArobA9HINwpx4UDBOId6sVUqSMHjxfF4gQ2u3//PXYKE
         ar6RYT7fHcU8VjKbhzGDEJMCeVI42P6zavmP91qp6i6pngHo2U+3YS7ttaYhwQLyqYcS
         IwDwgGB9sM8+MmH3xO43v/U938+uNNOUCfHa25Z/ew2CYcZEYmNOd0f5c4HbZCcz057s
         lW13ytA9QXRYgkSsc+mXmQDT3bNHRoZpo4oN7VWqXpUWdd7dOh7zikTJgDAy3Gy8BYJK
         DlKLXAD/uLXJ/Tm7s6cPH2M+0RQfa+1JUD8u7p9KlXIbsTVV475NO2U403gil/ltAl2Q
         JAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/6iXnqxfJ6pUit3Gd/WT6piNiAGRGDrqssqtaQL7Iw=;
        b=C/ZTF3DRjCwHQg6ZReeSAHa62ISJuVCH9Rk9X0D1aJlXK09ueCkpo27NCq7h90JnSf
         0U9Jqc5TEzs5Ou2AiIg6OdcXHn4CaZkYrPFHs1icV6Inbg5SOMYy+jKZ2ktTf0tGifnV
         F9UZSBbvutY49UIcVY1jFPLq8w1LU3moxAyFoIXV7D+e3zocte3Ul3jA8ojyP2RvrfnX
         N4ZYgauabFVu063RIgbzfkpcVUuL6FMBaMMYUNUbyeIlgaiR9xZrcxn4rNYP2d1BQLXF
         Sgy6r4EXtIZGpjZV8hN7iKMrqi3u8w/ckCKyzsaYuoYm+agcrP9NOT5QX6lneGrUHoyB
         v+1w==
X-Gm-Message-State: AOAM530+hF/SNoR4KcQdFghlzts3NKkEJ0jmyUdTw3KyK61JDqm0mCQt
        X01hAXKHTgfsuL/IM1ZBEzc=
X-Google-Smtp-Source: ABdhPJz+faWQQsq+ZHmJv77Kx9P7EPTFOtKOOUafuT3PV7H8kwydDhXTkhf4/duIHiXha3uXA6Wqyg==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr33591110pjh.223.1636710125437;
        Fri, 12 Nov 2021 01:42:05 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.42.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:42:05 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 4/6] object-file.c: read input stream repeatedly in write_loose_object()
Date:   Fri, 12 Nov 2021 17:40:08 +0800
Message-Id: <20211112094010.73468-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Read input stream repeatedly in write_loose_object() unless reach the
end, so that we can divide the large blob write into many small blocks.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8393659f0d..e333448c54 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1891,7 +1891,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 	const char *buf;
-	unsigned long len;
+	int flush = 0;
 
 	if (is_null_oid(oid)) {
 		/* When oid is not determined, save tmp file to odb path. */
@@ -1927,12 +1927,16 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	buf = in_stream->read(in_stream->data, &len);
-	stream.next_in = (void *)buf;
-	stream.avail_in = len;
 	do {
 		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
+		if (!stream.avail_in) {
+			if ((buf = in_stream->read(in_stream->data, &stream.avail_in))) {
+				stream.next_in = (void *)buf;
+				in0 = (unsigned char *)buf;
+			} else
+				flush = Z_FINISH;
+		}
+		ret = git_deflate(&stream, flush);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (!dry_run && write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die(_("unable to write loose object file"));
-- 
2.33.1.44.g9344627884.agit.6.5.4

