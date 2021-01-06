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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5C8C4332B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593292311B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhAFOos (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFOor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 09:44:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DDC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 06:44:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a12so2637209wrv.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zjjEep0YF7+ONLKZ4DN3a14yw7klISCoy7hp2Fc6gB4=;
        b=VjpXcyVAYZq1xUEfaeFmpgKGsVBJLxmKfxKXoJDInrBOkZYWCMkae/WuJo7NdAQFzc
         dUU+BoBHrpxI/SEp96HhyGi+gJlJqxcNV4n8kelVTbjHRsIWyBewIQ6Y4WKCqnI8IICg
         2KLg8y56QNvdRqcPOcHwuukpdsQxFqlKv+Ta1QPIYxNBhfbk7iSAXaNPWkDfntqNYTdl
         OW6GhPFd3UU32lOpBL1n0ep1gzCfptx7UNGmUcIj56jHsDvR9YSQ79wL8YdEOtSxVuFD
         IyfmMBt6in35H0Qv6mKUnT172T8PXn0NDNHDSUH/ExxQQqXMfMgWtiPjW6fERLVkZuSt
         E8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zjjEep0YF7+ONLKZ4DN3a14yw7klISCoy7hp2Fc6gB4=;
        b=mLxDfSD+xT2ttKSliECuu+jiCANb7sN9yMrvfGiJmyWlhKPnPQ27CJKk6dO0WieEBT
         xZKk3PIiFo46yMUSJF/h+SxV/lSzaaq6Gm/kUq3zYIVPjSiFB5Kc7OvfIQ/THgi6SF+l
         Io+rqdB4Q+gAcsS0Bru9o0zm8RKxhCRI7Q46vyX2dQAkuor9HCEL/5IfVhUZ19HjPNWG
         MiWKUKYzv7CE/dB3lu+dC640awUdPyVN1p/B54yuCTvxRPYZvRZclFfstzZnf8V9Y0Hy
         MpsjMlU/Hmdn8OZ7/t06xMcAg7Qa+VUuiqUn9eJWawUGaMbWa4qIf5MMCyKvObR3Jmp7
         2rew==
X-Gm-Message-State: AOAM5337iTiQXxaQdzZSV7r2tltHirfXDo0DHaar+kj0asVA1rxyt2zA
        AuLPLdYhF/ySBQprzOMpPGBWUi6QcI4=
X-Google-Smtp-Source: ABdhPJw0MJYo0TmhzGNivKT7ST11RyXL2oyao5dHzD1nAjzjWyfpY1F92cLVhO+qt8P9pl721H8vGw==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr4523988wro.59.1609944245628;
        Wed, 06 Jan 2021 06:44:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm3386762wmf.19.2021.01.06.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 06:44:05 -0800 (PST)
Message-Id: <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
In-Reply-To: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
References: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 14:44:01 +0000
Subject: [PATCH v3 0/2] builtin/*: update usage format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the "Error Messages" section of Documentation/CodingGuidelines,
we should not end in a full stop or start with a capital letter. Fix old
error and usage messages to match this expectation.

Signed-off-by: adl 1607364851@qq.com

Junio C Hamano (1):
  parse-options: format argh like error messages

ZheNing Hu (1):
  builtin/*: update usage format

 builtin/am.c                |  4 ++--
 builtin/blame.c             | 48 ++++++++++++++++++-------------------
 builtin/commit-graph.c      |  6 ++---
 builtin/fast-export.c       | 22 ++++++++---------
 builtin/log.c               |  8 +++----
 builtin/shortlog.c          | 10 ++++----
 builtin/submodule--helper.c | 24 +++++++++----------
 parse-options.h             |  6 ++---
 8 files changed, 64 insertions(+), 64 deletions(-)


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-822%2Fadlternative%2Fdev-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-822/adlternative/dev-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/822

Range-diff vs v2:

 2:  c5f01b0eab1 ! 1:  9d508df032b parse-options: format argh like error messages
     @@ Commit message
      
          Noticed-by: ZheNing Hu <adlternative@gmail.com>
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## parse-options.h ##
      @@ parse-options.h: typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 1:  52f7c8457dd ! 2:  d3eb6dcff14 builtin/*: update usage format
     @@ Metadata
       ## Commit message ##
          builtin/*: update usage format
      
     -    According to the "Error Messages" section of
     -    Documentation/CodingGuidelines, we should not end in a full
     -    stop or start with a capital letter. Fix old error and usage
     +    According to the guidelines in parse-options.h,
     +    we should not end in a full stop or start with
     +    a capital letter. Fix old error and usage
          messages to match this expectation.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>

-- 
gitgitgadget
