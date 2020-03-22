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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86AC4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F420320757
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO9y6Nnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCVA4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46555 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVA4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so966275pff.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK3AzpJ6LJHCUC9U7ugVkSvr3imte1dGz4l9yKLPRUI=;
        b=LO9y6NnpczL3eloMJN6i0WRl3ABUpWXD1iWCSI787vmBiTcSt/4OTHn2KkwnbbZbnN
         XV6li3tsSzIJIrYOdKDdIQ6qbrD59cm8cvIQMbB0QhQ4FeeBv1ehIET8XBIxlEl02Epl
         XaQwhOs4q5TPnDyFTUBXrpNksWtbBwShfBcz0Dd4fenVQCkPHW7yd1N9qvrgaz/r36MW
         JVTur9nVIlxDy6LJtaKlqT3O9tgpMDEAsc1b78o8Qv+2DVt66EdR8ONGnlVFHASq2CPq
         o03ncU2RMYNYkmgSWLPEy356XyL6n4pkjGdr+R3hPt9tkERacG0vkgRh0v3j0MXENFfT
         SW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eK3AzpJ6LJHCUC9U7ugVkSvr3imte1dGz4l9yKLPRUI=;
        b=dRAucwq10RbNHn0zc3KFJhrlCu2sCyrmn0M0tQ9KYPbMsOMu5T6KVEieWoQcCBJzfZ
         8u+IVRDTz1R1BaxW71i0XVkVMPCvlZwgz45j6Y+204HWfrbj7iYCXEqzC/p1AxK5c+dd
         fr0M5g9yAC/UxIgwcW0dnC0Y+tX261SFkjUdaQ2lwTPBIS9YnZ7jROJUk97HoH7j/lhH
         ucJubq9wew6IOlzpl3MkO9PncVMI0/Bd5+NguBlTpkFisYtT9BkNCVOO0GntAyU6u35G
         cpAP8sOyx49t+a1KGEiJz6dKRJKV21PbS/EMXVeya52AqqioFz972T8kBk6HbLFLsIEi
         e54g==
X-Gm-Message-State: ANhLgQ0aEUcPSRGsY54gyPL06jz+DxTIhio2Ty62iXMVL3RTKD/C8aCZ
        59S+cKtj14ybZIBH19PqpMEziGuQ
X-Google-Smtp-Source: ADFU+vsC+FDsugzaV5q+sAFrYI9nqQrQntUFFPFb/L1qi8/0k+ySdOw9QCvNHqLO2W7XIinTCv+Qxw==
X-Received: by 2002:a62:880f:: with SMTP id l15mr17350566pfd.218.1584838563932;
        Sat, 21 Mar 2020 17:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/8] t5003: drop the subshell in test_lazy_prereq
Date:   Sun, 22 Mar 2020 07:55:13 +0700
Message-Id: <8e85b5c15c47e7c524226d10915e4ecb12b2c132.1584838148.git.congdanhqx@gmail.com>
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

test_lazy_prereq will be evaluated in a throw-away directory.

Drop unnecessary subshell and mkdir.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5003-archive-zip.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 106eddbd85..df1374a312 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -7,12 +7,8 @@ test_description='git archive --format=zip test'
 SUBSTFORMAT=%H%n
 
 test_lazy_prereq UNZIP_SYMLINKS '
-	(
-		mkdir unzip-symlinks &&
-		cd unzip-symlinks &&
-		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
-		test -h symlink
-	)
+	"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
+	test -h symlink
 '
 
 check_zip() {
-- 
2.26.0.rc2.310.g2932bb562d

