Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D03C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiGSUrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiGSUri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5682157241
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so3396137wrp.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUiG+hQmbjgCXhnULs/dZp/hHWY3uYHsEAw8nOtVMkk=;
        b=KtwXAmqtMrnncm1gAwTtN5fWPcJI54WKqlerTauAX7RfiUPiGg3691bs714pDVUlKv
         OMz1aoZojTliuFT2x5Yuu4J8MbJoUr0gIpBL7KAZ3xBCGGI54Dz0xoddFFnlXqgUbJhr
         G5opy7SzHW1uX2Hoo2TaTt9+3owtAgSXpcDaGORiKxrX19Oir7RLVwMDn0PNYI3qYAsS
         273XFbKm1E6en+sObJebuS7FIDSZh9U055gBNMfAUTpOxHp0CJDkiVnCi0D0lRTiIg7K
         gzVBe3ZordALfp3vqPyk//SpoHL7HgGlTPCBfJ98ju6R/yVCUAJBHiOzV64aDKoXFkzZ
         ez7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUiG+hQmbjgCXhnULs/dZp/hHWY3uYHsEAw8nOtVMkk=;
        b=rXMWTXPJ79s1adGFraPhs2p8L9pyHTIESd8U1zShCw3/0eDXCS5xeDxvj4a+c1e+tV
         SD8qvYH0giwTsjmVHBKz1/PZ1AWhQjAINf0PRdhmKXRoT3BuSz7tPlbZIzkGjGEdLfKH
         VpXaRIKzUkzY1m0Gjbo1UTuOCPoQ4mlLFEDV7hXfxRKEI3pEkNzCiBGHmUIEHwJ93nN2
         bx4nOnVu4Ol1I5733fRcslq7mOAM9UFAI8nbvEtrncwbaX3hdJOuHqKYi0amJcSd33rr
         /vwbg01C+faa1S+8Gsve58nsP9ife1IZ5+0PyPP0H0GDDbJR7ZCCIumxvBBtGeiUsnBv
         47AA==
X-Gm-Message-State: AJIora8Ir9sjU2oFc7JzXx8VTlJ0fKWELSP2Z443RR07KG2UBEbckoxF
        wu7Sjoj/bwkTIeHQldHdRXGrXtyTuhKQJg==
X-Google-Smtp-Source: AGRyM1s3w0bcZ8jQIlUi1nfBoOXoTcn63plH3GYdDCTVM3I/W7MGGW39i5EJ6MD0rBFMg64167m8iA==
X-Received: by 2002:a5d:64c2:0:b0:21e:2e1b:d031 with SMTP id f2-20020a5d64c2000000b0021e2e1bd031mr4545674wri.8.1658263651566;
        Tue, 19 Jul 2022 13:47:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/24] submodule--helper: add "const" to copy of "update_data"
Date:   Tue, 19 Jul 2022 22:46:58 +0200
Message-Id: <patch-v2-07.24-30883f3aa01-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a "const" to the copy of "struct update_data" that's tracked by
the "struct submodule_update_clone", as it neither owns nor modifies
it.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3d32fdb3960..7e9af9999bb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1889,7 +1889,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1974,7 +1974,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.1.1062.g385eac7fccf

