Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B0C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A777207D0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb5vdC+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGISYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGISYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 14:24:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE16C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 11:24:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so3540451ljm.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6wYwkKODrnD1wNoFWIWMnWDv3hYFHin1wGsT1YAVRA=;
        b=sb5vdC+Zaq/6gH+loC/X9njdy5q9DZi+p4AXNa+wwpuDoZrJDzD2lwMfygLNzq6LHw
         TkmiqWnvHCOSXv+XyVeQK/2Wosvfw0y/lA1H2L0iDTBPtNS1wG9bvYVqPib7790QSDBd
         7WnTukeO9GH4uRbiG7BdHhnpx66zhCSjBOiyge4aF2KHpRs8MFTD3J6K+9VIXvk6aghs
         lByWd9DYDbtOiRtJRp/Ew4nYXeWiqqaJ0A2ozHXcFAduggjR3luOOLgy5gAqIgIa76C0
         73wg6+LZcXRIJAZnuhG/wUMIlnCt7ULT/DgQSBFF8toMJo53TDCQX6asvXI0/IdusS+O
         bpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6wYwkKODrnD1wNoFWIWMnWDv3hYFHin1wGsT1YAVRA=;
        b=SYG4/KOvtpVKzKHBvwPpSUaFezISBbRfuSI70WUWG5nRxlZgtus+e32Sl8eiKpKRcV
         x5rpmrwIVa+fXlddYBJG6KEZyaKy4nxRsrOO3GHg3lVjVwpu0NlZMLm3g6WhbiXUnDVx
         7QBespQiXcICa6C8xt7gDTtrygxyNy3ZQoYyjLRKDnJmvhW60XpTJ/vg62usunaMbvly
         Q3Y0V4ZIB078FPfsgw9X4eDEE+07ObC4AWMbbiB+JiO3am4ckqSw2cPy7KwoHhbdy1NS
         0W9L3y75I37OiYjy6WUVOBXGGspoHRgCRSKUqCVllIyuETdv/kgw0W3mD2kN3BhQWwCe
         wh/w==
X-Gm-Message-State: AOAM530iULBT1e4ic7ZzJXU50h08tPhzLxyLOxcRIEn1xE4VRyPUKjbo
        nIECX/FhWqb9k2RJwtw1XlSpB4js
X-Google-Smtp-Source: ABdhPJx4IN1Jkz17My6IqCCjNZFVapggnaW23LE/xoU8qDNwDpDr0a7czm/c8SbAmPIyeQpDharMpA==
X-Received: by 2002:a2e:1641:: with SMTP id 1mr30249105ljw.73.1594319093213;
        Thu, 09 Jul 2020 11:24:53 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id e13sm1201538lfs.33.2020.07.09.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:24:52 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] git-rebase.txt: fix description list separator
Date:   Thu,  9 Jul 2020 20:24:38 +0200
Message-Id: <20200709182438.17355-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't give a "::" for the list separator, but just a single ":". This
ends up rendering literally, "--apply: Use applying strategies ...". As
a follow-on error, the list continuation, "+", also ends up rendering
literally (because we don't have a list).

This was introduced in 52eb738d6b ("rebase: add an --am option",
2020-02-15) and survived the rename in 10cdb9f38a ("rebase: rename the
two primary rebase backends", 2020-02-15).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 See, e.g., https://git-scm.com/docs/git-rebase/en#Documentation/git-rebase.txt---quit

 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..9acea055d7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,7 +258,7 @@ See also INCOMPATIBLE OPTIONS below.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
---apply:
+--apply::
 	Use applying strategies to rebase (calling `git-am`
 	internally).  This option may become a no-op in the future
 	once the merge backend handles everything the apply one does.
-- 
2.27.0

