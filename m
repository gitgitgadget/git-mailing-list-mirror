Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A3CC2D0DB
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC19F21744
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFfZjVZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfL0Nro (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:44 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42193 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfL0Nrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:42 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so10054515qvb.9
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d7hQBM8aYSWYDp+gYPVX5nvfL0SvXrbvxbv8P0yEBm8=;
        b=qFfZjVZq1x1RFBQbR3DdBQc5U4tERh21SHxW5gsWEOIYimDVIp+SLBBNqhcu5cBfkZ
         fkgkuHczrGpKZNOTpmyKTW1fBLmxFW7dobds6UoaMKnBguT17+Ez8/HOJGkvmMyTtIgz
         ATO1qX1Tl+rmjv4WyR6PSSsO0AQpI9OQH0vRl5PzazHMNFVkQg95fvgTlQ3pTyHf0j1D
         /TxfrOwrtp39YDAnHZ7TwI/XIqKV7tZ/9rXE++lA6TJaQlKf5XK8ueSqCwNXrPX3FIYu
         GJXXElxIl9upi9ILVeWSDfJDTesVItXwBFhhjDESaYKCO8XhDGGZgTCzjBLcGMvbDSiJ
         LsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7hQBM8aYSWYDp+gYPVX5nvfL0SvXrbvxbv8P0yEBm8=;
        b=DmtmRlDdcxQbT4XIWXhBISf7XnrmHtyLWWVDEmIa1SIK+kPw9ICXZEBx2reTIfj62d
         KrEV5AertmV0BYZYtL4rJmsrWRH1YprkZrhjz93Yn++CbZFmBR3x9URELL4/IpFEUqMI
         1F9138byCY+yKnAxYylUrBoToQI7VlGuP1GklAjrGPY9fWuG3/xDsHFC1dMT+cbQmKiw
         nHMAns6M9g0z8oqvJZz+HspOVxCRGN8gAlFX5sMa21oBrXhfWcw5nVrhRAR6YedLke8o
         0WcE5296ipsnE5/+q+qryj64uIGEtTCAXtIh8xkqT20KWkcKCu698VJNKvn/qcISdwkx
         4S0A==
X-Gm-Message-State: APjAAAWaNPA4iRy5ylQcKA2Rh63Rt/JzVuplqVMPNLUyiJRAnbJRAOpq
        94VbRsXg0S6ZVc3pXVbLleGNd4/1
X-Google-Smtp-Source: APXvYqw72w67AGSR4nWPZZE/Ghy9yIwJN60Dt3u2ta0z9PuviMUorOmiqffdE4YzrdpRmy9b73KYZg==
X-Received: by 2002:a0c:acc2:: with SMTP id n2mr39344946qvc.225.1577454461769;
        Fri, 27 Dec 2019 05:47:41 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:41 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 07/16] t3030: use test_path_is_missing()
Date:   Fri, 27 Dec 2019 08:47:16 -0500
Message-Id: <fd11241003c92f8709f32c66f3ca3b4e8ff8fee5.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we would use `test_must_fail test -d` to ensure that the
directory is removed. However, test_must_fail() should only be used for
git commands. Use test_path_is_missing() instead to check that the
directory has been removed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3030-merge-recursive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2170758e38..d48d211a95 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -604,7 +604,7 @@ test_expect_success 'merge removes empty directories' '
 	git commit -mremoved-d/e &&
 	git checkout master &&
 	git merge -s recursive rm &&
-	test_must_fail test -d d
+	test_path_is_missing d
 '
 
 test_expect_success 'merge-recursive simple w/submodule' '
-- 
2.24.1.810.g65a2f617f4

