Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E12FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiCJN6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiCJN6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02A14F9AD
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so3430213wmp.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4ew7zgCX4z8EWaq1qfRudy0Qjw8oVj39a6DG47R86Y=;
        b=oOWKEOq9VrpN8/xwXFRNEjQyPpXm3TToGlc5/kYlM3doDUUmBL3kXsT7Zz9PdrJwGy
         h/DtSa2NfauFY2x8DWl3uWInyw0yvcqi4oH4xE3JOAM+jeZ35DP4/x5SAwG4qKcdIbTN
         jYu9o0yx603o8j1MfxyjKlR51GMKPtmSzepekkhYvbrQdFitcaTZ3B6FE+eM3+WcHg4q
         Nhg/cXi7tHDiH5ExD9zMG8uzN1eguISepo4NFSy5xLY6/5DblvkXuz9MdOIbu+Q5zxx9
         TSwA5DtDv5y6ZRh4cOp4XUAMPYQa3QiOhd1VfHAgOWSUSYH8StK27FgkF4rj31s2Weet
         WgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4ew7zgCX4z8EWaq1qfRudy0Qjw8oVj39a6DG47R86Y=;
        b=2ZJNDfU22rDURNsIAPGV5dMQx9RItfrlrongfpZJ+WHCT1CN/+6MdZl5iIcJYY51A3
         Q4JP6uTB5ynlhWDcsMrJRCUUDT2zRmt+nzeMBO7fDr3JNAUPeDeNWeqDtk9u4885bC3Z
         NC0nVSin2+jmhcajPB1h9NqQ2wCjwwk61R5An9DRWihWf9wlajRInXKusr0U8oR0MQCv
         XHm2GHieRIgQbTXhgzkpJG5SK1RidJRSP9Ag6ks8M7EjuM937PBIiSu9KrF3GUYfVH4Y
         EWh6zfLohEGNYp+CescXjED9nOQe6s+4NMUZvQHlhO4RQcWTtUOc1zynh/X7mripDR3X
         IzkQ==
X-Gm-Message-State: AOAM531tOJy04UcaxWDiAgs8MTBdpVdcEMcnNfpvlZbcxn0kFu25jkcG
        GV59iMfY/VKIx46Bpcj1yJdJuYAf7ke+hg==
X-Google-Smtp-Source: ABdhPJwcuI0d3OjIFO38/UTES3uxJ5hOWPKNBTO95m//oS73l1Y15x+yvDyFPp4up+N7StFWGIcphw==
X-Received: by 2002:a7b:c841:0:b0:389:864c:e715 with SMTP id c1-20020a7bc841000000b00389864ce715mr3695778wml.72.1646920630586;
        Thu, 10 Mar 2022 05:57:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 3/7] ls-tree: remove dead labels
Date:   Thu, 10 Mar 2022 14:56:59 +0100
Message-Id: <patch-3.7-cc2989f72ba-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These have not been used since a preceding "ls-tree: slightly refactor
`show_tree()`" commit, and should be squashed into that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 23ec2f0fe76..f04733a9be1 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -18,9 +18,6 @@ static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY (1 << 1)
 #define LS_SHOW_TREES (1 << 2)
-#define LS_NAME_ONLY (1 << 3)
-#define LS_SHOW_SIZE (1 << 4)
-#define LS_OBJECT_ONLY (1 << 5)
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
-- 
2.35.1.1295.g6b025d3e231

