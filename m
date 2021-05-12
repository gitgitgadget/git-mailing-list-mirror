Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEFAC43616
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A87613C0
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387715AbhELUjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386797AbhELUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 16:22:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B4C061760
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z4so1782687pgb.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paxxEg/unpIJ8Cw+Ag5i5+ghUkbx1BCAFelHIzb8WsA=;
        b=Ut77SWF2IfrpnOYzmemjk+W+8G4/rWpjhNBxg+OmIDpRFciJCcEJgR8BoeK4eWwmyT
         iyYJrXNbS4YUzQHoOZ2kDVc7IRh9mUzsFPXyGwsK61J68o5G7b83oSvltPH+gmfO7K5J
         s34CmHY5R36Dd1QaTrlOMzB6c1JzfK1c4ubksQP0DrkImv1cNS2/i3x25Po0OSJVrnDN
         fd3Gg6FlmU6HEUMRMVXRsme+QM1vLRvT8/3kyFShuWgN88DV5Xr3sbo0yIdHxOy0I7r1
         OZFV5vndKxqHtHNyucmu4Xn4I2ipQYrIJiWRNL78dXHLPnzHDNwO0OK1kfKHlFvA4MBH
         HTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paxxEg/unpIJ8Cw+Ag5i5+ghUkbx1BCAFelHIzb8WsA=;
        b=KjXZvlhnXGYqkYEce5wv/gTUmIMpAc3N0l0KK6uGNc1v495AH5tKcXvjul38/Je6BY
         czBHCNBDiBJqL1BICimlnFDq4RBNZSHD41/4MEbHM2YgYOIFHXl9PqheRZwykaaUvYiU
         62qINcNlQgbANsQnSc+lLtLhIzBNetjPfV5MOmC5L5MS/UnwUgsyyU2ggTOVbzxWwqKZ
         qBDG71eJ1trVMVGFTL6cSRjp2mvziuB1Idl8pV8q9lExiBoAtCBcCFB1IHifVTYlHfEt
         RtMKzHYKlvqiVRyE34n/VWMNFK2Z9RChJ/8IShRmpWtGW/OwQQTAt/d/zSbtm7fXejUz
         xcXQ==
X-Gm-Message-State: AOAM530E+s2JoTXjIigCntG5rG088oAMRjY88zbLn3RrLLOKzLtm1G+Y
        d2WnvhY2IGjUxe7wchtoHQfCwDsD+0I=
X-Google-Smtp-Source: ABdhPJzayUklF3LvTkp5XY+XVs/pXx+wVow4nSgGLlFfgjoJL2yK63GppFuBmAwVvFzO8oy0uKfwBA==
X-Received: by 2002:a17:90a:d3d0:: with SMTP id d16mr270926pjw.157.1620850580518;
        Wed, 12 May 2021 13:16:20 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id bx12sm5109133pjb.1.2021.05.12.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:16:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] Fixes for dl/stash-show-untracked
Date:   Wed, 12 May 2021 13:16:11 -0700
Message-Id: <cover.1620850247.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These follow-up patches for the topic should be merged before the
next release happens. In particular, the last patch fixes a potential
segfault that occurs.

Denton Liu (2):
  t3905: correct test title
  stash show: fix segfault with --{include,only}-untracked

 builtin/stash.c                    |  8 ++++++--
 t/t3905-stash-include-untracked.sh | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.31.1.751.gd2f1c929bd

