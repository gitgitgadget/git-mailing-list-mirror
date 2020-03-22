Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFBC4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9152920767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGZAKOEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgCVA4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40901 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCVA4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so5171269pgj.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZcBGgwUU7ZEl+yafXL19Ukf2zYYiTHwCg8RNZ4Hvbw=;
        b=gGZAKOEOCtPcc109EwLWDal0FRvIg6yWexZ048MwkDnSl3AHUY5pSn9Y0Wk5w0BC5c
         tIzEO2Ew+tBnQPB5tuUBjDShaUzPEMSmz5HR9axAdL2GAAbRm3pr3TNmDIpP8bxTnA6e
         Gto0xmdl9XKTLGPEZ3AvYRsS0YYE+XoPbKriAow6cuiaPiisBa0U3cZVOExxaTC3QXjY
         Mtt1aufPnfw2C09ZnpA6A3mI+AOJ63vMHmnj046TsyVw5/G5BDo/4GLA+MPdf4lZbz+k
         BA0BKvB/vAQeQHPOIzCBmu6MhNiNMa+tP9R3RAnCNT4cKqgiwRa2y9pkjDn8n5Y4cE0B
         PqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZcBGgwUU7ZEl+yafXL19Ukf2zYYiTHwCg8RNZ4Hvbw=;
        b=Ze/PCQLfyTHuJMLSoyNZVWRIslZ2w+mpaG1PCvpypuZv+0C53JiyXiz6SXA1nqWtX1
         Zqw50oR6u2gOl1Vcv4NQThsLrXygmFbKJpQVgxF+TdQXVd0nmFHNmPYqHeieVKM5P6RY
         6Zm+B7yx32njK5HlNiDLRLZkROSffrCqf0eUO5i5YO2jZlZ6K+khjGBOiva85dpqs5ZN
         gXkbCa0L3EZzUto0aBFjO7uzFmxqrgVkNqaZLPp+Fu6BjscH0iQPkyCO61EWqNBKUtrl
         bcd2TZsuyj7isS6BCM6XjGNzOp8Jkt2jsnxhvxa4QTMe+Yij4QcuKFaxKgIvbtHeZL0U
         /RbQ==
X-Gm-Message-State: ANhLgQ3UZwkya0fcJS15/0vsmzAHtFYH/5TXSIj+2lx1poHd+ALhG9Rr
        SWopn1qD35bv69eb2LnVD9NRCHy2
X-Google-Smtp-Source: ADFU+vtWezT+DmZZD5zU1Z+KmVufLTZAq+hLkpWGUeCoE8Vda9jBdDMLdHa71tbRol5dVjBf+heNcw==
X-Received: by 2002:a63:ad46:: with SMTP id y6mr15501294pgo.11.1584838579718;
        Sat, 21 Mar 2020 17:56:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:19 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 8/8] t5703: feed raw data into test-tool unpack-sideband
Date:   Sun, 22 Mar 2020 07:55:22 +0700
Message-Id: <d4507d381e739667f9059fe2b512fb251a74c500.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

busybox's sed isn't binary clean.
Thus, triggers false-negative on this test.

We could replace sed with perl on this usecase.
But, we could slightly modify the helper to discard unwanted data in the
beginning.

Fix the false negative by updating this helper.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/helper/test-pkt-line.c           | 2 +-
 t/t5703-upload-pack-ref-in-want.sh | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 282d536384..12ca698e17 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -67,7 +67,7 @@ static void unpack_sideband(void)
 		case PACKET_READ_NORMAL:
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)
-				die("unexpected side band %d", band);
+				continue; /* skip non-sideband packets */
 			fd = band;
 
 			write_or_die(fd, reader.line + 1, reader.pktlen - 1);
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 7fba3063bf..a34460f7d8 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -13,10 +13,7 @@ get_actual_refs () {
 }
 
 get_actual_commits () {
-	sed -n -e '/packfile/,/0000/{
-		/packfile/d
-		p
-		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
+	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
 	grep commit objs | cut -d" " -f1 | sort >actual_commits
-- 
2.26.0.rc2.310.g2932bb562d

