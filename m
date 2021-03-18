Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CCC4332E
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6200064F01
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 18:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCRSoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhCRSn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 14:43:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D07C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:43:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g15so257821qkl.4
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvKOZVML0bXqZFa1CfCo+H0wbC2MQwOAv3sz9t9wURw=;
        b=cjQQbYFggN/Q0B5oIzdysBzNt0Znhv7olXIpN227BNIHmBepP07+i6eiTScPu8PsW3
         jgc1tw6Z9MosSH5cnvbaj5xNZRipfwvnx8/di5J5qtoG8wpUOTq4M63yliM7Bc9yPDYJ
         YLew0dTTYbMKhcx93GkvyupkMrVpFCJJ+GKTyquX6Gt8CFcorh9LgrPnQ1ZxgKJyd4wz
         dvczcSi2hACijStkgODrhkgj9QfV36H7w/1DCO4iVtXOFpqtI1O/eo8989KMTDZadOSm
         HmU12Y04ArvO8rmxmXrRgl4ns+vazXKGi9/pqjvBtMSwhHBTwWXWStPD9Psy8dSUAOGa
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvKOZVML0bXqZFa1CfCo+H0wbC2MQwOAv3sz9t9wURw=;
        b=REcalOlUcco+Sfw5cBCsY0GcFer/HzqVMgDkFuo/WBonEwneLo2bc4nfOT8UHkoc4/
         SFc1c0Iwn0jheRMxjSK2TQsOeuGlHmmz9f4gq9tVzoGb+esfSoORPTtDVnsYbPk8vHNy
         qxHWcmaY/RntpskMqzw8Gog1q+WM7gTs0cIqqzxBYqb/JckDGOji/g3Wm4UMdqCYukvl
         6mW0YtlCJzIY42hialsTtteUf1MkU27riy7qhdEYEAEXCriu3GDI75uoJM/L9I3kBueX
         zrKqilJ0yD5vX+PTv0Y8KFMZpalMaQ2ADeCzcrDbpiUKfieR0zYI1Yv71j8QCKLyxxKi
         S71A==
X-Gm-Message-State: AOAM531K7rnKlR9WVBuFFqZO+80ylfTgA1H3oSMpDRB6ywvvLEkaCD/m
        2BL1WCk3UOChYdAbx8qy4uIGCIkKHyi+gQ==
X-Google-Smtp-Source: ABdhPJz1zFIdT+hWdm2ln3ajuCV3tMdFeoWWbDbq68pFDLsE9Vncw0LlR/hN5uYIfltnHilHW5mKzw==
X-Received: by 2002:a37:6312:: with SMTP id x18mr5539931qkb.193.1616093035840;
        Thu, 18 Mar 2021 11:43:55 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm2037324qto.46.2021.03.18.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:43:55 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de
Subject: [PATCH 0/2] checkout: don't follow symlinks when removing entries
Date:   Thu, 18 Mar 2021 15:43:45 -0300
Message-Id: <cover.1616091229.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the leading path of a tracked file gets replaced by a symlink, git
checkout will follow that symlink when removing the file. This bug seems
to be present since 2011. Fix that and add a regression test.

Matheus Tavares (2):
  symlinks: update comment on threaded_check_leading_path()
  checkout: don't follow symlinks when removing entries

 cache.h                       |  2 +-
 entry.c                       |  2 +-
 symlinks.c                    | 54 ++++++++++++++++-------------------
 t/t2021-checkout-overwrite.sh | 12 ++++++++
 unpack-trees.c                |  2 +-
 5 files changed, 39 insertions(+), 33 deletions(-)

-- 
2.30.1

