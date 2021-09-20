Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E335C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAABD60EB4
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhITItN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 04:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhITItC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 04:49:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA0C061762
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 01:47:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so27467977wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Jw7fm+65YZFF3bxrsGgXdi5YxHjGMO/+dGuY0SI89s=;
        b=79Teyd6AvJVs4iPOTeE/NUY+mnMnxOPlSt+2C6Q+4FtA2x1h7McUCNEk3NfOegI/GL
         mFGnYsxFtZwY6/5516VqgnRFGtaCwlcJLSG8SbWf714ESm8HD/F7X6ePxhvtvB0+0MTC
         OoIPAvVPujIOKZ5wNi6iyKfBxb0qMNQe56TEQwelTZrYTAbxTGTH2/fkvZHd3HO30ocv
         yDhd87BNByAXWDaM5PEjvpE1nhb4TtWAXwxN+lOPcnZWerUve+LgNo+NuBPerePXQOO5
         QXgcGyL5Xy3LwNSCuoM5I3RDtO7/MVviRIQGrUTM3xO6/gcsayTIXuZidk0U1lIkAMRp
         ZkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Jw7fm+65YZFF3bxrsGgXdi5YxHjGMO/+dGuY0SI89s=;
        b=xhBv6768NfDzGFL4cJ3ZJMSmSjC0sa0As7FhyUj2lB3ye8m/ItBwrsWLw2ALMkYSqX
         sj+z744ft7wmUWV00fjFia2NuaGLZugNOK9pOrqOf1mMmSO0GFvyw00hJ26aScw/G2b9
         pSPvex3I/726wQU9zEYB0syqfxYR/2ME6f4k5Cur9326Z9cU11/aADw9mN4ic43I/MlJ
         GkpZYEvHUpBTstas2DQZwEF3dGM1HHjx+UaGYFGuAMD/2Y9OM6mwhx2CRykxhtC6rqH+
         YlYtw6UDkLxyl3QZEij1NkPX/uQ8NU0bFbOp3vgvM8G244Sc2PXrCOcUBCdwShfr8Lb7
         X4DA==
X-Gm-Message-State: AOAM533x6X5Nex7nvyCclIW3oMeB/V4xacg996+Wuf+q8oSYHFVm3GNw
        XYYS1XEBENIPMj/YmsqK8JMiNUyVKVcdqA==
X-Google-Smtp-Source: ABdhPJzQ9NVj5sYiWP/hO5mbihiGJ1Qt1K4iOKfaAgE70djdoaBfNjBmf2z6sAhlVpmMgSROL2ofnA==
X-Received: by 2002:a5d:64a3:: with SMTP id m3mr15014822wrp.157.1632127653778;
        Mon, 20 Sep 2021 01:47:33 -0700 (PDT)
Received: from localhost.localdomain (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.googlemail.com with ESMTPSA id 48sm16132935wrc.14.2021.09.20.01.47.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Sep 2021 01:47:33 -0700 (PDT)
From:   Fangyi Zhou <me@fangyi.io>
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>, Peter Kaestle <peter@piie.net>
Subject: [PATCH v2] .mailmap: Update mailmap entry for Fangyi Zhou and Peter Kaestle
Date:   Mon, 20 Sep 2021 09:47:19 +0100
Message-Id: <20210920084719.29122-1-me@fangyi.io>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Acked-by: Peter Kaestle <peter@piie.net>
Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
 .mailmap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9c6a446bdf..854f397796 100644
--- a/.mailmap
+++ b/.mailmap
@@ -70,7 +70,8 @@ Eric S. Raymond <esr@thyrsus.com>
 Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntnu.no>
-Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
+Fangyi Zhou <me@fangyi.io> <fangyi.zhou@yuriko.moe>
+Fangyi Zhou <me@fangyi.io> Zhou Fangyi <fangyi.zhou@yuriko.moe>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achleitner2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
@@ -209,6 +210,7 @@ Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
 Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
 Peter Baumann <waste.manager@gmx.de> <siprbaum@stud.informatik.uni-erlangen.de>
+Peter Kaestle <peter@piie.net> <peter.kaestle@nokia.com>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
-- 
2.33.0

