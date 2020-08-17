Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CFC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D96206C0
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdzKPFVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHQJJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgHQJH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:07:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19345C06138A
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so14157287wrh.10
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:date:subject:mime-version:content-transfer-encoding
         :fcc:to;
        bh=6Z0IG1lReTHl1UKOX+1ZECyD6vgfeYWNTOdGcTKYSGI=;
        b=kdzKPFVsuijxXEGRPNO4wjNl/o/ny6e1MrWg9O/eJa3ZnAdSN5tG/M6d8V0g0ZZeVv
         9f2Np+PpczFuzMjJoZtc+z7su3I12Zbyiag95LhsZOgDNxrIZCcFdpGhnk1uOnUA6GVT
         0ksoMXV+NMubBjSyccYIx/nbtu+gZmm/rQsBfFB/GdV6Joc46Oz2C20O4pz7yg3ZieFM
         U/mmvlU5XuLRkoqUtpZkXdWHnEUd9S/xKYp/+ttOEnTfsUStihupuNZkBw4fXOigutkG
         i1krzAjNQOYTIko9e+UtHjuVVRPNJFs/Pu1WJ34iVFoBATJYhzHZ9TxAjx2E1BWVcXdj
         hXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:date:subject:mime-version
         :content-transfer-encoding:fcc:to;
        bh=6Z0IG1lReTHl1UKOX+1ZECyD6vgfeYWNTOdGcTKYSGI=;
        b=hLQmaVK8H+A7x9uNcwWltYzCpihohKA9Tg5kL0SxEip75BQLXOJqzL36gYOFcQXqyV
         CpIf1vw76e3bPa3E1y3DCINwxtKDEus+D+sf2x42qQbjXZpNFcWLDRC2XlsX1V0ywZrM
         OC+YAXwubBO8Uw0c4MTMW5fwdZ/mQ8VJx5XWN/bJqzapV2PBICJZd8RWOzCI0uPqLhD8
         3q1dN7CizNI00UM7MEm978CDZYK/KL0ieaQ4kFKqwHVnkTSAmTUvZKSsZ8gX16FQaiUU
         MHmG+H++w1+RWunLw/IgwBKi8g0fhnHmcTesvBlH8dy2STLdq4EzJPn9DWnE0Zdk8CAr
         rBPQ==
X-Gm-Message-State: AOAM532wNkktSk5s73SItJKp1jbc00OacMcUJiCDszaph8Awv1nDPa5q
        VfaT4jEiK6F9k4XMOA/rLxCQC/FjrcI=
X-Google-Smtp-Source: ABdhPJwQtNvZhkPWZboiMbfVmKUiLTbOA1E5hbCxTXySBCpLYBW1UcHf6Fllk0vEBQC9gj/WAJD9ow==
X-Received: by 2002:adf:f847:: with SMTP id d7mr13590916wrq.328.1597655274690;
        Mon, 17 Aug 2020 02:07:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm30596089wrq.9.2020.08.17.02.07.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:07:54 -0700 (PDT)
From:   Johannes Schindelin <gitgitgadget@gmail.com>
X-Google-Original-From: Johannes Schindelin <johannes.schindelin@gmx.de>
Message-Id: <pull.411.git.1597655273.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 09:07:50 +0000
Subject: [PATCH 0/3] Optionally skip linking/copying the built-ins
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dashed form of the built-ins is so passé.

Incidentally, this also handles the .pdb issue in MSVC's install Makefile
target that Peff pointed out in the context of the "slimming down" patch
series
[https://lore.kernel.org/git/20200813145719.GA891370@coredump.intra.peff.net/]
.

This addresses https://github.com/gitgitgadget/git/issues/406

Johannes Schindelin (3):
  msvc: copy the correct `.pdb` files in the Makefile target `install`
  Optionally skip linking/copying the built-ins
  ci: stop linking built-ins to the dashed versions

 Makefile                  | 69 +++++++++++++++++++++------------------
 ci/run-build-and-tests.sh |  2 +-
 2 files changed, 39 insertions(+), 32 deletions(-)


base-commit: b6a658bd00c9c29e07f833cabfc0ef12224e277a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-411%2Fdscho%2Foptionally-skip-dashed-built-ins-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-411/dscho/optionally-skip-dashed-built-ins-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/411
-- 
gitgitgadget
