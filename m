Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7048C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AF320897
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="P4HSrWxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgITItD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITItD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 04:49:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888FC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a17so9660659wrn.6
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OWD2Hx7SyGESq26oIKmj5k5yPvy6ds11VC0c6tbPWg=;
        b=P4HSrWxpiZCUuud7CImQnKYGkE8vygJg+YxGAAhak8IrSpfkKEOJBwQSsbDM2chc2j
         +M6qGJU/otOBR6O5JjUTU+TuNQhcubr/BFkmePx0zNFvunAtGY03vbxTysJByO8Jq7t/
         xTmQwCokdVXMQntsDUMxtSNQ8pFJCmRtU4YgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OWD2Hx7SyGESq26oIKmj5k5yPvy6ds11VC0c6tbPWg=;
        b=YB6t80V/7AEJeF8SLxj4lHKlkoIWGRrUig8OnHELwiZVg1YElw4tP7Wx6a12EOMqc0
         VJCQdgYDF0d3V549PrcOWJCsSYlx1Cwyin3tyoZmx7tOZm0tfjkIIgvSuUH0qhDZ7Sy3
         R7r7o3PKFZuRWhM2LZjBCRRL5DmDKk2cavX0rJRWoVch0sp6xFOgp09bB9v65+6zpWil
         F4QCUp7Y85hfYCejsI8M6+KQleE8kdz/IINgA3sWyOYDlr0Fq1oBa7Sbth65uBT3TKNM
         V2jT+ZyJabRg3eGcPV6tgRkrR/o93d4415PbHprOPv3EsW1aAPtGOaaAuIyq+uVsHn/I
         Mzyg==
X-Gm-Message-State: AOAM533v9s8h5WdPhbgnq+mZkP2b/z8VsTQgYDy1GEAxWzwDtAWYPuA6
        cScH7Wi4D5dNxMJ74X3UsAiw4fvWBXA0kA==
X-Google-Smtp-Source: ABdhPJyMXEsqYNUGpb952EA0XCh8+ytKkQTOYKxH01DiYUPzQbKW5fFO/vlVHzYls2zG1fSGq6hdoQ==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr44599676wrj.94.1600591741697;
        Sun, 20 Sep 2020 01:49:01 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id 11sm13437567wmi.14.2020.09.20.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 01:49:01 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/2] git-p4: unshelve uses HEAD^n, not HEAD~n
Date:   Sun, 20 Sep 2020 09:49:07 +0100
Message-Id: <20200920084909.17794-1-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated commits incorporating comments from Eric Sunshine,
fixing indentation.

Luke Diamand (2):
  git-p4: demonstrate `unshelve` bug
  git-p4: fix `unshelve` bug finding parent commit

 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.28.0.762.g324f61785e

