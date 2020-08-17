Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8BC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BDE23359
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1uQxyfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgHQPkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbgHQPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A4C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:39:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a14so15473741wra.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kqz86Bc970sWLN8JwCwlkNQshq/3jmSWmCyTtwBJ8qY=;
        b=i1uQxyfMAiynhQ49Roqc7j/x5zahKa7vrTVEUFKd74ZISq0/Cb6mOyzV8Y4qAV2E1N
         eRZNiXbpwSkicWPqExEgz6tiIiQRyCCjVWbkpvy6pwYb/H2Q84tCEfbKEgYcjsGePPR2
         bLByTZ+XPQr7OAf5jqclQiZ2r+1Cb87jmnVFFbQSb2xOmYUpMEQrHUa/h2lzBurlCM+j
         NL8W03nBp9J6ABrVh9d7GNJZFPtUuwQHpzV0eKMgFSsKUJB77qEfznh8R9vHtyIUV86Q
         IhzY6LSkJ9a1d66Mv+vn7IKvo2fpWEwiurBdVMeG3cZz0kd0xHmddTcfhDsFNAL6P/1F
         550w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kqz86Bc970sWLN8JwCwlkNQshq/3jmSWmCyTtwBJ8qY=;
        b=cB1N/6iDASbdd/zaQ/0KpBOepE7c9+K/3ocyv4xk9CgeBUbYWGSUMX7pCfx4BhyLTS
         FeAX3JGoudOja8ACn5x8FMKnER+nJszajPNDWQccymy933fTvOLMDcJ+4vGEXsmzi/+x
         e9+TUYd80u6BRCUk8snMhDn1jtVrr9GsNtL2OQXXQq/EZVsgjWu2HFBSChLeTzY+MdM+
         4+zJQFDXXvczUPEVRsdAfiv8Dezwg7fArVThY3HdrW5JmUfDEaaN6Gbzh1zAJqHS7mHF
         WGAJnSMTNGYZDqi767rvuUfFrGYMmYKO7ltot7U/ngXSRPXGZO3dtdCekXTktfV8UQqA
         7C3A==
X-Gm-Message-State: AOAM532vfx4Z9q7gwDubJcnXFiubHY9avcaHegkNpyHA7gehkG6Y+6ur
        rtj8Kk/a/kt2WZye4xCrCEgrviPH3ik=
X-Google-Smtp-Source: ABdhPJxt8GFbvfqWqBsD5IUfdvEGTHlFfC9QYH5ZTbFfwpKOQLwOL1XiRr3sijKzLlK9IGdHtoZqrw==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr17390803wrn.56.1597678798197;
        Mon, 17 Aug 2020 08:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm31704128wma.45.2020.08.17.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:39:57 -0700 (PDT)
Message-Id: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 15:39:52 +0000
Subject: [PATCH 0/4] Handle FETCH_HEAD generically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the FETCH_HEAD handling into refs.c as discussed in 
https://public-inbox.org/git/xmqq5z9pav01.fsf@gitster.c.googlers.com/

Han-Wen Nienhuys (4):
  Split off reading loose ref data in separate function
  refs: fix comment about submodule ref_stores
  refs: move gitdir into base ref_store
  refs: read FETCH_HEAD generically

 refs.c                | 27 +++++++++++++++++++++++-
 refs/files-backend.c  | 49 ++++++++++++++++++++++---------------------
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  | 11 +++++++++-
 4 files changed, 62 insertions(+), 26 deletions(-)


base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-705%2Fhanwen%2Ffetch-head-generically-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-705/hanwen/fetch-head-generically-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/705
-- 
gitgitgadget
