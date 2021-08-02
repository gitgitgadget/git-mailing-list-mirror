Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D17BC4320E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ECC60F9C
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhHBRaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhHBRaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:30:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234AC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:29:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so22296325wrx.9
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to;
        bh=Je8IuD2gLatLFU2Du1Qz3P79a7Lu3jWQccbLkaW8jpI=;
        b=QRvE9NfB6c/UvUEsvVgXdrPWZ/R2qzGxnoj/eBgidLizs3Bn8AS8fD33U3k2EOrnW4
         K9bcwsqb0wIG+OJ2TCVg6cAAJYGys6mEqsK3hNaJDB2vqtsJ/f7SM0gWPVxDbcEAbUoJ
         pHiYz4+YV8KnPQ4KV19dyzKJ9Kw/Zj6tNK0qUWE/LYX15bQV3m6UhHLUZmUKx4vOunUd
         N3R761Jne04rU1HNGB/57onWQ+XMyoLi+sZgX5kcQ4oZiPpIr3LihjhwqlsyXAzGDbWr
         VxMbkWNTtF4sq6GL7ZVpbgBA6aQUZYnPGQIGdt6KWgkHZY+3f4LvN9s0zqn3SrVdf4U+
         oXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to;
        bh=Je8IuD2gLatLFU2Du1Qz3P79a7Lu3jWQccbLkaW8jpI=;
        b=S61dWD3iuSmDG3Ow69SjQ/eb1aLpLD7Boq4sNa0PkAWb5ZaRSWTEbF9lfjdlWOWRhy
         zj7958HzNkj0MHCPB/7AgtJOiirGc9Hy+6uxtGdXpyX+gImKaVv/nCFsYvTlYGeGBMQu
         4jEG4Yi3Q2NFEPmsV8MbzVmeRBZXrxywkHkSwvZLGbdo66cLNbQlAetg1cnpapSK94NB
         AO9dNWYbMOlGzBPEFkr4emTKQapPLwojLeIz2gVJ7Ha8D7LiyHjgGzv6SzNIZ8Uo+MKi
         USPN2GykADvV9FmgB6+LnpnKvIf0/Ci2VgDBKkot9zUjx8QUX/ZjWAEbG20K/tTl99w2
         kp+A==
X-Gm-Message-State: AOAM530Msthct9KBiRWBokROR9q597AfVHqwSs7mvu1Hfl872dj/IAWA
        n2TLVDrHBtNLIQ6bmLkWCvi2LmQCZPI=
X-Google-Smtp-Source: ABdhPJz1afHXFql3r93sziRhl985SDXjaNUkBWMPGyOfAEWLQX6hGBwbcEZMlIjuMNvf+4DW5EOxPw==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr18401284wro.86.1627925392009;
        Mon, 02 Aug 2021 10:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm11915413wrr.16.2021.08.02.10.29.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:29:51 -0700 (PDT)
Message-Id: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 17:29:48 +0000
Subject: [PATCH 0/2] clone: update submodule.recurse in config when using --recurse-submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git clone --recurse-submodules', developers expect various
other commands such as 'pull' and 'checkout' to also run recursively into
submodules.The submitted code updates the 'submodule.recurse' config value
to true when 'git clone' is run with the '--recurse-submodules' option.

Signed-off-by: Mahi Kolla mahikolla@google.com

Mahi Kolla (2):
  clone: update submodule.recurse in config when using
    --recurse-submodule
  clone: update submodule.recurse in config when using
    --recurse-submodule

 builtin/clone.c          | 1 +
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 8 insertions(+)


base-commit: 940fe202adcbf9fa1825c648d97cbe1b90d26aec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1006
-- 
gitgitgadget
