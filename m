Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD78C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1620789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRPDoqM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCYPHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40128 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCYPHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so896829plk.7
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWRiskax7tm9yH3inDrU/u9x8duAw9U0FkyXTN++6Xs=;
        b=sRPDoqM1UmogyMSMPUuAvKgu5+GCQkmwVeGnPD5bXI38w+WHDAh4H3Ls34WrCMgz5f
         Kh29XMl/E2xL2Rp+6GOBtkEncktF2eqrGS855OGskygp+UC3MDISJsPruz36sUKAU0zt
         f81BgBg/iJIUVqoccLBntYniQvGz0Ye5YFvvVLQYqgxcVC10IsxPwg9O4bt4niyy+bh6
         JUtBBsG+pG+riIWC2xsZRGMhkD6ZBTnYab1HAJA/8BzyPEL1/1Iatrc1uYRM1JbrIsOx
         CAmkCWBfQTnelqO6jL8G4tcRxXNEpxFBElvL+Tns3jGL421X3IPagerHWhX25ojtQbD0
         3cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWRiskax7tm9yH3inDrU/u9x8duAw9U0FkyXTN++6Xs=;
        b=QnrBG7uC00cuEApKsOBik3gK2mJJTWTIzZCYzzA6OcXn2qxTv/thvgARPEBWC7bw3p
         jqH+o6/Kh5wOONiOWo+4w/qIzc3RN9kDHUN50JIG+irvwG8pE+3WJze2ndJIeS3ES5Wu
         Mc942KGRqeAYSFtKL/QsrttJJwlNoqXVn6FlnyFaVsqmcnLiE6Pkuse2T7uCqq0zV3a9
         4EoFX13Q+KIxqPJKRlY1WpfBWCNZfHmRbRHOFcDCeqZ5koQTmNQt11Ud1o5oNCxKRlQZ
         PfKFhuHV0Knolg9Af9HhYw8PQG5PMePtZstcG99cgKm3p39yueIS50cEkrDtW6lVmvxh
         BQ6A==
X-Gm-Message-State: ANhLgQ1+8e4/TAWhYqwvPBdYOVU9PiJmVpk7IFzrwYzx0ifVjMkIoh7j
        P/EkXpgXpqpAjjwtr8Tat1mgfjBm
X-Google-Smtp-Source: ADFU+vtgn4c5Bt0xWDf8Qht3VKv6nf1P9fb7W9jEOLpsHNOEjoTTl1C2VCkO8qPnaAgyziMW4EZ4kg==
X-Received: by 2002:a17:90a:37c6:: with SMTP id v64mr4300454pjb.20.1585148826992;
        Wed, 25 Mar 2020 08:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:07:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 8/8] t5703: feed raw data into test-tool unpack-sideband
Date:   Wed, 25 Mar 2020 22:06:21 +0700
Message-Id: <8689e03400a4a4c2a2c95cc5aac3f1d24ba7525d.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
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
2.26.0.rc2.357.g1e1ba0441d

