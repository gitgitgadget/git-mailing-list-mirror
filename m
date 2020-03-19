Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740AC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF32208E4
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhBnotn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCSOAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41926 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCSOAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so1476042pfz.8
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+oulQ/bEONJEMUl29tOXAQDEenCp0qjzC3qlWA8kEI=;
        b=BhBnotn29hCya/Ov++JJWk6X6dOPa7fpcAzvAvyYuJ7lZAdEO83Q5Yqa4YfkV4xqO9
         WcSE0IoZakT1sxv8PRT59W0K9oYbfXQujf2tAYvdDf5UYlfhS8jgVYkurnKutYjk3fNK
         UWyGDKQq+1ZVWQ2bmmjr+Y8UsbOIyHritj1WpD/fF7ihRJPTatNWAI3sWA5lcS75dA80
         NIHARnVtgVeoN62dwOL6c9h/GQRmwIC8J+b38gDYuGrNuh3NuSv/h1exIt6fV3BflmOm
         hWFpeSLj83EAJJexIjLdjCAmm/RPumAyOraCkw2ZkxN9mXEtKsLDXshgqOpzhdGRVvCw
         G1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+oulQ/bEONJEMUl29tOXAQDEenCp0qjzC3qlWA8kEI=;
        b=FEXhlW7FYtDBqRsNMNiYCfsZWTPhUhfhZ1vjiNgGMrPxBOAHN44CycqHR2X/C6juIw
         Xpg69ry2bXM/wvvnlzoz5l85+ngNKctyDq9k8zyg0ErTmSSCIX1bkUPR8SdAKB/En2zi
         A3OVNiv0nLo6CEVD23M74SAo/Emt8P9LV2H+xrv9BzY8C6eo1YHIxQzWZHWfddc5Omnc
         wjJJHj8hq71Ay/pudzlsegTzavbpwhRnsgIJOiylrif9jeLXp3nTqE6+76gO9whm+Otn
         VudoqpI2mol1vz96TFjvGMe1pD/u+JpVIBCbJ/uuRjcZA1OczIQGjfRefuIZpUC6NO+7
         jTlw==
X-Gm-Message-State: ANhLgQ2FkM2u29yoPJ0QCJk2KTJO9BpT7xyFkf0ctvUrwMHhiJ04dy3H
        NvLz2hwl6zTpMsWSob3dlPrqb044
X-Google-Smtp-Source: ADFU+vt1IySciSsvM7kVcStsSNoOKymrUwk7iLg4Hmp1ffmY1D7FEgQu8EmcCfP92HL7uKnxEWlAmQ==
X-Received: by 2002:a62:2e42:: with SMTP id u63mr3705629pfu.69.1584626444331;
        Thu, 19 Mar 2020 07:00:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:43 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/6] t4061: use POSIX compliance regex(7)
Date:   Thu, 19 Mar 2020 21:00:02 +0700
Message-Id: <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BRE interprets `+` literally, and
`\+` is undefined for POSIX BRE, from:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02

> The interpretation of an ordinary character preceded
> by an unescaped <backslash> ( '\\' ) is undefined, except for:
> - The characters ')', '(', '{', and '}'
> - The digits 1 to 9 inclusive
> - A character inside a bracket expression

This test is failing with busybox sed, the default sed of Alpine Linux

Fix it by using literal `+` instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4061-diff-indent.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2affd7a100..0f7a6d97a8 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -17,7 +17,7 @@ compare_diff () {
 # Compare blame output using the expectation for a diff as reference.
 # Only look for the lines coming from non-boundary commits.
 compare_blame () {
-	sed -n -e "1,4d" -e "s/^\+//p" <"$1" >.tmp-1
+	sed -n -e "1,4d" -e "s/^+//p" <"$1" >.tmp-1
 	sed -ne "s/^[^^][^)]*) *//p" <"$2" >.tmp-2
 	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
-- 
2.26.0.rc2.234.g969ad452ca

