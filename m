Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77365C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537E061026
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFTVlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTVlb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 17:41:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A761C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 14:39:18 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1lv59v-0003Ek-VG; Sun, 20 Jun 2021 23:39:15 +0200
Received: from rhi by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1lv59t-0002pg-HM; Sun, 20 Jun 2021 23:39:13 +0200
From:   Roland Hieber <rhi@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Roland Hieber <rhi@pengutronix.de>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bisect: allow to run from subdirectories
Date:   Sun, 20 Jun 2021 23:38:37 +0200
Message-Id: <20210620213836.10771-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, calling 'git bisect' from a directory other than the top
level of a repository only comes up with an error message:

    You need to run this command from the toplevel of the working tree.

After a glance through the bisect code, there seems to be nothing that
relies on the current working directory, and a few hours of bisect usage
also didn't turn up any problems. Set the appropriate flag for
git-sh-setup to remove the error message.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 git-bisect.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6a7afaea8da0..20ba0ee7c18a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -32,6 +32,7 @@ git bisect run <cmd>...
 Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
+SUBDIRECTORY_OK=1
 . git-sh-setup
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-- 
2.29.2

