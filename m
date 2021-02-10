Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA6C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B5E64DE1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhBJSJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhBJSCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 13:02:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D0C061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:01:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so763246wmq.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=txO9evuzA8h3xuLX70NgCW+XvptNDhhvpp0yBiRL84M=;
        b=InbsVGsD34d01kaQdInpK4lYpMpEYQHx9LybfZyCOcIw3OTQ8FJqkOgi90kYRAuSfT
         DL3tDmYpOif5fsVETSnWryeLNN5UPGSkzqDQKzCf+0qOPSz63A5Q8hLvhhsGAXQllHgi
         2S8KbBy7s6wmEJ6O6lHQpyoj9xVPJgMK7UXQ2xQEZbp937Mj8cX2MZ7G4oVZU2vPn/C4
         ZWBjUkifc1lHpKShj9GDYEQ8Gp72E3/xQwbojOa3LnirgZkvyRFeVwZWf/HwRX9Sw/dk
         o1vBNoCd/9Ya6NKpM0hO1DfbIFiZ5JS4Nf1djHzlKWAsz4MoX9vHNkZ7Sg9VH84xb+b3
         pRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=txO9evuzA8h3xuLX70NgCW+XvptNDhhvpp0yBiRL84M=;
        b=lWsLsnbzaEtO73ilCf3z3R/nJosgzu+ZqQ53Ao3QV4fVqRS7ll3q1TKd+hqdOeTG4V
         4uv+U1VZgki7lIY4g1rKLLdrGxvxG3vlDCeTaFQKwE7wuOQJ50rU92P8SwcAKJP2HgTo
         76ZHUPW0qd6PJiKqBJMdLQwBOHuPuUz1A2zl2eEeBd4IMNlDGBto8PX6ZQ43fhJfsv0d
         r0XxpKpZqspGfL61zuO/7p84bot5F+s+8WbqUdXJO0I7fN9J8dzmL3FyLvn9qMbt9VKi
         78gNug5sFf+jIiyVohEbePBXJq1BJUF2XH1EhCm32g9FoorA7q20zecVuAgaMT8TA3oZ
         Txvw==
X-Gm-Message-State: AOAM531gIIOIWiLEc2ESMElV6MW7hnvU2zJYA31/2bD/nQX+y9b8UiLd
        xf6MK+Y/WvCKEKgLyoqRMel8rSnYLhk=
X-Google-Smtp-Source: ABdhPJwKCmfncX48jwzK/UOV2t3Q7DHvROsq2ftxfiZzAN3uLt+xBRN6VHBvYkL6Jj+MgSabVN+0NA==
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr109581wmf.64.1612980093344;
        Wed, 10 Feb 2021 10:01:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm3249170wmc.42.2021.02.10.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:01:31 -0800 (PST)
Message-Id: <pull.874.git.1612980090.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 18:01:28 +0000
Subject: [PATCH 0/2] Fix fsck --name-objects bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described in https://github.com/gitgitgadget/git/pull/873, I managed to
corrupt my Git checkout in a rather thorough manner yesterday, and it took
me a long time to undo the damage. One of my tools for that should have been
git fsck --name-objects, but that command produced bogus output: It said
that a commit with the name ~2 had a missing tree, but ~2 is not even a
legal rev name.

Turns out that this is an ancient bug, and the fact that nobody complained
about it suggests to me that the --name-objects probably has exactly one
user, and he uses it only every four years, when he manages to hose his Git
checkout.

Johannes Schindelin (2):
  t1450: robustify `remove_object()`
  fsck --name-objects: be more careful parsing generation numbers

 fsck.c          |  5 +++++
 t/t1450-fsck.sh | 26 ++++++++++++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)


base-commit: 7397ca33730626f682845f8691b39c305535611e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-874%2Fdscho%2Ffix-fsck-name-objects-generation-parsing-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-874/dscho/fix-fsck-name-objects-generation-parsing-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/874
-- 
gitgitgadget
