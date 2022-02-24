Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD3C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiBXJd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiBXJds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7185279921
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so1969218wrg.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QifMvSw5OtOoyqrXMo3/A/IJZ523xD6fp1251kGqWSA=;
        b=Q28XyMMRmiZJBjXpM2Ha8Ankop/aEiwNW7v93K88/NJdGT54fhdqZFuSyUzh2ssvZ8
         9NgJlEiK2pKHOo2FuTQGyX5DU3OVdY/7T+rwPeVOdC9KXI5lFqfyTacf+RTllPpfjdIJ
         PhmQgUL8aHZgJjjeK15U+7aup2LOZ7aaVi5mJO5osmx5ZC/VWUz1c7yezLB51UKIANuN
         yPwrEIHKwGIjDm0Au3Jq+6Sbcn0/PnG77sp0NPynSkI8NEdOu0ksxShqt54qjzb2kaDg
         hofoCpANu9VZ0KOA9zX7po26vHuqRY29zDpeqIWSwGtjE2F6g7WCd9Nf2LT3DR01u+BD
         YD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QifMvSw5OtOoyqrXMo3/A/IJZ523xD6fp1251kGqWSA=;
        b=M3PpbuJtW0dd+wN00KGC4/xSfBTec59FYkog6GHMBueAbluxo4mdnOmQPhvKOnbiEq
         AGeWykEj5yOnSHyKJfcr2sAzRTfzCydZcyi6Ws6zD9URC/rya+AkU954njf+bs3WXYhR
         RmbAtkKjcZtgKh98YF/kDU34DjVjY7ot+d/uovb3dJTVBOrpIC60CXXAygqMVQWkKXQM
         jfDuJYuWSQdg+zDPgnYHctQkjWDV/QDse2KSQBTRsFAyaUi0GKwMuEOK6bp8/s+GBvwQ
         pa9N8rbPiJJItdZcPAjpBryyvCp6b4HbHnfapOycb9cLXojrmaaS48Zgt4VH95TfKE8s
         BtYw==
X-Gm-Message-State: AOAM530DeiAFHe/KuaKWbVs0bkX8pDUH0LUeoa57iWGo++7/wSdSs9kc
        qH6UoEREHcrYyWdORI1QHAKPoS6oAsPAQQ==
X-Google-Smtp-Source: ABdhPJzGI4qNzr/TPGh91LMSsF8Tkf25veQG/cV4t4C/ig53fEKIOKiqFcBFr7wz/d+yrY+s/XMMeg==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr1499927wrs.196.1645695197032;
        Thu, 24 Feb 2022 01:33:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/12] archive-*.c: use designated initializers for "struct archiver"
Date:   Thu, 24 Feb 2022 10:33:02 +0100
Message-Id: <patch-07.12-54e868d304c-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-tar.c | 6 +++---
 archive-zip.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3c74db17468..042feb66d28 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -461,9 +461,9 @@ static int write_tar_filter_archive(const struct archiver *ar,
 }
 
 static struct archiver tar_archiver = {
-	"tar",
-	write_tar_archive,
-	ARCHIVER_REMOTE
+	.name = "tar",
+	.write_archive = write_tar_archive,
+	.flags = ARCHIVER_REMOTE,
 };
 
 void init_tar_archiver(void)
diff --git a/archive-zip.c b/archive-zip.c
index 2961e01c754..90fe99eaaed 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -637,9 +637,9 @@ static int write_zip_archive(const struct archiver *ar,
 }
 
 static struct archiver zip_archiver = {
-	"zip",
-	write_zip_archive,
-	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE
+	.name = "zip",
+	.write_archive = write_zip_archive,
+	.flags = ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE,
 };
 
 void init_zip_archiver(void)
-- 
2.35.1.1157.g524e2d5a0db

