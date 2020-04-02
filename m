Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC67C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450EB2074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giUzpU/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbgDBKP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBKP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so1621737pgf.11
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLDDMVLXiD/ZgqaYTSvd9gtBPBPTdVwkdIdghP85McE=;
        b=giUzpU/AezM9sbaSBT5i5/Y0Xia74/4NMJAae3fbPVfEsSmVeKIWN2oXG87rooqbbw
         u7th5LUKGQNINjhWjAz1MpQOtNACloby1wxLKNQFMBihxedI4Ej3IOyois+/603GvyDJ
         gw8oBw1hr6JBtJy1TUuZU5jhArigEfuIn2YJMO067unvrwIypa9Lm+Tfyj6Ra++Iczly
         th7AjocNTcv3re+huFppC+I2wGi4hQ779T4JYGwTt5mMIuOPu9vCoJm8njqOiTPnGT19
         8NCVEXXMgFmTDyHLsYK797rQxfaeE+zgYkuV6o8jpyCgGxOjbxWPP5Pna8FELE9wi7wQ
         wv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLDDMVLXiD/ZgqaYTSvd9gtBPBPTdVwkdIdghP85McE=;
        b=l9fAHhhZcir5mEz3uZfqWizr1Jbha0ZPO60tffEAM/CCpamY49LC+cEtLjPUGuYeUP
         DcyqP+CpKYb+uaP5g1MVAdEWNdy7PARIT7GFJT81FaskdVOkEAyuwXEj3jwz6VPdeX1N
         ff72edRvjRm8MV1a9d0Dx2vbjzqVC+od1c3SA9tyi7RcOQkcjEQD3i1IhvsbUR/gAYCP
         tSs/GvuW1uo7I6Cj8sC7GLP3jaBDZkNfSdLL3HasxEVwDkKTlM3I2Mnscfr/7stHZggL
         l41R8rqe5g9e5hHiqe3b5IkGZ7cjprTdAhxFgiAsGNDmFBk/ZtAJvMsoi5n7CRI45Kf5
         QoOQ==
X-Gm-Message-State: AGi0PuafwoeQ4bgjbiaEZXxz5vqFn6A5Z6Fyg9Uxy4Pt7+QWZHfVMquP
        7sWBdcwsyW2B8n3HU6gowbbflDl9
X-Google-Smtp-Source: APiQypLSTqaOkPFP1g+Aw0bj5skLWHTwrYOE0CruG1l2IJL8VfRf4dV/6HOinPoONSXuwatAYV/hkw==
X-Received: by 2002:a63:3002:: with SMTP id w2mr2664846pgw.290.1585822553785;
        Thu, 02 Apr 2020 03:15:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 5/5] Documentation: document merge option --no-gpg-sign
Date:   Thu,  2 Apr 2020 17:15:34 +0700
Message-Id: <d35dd89c52e427861c38d17e43c61fca149dbfd5.1585821581.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585821581.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585821581.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/merge-options.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 40dc4f5e8c..c46e4fe598 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -61,9 +61,12 @@ When not possible, refuse to merge and exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign the resulting merge commit. The `keyid` argument is
 	optional and defaults to the committer identity; if specified,
-	it must be stuck to the option without a space.
+	it must be stuck to the option without a space. "--no-gpg-sign"
+	is useful to countermand both `commit.gpgSign` configuration variable,
+	and earlier "--gpg-sign".
 
 --log[=<n>]::
 --no-log::
-- 
2.26.0.334.g6536db25bb

