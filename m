Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E950AC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AD361075
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhHSRRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhHSRRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:17:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A2C061756
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso4438448wms.4
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0Q9+gG05vetHt/0pJ4fpO85vlegLx3/gvuvTzMatPHk=;
        b=gv5XpKmJ/aa9SOOP4E/vOiwLVou3qmslUYw8cWRlBtfqZHcZbaCAKtlcgzdHqJlLCv
         HA1JH5assNmCQPHks8lNHGuG9ARpVnFU+BWTkf8qE/Ksl+aczivqjH2VIkvOdc+L5kAF
         cKQr48iMniCYmWkBMNe4IwCYNmVyxrD5XzVkHePoXUiQCJYk/rfefpI8BuR0reIA3Wmn
         TCBrmz/HSwpklhT77G+N5BVbNu8i43l9vLy1EuySJqHhlypGlc7vTrE1c0hNhJQFD5tk
         aIUpQF6xDiU2IIk2tHUDiAwewtErUUUAujE7LZKCbpMvnzhfIOF5re+4plYWJQqh+cv5
         dKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Q9+gG05vetHt/0pJ4fpO85vlegLx3/gvuvTzMatPHk=;
        b=X1SOw2V7x+y4W7kPot2CmiMo08dw8Hc5BBIfsFWrwKEw58Iu1xE6PinMEmQmxtr5Mj
         dYowFW6L9RhQyXdysttoGVFUmk6XJ5I0+fwhhwLnSoKV3w9E9+W3p6tARquXmWTJSJXU
         W4YVCfhDkQPOqDerH66Hj5bt+DZLsY5Z0IuvPmPHRwGPWxUdyyW0DCVnn85mR1piySkl
         VDnODOb9fKMgBgtlRZmHUPQpz6ez6DezevJDwzIUywxlGEczKhf6spUoZPoVPpvs2P5G
         DgOZHNJQ4/agK3qsIAvle9AHI1TFIhGxjuLKOFM/U1CIXiyOiAtlYxiyWdmcs39dvM2p
         JLqg==
X-Gm-Message-State: AOAM532vrpW5wA8u5bgi0LJUMSUZK7st65/A15N3gQYHOIZg4NQBkgKa
        /dS/vr6TyoXOoIterSwjjBUXcdiACpE=
X-Google-Smtp-Source: ABdhPJxy/QWy5ybdBPAjKX5T+PRds4U7YfbI4eXVOlJRrGSyE/Xp2lXWi4cq8kmvVn61Qv5P1RdIhw==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr14951443wmg.27.1629393396873;
        Thu, 19 Aug 2021 10:16:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm8449658wma.25.2021.08.19.10.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:16:36 -0700 (PDT)
Message-Id: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Aug 2021 17:16:33 +0000
Subject: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and SHELL for 'test_pause' and
 'debug'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series proposes two small quality-of-life improvements (in my opinion)
to the 'test_pause' and 'debug' test functions: using the original values of
HOME and TERM (before they are changed by the test framework) and using
SHELL instead of SHELL_PATH.

The later might be too big of a change, but I think it makes sense. We could
add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
simple for v1.

Cheers, Philippe.

Philippe Blain (2):
  test-lib-functions: use user's SHELL, HOME and TERM for 'test_pause'
  test-lib-functions: use user's TERM and HOME for 'debug'

 t/test-lib-functions.sh | 4 ++--
 t/test-lib.sh           | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1022
-- 
gitgitgadget
