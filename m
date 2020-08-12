Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E7AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6AB20781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEtLQWu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLWae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHLWae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:30:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EEC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c80so3094368wme.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=U8sfm0MKZeElLS6CF2e0hQ/eBNihD8kMApyX6RLp3yw=;
        b=cEtLQWu6skuyKjGehWu+nsP1+0AG/copM20P8tsoZGuTE908gc7Vi8MQFsJ+wxxLzR
         B75Jp6UsJu6K9NsP6wYjfjffbbjzlI8kn4aO5MnW43hyNO6P0TnC7MxJI/0NY77cUyGa
         eRbOTE/fc/sDalNeJLVvgEo+dvVndbOP6ir9PHTK7Po5NmX+hcGrjMccODIAQRZp7pl1
         /pfcUFaB4gX1bRPoCog5bKCaXvc4qm6hndVqLx7I4jit4EpUbLo/roG5uUC4htMbzBzS
         WDmMN/LFZX90EfZrWHMs/7MuuL5wRXh7S2heYK12EfAUdvmnIPkGy6VWr4oQ24Tzf28b
         kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U8sfm0MKZeElLS6CF2e0hQ/eBNihD8kMApyX6RLp3yw=;
        b=HCdk99bPfoAd5C5UMYvKNnopJdpGJ0zjXHT3u9X03PDmTdTzba8JJIp8igSNoroZGw
         LncZBzFPOPDvIyIbljRX8AK4oRV+v9u4Mly3SSq8ajio8gpSzCyX0uLitYt2ajIOvOAw
         UcZOtGGjw0FrIWfFLHxLpHhW19st30MsT75obqEkGZQy7TtpYwK6py+id8MHHCmCPARP
         AxRiuKYVrH3o4ZuPp05z30GSE3mOddkvOEUSh+MXgVV1WAsZEZioGJAS0YethsnPnO2T
         8PL5Ud3VCC5MTddoKwvSicxfrA0LlprouaOv5mIXWYC3m5b5LTMp3s/4TOUa/n5QhqSr
         FGFA==
X-Gm-Message-State: AOAM532AoAQjA7lF3Hu4KEnFG6qx0CYRxSD3SXTAqWyfCq7AsieetlfR
        d5RKGVoJ26MG2BXYVOCUpvOaKqZ4
X-Google-Smtp-Source: ABdhPJzAevWhR+yM++F9nfV16cuOahLbB+w0iMGep8VkZU2oGa/K3oYCGd4t9qXbxJzqXhIIkGT5hA==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr845901wmb.2.1597271430869;
        Wed, 12 Aug 2020 15:30:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm6125523wrr.71.2020.08.12.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:30:30 -0700 (PDT)
Message-Id: <pull.700.git.1597271429.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 22:30:27 +0000
Subject: [PATCH 0/2] Improve and test Fortran xfuncname regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds tests for the Fortran xfuncname regex and fixes a
shortcoming of the regex.

Philippe Blain (2):
  userdiff: add tests for Fortran xfuncname regex
  userdiff: improve Fortran xfuncname regex

 t/t4018/fortran-block-data          |  5 +++++
 t/t4018/fortran-comment             | 13 +++++++++++++
 t/t4018/fortran-comment-keyword     | 14 ++++++++++++++
 t/t4018/fortran-comment-legacy      | 13 +++++++++++++
 t/t4018/fortran-comment-legacy-star | 13 +++++++++++++
 t/t4018/fortran-external-function   |  9 +++++++++
 t/t4018/fortran-external-subroutine |  5 +++++
 t/t4018/fortran-module              |  5 +++++
 t/t4018/fortran-module-procedure    | 13 +++++++++++++
 t/t4018/fortran-program             |  5 +++++
 userdiff.c                          |  6 +++++-
 11 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/fortran-block-data
 create mode 100644 t/t4018/fortran-comment
 create mode 100644 t/t4018/fortran-comment-keyword
 create mode 100644 t/t4018/fortran-comment-legacy
 create mode 100644 t/t4018/fortran-comment-legacy-star
 create mode 100644 t/t4018/fortran-external-function
 create mode 100644 t/t4018/fortran-external-subroutine
 create mode 100644 t/t4018/fortran-module
 create mode 100644 t/t4018/fortran-module-procedure
 create mode 100644 t/t4018/fortran-program


base-commit: 4f0a8be78499454eac3985b6e7e144b8376ab0a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-700%2Fphil-blain%2Ffortran-better-userdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-700/phil-blain/fortran-better-userdiff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/700
-- 
gitgitgadget
