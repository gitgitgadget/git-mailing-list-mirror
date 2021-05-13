Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85201C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C52E61421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhEMVnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEMVnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:43:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA77C06174A
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so28181115wrt.12
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcunEnC+6NBwGjnJw5Qo1tLcK2EpDq3KHJ1NTWRQ7e0=;
        b=Dh8+HXutQ3HQm+FEjTGEpvCHfBGEfr/DMBR1m+1UTt4swO4Nw1TWD4Njj0oTiOLGsh
         qaWRGAd4Zn9/b5s+LRBg9db55LZFGLU4iaub+emUEcx9IyGzbxI12uItFsCbK9MAN+Yc
         JJwgrz+DAiqGqlADFA0fFNLL1XJT1aSoSAiwM+wkwVkMs1GfHFDbOwYB8r6GhUjBNPnu
         cCA6DDSljQl/Z4A7LA3xomCcBHx3eXvNKUqFC6f77P4aeFmvA5Eb6XfI5grqEdrVqHZy
         f3erOABxfYDweF8dqIsqeE3vgTx+5DVFzScn05cd9E4ryxmSKv2bjEByt6jGLJkPylzu
         vUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcunEnC+6NBwGjnJw5Qo1tLcK2EpDq3KHJ1NTWRQ7e0=;
        b=egT7/8P6j8a4xB7B6WQIMOgoi7Jlg1zt3f2iuWNlBguAwvLZSGLHXoyvutrVZf5ixy
         cyMh64vlqDR0L7YX5cCopV/KIdGweCaWsrRPmDjsR6Jf1dtONCOKVJ1MxfAPCCtDvNJ/
         i9I3qY2lJW8bUErfmVuiZ1Nrg0TwTTpNenV970Ms2+PVKf9xgZLM0mj4WKCXQef0my2j
         VikeUoJEN5sPPeK3IC3AnilnYQots8Lyj8w/MrQm2wCGm7xXvqsbvQ4BGJXXma8CFu8L
         QgXeEOVxMFXz27lUBNyDYNE+PgBM2Ve3CqGAHcwEXeeYFpi3R378f1yvgbBjJykAl2dD
         zNQw==
X-Gm-Message-State: AOAM531JW7UC2XVtddaBCMQZlb2a66RxTbTNdyr+LoEozzPdqfQW3yqZ
        OERkQZAvtka3AC8zMgoFbFRD4BSIrZphUw==
X-Google-Smtp-Source: ABdhPJx7f/gtSslpMvYSmHHylU4EXBo7ovJa5OT+HVkVcIgxoClY3JSRVpHu4n9XcUsCjoL6z9EqBA==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr50842184wrn.337.1620942118427;
        Thu, 13 May 2021 14:41:58 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001c07d070726df7f9.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1c07:d070:726d:f7f9])
        by smtp.gmail.com with ESMTPSA id p14sm4273606wrx.88.2021.05.13.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:41:57 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Refactor some prompts
Date:   Thu, 13 May 2021 23:41:50 +0200
Message-Id: <20210513214152.34792-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in [1]: 
- The two instances of git_prompt in builtin/bisect--helper.c should be
replaced by git_read_line_interactively;
- The prompts using fgets in "git am -i" could also be refactored using that
helper function;
- It would be nice to add a comment which warns people to not use
git_prompt for regular prompts. 

This patch series addresses these points.

[1]: https://lore.kernel.org/git/20210506165102.123739-2-firminmartin24@gmail.com/

Firmin Martin (2):
  prompt.h: clarify the non-use of git_prompt
  builtin: use git_read_line_interactively to prompt

 builtin/am.c             | 14 +++++++-------
 builtin/bisect--helper.c | 15 ++++++++-------
 prompt.h                 | 10 ++++++++++
 3 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.31.1.443.g67a420f573

