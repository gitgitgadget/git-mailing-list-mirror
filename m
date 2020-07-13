Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF41C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4EE20738
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyHb9Hsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGMTKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGMTKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:10:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA30C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so19307306ljm.11
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7il1X+ARXXOVJRXzejW0FpYWsC+AfcDKsmHO05/4rg=;
        b=oyHb9HswGZ8OftJDm38NF5I8CxynniDDRB9zphu7kq87jN1+GSXGSDjGulJNE5o7Gd
         eYEOm8bryxY/6V2xbfGB8OIqZLHOILJ9Bfb0qmsskkBYSpdoqI6Brb6fvZ6udx2E1Mwt
         p7Enb/hAsXE0Dwjed78OULRa4NRs/1eBkQ6yNoBlN/swCMaqdg1CtL1FADlGdwekhLQd
         QntyGRMg+loZcp+LTQOZ6xptaah/lsSvSYSG7K818iGyw7OOJk0we3ZEe3Ts4YNLzTde
         AON0aH/kYt6zzTrLQTV0TQuVVo+xsoXBwxdi10nIFHhqGhsmzmddCFsu9Vwt1wD5wtVC
         zQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7il1X+ARXXOVJRXzejW0FpYWsC+AfcDKsmHO05/4rg=;
        b=IGqrkWZyBhf9cbfIxz6JOMnqJcvSMszPHB2Krs19PHWP3FzSgpN36G9/1zHjpg7ciR
         nVCIfdX4S5aGmoQ+MFcyhJRxVI7OewVHq4TIJdJ7s21wQ0irVEcWiTn4PAvsp0c72Z1v
         jo0YX3lA5rXqQH4cvDHBeTccWjrxHVRXFREnSorDtZkwVrCnv4oGx3vIycqFC1HFw5ys
         59x2XQVE2Oj7kIoklwQtHTNhTgkpVXwNiryLdsJ+gPVXOkcDBqENiSu8HApfYENmWNqE
         RkXIQ11/8KEAa5FozY2M4XR17pCumWTNrnch7ztX5H4y7TnXW33Fjw5+/DpCuPDhyTns
         qiSg==
X-Gm-Message-State: AOAM533Ih9HYPruEx0keOV2VV4iIzxJKyJALRwYfl7xKmOjdLODtoXpY
        CAEhO3rX2gcl3Fmk8nh9s1sGcuSy
X-Google-Smtp-Source: ABdhPJyxZRnfakWn0VkckxrnECnjA/9Vt0WaU87XtPtX315lj8U/YnoYaR51GYrRyeLf+TmNmxPITw==
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr508309lja.210.1594667443104;
        Mon, 13 Jul 2020 12:10:43 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id m6sm4192367ljc.134.2020.07.13.12.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:10:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Subject: [PATCH 0/2] git-diff.txt: reorder possible usages
Date:   Mon, 13 Jul 2020 21:10:07 +0200
Message-Id: <cover.1594666410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Going through the doc-diff between v2.27.0 and v2.28.0-rc0, I only
noticed some small things related to b7e10b2ca2 ("Documentation: usage
for diff combined commits", 2020-06-12). The first issue might not be
something a lot of people would stumble on, but the second one could
probably trip someone up.

All feedback welcome.

Martin

Martin Ågren (2):
  git-diff.txt: don't mark required argument as optional
  git-diff.txt: reorder possible usages

 Documentation/git-diff.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.28.0.rc0

