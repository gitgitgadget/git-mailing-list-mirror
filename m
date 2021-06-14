Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C525C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7598B611C0
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhFNRUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhFNRUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EAC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c5so15337103wrq.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp12vhSsHfL7+CmdgrHpxinsCBSUHrx/LALXilhZIpY=;
        b=h3z6jwzMafXyNUwLSSUsjXR16y2k3XQ93T0zRhdvIttFJoq37NLuGGk/kacQAmWSjS
         EWppGStpUG34BEwutqnCsBI1KP0zijN/SXY+YPHwtz8P51cKxs6tGnKVTq1l3EeY7+WW
         MAs1mdAO3Oo7fSbSIarX9iZYw26pSMW4VDatjR5FS+s6GaI0yQwjeieRWAM6kOkAXeFV
         FHXYTj4NotNpnkvOA03ZqY5PeDunlXQdJqYddIDVkPwth2SzOZJTj6y60ZGNBYxvSWOn
         C6vsWo3V6wH3w9Pl2IAv0lg2niNFR/8JNxF3aUAq7UFOaZitIHaIEIUfac0IQ82GhHA5
         SKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp12vhSsHfL7+CmdgrHpxinsCBSUHrx/LALXilhZIpY=;
        b=crwqUcXl0Yp0U1cGe3PrXi5mbFrs9TJIK1jK6+s1jrUwApT4e1hSqLdCzXuw72HtUg
         qRu/V1Cg8jiVMz52NWI8sGx7SWjPXi0utrEwYxRLmuzyyfyy4XG2KtrSUbjOvh3Uu8fJ
         2UGreik72TjwEQt7q0eiQNBYIkL1cnIxGchggGGgq1NYiwmq0ogMBUxDYqjxNb2V2Iwj
         l7+wBUHdPQRx05z3oHXhXCWWk5pDzoQOtSc8pWyxKvKrHFQPTB26mOu2JHtIX6SBM3aL
         9HGtf65aTn7C/Ii6KXjPjX2Ul3OGJOQZLdCERILDfFKsheFrh9WFXEcVE+3s6k55KLtc
         q8FQ==
X-Gm-Message-State: AOAM530JxhNfBdK1tBzBsonwnEDn1ioBeZQ8Uv/rTY4klgWp7ExIXRBw
        OgLNLsTeFQisZI1UOKo7iYlTWCvQg6x+Kg==
X-Google-Smtp-Source: ABdhPJwGjFHfqxQdBkgK1nlPI/T4K71LaYXDG796lr3nY8w69e/0cQgBlZTjYAyrVydVh/HAI2t2+Q==
X-Received: by 2002:a5d:5983:: with SMTP id n3mr19967540wri.241.1623691093762;
        Mon, 14 Jun 2021 10:18:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6sm83816wmb.15.2021.06.14.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:18:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] show-branch: add missing tests, trivial color output fix
Date:   Mon, 14 Jun 2021 19:18:06 +0200
Message-Id: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series I've had lying around for a while, when looking at
the color output for show-branch I noticed it reset and re-enabled
color for every single space character.

This fixes that, but mostly fixes the mostly non-existing tests for
that old command it. It still has big blind spots, but now we have
fewer blind spots.

Ævar Arnfjörð Bjarmason (4):
  show-branch tests: rename the one "show-branch" test file
  show-branch tests: modernize test code
  show-branch: fix and test --color output
  show-branch tests: add missing tests

 builtin/show-branch.c          |   9 +-
 t/t3202-show-branch-octopus.sh |  70 ----------------
 t/t3202-show-branch.sh         | 149 +++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 73 deletions(-)
 delete mode 100755 t/t3202-show-branch-octopus.sh
 create mode 100755 t/t3202-show-branch.sh

-- 
2.32.0.555.g0268d380f7b

