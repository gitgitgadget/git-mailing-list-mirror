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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A5C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ACB60560
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhHBWis (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhHBWir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:38:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906FC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 15:38:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso444632wms.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to;
        bh=53L5rDyzZYfJZfs+L27RCEdPK7pv5caDgdM3Kw2D5W0=;
        b=X4d+utT+nL+cHVfZx3NrNTm3YfxABjzXITfTxuD6a7XxcoAgdN/0okDg97vkwTc47e
         +glJHR3b9t9mFP1Be69riVUPb+U5GOQpAguIfiMAaXfE2EHkTWxg60CjaLU2R2B4zFre
         f10FaTcUtEaISvAgoDIypyuGwiioagrsYIsf+9ghzvjBczr7GXfc2JnE8NtdDW9pFVzY
         bhJEkE/Y8w7AJCVCm5njnS3XxhVyqyxwThateQmG0piwycySHl+kze0Mx/zhBz7+//MS
         dFn4z4JxFtcCSRBTjiAELc83ORFlD6AtUYYx3lKns9dAUIZPzc1XxE2XVVVc2/eK9dSY
         0+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to;
        bh=53L5rDyzZYfJZfs+L27RCEdPK7pv5caDgdM3Kw2D5W0=;
        b=jsYQpJsaG94usz7QlD9DB1M+CUf+f/GRW14GOLPx+fDa710wUVcRk2vdquVQmKsiLR
         AuX+/R52Br1EvlyEX3DKC1y4H4OAAty9yYbHkr26I/sopp2ZMsfFyewHhRqbyPpiGiv5
         vOV3yvCUuNuvohYXBsVzamMAaEGR0POQuSrxDyxxYtFhbcBIz3p0BhLs6Bj0daA2vqyK
         D6UG3PaHqp2NiCtRkpmmkgXhlVm47Mn6TVVj5Wo6nImrXh8DU8Dr6xivzvVFKn6VEGUA
         6ne9IFtq0Cxi5Oh+r3yhIFw7ZFsMXYQt26fINQPSmISr0Kj/TjL94mrozHbv7ZbIjvfA
         YwaA==
X-Gm-Message-State: AOAM531D9M54fiz4b9ei1XBzClXjKCZ5BNIy+RBVYHcuPWGxsInK63GK
        yaVlzfXeiw9bsu04ysB98N1yKyuCTUY=
X-Google-Smtp-Source: ABdhPJxQ8jZLE8jNdrHnvwy+BNY5sN7/I8NFenOkVAGPLVh6/IvHOQrdrmbv17yHQQ2wtFed+cIPcQ==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr18887889wmh.188.1627943915218;
        Mon, 02 Aug 2021 15:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm11328812wrt.78.2021.08.02.15.38.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:38:34 -0700 (PDT)
Message-Id: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 22:38:31 +0000
Subject: [PATCH v2 0/3] clone: update submodule.recurse in config when using --recurse-submodule
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

Mahi Kolla (3):
  clone: update submodule.recurse in config when using
    --recurse-submodule
  clone: update submodule.recurse in config when using
    --recurse-submodule
  clone test: update whitespace according to style guide

 builtin/clone.c          | 1 +
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 8 insertions(+)


base-commit: 940fe202adcbf9fa1825c648d97cbe1b90d26aec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1006

Range-diff vs v1:

 1:  fea3d6d72b6 = 1:  fea3d6d72b6 clone: update submodule.recurse in config when using --recurse-submodule
 2:  dd13a65ef0f = 2:  dd13a65ef0f clone: update submodule.recurse in config when using --recurse-submodule
 -:  ----------- > 3:  020eaa2c819 clone test: update whitespace according to style guide

-- 
gitgitgadget
