Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2458FC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2BC2076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cphtI56A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJGIRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 04:17:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A9C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 01:17:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k10so1078578wru.6
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uwHyIIE90InY7+rSzeFWHxvjR4wIUPfzSbyXvyEERso=;
        b=cphtI56AHCsHwNz+39lRtGZZVFx7brFPmQIDj8LtPEgHS/StBO9vtDvCfEWOquLHNV
         z2x88mAEtaeWfAGenqG4y+cq53o+oBUNEDbpzm9ucBPHZ55xBcjHJvyvyJaq6OriIPkd
         qakkl79JdUUeOXNjCBg6nPe6roQXh2mdql+Cx11BxDCiL4WNz92cyN1+PtJa8eIN4gI5
         BlLED+6WOg3WUEscX08BCCJkfsXnKn19peX7+zl/T2oX7/Q0vbR9iq1UUcaHGYPONgHL
         h5WrIRxRgwOYj/4SUJg3l+1itOJbU+MskZ93fy9OCc7XlnctEqzCx3QF0/FjGsNhmZsy
         XbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uwHyIIE90InY7+rSzeFWHxvjR4wIUPfzSbyXvyEERso=;
        b=J24KPYsK7i19F4kTnDKsAA6qTzqJoFtbJE/3g+E5/QZkdCYn/D5z+n4tDbOJhElpDB
         DgZb0xezcUPufOUeqY3wG4dEtnHs1attRhln/r1sB1ywr+CaHZaiRvmpOkh499hA9w62
         02kHYKdl17bZFxCs04sMUoE4011I23EiUplrZEXZ6L9ejyl9n1il5wANvRvVS1rt9Hir
         uYBtcTX6J7or1CPOCYUAKhV5bwTWog15KfUjkscuS4/FZQwjWe29fu4CQtYbVhu49QZW
         3sJQItj5ZrPaQ6gvrOT1+CdoLW8oEmyuIXCP4ZO1UIPNlcqLE5etrAfv9TOuypN7D4Aq
         X5bQ==
X-Gm-Message-State: AOAM532bE/s3Jl2PDgMwhrYNOUQaIMl8lNEhh2THpoY91oDmr+MZXKvC
        XVp5E1BObTcpNBHy7m98g9QsPQB1IK8=
X-Google-Smtp-Source: ABdhPJz08THo+eEb9xqo4p3tnDq9N+bC8dIAiqplGbiOzsELnJYS/D5Mwh+zAUaB9nzuzDAjhx6AUg==
X-Received: by 2002:adf:9361:: with SMTP id 88mr2051526wro.37.1602058671358;
        Wed, 07 Oct 2020 01:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm1021049wrn.27.2020.10.07.01.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:17:50 -0700 (PDT)
Message-Id: <pull.744.git.1602058669919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 08:17:49 +0000
Subject: [PATCH] GitHub workflow: automatically follow minor updates of
 setup-msbuild
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is the custom to follow minor updates of GitHub Actions
automatically, by using the suffix `@v1`. Actions' maintainers will then
update that `v1` ref to point to the newest.

However, for `microsoft/setup-msbuild`, 889cacb6897 (ci: configure
GitHub Actions for CI/PR, 2020-04-11) uses a very specific `@v1.0.0`
suffix.

In this instance, that is a problem: should `setup-msbuild` release a
new version that intends to fix a critical bug, we won't know it, and we
won't use it.

Such a scenario is not theoretical. It is happening right now:
https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands

Let's simplify our setup, allowing us to benefit from automatically
using the newest v1.x.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    GitHub workflow: automatically follow minor updates of setup-msbuild
    
    This patch was based on dd/ci-swap-azure-pipelines-with-github-actions,
    but due to changes outside of Git, that GitHub workflow does not even
    begin to work anymore. Therefore, the patch is now actually based on 
    master.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-744%2Fdscho%2Fsimplify-setup-msbuild-upgrades-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-744/dscho/simplify-setup-msbuild-upgrades-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/744

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fcfd138ff1..14ff94dcbe 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -154,7 +154,7 @@ jobs:
         Expand-Archive compat.zip -DestinationPath . -Force
         Remove-Item compat.zip
     - name: add msbuild to PATH
-      uses: microsoft/setup-msbuild@v1.0.0
+      uses: microsoft/setup-msbuild@v1
     - name: copy dlls to root
       shell: powershell
       run: |

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
