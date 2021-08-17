Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF3C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E4F60F5C
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhHQGpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhHQGpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 02:45:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B7C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t66so22013575qkb.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCPw3EhVOnlyAOusKVtcbZ8etTYvYsbrsVwZV7Qy6mo=;
        b=gWvTQ8b53GNXB+GfN5/qku86aFwx1OgWLCZCyGGzbgL3dr4hUWlary6VBfjEM2MlDc
         uxlapRKw2DGBbXC+k26XuAaF/G/krahl9vN6yq4A2Rs2VG3jq6S6nESbrLbh2r7guOCJ
         DrZL65K46gwJBH33tslM83aqSZxDMWlPmGX2P3zkpqSV3OPdzFyuWSpladleiIJGUis6
         ggg9HShW7akIUnVS1MCOtOaeI0S2I+oOPIQVI5I/wTCrImHk9WZS35JCLUOVVOpB0dYb
         UqxpwWzqSR2R82wyi9TAr0XExYxD4cavmc+Lm/mNFKGlNgdWves22ONnr233DwoOtgZy
         vC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCPw3EhVOnlyAOusKVtcbZ8etTYvYsbrsVwZV7Qy6mo=;
        b=QSq08Ad5MF3i8Je2p2jqFHguvfOHVOk3Wc24lMS+vh1Qi4DciSqhyq56qXYao4snoj
         78fOnyutNl795ns00AsVPO96hT4XXwNH4K4mTC78s/GaBc+RMsoA2I7Lo0zoAGmS0BFw
         E2TOXOI1WopmTe3/BtRG1XakLtlf+DfTucEHAuQt4WCKzjM/yHjZofDnMEQHYMu4xwai
         WbqFIjtNQBIKppAu0h0fTT8ghTXAhVT/lzLT3g/AYGujNDV3Cb4TApOHEZnVIV0WzSMv
         967Ws74haYhVYSz79F+d6ZPJ05F2xBtqmg0uQYQrhjELfFXcDtV3lOIY93XSx3QxPE1A
         gyMQ==
X-Gm-Message-State: AOAM530VVtm/BW83nGfYV69SXqO1vNin8zJfcqlQPcsH6b9FRAqFawCY
        X2kQ0bNeOtbpnOrxLFBwNS693BHQjZM=
X-Google-Smtp-Source: ABdhPJz+Phbi0hjs2aa4/47GYPe5+Bx6z8W3tCqUhwmhq1LN9GcnLVdPV1sYl7HDbm4qSLn07v0I8w==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr2237927qkg.403.1629182688536;
        Mon, 16 Aug 2021 23:44:48 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q194sm757062qke.83.2021.08.16.23.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 23:44:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/2] builtin/add: minor unrelated fixes
Date:   Mon, 16 Aug 2021 23:44:33 -0700
Message-Id: <20210817064435.97625-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While not related, they touch nearby code and had the same author.

Carlo Marcelo Arenas Belón (2):
  builtin/add: remove obsoleted support for legacy stash -p
  builtin/add: make clear edit and patch/interactive are incompatible

 builtin/add.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

-- 
2.33.0.476.gf000ecbed9

