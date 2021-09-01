Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD823C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE8860F4B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhIALOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhIALNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:13:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BDC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:12:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n5so3842341wro.12
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqq1fekqLOud3I7SWXqslrYVd/Ptu9AEC9mNyvFj2Iw=;
        b=UbUIswXru+53hVX1E630wzE7i9saef9PiPcBcdDjRjnl2bnZ6pkXrIUSQfN0V644Y6
         5Mw0X4v+xcPi9BB5FWGn3+V7tnGg67CniIsFf38YPhSj5nb4watx4486ZSmwj0DrU25H
         1yfm6LfV9skXfDKOVrMEfvDg1mt9jxZ0Nsmfi9Ft1tDWuPoujD9dxDMihOVSv1cL4SIE
         SV4E/ybjjAg358dm7RLoAiQ2jrqVpPMqVMqFGq9cEfUT29B0m+YBIXxHq9cFkAPBq9rR
         ApMtDsv9g6pk6MkLjIMr9DH7L5ez02OPOBBu5rPjmmsnku8LOZ4FoulI0LJ1fXk1lV4/
         8Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqq1fekqLOud3I7SWXqslrYVd/Ptu9AEC9mNyvFj2Iw=;
        b=t+Dt657wSpbpEJGBY2rOGUhMI/n5qxdiJxeadXP57mU6YRtl5GT5G8/QRIbw6ppVXG
         x2hTiOfvWygvHTjocFhG+ITpsO2CN8LW16XxnhrFI0IMfv29Be3HYOqogid699bUO1QO
         OkaCHD/O7ufC4BbqYCRFS3krw1Gi0BAEJ50s40H963OmpgH//++1IAEut/6yPTSg+p+4
         apsZJ9Fy19fgDBYnq79Y7sZmy4SmyfKGWmWN9P7Dp5O53N60iMwYwaz6+QL+9cWIE2Br
         X0LI/9RiIsNFHPNSO/FrOm9ZuwMRka08u3KjF98UKALKfcZcAV/xvNlf8kYL1KGPrBUP
         a/bw==
X-Gm-Message-State: AOAM531JsvvfP5gVsr4lcZ5pdwk5afz7ynugtH6t/99rsK0RcKTmQ0nm
        e60HXAcfaS19cphKwJrwfotYcikHNf8BRg==
X-Google-Smtp-Source: ABdhPJyIJHBMnnzqDe90MUjbTRCtxlHZQvGqDuRE9Y61xG9GOM/p9DzLb0GirakmxhwDMSjLl1gLiA==
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr37105396wra.258.1630494777250;
        Wed, 01 Sep 2021 04:12:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25sm5151499wmj.10.2021.09.01.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:12:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] parse-options: properly align continued usage output
Date:   Wed,  1 Sep 2021 13:12:53 +0200
Message-Id: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.807.gf14ecf9c2e9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes usage_with_options_internal() in parse-options.c
to properly align continued "\n" usage output.

Before this change some built-ins using the API effectively tried to
hack around the lack of such alignment, with some getting it wrong,
and some getting it right. Others such as "git stash -h" didn't at
all, and their continued "\n" output would always look weirdly
misaligned. Now the output all looks nice!

This came about from following the thread of "why we we even have '\n'
here at all?", which is a question I had in my own mind around
https://lore.kernel.org/git/87zgszxirn.fsf@evledraar.gmail.com

Ævar Arnfjörð Bjarmason (2):
  built-ins: "properly" align continued usage output
  parse-options: properly align continued usage output

 builtin/ls-remote.c   |  4 +--
 builtin/show-branch.c |  6 ++--
 builtin/stash.c       |  2 +-
 builtin/tag.c         |  2 +-
 parse-options.c       | 79 ++++++++++++++++++++++++++++++++++++-------
 5 files changed, 73 insertions(+), 20 deletions(-)

-- 
2.33.0.807.gf14ecf9c2e9

