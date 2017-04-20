Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBEA207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944871AbdDTL1N (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:13 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36187 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944521AbdDTL1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id a3so3197975oii.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqQbT+hPdB3d5lODHplg8auf3wx50KO7arYBHJ05pZM=;
        b=Ed+JpKUlFofCT/50i/V+Mtb027TtS8NaLCVsGAHpd6EuA0vBVvDjo2UPgW/8XtxSK0
         3Aj8dk/6OcoENEa0wWW2dO9nFkTvudFxnMR1ADRZjjmyZ4SfJ6TKcI7Aq8u2HFj8sIJS
         4+pm2zU+dEHOEoB9p2bMKXJNULLmOw8/uPDNrEcDd6BXyP9AvLSLPI3IEGCPUeT16+l2
         BMkMwuMAEElrXrHc/hBdzagPo9NkfNZWr3enpDAHo6RuICqwOS7dtg8Q2lfNvYZRmJnt
         SCiDdv2OMK57zYSm+OZrg6Q0kUayWnBldiQ/sPoSXn+s16c8cGCEBzjRwBXkxkCG1Qag
         XB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqQbT+hPdB3d5lODHplg8auf3wx50KO7arYBHJ05pZM=;
        b=S72YBwBNCAoiV1ILNmyL4Y3yfK8j9LXE6x2egPzZsJFwt9pSuG75J1YExZmfo3A9V5
         dwiBnC0Vkm1sakrcZ4aRKOVwLDY6DXAksxewA/TS+cTfRlKA0JH/QPBK/Jc91T6+rItO
         iDsFij1EhX9ksT5+jmyp0IF/mEIJ4RVR/9gfO0BolXUdW7bICmcfbhFj4KMFC8Dg+4hM
         gEQaTvpaXJnyNKnswvLCWLiDA70Wv4wgsxtBL2s6JBCgpLTG7teshe2L/LVLgNkv0iA9
         oHgdkoOCFZAfeKlru4cFqFDxMTZ8CvokHeKhBJJmD1J0jW1OY4MWlLnwAqv0BWePSU7u
         XPTw==
X-Gm-Message-State: AN3rC/6K4bQqogI7kEOYXIbrLRUYAyKwVuqLNRehL6dUsRgxliHz+bxC
        o1w4/s2cW6+0oQ==
X-Received: by 10.84.232.198 with SMTP id x6mr9739692plm.143.1492687629562;
        Thu, 20 Apr 2017 04:27:09 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q63sm10062847pfb.38.2017.04.20.04.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/15] rerere.c: report correct errno
Date:   Thu, 20 Apr 2017 18:26:03 +0700
Message-Id: <20170420112609.26089-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
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
index ef9b11578f..f10c3d8ae6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -487,13 +487,14 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
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

