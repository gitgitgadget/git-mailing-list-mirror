Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B94C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E52C6117A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFQQUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhFQQT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:19:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1167C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so59388ote.11
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuoDBBZDUEBUj/UnRKf0FOhatbeeX6da52mTvAVLt6Y=;
        b=P1CM6Dy/tS+yxZW1VsEPCXj16r3YoHELRo6F3feFkQbMGa0DiW95GwsNb9bri660ez
         XZdBjgW9IAzUIW7LLU70qqiap4+anV3+Lb/x3elsroV5s7Qg6PWeJ4Iae7ImIj1IDGAy
         F59TlYJASsM5HiR9akqccv3U3Jioc0+u1gxQRzB9YYH5VRBuv/KKlj99XFR9q8oqLROp
         CoobKRHzZ72+IbtFj6s9Rp8CSuNPhjnMgCuBhOOHU4fyDlGZNG2WHa4RsCNw7zqLvq8t
         7trNd8W2mSbogAh+v/tGQcas6i3P9FpryDeyCl3k5myNE4/C5KB6R+xLP9Ou1Q0MhkGo
         mvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuoDBBZDUEBUj/UnRKf0FOhatbeeX6da52mTvAVLt6Y=;
        b=koh8ZTQ9P1UMUUrAX/KTmOcMxf7IdCZyiAHB4m0bl90SpKK/1i2/xLzf1G7g4M66Oc
         ns6c+LZB2p33vJkDYwh08NZyL/p0eRIvJ0/1cNYk2Fp9ADs6Th65/pZ5czT7uBP1e3+j
         gExF5N11RF8T4DaNB8LWhugmM52Vybi5dIG/YFdDjh3M6Fuv5ifs7JmulYNeuhRx2dkM
         sGDmH38YaMA+zTleOBGe64QbFevshME/SkvOMGlW5pAyaY4dHxPDNmCkWk1Shv3gpnq0
         ZVTMY6KEhXLXXIuTp6TRv9GZZfRuDKxbH94s+HcbodiHQF5x3+JtVwzPhgenEFERudjp
         5f9g==
X-Gm-Message-State: AOAM532SNcjJ5C4BmOr+lZnFaK5cbDgjCNpRcj6Vu6YEsVCrdM4R2YA3
        difrB0pNPY3MTHJJvpc9j4XxD902pBwR8g==
X-Google-Smtp-Source: ABdhPJxApN6sXFRGWuHz8aqJJ87/c0Z1/EjJU4ILmCkcTEYCIKF2e40XXkr869Bq4E7DCahYA8NWFQ==
X-Received: by 2002:a9d:2f62:: with SMTP id h89mr5155991otb.225.1623946637724;
        Thu, 17 Jun 2021 09:17:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c184sm100079oob.43.2021.06.17.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:17:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] pull: trivial whitespace style fix
Date:   Thu, 17 Jun 2021 11:17:10 -0500
Message-Id: <20210617161710.81730-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617161710.81730-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <20210617161710.81730-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two spaces unaligned to anything is not part of the coding-style. A
single tab is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 80e2f55cbc..3e13f81084 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -126,9 +126,9 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-	  "(false|true|merges|preserve|interactive)",
-	  N_("incorporate changes by rebasing rather than merging"),
-	  PARSE_OPT_OPTARG, parse_opt_rebase),
+		"(false|true|merges|preserve|interactive)",
+		N_("incorporate changes by rebasing rather than merging"),
+		PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-- 
2.32.0

