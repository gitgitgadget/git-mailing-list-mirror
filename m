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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F66BC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DC2082D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392470AbhAZQJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392618AbhAZQHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:07:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0527C0617A7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c128so3263379wme.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dvje3De8Mv2NcYARWDjgtsUlBIIB/smj2NYo5XK2U18=;
        b=lbLNch6B9N0YpnJtPXI+dtNXrLuSSkAR5ILGpLSKaMEUn1n+8bpOzeL8852WKrqsma
         F/xD7bKRVt1m52CdjerUvmvw/ZW6L/2z//4+nBTUhirHJZXt+6dasBFAzZFANM+N1W3S
         I2UxkUpLWtB7INd/tyOxI2ybDczkdqDxKVCb3rr4Lo1gWGXuMSCmE1G/H5O1LhO2j4ab
         QMlt/Ogn7WPLkb1nlokaOSQeL/cCxtNeFgItOOZAL0dRP+zx9e9e8RSr2pTtsegx5GqY
         vOEDNbJSEDUW3K3ESw8QFJlfkRuHIPyqCLn/nndCkSi4DjUKD7/UZZ2B2s3LCPKwF+XF
         IjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dvje3De8Mv2NcYARWDjgtsUlBIIB/smj2NYo5XK2U18=;
        b=ssi1wMD+4A9ArnKmGFhyP3O/HqYW99xP6PPKqqLXnUcUh2k7Tyg0ap3vl1nnlTYuav
         F3KwefXFgZEPYTY6x+ksRNUb0l0gH5nYFmzxlkUS7thm35MXez/qT//s8NiupxNgiuH4
         dmBWRDjOg6Za4ECxuUh0FurxUlZEfahQpJAW67Elc82OhT3omPKb6yqkHMbQ1IGIQxdi
         nHmh1viT77KShZ37uK7zAsZLunnJudvMGyX94SLaA9Mr0exgx3rI+ENMCWR0s0sDpdDV
         t7tNOIe27tv01Tw3VH7cU6u5ehaeIuV+RNWcSD0CBxujbFs0pP7wy1wdv2RfdzGNJyPD
         6wSQ==
X-Gm-Message-State: AOAM531YPHYW/AYnIffcEklcUFKeuGQv8iY9fvZOSy+np6IdX2NTb2ft
        xRcPnJp5wODAqRDyyvdhcwPmysfK478m9g==
X-Google-Smtp-Source: ABdhPJz7dkbziGsyoLD6tBUs0734Lam8l3z48T90Z852uO16MCFN8TFXcFt9oi4X1ISPVjXAizX2SA==
X-Received: by 2002:a1c:ddd4:: with SMTP id u203mr381700wmg.83.1611677233238;
        Tue, 26 Jan 2021 08:07:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17209743wro.27.2021.01.26.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:07:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] Makefile: micro-optimize light non-test builds
Date:   Tue, 26 Jan 2021 17:07:04 +0100
Message-Id: <20210126160708.20903-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small series speeds up builds where you just want to get to a
working "git" binary, but don't care about running git's own tests, or
about making/installing fallbacks for "git svn" et al (which we do
even with NO_PERL).

Ævar Arnfjörð Bjarmason (4):
  Makefile: refactor assignment for subsequent change
  Makefile: refactor for subsequent change
  Makefile: add a NO_TEST_TOOLS flag
  Makefile: add a NO_{INSTALL_,}SCRIPT_FALLBACKS target

 Makefile      | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 t/test-lib.sh |  5 +++++
 2 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

