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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B05C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B8A64F26
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhCQP6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCQP6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 11:58:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5287C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:58:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x21so2901864eds.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qAHTFmddxwDCoAjcuoP3IGaFGaz+dh5aK4WbzK3BoPc=;
        b=EP5AB+fsA0qlb+PsbZZ7BFQVMKHj5u5AHdYDwV2tPF/f/GRi1fNKydjUNZxakjvD3v
         WB+fKPxw0agGYALjEVbBsPrr7pxQT+TZL8cuboSNDlvK1z9zGQwaeXAPe3iVaJHn1mS3
         eMbuC9sAsZ/EPPIASZQcmiIhMdw7e+WmxQj+33OQtDdGdFcGZ3MMztOT/fYiv1jazVIm
         fnUrb/uqHfL9Zt7vQOmQAe2cbJEaN9+hOh0C/zJBxr90X4ic8HbI1fVZox+sQ/MHwcuv
         OrcygfnmMaGgnrwftCc/7SieUKeNJ7xXCC1Kwva+rpuYyIQ8gI4Yt0mI/IsQxlB6PF59
         Z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAHTFmddxwDCoAjcuoP3IGaFGaz+dh5aK4WbzK3BoPc=;
        b=NLVmqrv1cn7/Nk9cdXkc0byABIgoFkOaxl3Alw6ASy776rxlzecvVDQ6mARA3NiPly
         rg7rV+JyjwIgCfzttPqD0N7K9eJuC/O3/x4VWReskdwml2slCkyYWt3lkx8xAUCDCWxS
         Fcs61KxxeQ//mX3gjohVd6pLBaJOQAevPvzvXsB7a6PqeNi+OFF2hKjFLk7WwxRYZdc+
         LCaKsbQmmB9WpGVWKVcqkbVueo+E3F1NyjjOiEuUTkHh9jPoSybKQXpixvnUWyi6SJbW
         HbDZeWA0V3zHVGd4v+P20yl8DB8PYsgZcZDn8oh7KeCH423TZaF7V5JOJJypnA2I2Q0C
         pdFw==
X-Gm-Message-State: AOAM530gYcIV5xq0aTeHUOA8tr1nmeramfMoWTgi00W1oVLwaUC2Xwlf
        3SqF1c9IFVfBFrJUYk2k/WbKMd6nc8Q=
X-Google-Smtp-Source: ABdhPJxzhE+nyD+Mh2e95wiNw4kBU0QRelZAXcD24o9WgjlSED0RvaQKRJTaeCVbQtN1NggsPxy4hg==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr4998377wrq.374.1615995051175;
        Wed, 17 Mar 2021 08:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm25388087wrt.8.2021.03.17.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:30:50 -0700 (PDT)
Message-Id: <pull.891.git.1615995049.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 15:30:47 +0000
Subject: [PATCH 0/2] Fix memory corruption with FSMonitor-enabled unpack_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While dog-fooding Jeff Hostetler's FSMonitor patches, I ran into a really
obscure segmentation fault during one of my epic Git for Windows rebases.
Turns out that this bug is quite old.

Johannes Schindelin (2):
  fsmonitor: fix memory corruption in some corner cases
  fsmonitor: do not forget to release the token in `discard_index()`

 read-cache.c   | 1 +
 unpack-trees.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: dfaed028620c2dca08d24583c7fc8b0aef9b6d0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-891%2Fdscho%2Ffix-fsmonitor-crash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-891/dscho/fix-fsmonitor-crash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/891
-- 
gitgitgadget
