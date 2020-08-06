Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF9C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22EA2173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8awdTLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHFBFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHFBFI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15BCC061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 18:05:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so6139805wrs.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5uR8koG+8nRMfF4vZbyb0Bzx8b8/OiGiNa+OcwN+n1A=;
        b=t8awdTLG8sTMLIFLSoDbI7MC0281JvwYErLadCH/Wox06D+n6Eaky6iXcfaA/voCYO
         oQ63UA9N6pNnl8qLbBXNz5vHBvUa3Wm34qax0+nIqYqEKqXyed3XKmRP0XfBIgE65ZgB
         PB0Ow5/HfEB4zvPtTePdPhw16ZLJFTwCQjxsvI117eO7dFqQa7saNV4DcP1yCKk4b/Ev
         48xP8DGC7X608ipx+Qgzqvs/JU3WSOQDQEUuAXGtBB/+NN5M28/LQ4/LEacahqtw94nA
         nxksb4WSVEF2tGMrUfARYAfBPzPJKx/RJWpeD0PHxianZ4qkC62mem0bfvdmeUJS9a/w
         FHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5uR8koG+8nRMfF4vZbyb0Bzx8b8/OiGiNa+OcwN+n1A=;
        b=cc8UofbDTAMcgPrNUN0OQiKaTD74T7lYgaPjSoFQ7k+RaxOVoI2D2a8aBUunhR1pKG
         MryoaBWemwmclAx1gZMuMqIymt3lhBj/nRO1/ZyKc1Xz8LmLY+/KcIIOqg1iCvpJXTds
         jfgX5bP6g0wa8l8GRV4kMTcfGGp+qdYNAGR1MuSYPjoAea+TB3lCPECwG+F7UunJlsm1
         sUNF48kGWSxol5bqcSFpOQEkZ/wddRcplBD7EALt4wHb8c4csEpZevKs6TtOcb0gRfJP
         9hcKhZMc9VOBXgpvYSTw00N5g8OVy23XIdE2nbHbzgOqUehf2Y9T/ibCWlHJMC03XAm1
         s5eQ==
X-Gm-Message-State: AOAM5302TddhJFdUNqJhiebYeFP+8BEccnPtU49EkkOIiBDPJAoa8dd/
        UqOX2hL9vqCES/wXYguQqV9WaZu3
X-Google-Smtp-Source: ABdhPJwCl4d19Wv8eGBqSoOvDxkYxT47y6GiH2UuQA+dcnc5/e7MCQDNB657m9cyT8nbP147jAhjUg==
X-Received: by 2002:adf:fa4b:: with SMTP id y11mr4819976wrr.349.1596675906275;
        Wed, 05 Aug 2020 18:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm4678765wre.44.2020.08.05.18.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:05:05 -0700 (PDT)
Message-Id: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:05:00 +0000
Subject: [PATCH 0/4] Fit the building tools to Plan 9 environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've posted some commits for porting git to Plan 9.

This pull request is thing that cut off building scripts from #305 and is
re-constructed that.

I expect this don't change any artifacts.

lufia (4):
  Use $(SHELL_PATH) instead of sh in Makefile.
  Define TAR_CF and TAR_XF variables in Makefile
  Fit to Plan 9's ANSI/POSIX compatibility layer
  Use $(LD) instead of $(CC) for linking the object files

 .github/workflows/main.yml |  1 +
 GIT-VERSION-GEN            |  2 +-
 Makefile                   | 33 ++++++++++---------
 ci/lib.sh                  |  8 ++++-
 config.mak.in              |  1 +
 config.mak.uname           | 18 +++++++----
 generate-cmdlist.sh        | 19 +++++++----
 git-gui/Makefile           |  6 ++--
 t/chainlint.sed            | 66 +++++++++++++++++++-------------------
 templates/Makefile         |  6 ++--
 10 files changed, 93 insertions(+), 67 deletions(-)


base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-694%2Flufia%2Fcompat-p9-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-694/lufia/compat-p9-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/694
-- 
gitgitgadget
