Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4CC2BA19
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 03:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E316E21D91
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 03:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXRLwXMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgDRDzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDzF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 23:55:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81FC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 20:55:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so1932430pjb.4
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rkiZwvxsE8w1Tz9DVMpd8i3xRH3H7bCg//76q+Jrq/8=;
        b=AXRLwXMKQzX0ft+AQWVeM83P4XwdodcMxwK6HtqDS6NJBmzCCFDPKXaoJ8Ncjapp0d
         E77fEIajrjdrZHnhx8uR6uwLH533E5VopV7LBGAFufqcssQyqCxT1WKgrDcLzCQam8Cj
         xw40EDAQ2TZ/RRpH4vJVtYRhgw+6HzFeR+zRsGfjm4eDqKbjGgQsv38OjlXSeeE3ER5/
         0u7LoTjNgID8KHyqa934PHL74S2Fx+Z2ZqAqqRpKWEwOP+Ir+990X1yXaOeZYCFptJB3
         B3YQODvW+PVZdDKm3mV/U8nSSX3w2Rhl0L+t50t/pbLIgVf+SJwC6vwQ99O0xc0nZXQR
         noaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rkiZwvxsE8w1Tz9DVMpd8i3xRH3H7bCg//76q+Jrq/8=;
        b=NwzmuEBZy1u2QQV6cYd/Jab1MKHfdcEQJxPqfP0vZh3JqNxWn0XMfEuIM7IFDSk7Dh
         46Ue7ipqGLVaczK5yoJKqH1A/yv3gbMf1gIriEKeCbwdzksMUMuECScF/tfft2MTsZ/8
         AOdDzC69gljbIDKdvhDjpDdzKm2A7lbopTsEaGMrkb/4GR5A/z7ZNuJtDW1sKisRdwv5
         dkxfXYcHD38f3WUnPmbn0MJzQDJ00S9Jmcgvj/J1mri+igFwOnfvTAtEcHnZh1KkhT4f
         Sh1eBR8Hjd+YiMOZUUFiNkHwq1+bT2h23jqLjuGEEW8WZYdMZ7vVloUJFLVmRlYZ8Pqm
         SJrw==
X-Gm-Message-State: AGi0PuZZKAB46+4krFYhg02DPqzW8BLOhV5SV0Td4RZ+p3bBfEVGQVPl
        vBrPBnBoBSZ1iF+TXVuY4Dtcd2lu
X-Google-Smtp-Source: APiQypK+thsK5nf0GNSlwkmcC0Z/0BsKL4Y6f6rJdup1HP5ZjGXODfeqtd4YETbfmjIF3mujpkkDMQ==
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr7928918pjs.98.1587182104558;
        Fri, 17 Apr 2020 20:55:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id w13sm5957353pfn.192.2020.04.17.20.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 20:55:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
Date:   Sat, 18 Apr 2020 10:54:49 +0700
Message-Id: <20200418035449.9450-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're passing buffer from strbuf to reencode_string,
which will call strlen(3) on that buffer,
and discard the length of newly created buffer.

Then, we compute the length of the return buffer to attach to strbuf.

We can do better by reusing all the available information,
and call the underlying lower level function that will be called
indirectly by reencode_string.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 742fa376ab..0e9911df6d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
 			   struct strbuf *line, const char *charset)
 {
 	char *out;
+	size_t out_len;
 
 	if (!mi->metainfo_charset || !charset || !*charset)
 		return 0;
 
 	if (same_encoding(mi->metainfo_charset, charset))
 		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
+	out = reencode_string_len(line->buf, line->len,
+				  mi->metainfo_charset, charset, &out_len);
 	if (!out) {
 		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
+	strbuf_attach(line, out, out_len, out_len);
 	return 0;
 }
 
-- 
2.26.1.301.g55bc3eb7cb

