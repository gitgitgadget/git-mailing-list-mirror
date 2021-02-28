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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB2C433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588CA64DDF
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhB1TzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhB1TzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264AEC06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mm21so24017431ejb.12
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMANFPApib40VjwoG0Ii79VkqrqCc1F7LCXodPYfuV8=;
        b=K3NeklN3mTMMNBm43oXJlXHBlq8SdO+nyYwkoF3wknPOa/SVvOYgQ7tzoWfxwRy1iL
         YGhRk9OAENPirkjJZMW3SiwKoYI/CapgRa04lw2DFoxsW37Npq+JXHMLgWkH6hRaBbGa
         TQpFvlMZvaBOS5sWiyGxWeqaLljoQZwJfBqepqAgi1RICknUpogbZwii6xSBgvrrje+l
         CE9l28Y6TRHkJ/9/XG+rt2bgv4pmFLvbYaYZrijGo4SqWEbzXSQIEU53UGbH37D9xP3U
         R6xkxE7orU08TCvZexzUrYzaOnf8yoYNT4mbX3xHV60keglCaxvxoCdqX4t36y/9q7l/
         jL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMANFPApib40VjwoG0Ii79VkqrqCc1F7LCXodPYfuV8=;
        b=ocLmO6mmhbNX6SgTPoo8Fams7o62BL01IuUiv8Qapke0nE5SWCHRJ0nqTq5pLAQHSH
         2T+GktOddCpu27HOzThQWWMzHeyr+lMewC56i/d1pBY6ZYxxdjQxLrnSAOmlqcMrGSf8
         2ahi1CVaDvzsqclZFc4wGm5QSNgi7fMeP+2Vhc7DPJvy1QeXP5FcR52uBpUCC/bvBaQ9
         WR4A69xbDgHgaG3eOvsf0XyYJed+JfnpXsqueFVhfRG+wPDpMlP2706BGWf35s7Qvqcb
         ID0jnMlf4xuCbEKDP0yelmrbwoWZL7bddk72ZYNxCCbADa/HEt5ylagpkVyCC6wie7qj
         w0Ng==
X-Gm-Message-State: AOAM532gbcx0455XxvSBl5mNvFKS4CnSb1g9BsimVG243QYHaz2uO5ko
        IqKtvP4RKK++bQ1kR40xvT+E1Q1PUHs=
X-Google-Smtp-Source: ABdhPJy81ca2+6W/MH69e6O6rn7mC4bR+Kf5C0h2roG8mIcvE85xZnIMx8rnrxDmoosvxiNeIOtJXA==
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr6766460ejb.275.1614542074369;
        Sun, 28 Feb 2021 11:54:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] describe tests: refactor & fix recent broken tests
Date:   Sun, 28 Feb 2021 20:54:04 +0100
Message-Id: <20210228195414.21372-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the "git describe" tests due to the on-list
%(describe) discussion I discovered that the feature added in
30b1c7ad9d (describe: don't abort too early when searching tags,
2020-02-26) has never been tested for.

This is because it defined a custom test function that called
test_expect_success, which then got called inside another top-level
test_expect_success. Thus even if it failed we'd pass the test.

This series fixes that issue, and makes some general improvements to
the "describe" tests. I then make test_expect_{success,failure} return
1 to catch these sorts of issues in the future, which required fixes
to a couple of svn tests that ran with "set -e".

I was on the fence about whether to send this after the recent rc0,
but figured that since it's test-only Junio might want to pick it up,
and possibly for the next rc in case we'd like to do some pre-release
testing for this never-before-tested feature added in 2.26.0 (although
the actual implementation looks fine to me).

Ævar Arnfjörð Bjarmason (10):
  describe tests: improve test for --work-tree & --dirty
  describe tests: refactor away from glob matching
  describe tests: always assert empty stderr from "describe"
  test-lib functions: add an --annotated-tag option to "test_commit"
  describe tests: convert setup to use test_commit
  describe tests: fix nested "test_expect_success" call
  describe tests: support -C in "check_describe"
  svn tests: remove legacy re-setup from init-clone test
  svn tests: refactor away a "set -e" in test body
  test-lib: return 1 from test_expect_{success,failure}

 t/t1403-show-ref.sh           |   6 +-
 t/t6120-describe.sh           | 193 +++++++++++++++-------------------
 t/t9117-git-svn-init-clone.sh |   6 --
 t/t9148-git-svn-propset.sh    |  27 ++---
 t/test-lib-functions.sh       |  20 +++-
 5 files changed, 122 insertions(+), 130 deletions(-)

-- 
2.31.0.rc0.116.g45ec00aa00

