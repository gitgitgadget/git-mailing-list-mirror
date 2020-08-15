Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38AC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4235A2053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSi6XBzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgHOV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgHOVwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F017C061364
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:38:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so3430381plr.11
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jpdTeodgbvuJOS1bOHiSqljuVjevt7qbFsQfaWbaW4=;
        b=NSi6XBzoOuqqhiZoRXZdXRI2Cub732UcxBrAYcQTsa1yQumbrA28LSTcTxxTanQhtR
         0fpShmYXg+JiSvg3k707DpV6MUVRvsT9GJAtGajluv6atMYsvosAlddSMS3gPUdEsUrC
         wfF68sXX1y7Ujwqn027tfUORg6m3dHuDqeC5p4GASIb51o3wNEvlbpYcITzOgl4by06H
         YkUntPKlP7Th3bw1A8X9+oY5M78Cr1cr/oM8Cf56gqRf6Dg7dQGCGxjZRGTjVUtTJ0Ak
         4U1mt5k6pmYAcaSbKORvU+P2ah/Fr4mmOoQcoQqruEPTRqa+QH/JQrWp6Lm96+AwlVnq
         9fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jpdTeodgbvuJOS1bOHiSqljuVjevt7qbFsQfaWbaW4=;
        b=NMLdd6nMAA21Q2aYCdh8XWAZwCXVID9lX93KdsuFNoi09KfWMllS4JdzQSOlGHC4eA
         TyTb6Oc5l+fgOg7m+ZIUnhnphcaawIqRSCQ4a1LHYXWpDZgNUL0hoPAIWGIdzj3LJOkD
         0wUKzaRcqeTvnaTdCKvcG7+aBuyBJk9rLt2hOCFkpOgSA6RsSBxoF8Snv03ve9Bg2pc6
         GFxSRHrrgJmveEyH/xT4VOHmkB9MHRM1eTxzAZHi3sfS27NZt+C07TJ7Di9pyrwK75WM
         ZZN8jgAu7+ktsG6eaudx/9cklmtwfQvbO66bQmkCVQg+0Hl5sWCSoieJ20dnpw8/SZzh
         nt3A==
X-Gm-Message-State: AOAM532B8R11z8gR19MY0huAGPAo5RPaingoMpTj6/RjeRjv21hRDEtU
        xDwY8jW9u0Pa5cdkW3oeQLEklXbBnqOa65lh
X-Google-Smtp-Source: ABdhPJzf0PLwrmHTfKsZkxzo0GaVBrk9I3YUbnj0MXP3RrPYiXdHTGHrPbEQ2z+gh/U8+SFXIy8agw==
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr4045197plq.254.1597459089183;
        Fri, 14 Aug 2020 19:38:09 -0700 (PDT)
Received: from localhost.localdomain (36-225-225-45.dynamic-ip.hinet.net. [36.225.225.45])
        by smtp.gmail.com with ESMTPSA id g129sm10438980pfb.33.2020.08.14.19.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 19:38:08 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     git develop <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Danny Lin <danny0838@gmail.com>
Subject: [PATCH] Fix --squash for push in subtree doc.
Date:   Sat, 15 Aug 2020 10:37:03 +0800
Message-Id: <20200815023702.905-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git subtree push does not support --squash, as previously illustrated in
revision 6ccc71a9d02726d59c1de818febf85a836f4e418.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 9ccd431c7f..0db02fe3c0 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -143,8 +143,8 @@ OPTIONS
 	Specify <message> as the commit message for the merge commit.
 
 
-OPTIONS FOR add, merge, push, pull
-----------------------------------
+OPTIONS FOR add, merge, and pull
+--------------------------------
 --squash::
 	This option is only valid for add, merge, and pull
 	commands.
-- 
2.28.0.windows.1

