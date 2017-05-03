Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D687207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbdECKT2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33137 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbdECKTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id b23so3687244pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=co48SpS7itFAzVN9BhiHlDIMZipUfF9g8PJ6ZE/5WfU=;
        b=EQCSB+0Jv5Nx/KEVbZf1Z0VBMJJPQkAGp9b89dcL8HRp0jpWHmxf8WA2wrp39TjD8u
         B6xhImGA6vKExlItnG8oZPvrtNWYSX3pV82d7lMwrvh/g0teHXZOKRiupG9oS2cRFmTk
         UsR3N+32MHYK4Qf5oG2NNDlyrQtyseUuGm+Kf8q1E/FOq+BhiLubGq9hUswWxMBNrf1y
         K5xJ+p881U3wNTMsDi7jhCctGK6FyZ3oS8yypYfPsip9Mh7Bgq3ddsWsk4ZCP3DFWV+8
         zBsReCblXWiTtupdnH6ylnEQVFQUt2PLTw1bVRxZcAX/cOUov2eZiYFocX9ynpnQr817
         GT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=co48SpS7itFAzVN9BhiHlDIMZipUfF9g8PJ6ZE/5WfU=;
        b=Wj4BAuZmtkWKUatH8p2vs0K/nQJX1gsbQgn/242rwo7UgIfUqqDq+WZCbdgIXEnQkD
         aPOLMDCtnmyE0G9Kpja3i2tg2kUF6tCH/lsQCEAQG3xce3TYxIDQGifrLepcEx5lQ+tj
         u5KFoYEZtrxBW583wtvOcHwyIxg9SCU9U2Qa3aCIK6jjrVawuy952rLdfggDDXtcOW06
         aUKEetgsF5ng/jo84JVUHVYkXZ3Iw4Nf5karXFxMQjkIFDrswi2VpvWGf5wlqsqpDOBn
         LKQzi94sexO1d6+BL/UB7MP21TKb8ShV8hoKPg3QJPTRhgF0Un/Uajb0Rey6VF8OFDdW
         Onnw==
X-Gm-Message-State: AN3rC/5Vr9jrmLZoa1lWiXC3Obbfqd8yylvUp4GkdcC6gg0o9vlo9C3s
        NWkmKi25MsxrCw==
X-Received: by 10.99.121.13 with SMTP id u13mr15709280pgc.147.1493806764811;
        Wed, 03 May 2017 03:19:24 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 190sm3540860pfz.15.2017.05.03.03.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 15/21] rerere.c: report correct errno
Date:   Wed,  3 May 2017 17:17:00 +0700
Message-Id: <20170503101706.9223-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first case, we should have reported the reason fopen() fails. In
the second case, fclose() might change errno but we want to report
fopen() failure.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 rerere.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index 971bfedfb2..c26c29f87a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -484,13 +484,14 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	io.input = fopen(path, "r");
 	io.io.wrerror = 0;
 	if (!io.input)
-		return error("Could not open %s", path);
+		return error_errno("Could not open %s", path);
 
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
+			error_errno("Could not write %s", output);
 			fclose(io.input);
-			return error("Could not write %s", output);
+			return -1;
 		}
 	}
 
-- 
2.11.0.157.gd943d85

