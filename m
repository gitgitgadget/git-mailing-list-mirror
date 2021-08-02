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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259BC432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB70A60EE6
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhHBXXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhHBXXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 19:23:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E3C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 16:23:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h13so9788033wrp.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to;
        bh=xaOMIHl2COnigiAnF0TXT4UczBOnGVQ9RFiolBXo6vk=;
        b=ThQaa1NGTWfo66miCd/uKScRPA+o4tRvIrdjVTjeEXOrDqfystAYzASEL+eMLsOU7J
         qRJgylB23JRrAaKRtgenMNs99fAnrF/TKM+sBB6YdJ/xUyI9JNDOiswXgOFggh5K/UMr
         iJvFtNVH4AjplCtx+jrLhkxhXlqi+HwSZihaVq4/uhTCdiqZDdAFEAzyWL6yPWjAVU/m
         acFAWRVSSerqK9pVX4PblvauVEs1dqntDS/QLHZkNsbhkorF0CykHZ6b1E9DyhCGjxB/
         B3BnwY+rr7YdLR0R84wDnbRNeu56uk5OqY5iADN4LzJ+fW1AC/Ftfp5+r9Y24Vb8/2nX
         71wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to;
        bh=xaOMIHl2COnigiAnF0TXT4UczBOnGVQ9RFiolBXo6vk=;
        b=lB8U6Hodg6Lma5M+ifySZvyZJYZbgJSXDPxpQu0niRf5e00NqYrbWmCVRgc+0WY3zL
         qSJDVBznp2S78rIGE/GY6hv+esyUajhUg4rDMo4niox7HzXpp5gTNlvRnFhpTmvqDhuI
         Z2CWyynB0TtQMOd96wNtTa9MFQo+xa9PQKp1rpwi68BNC7q2wjTahiov4ukp4vr5EMJ0
         +n9kzGIgowgKQFeNSlVBUVleRqr+pBGiNBzvmZ4SbRiXJw5QRRquwx5XsUjieHeiBBCY
         y7gdgufwef66vXKXGaFoWrRgopPxWGuBnCE17ALIZUe5gliSUGiY8tzPMwejE0CmnGD5
         Vhlg==
X-Gm-Message-State: AOAM531+SOypga2JsskMEPr52GET67Tmq0RoJfqGFURtG0IUkzepBnfF
        NDI/lH1k+wfPvw9F/9ZdIS/tmPTzuAs=
X-Google-Smtp-Source: ABdhPJyY4coaNqDfjC03hrjCxWb3KumKGK1ITxscMsfGQSaMlextPtbQGOAxqwcnYezshVsn84uNCQ==
X-Received: by 2002:adf:c3c5:: with SMTP id d5mr20210724wrg.76.1627946592517;
        Mon, 02 Aug 2021 16:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12sm745340wme.17.2021.08.02.16.23.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:23:11 -0700 (PDT)
Message-Id: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 23:23:06 +0000
Subject: [PATCH v3 0/4] clone: update submodule.recurse in config when using --recurse-submodule
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

Mahi Kolla (4):
  clone: update submodule.recurse in config when using
    --recurse-submodule
  clone: update submodule.recurse in config when using
    --recurse-submodule
  clone test: update whitespace according to style guide
  clone: update whitespace according to style guide

 builtin/clone.c          | 1 +
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 8 insertions(+)


base-commit: 940fe202adcbf9fa1825c648d97cbe1b90d26aec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1006

Range-diff vs v2:

 1:  fea3d6d72b6 = 1:  fea3d6d72b6 clone: update submodule.recurse in config when using --recurse-submodule
 2:  dd13a65ef0f = 2:  dd13a65ef0f clone: update submodule.recurse in config when using --recurse-submodule
 3:  020eaa2c819 = 3:  020eaa2c819 clone test: update whitespace according to style guide
 -:  ----------- > 4:  f3ddb344b49 clone: update whitespace according to style guide

-- 
gitgitgadget
