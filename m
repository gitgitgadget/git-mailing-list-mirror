Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4DC433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiBXJeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiBXJdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1F26A393
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so1957404wra.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFWfUVipBOaCkUF6DiOjuBrBNHUsqYwlfKSLVm0SnyU=;
        b=TxlTnqiyx1+kGuBFUTrn8G1bKZT0YF1mfeaF9mw11DFhJqYrohUqKQ16NFLkAw8ciz
         SlwsLNHHdYuxrgZuEvLpWCVrYJIsfpLgnib9v0lQ9EoP/LJCEV6L9nZAG5eiVde3JPyD
         /4G8Nj+PfPv/OL714px3wX3qBPhdb1xzQADjrPmsZ2g7q354NnmHwbRhRTn8fz902cyH
         oy3HNle0ORNVKR4X3NC3xjpINCTm4nodKHRUNgxQkItY3NapV53Nbm2mXuZLFTEpLw+6
         7UY5QlNrergizdXByeSSYl/z6wsLo6N/br+RhZQlXd2QX5UCFoaTsH/1Rebiq0o1ryQG
         Emfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFWfUVipBOaCkUF6DiOjuBrBNHUsqYwlfKSLVm0SnyU=;
        b=LNrxNAlpaDS5wixcUDg/NW51sHGTdL+If+niGwCJCn+SGyEn0lYKqoYHS4zIn8ah/y
         tlYZKqdqKOB5k6lBT+B6ykFRGaRKgnHrZfb8KK5JG2K2AWIx5nPDahyvUz6dUdEq9upI
         jijkH7HqG7dhEZYnrQdpE/ZcG6TVqLHWFVLwEt36DA19jGeBL+nPsfexLZejdq0hlAlo
         8fPfFOVUzSStVjMz+hBuXiT31yWh4f7XbsruHIk14+a9DuE3dzvi/7EzsW6OOoUGvcGH
         nQiZsZEHES7Ewaxj0NoUSXRdEkwJJXGkxOJCK6QfqWYlFrI0fs5zikStwmNmhXlc7mw0
         pCYA==
X-Gm-Message-State: AOAM531I4c+cIEWPGfPcpaVvBoEfGjk0n83SlJ2qqjyxTLwjOP37Ligm
        c6e+D4x81poVXF74RlKJeikU4Kkw8eoUGA==
X-Google-Smtp-Source: ABdhPJyPi/BiFSHzG6t1unO1/c6jdJrfIGCfTgeNWBx8TrMiIDp5D/FQAjedwFgS18waWz94DztLHg==
X-Received: by 2002:a5d:4450:0:b0:1e6:8d72:b88e with SMTP id x16-20020a5d4450000000b001e68d72b88emr1524950wrr.632.1645695199738;
        Thu, 24 Feb 2022 01:33:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/12] refspec.c: use designated initializers for "struct refspec_item"
Date:   Thu, 24 Feb 2022 10:33:05 +0100
Message-Id: <patch-10.12-8552c5701a2-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct refspec_item" at the top of refspec.c to use
designated initializers. Let's keep the "= 0" assignments for
self-documentation purposes, even though they're now redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refspec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refspec.c b/refspec.c
index e3d852c0bfe..63e3112104a 100644
--- a/refspec.c
+++ b/refspec.c
@@ -4,13 +4,13 @@
 #include "refspec.h"
 
 static struct refspec_item s_tag_refspec = {
-	0,
-	1,
-	0,
-	0,
-	0,
-	"refs/tags/*",
-	"refs/tags/*"
+	.force = 0,
+	.pattern = 1,
+	.matching = 0,
+	.exact_sha1 = 0,
+	.negative = 0,
+	.src = "refs/tags/*",
+	.dst = "refs/tags/*",
 };
 
 /* See TAG_REFSPEC for the string version */
-- 
2.35.1.1157.g524e2d5a0db

