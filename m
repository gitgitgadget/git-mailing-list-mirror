Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE7C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C50A61361
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFVOXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVOXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 10:23:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB304C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so2408876wma.0
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iduYz/KmrKCFLBZNxGC3nT8GpQlK6xnOMQAKd2XblfA=;
        b=gYxDr+dY4uyCju+RJVmsuctq+/eqmmONZt06pO4WrqESVoM5am7SaPNqe3tJBxUNG7
         /jTRUvUUg1wyxy5OIoecobqT5C1Ep+2yS3Pq+jJtHQ7k0gupn1p3NxSfbD59MssxOIOJ
         r4TTV1xKOQmTyS3tVSc3Rxreuh8WaO5gAMza6yg59D7B/tQj+N8D4AouElySy6q8zFAg
         GN9tIDlkZOUCBy/5WByamjfq7idXH9ARlMQWkwVaIHChlM8oRVjR/BDku7Vc+ILNYvns
         zyTyeDw2x/U1SEpJRMWDY2cmEalhtb3f575xy9PEM0cBo9y6Lp+F4zHNNrHc1kPB16s3
         wh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iduYz/KmrKCFLBZNxGC3nT8GpQlK6xnOMQAKd2XblfA=;
        b=WfdQZlkczVEUinpsDOltQBLMfZ99zug0GekMFISe+Z7/dsAVL2QQd5p5QdfkN8WVAm
         CTIEz7qqrJqLl3B2kmyf5tdGOIlPjClmcy09wtYutrtwFODDY0MhHDs10eripXL2boId
         WCe5PIa/njIml+DZT3enI+MF66Ozy1z9npLX03HdVxQxXTwXXmCQo5Jp+KpiFvJJCOHU
         YxoFe5hp49tioljR4vf4QXG/qqodK9XxbSMXlNjuDPr1eA05WGnywETTf12r8ag7zGoo
         x4I5tYeSDYODT72rA/mHJAT3Z3ZRQzc9ifc4+yUmo4TgiVrBEc5XJ/rB2jvFElke7OBq
         1aaw==
X-Gm-Message-State: AOAM533n84lsUIO1HHgafloq54quOD6xEGX2e30ksOVx1b0DGcfO2VCs
        sUofKucOIYyv5szzqgki5ugw4kh7PYDNrg==
X-Google-Smtp-Source: ABdhPJyoaz8iwJd2g7DFEPwQHosYQDwKu8BOJoavyBJPtUs//mPiGzTvsBYVwZ0uwpQ0PWyt5V7nRg==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4877870wmb.142.1624371689174;
        Tue, 22 Jun 2021 07:21:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm22617395wre.84.2021.06.22.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:21:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Makefile: "make tags" fixes & cleanup
Date:   Tue, 22 Jun 2021 16:21:24 +0200
Message-Id: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small series to fix the various "tags" targets, i.e. "make tags TAGS
cscope". We'll now properly detect their dependencies, so we don't
needlessly run them every time. I have this as part of my standard
"make git" command, so doing nothing when we have nothing to do is
preferrable, especially when my editor will eagerly reload the TAGS
file every time it changes.

As noted in 3/3 this is better on top of my just-submitted
.DELETE_ON_ERROR change[1], but will also work independently of that
patch/series.

1. https://lore.kernel.org/git/patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  Makefile: move ".PHONY: cscope" near its target
  Makefile: fix "cscope" target to refer to cscope.out
  Makefile: don't use "FORCE" for tags targets

 .gitignore |  2 +-
 Makefile   | 31 +++++++++++++++++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.32.0.599.g3967b4fa4ac

