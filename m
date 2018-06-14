Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C991F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbeFNRhf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:37:35 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:43825 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754741AbeFNRhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:37:34 -0400
Received: by mail-qt0-f202.google.com with SMTP id j2-v6so5250988qtn.10
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2wK3rVIozdKd/ppCnuUO/3lF5MwzUHgSKa4jwGCUPG8=;
        b=erkEdaVg5razK0ai8EiCh1pj8NGrpnV3JTzg4fpQQKZi0E0T9LRG+kpgPg4oykyJmj
         5LCsJ6LnkgHRDF+7woEaEgnkndu61CXSrKTp7wSGPeEvqWp3tC0isnWQTKYpmQVf2PGS
         ZMIDNODT1SM6YQZalV4u3AkSwM8yqVW/CGuKhrHDbjZt/35HLpQ98bly/DoG24KShVKn
         qeBccmG8AnfT9OLjKldbLbG1WBheklCFrKCfmHKd2Uamt0wDeHG63bu0LFDn4js5MyCH
         U1H9dlCT6NXVvz4IorXsvGle6WyZE/GOFMfWIRW7e5m4aVV3fjke2Hoq9siC1Jdb2Q5X
         xtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2wK3rVIozdKd/ppCnuUO/3lF5MwzUHgSKa4jwGCUPG8=;
        b=epEOqGSTrhWuPEIk9FPyYScCns8JSJnjZXy82yFaKAvtobFQPrJ+PQOab9+RmIm7VP
         kUuiqWJFCvWO2847HlStlLm9WMIIuxY5sE+vDRi9plX9IQ03x1SCyD0MQATe2OXUrGER
         Lxi4d/YO6Cg6565Xiw0bId/f35yEJRCxNMmGGz84u44rqLF/BtBTbEVjCYPXM3Pu+yfK
         UdAbVcmEX4F8GlvEHEyK/gcX/ehK9Kag/qRy51v2ixI1elQjg8K6acTLGJR91AXEhwxW
         FP9EHnMuD+Kcn8jp+kZDOB/29J4zhkLY8bc47XIGY1sPXwPntkKcLl0fT6emWj1gz5yc
         RRSw==
X-Gm-Message-State: APt69E2SPI0I43ejK9fHnXcsb21QcXRi5ZEfwgc4YXXttd8aSDKy60Hg
        uI28AhOfrAY8REAjpyI95gkAItgzxvyQ
X-Google-Smtp-Source: ADUXVKKaEewnjZIw3jRdrnjbQKIA4JIQvtrfDzT1CLSAM4ZrPm9QTRpLISVqp2CByJ8BLbUMWyyfTmRn8ue8
MIME-Version: 1.0
X-Received: by 2002:a37:b241:: with SMTP id b62-v6mr1827215qkf.49.1528997854184;
 Thu, 14 Jun 2018 10:37:34 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:37:30 -0700
In-Reply-To: <20180614173107.201885-1-sbeller@google.com>
Message-Id: <20180614173730.205646-1-sbeller@google.com>
References: <20180614173107.201885-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] t5526: test recursive submodules when fetching moved submodules
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, kaartic.sivaraam@gmail.com,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The topic merged in 0c7ecb7c311 (Merge branch 'sb/submodule-move-nested',
2018-05-08) provided support for moving nested submodules.

Remove the NEEDSWORK comment and implement the nested submodules test as
the comment hinted at.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I found this when digging around for the previous patch.

Thanks,
Stefan

 t/t5526-fetch-submodules.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 9cc4b569c05..359e03ff836 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -574,11 +574,7 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	git clone . downstream_rename &&
 	(
 		cd downstream_rename &&
-		git submodule update --init &&
-# NEEDSWORK: we omitted --recursive for the submodule update here since
-# that does not work. See test 7001 for mv "moving nested submodules"
-# for details. Once that is fixed we should add the --recursive option
-# here.
+		git submodule update --init --recursive &&
 		git checkout -b rename &&
 		git mv submodule submodule_renamed &&
 		(
-- 
2.18.0.rc1.244.gcf134e6275-goog

