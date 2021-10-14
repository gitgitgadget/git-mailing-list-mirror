Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26417C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07B660C4B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhJNXjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhJNXjY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:39:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A1C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m22so23330600wrb.0
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rod5qXkPc2cB6nDO4uOqN0WL7Yr2HmTtVHdid+gAbA=;
        b=YwRRYZ5Y0qCCFvchHq/yJ4hEv8vlr/5cXSn2HP4CJoc9iNbwPmaPQ1mKPOeBfRMHg7
         1t6BWX0t7fyzm5fK8Py1JK73ez7giV95qTGCMKlx9yMTKHwadcQCV3UwH2nUDmWFXAa/
         JM9pYiBU+wzdLNY4nqIMscmYnhxWYKOexHIj531fgOG/ve4X/tGaCXeFDXgAkMvpe2f6
         N9akBR81HMn3RRvsw5eiRpfs3bI9myKidGYWKMZ5cJWg7PIf5U3Ma7m3zcwRdP1XUcVl
         SnIbYZ1aWelKjQMPnJlyWk3mdRkFm89jeY5yJj0iZoRQPzh5HFzdLcgzlyD6N0mvVNyS
         VC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rod5qXkPc2cB6nDO4uOqN0WL7Yr2HmTtVHdid+gAbA=;
        b=IJxT+XPMLCvvg+u4KrSAj8Cdhpsnwsen8Nd+VRigOkTLejg+A8FDSVtjDn42tgLP9A
         3xPhwIvXph7daBssK/E7pEndLTwB3WW4ozHIvHQSGlUdhISzWEcqx4eiJqCSE8hPkXRK
         oTFTEXg8szH/GLa+gs9ts9qMvACHmDHoF6PIpffVeTm9Fnl+zs9nXR31JM0kAQTUpv9R
         Nx5EIMeXZM3YOF0tbwAoP7i0S2p1uUO5JSJP8KNO7cWZmxKBnjQj6OOKs7xynkouy6Na
         5ywCgGr98lYyleGM/lz6kH9OwKrk779lWjGACjde86JfgGFFlYWg/AUYopSRWMz83HaY
         g2mA==
X-Gm-Message-State: AOAM530+8P632vXTCtWckD0U8DpqR/PMPND/bURJad+3437BMx9Rg6SH
        sYl30GNS/kbYceVkfgGjKWzTShDKxIcnHg==
X-Google-Smtp-Source: ABdhPJxTamWkqdZgQA5ssxGpoV/n8YMSlB0k9UxWWOHHZdtVmEHi/H6VQk0s3GLhto7HquVC2R4ZJg==
X-Received: by 2002:adf:a1da:: with SMTP id v26mr10470579wrv.186.1634254637773;
        Thu, 14 Oct 2021 16:37:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g16sm3547658wrs.90.2021.10.14.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:37:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] commit-graph: make "verify" work with replace refs
Date:   Fri, 15 Oct 2021 01:37:13 +0200
Message-Id: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes "commit-graph verify" to ignore replace refs, as
"commit-graph write" already does.

The 3/3 is a rather simple fix, and unblocks another series that wants
to fix the GIT_TEST_COMMIT_GRAPH mode.

1-2/3 are fixes to existing commit-graph tests. I just wanted to use
the "graph_git_two_modes" helper, but it was broken, including in a
way that hid an existing failure in a years-old test.

Glen: I've tested this with your v4 series with that
"GIT_TEST_COMMIT_GRAPH=0" part of the mktag tests removed, and they
pass on top of this with GIT_TEST_COMMIT_GRAPH=true.

Ævar Arnfjörð Bjarmason (3):
  commit-graph tests: fix error-hiding graph_git_two_modes() helper
  commit-graph tests: fix another graph_git_two_modes() helper
  commit-graph: don't consider "replace" objects with "verify"

 builtin/commit-graph.c        |  2 +-
 t/t5318-commit-graph.sh       |  5 +++--
 t/t5324-split-commit-graph.sh | 20 ++++++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.33.1.1338.g20da966911a

