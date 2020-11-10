Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F170BC4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9354620809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeUpa4wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgKJXmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgKJXmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:22 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054BC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:22 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so2999557wmg.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nyv7U3aaSI6+eTRM61DEEAYv9P+dk96grAwDRPifWDA=;
        b=CeUpa4wdIoN8/u1uy98rCAi46uik7q+ypiWCzB2WtPVNrLMFk6l2YDcg44qMDhgtiz
         7eUzJMtf2JvqBkHtzKH0yAOA5pSGGJW+2j0zumbEMjIPiJfYZE5f5ySU2CM7IycaU7HF
         mmJ8gwpc0+anKzj/HbC0fV/psipzuIloczcaT7nRaCrLsM3ugPaAlxa0K3qePVx3TC6p
         oIMaGTiMCtKwRa64DzNsoEjEJrRf3XY2nRIjZe7+NZKWXZQzmH4/s2av/xEYfB+sRmxV
         Alk2WjQT51MMYR6PiJWEMBb7eTDYSmN5iG0nodMvocqu/WDJUqGPz7pmjV9lrSF7vV5I
         IK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nyv7U3aaSI6+eTRM61DEEAYv9P+dk96grAwDRPifWDA=;
        b=riSvTpHGnOZNhhIkLjyKVhX/njf0xTdDj+R8mDVb+6OjaqT17ogtG4iZbX5ixZpxk+
         1eoBw//5cOEPy2iEdp6FhnGkvxUiUFcfSWxE+1T2r2bCQDrAd5OEufsyYZdK0PJ/87Fu
         nJ32QqpefdMOKhvQNn/Pn0m7wU0TPggkjpa4QhKr3UZprCcqvp9ksN72rHaiP2CPUgaG
         KviapkaX9kkrktNJ2G7dKjFaLBQ1Y8i1Wzwet/FDG2hDXGFotvfBNIV2cLim3v79MmnD
         NS91NCREmwVN7y6kkbeP2rAVDO6A15Bc43IQZZ3G71gt5K3XYUaMfEmwfxbus5wdziuN
         nJrg==
X-Gm-Message-State: AOAM531MXpKfndd99WgARl96gPca+4B3vfbdHCe/fxac45sjWOJRs8oA
        OQfCdxl1gPpc4Q3U74Bw44dj2xYPm/0=
X-Google-Smtp-Source: ABdhPJw27QzvCAPlxMXomvAEh7t0ozuwjtUrKHbzz5qF70Ws4sQNbGvGEC4tYTYOKMCpCAIg7QMxUg==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr581740wmz.74.1605051740733;
        Tue, 10 Nov 2020 15:42:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c64sm347480wmd.41.2020.11.10.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:20 -0800 (PST)
Message-Id: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:10 +0000
Subject: [PATCH 0/9] Fix color handling in git add -i
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started out as a tiny fix for a bug reported in 
https://lore.kernel.org/git/313B8999-1E99-4695-A20D-E48840C30879@gmail.com/.
And then I only wanted to add a regression test to make sure that this does
not regress. And then I just wanted to ensure that it passes both with the
Perl version of git add -i as well as with the built-in version.

And in no time I was looking at a real patch series.

Johannes Schindelin (9):
  add -i (built-in): do show an error message for incorrect inputs
  add -i (built-in): send error messages to stderr
  add -i: use `reset_color` consistently
  add -i (built-in): prevent the `reset` "color" from being configured
  add -i (built-in): use correct names to load color.diff.* config
  add -p (built-in): do not color the progress indicator separately
  add -i (built-in): use the same indentation as the Perl version
  add -i (Perl version): include indentation in the colored header
  add -i: verify in the tests that colors can be overridden

 add-interactive.c          | 34 ++++++++++++++----------
 add-patch.c                | 14 +++++-----
 git-add--interactive.perl  |  6 ++---
 t/t3701-add-interactive.sh | 53 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 25 deletions(-)


base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-785%2Fdscho%2Ffix-add-i-colors-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-785/dscho/fix-add-i-colors-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/785
-- 
gitgitgadget
