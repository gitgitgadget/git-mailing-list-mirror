Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F984C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2188B61AA2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhKSN7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKSN7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 08:59:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3B7C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so10589583wme.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkYXYR9vGGJDxGqHU8ZLFYyjHEfBm7+PEAEmzSJg6sc=;
        b=hgiZ1ew224gXWoMoUhsQ7eAAONNrUo+WUDGiCHnjRG0JqnJxPYfwrj0Qj36bvFjZO+
         DEtFacJwJoKEoZ53LU0INscxwVFrezkgz0WB2uQ/2z4LB7TgZ48Wp2rY2MFRNFCXJdc1
         KB0aK4u0iUaOqu1GFOZt0BMgusYu6/kux2aLs1r6JXob1Lp/e/6TLqYu8MTU83yAa3St
         +Z8Nin3kUGo91eiwM14CzGSmLwgMKWp+mrsQEzoed2/yJTAtriOIl/WSUgrks1zlHboU
         svDcxxV6Nahb0CgotshtIlgCaPwx6pTPs1avNG8luT+xXkROUOCahSzYK+KQWQ/y1YpG
         /nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkYXYR9vGGJDxGqHU8ZLFYyjHEfBm7+PEAEmzSJg6sc=;
        b=x3jhqwZv8GiX5FGSXTmzUkReq/s093nwAYSncImXq9sX6e/wIypFnXEsvwAXV0k32I
         Gc7bGJ/3/qxOgBzrkdWKgymjAIw16/VFoJNLweMAHrGmXaOnO3i4vRRKjLFvgHexq/27
         V6KXEwr+SlCBDfS41iOJgzYnxhJ6ON4jHvxQLvWWom25FuOawPMarPDNbR8yKM9dusjD
         ZmGMv3cARBoTqubceHNbN0yBZ0O3FPUAN0QW9gnfy79/tL+RYhUkKs+RuIWuoP5ewMgu
         RyMieFSW+l4U00x2WAehkw52hl+aOaQQtqoKUmK/iH4DGGIuo1nzux74JV6Ogkzgn4C7
         NqoA==
X-Gm-Message-State: AOAM531n2Rhz0jpBL5kYF0cZpIKNmySn7IHNifM9hiVYUC7z/++iBlpR
        Fl6apAiks1Du+eZIQvYX8AMJByC4yTtMNA==
X-Google-Smtp-Source: ABdhPJxbDt6entl9FsOVYtPGS3/SgOqlnPBtiu5gwdBzt7nHnG0uxrzqwsSzsmimRjgUEr7gUCK5hg==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr7421536wmk.34.1637330174719;
        Fri, 19 Nov 2021 05:56:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15sm4488823wri.50.2021.11.19.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:56:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] CI: use shorter names for CI jobs, less truncation
Date:   Fri, 19 Nov 2021 14:56:05 +0100
Message-Id: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.g5753b56b5c1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes the names used in GitHub CI to be shorter, because the
current ones are so long that they overflow the pop-up tooltips in the
GitHub UI.

New pop-up visible at: https://github.com/avar/git/tree/avar/ci-shorter-names

Full CI run at (currently pending, I had a trivial last-minute
update):
https://github.com/avar/git/runs/4264929546?check_suite_focus=true

Ævar Arnfjörð Bjarmason (2):
  CI: use shorter names that fit in UX tooltips
  CI: rename the "Linux32" job to lower-case "linux32"

 .github/workflows/main.yml        | 15 +++++++++++++--
 .travis.yml                       |  2 +-
 README.md                         |  2 +-
 ci/install-docker-dependencies.sh |  2 +-
 ci/lib.sh                         |  2 +-
 ci/run-docker-build.sh            |  2 +-
 ci/run-docker.sh                  |  2 +-
 7 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.34.0.823.g5753b56b5c1

