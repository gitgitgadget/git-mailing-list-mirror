Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58AEC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C198208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMzLBLvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbgGaP1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbgGaP1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858FC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 184so9613098wmb.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Z8vEIBY7dqXeqqNBUPsNw/E+iUxatUcmVMbFcKVLzc=;
        b=ZMzLBLvsKhgNJRiNbRPvYsaiP1dqNhFJOFtnxuzurd4qqCWesSLNi2YZtwvGMXDhE0
         AczyKUWkyOK36IRBLvGu/B6Qz+7PTG/9ELTJWlL8Bwi+MuPnA/RgIyGW1WlnsJ1z17Wq
         ZN3T0CyOcFsXj2JhxgJ6x17XFM6SFmJCTwori5mEpM5WAhW1I6s5cRmrPLxQk1J/Se49
         1jUpWrf963Xzdfd+f1eN19D39HdoarnyqEybQlONBmeApA1tP0WQT1wjvLAbffAYsP+u
         GmVam6NHs2GpVYDg/kNbH8o8mllTG5rWIPRb0fvNWBw6CBzlw2LjkzqS8OpTBtQlpIyw
         0UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Z8vEIBY7dqXeqqNBUPsNw/E+iUxatUcmVMbFcKVLzc=;
        b=oX7W9QN7rnW2pYbrlKM2KRLY067+8C01DnT9ey3+9/+0mqLRmEo8djaKemUbv2V0VZ
         KeZlrPv7ZWZlhm5O0drcdkrHUr49siag8TdTGWN0LzIDECcQO8kfdfNJC1MZJaHL7Zoo
         gfOV3WRLAWi/p+NkFNKEP2qDNgFj1nj1iSPneKxKa0glTqBdWt1bnOY3f5fyyBmCFKFH
         G5IRb2mTUUjBhRwyoNw2guFxaDa6/UZEnIzNkj4HqdJ2iuosCDNqZbEkTBUZJs2EkW6Z
         ZtE6j6SMWH8H1yjZZDxq8OD0logArc1LKVME9Q31UjwjsSLsRCuHip2bH78ykGXqqELV
         obIA==
X-Gm-Message-State: AOAM5313yvawoMfhsd7YZM/5ognXSxgOkd4PPxporqUqsuYq+SwTf1yP
        sVkYf1CL7/Zc5DoLHvr9/EODdL9O
X-Google-Smtp-Source: ABdhPJxTt+51F2dxeAgEtn7pR79xMKJjWb3thjEweQ8PAc845U4ipashXvvEnVI+ayIS9VH1/S9ZYg==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr4207891wmc.24.1596209253773;
        Fri, 31 Jul 2020 08:27:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24sm14340179wrb.11.2020.07.31.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:29 -0700 (PDT)
Message-Id: <0606b2a1c8aa4d5a346d548dae20085eabdf7b46.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:07 +0000
Subject: [PATCH v20 11/21] Add .gitattributes for the reftable/ directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 0000000000..f44451a379
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

