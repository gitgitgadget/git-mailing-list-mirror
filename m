Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5FC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiCaJWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiCaJWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F77114351
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m18so17959212plx.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnD47fiW5I4I+yViIQEcqcT47YkXK6CfTwkxvYPlq9Q=;
        b=aYspPZ0yf8AFwwSBaYMKxlsMWMkkmjEAikN04hPsqEQFDmnoUe+MFWJpjflxA44bvt
         RMKwIioJYONE/26zOFqYejY9rujTvOEKAiI8iZHbzXYtmpOMv6xn+nIMUIfhWURoYlJS
         btHDplEmoycO+PFkQyg0WrYIHyqH7KI4/dCT34XaxLSyukUMyKmUzF3jkRcdpbkFFl9d
         U73A/80NbatAmlp4awYsGf3omW8M/JRaahzFLVN3tUxUVP/BjmKJbi0N1q/ijbdPeASr
         /rVU0CYDAuCvtvNavdzyQ3KIVEqYd3+b6TNEcSL9kZt/wrBMYt5BqxBrtGhpt6hC8BBJ
         308A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnD47fiW5I4I+yViIQEcqcT47YkXK6CfTwkxvYPlq9Q=;
        b=uJFnxvz7yZDaX5cIApX6aWLSaW5Hez39nZ1rB/DY97bNq8cdN/bbpIIgSqjbCDzsDg
         o+j3iYqAF4Zi1/pAj5W0bY9JJWsgyWRq1hfO+CHS2wNB2vTNJHGJKTnC5GuhC9ZCtIPP
         dDTLKngo6Py39Z+nte5stShq9qcVps50jQ8jKVM/LJRnv3s1Wz75Ylzjy5dCtqPQnjcP
         mjpMi8WExFFrtLwT18h5f3yg6+HI4s1QeCfD9hqlGDROy1+0GALIAYpV8UaDfLgEFnxt
         j/I277THzLVGW8T6AtgfgZQWxo7PIQR+z/E+tsoOmoZ7k0egAFS33NoxKRwUNbjknsAg
         gpjw==
X-Gm-Message-State: AOAM5302gcZ+JdGt34Poht9bLnuRgez6Es1C0yjty+kdeBpwj/o3wLyq
        NMhxpqngAXSzEqkZ5w1/f7S7iuc/Q5M=
X-Google-Smtp-Source: ABdhPJycvB7hpbdMw2I7VmcQMHiXc5JD4boVMfjeiB5OxNpP5Q+dEM04AARNQdSsMEZd7eLfZfHGJw==
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id w3-20020a170902904300b0014faa088497mr4386813plz.109.1648718417186;
        Thu, 31 Mar 2022 02:20:17 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.75])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm27225931pfk.88.2022.03.31.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:20:16 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v1 0/4] mv: fix out-of-cone file/directory move logic
Date:   Thu, 31 Mar 2022 17:17:51 +0800
Message-Id: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating 'mv' with sparse-index, I still find some possibly buggy
UX when 'mv' is interacting with 'sparse-checkout'. 

So I kept sparse-index off in order to sort things out without a sparse index.
We can proceed to integrate with sparse-index once these changes are solid.

Note that this patch is tentative, and still have known glitches, but it 
illustrates a general approach that I intended to harmonize 'mv' 
with 'sparse-checkout'.

Shaoxuan Yuan (4):
  mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
  mv: add check_dir_in_index() and solve general dir check issue
  mv: add advise_to_reapply hint for moving file into cone
  t7002: add tests for moving out-of-cone file/directory

 builtin/mv.c                  | 76 ++++++++++++++++++++++++++++++++---
 t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 6 deletions(-)


base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
2.35.1

