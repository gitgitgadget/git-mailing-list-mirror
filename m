Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF587C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0203206FA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVvDJFDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgIAUTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgIAUTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 16:19:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE880C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 13:19:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so2898384wrm.9
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yB1N65SVgJuZuyUXlOm9gzkAc6MxJAB3IatkPk/QjFQ=;
        b=JVvDJFDXySvXOLM+3SMxmviGim89kpeq3Xe8h5sxM9yZBcf0G26ypxAcWEFWsahv8V
         bKaUExFBa/qkW8U0pTWZTE1346GG2zAjUyeM+h6Jc3ca5XE7DGAbq/5l6zc4aMcYS17L
         dJ6BtdW/Qch63UjuQhuArvzMZaXlvQ3w7E5tGmvLUbE9iNAI7JoLEX50qQdlKKQm87Vo
         7gTYbECuC+e/rPpjAqnIipE/6UxoNVmKQUZMsl3BteSHwGUO7DDGr2y7bsYgmy1Jsaa8
         y4e2YXe5jHXNcbT1N41KTxbBBV38+Ciq7JoqTztt+b+M8zJfIVGMvxW7Rq4V/A8vvXrs
         thyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yB1N65SVgJuZuyUXlOm9gzkAc6MxJAB3IatkPk/QjFQ=;
        b=HRmdlk8mvi2O95L6H1D6h1KleadUYXgdtPJ62PhKiwgmymm0/4GYU0JuNMK9lf3ZC2
         hL3O8iz6kTyk5Upmv2I9jFEWnlat3Qqej6k5zam96syHUUOgo03unp9L4tBxTj2iKQxr
         e4QdmcgYh65xBWoDtdbqxo7W/MiiXtd+DYbbScB6SmsbQwv8gGHNnxkh1FbZZy29kCab
         /rjt3liDIplGFAyij/ud7+JqRJBszoOthzlkDfWsgUsJ47+Rrrr4TsovkoO/OTTDvpPr
         Ehba5bEOk94jbStLE0Ma9uoHlGnfFql7g6xRp+M4O5mPzIlG8JSdUlSjCxyn5Olj5ABj
         CoCw==
X-Gm-Message-State: AOAM530GZhnK6U02UKjb0ck/+uhBkpEDqY3rkzdeVpdowN7VKNrc1lL7
        tVqEhyAQZqeYYpWxTJQmBrlGX6OOjU8=
X-Google-Smtp-Source: ABdhPJz7Vfh0MF+IbTNjMkKhrv3Z4Rt7D9BM553cfow6B1MsP4d1MYHxWSyg3Gy7vKZPphB4TNBKuw==
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr3516495wrp.79.1598991569343;
        Tue, 01 Sep 2020 13:19:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm3698101wrx.91.2020.09.01.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:19:28 -0700 (PDT)
Message-Id: <pull.719.git.1598991568.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Sep 2020 20:19:25 +0000
Subject: [PATCH 0/2] ci: avoid ugly "failure" annotation in the GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever the GitHub workflow runs in a fork that does not contain the
special-purpose ci-config branch, a big fat failure annotation greets the
casual reader. See e.g. 
https://github.com/gitgitgadget/git/actions/runs/233438295

This is caused by the (non-fatal) failure to clone said branch. Let's avoid
that. It's distracting.

Johannes Schindelin (2):
  ci: fix indentation of the `ci-config` job
  ci: avoid ugly "failure" in the `ci-config` job

 .github/workflows/main.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: e19713638985533ce461db072b49112da5bd2042
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-719%2Fdscho%2Favoid-error-in-ci-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-719/dscho/avoid-error-in-ci-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/719
-- 
gitgitgadget
