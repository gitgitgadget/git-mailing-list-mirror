Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8B61F597
	for <e@80x24.org>; Sun, 29 Jul 2018 10:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeG2MDK (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 08:03:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39370 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeG2MDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 08:03:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so7982945lji.6
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEMKMSUAG+G9tSNma2Xv813WWEz9ySB2DwMrb2lH7yI=;
        b=UzwJH6xOQ/gbLiDo+Ypc2UDOPb19YNl6VkClbSWzjyzl6sFlFZ+3eJGufUtt69668U
         UHyUwkJyyuFO6UULgNFIPLUqIZeivlSK4pE2hLnL1kthWqstBEnVGiXHRsSQO45D9E5K
         zlHKleLplti6tgF1W+MhFwnfiNMgruM1gojIGU+vZRSW99Bv2s8uBFZM5K2iZLEUom4T
         kyRcJG3rs2YAr/7uep0LduNLTYp20RzxvZ4lS4FSn6KcLPOP1GRQUBzJ+sTlq0YE8Um2
         rKv+jf/HiginB2NMLz53ESb3AU1pAWGkWom1MRQfma1b1z/gH4S/U3yHbhxQWwXb8AOb
         J77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEMKMSUAG+G9tSNma2Xv813WWEz9ySB2DwMrb2lH7yI=;
        b=pPIV0TKf/s2RoSE4NmNb0GolEkPMU+y8CUHfkrJLZLwYOWsLtOrkAI5zIV6NJK9hYY
         PGqxVc4LIKXYWoyeDWw131W0/Glm0UTJ44ch5CnZmhBH2FuT8p26X8CLqTsljJPePqqB
         iDAQneXMc41d/6f3rnxDoN6OoxHbQjFBCDYQAnjiRPneD0NxBHpBZzsw8YmL0h1fvq30
         9/qRbgE5rtlsUWi01JIrPNHvXi3LEUvcy6EsAhMX8ocLitbQ5c071+FgqvQa28N34p32
         PXtkbewuWVv+R4ZhwMTc/0wpbKIRFpuQvEqN7vHww11McTJ2UK/CsmHLavSwrwBN30a5
         yFXg==
X-Gm-Message-State: AOUpUlEn/Gfps6Rxz2hgx53NuHi5DLzd7YCyu0ajoD1Cv5MOd9xYe26K
        ept7WBZEN1KZYGIKTTjoiG8=
X-Google-Smtp-Source: AAOMgpeymqaKjSR++e63LGj7X62sCiVeALfxPSfwSO8qAWUkxOWbxHPvXF/DqA+FU3VYiiHto3/3sQ==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr4024807lji.11.1532860390134;
        Sun, 29 Jul 2018 03:33:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1529212lja.6.2018.07.29.03.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 03:33:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v2 0/4] Speed up unpack_trees()
Date:   Sun, 29 Jul 2018 12:33:02 +0200
Message-Id: <20180729103306.16403-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180727154241.GA21288@duynguyen.home>
References: <20180727154241.GA21288@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series speeds up unpack_trees() a bit by using cache-tree.
unpack-trees could bit split in three big parts

- the actual tree unpacking and running n-way merging
- update worktree, which could be expensive depending on how much I/O
  is involved
- repair cache-tree

This series focuses on the first part alone and could give 700%
speedup (best case possible scenario, real life ones probably not that
impressive).

It also shows that the reparing cache-tree is kinda expensive. I have
an idea of reusing cache-tree from the original index, but I'll leave
that to Ben or others to try out and see if it helps at all.

v2 fixes the comments from Junio, adds more performance tracing and
reduces the cost of adding index entries.

Nguyễn Thái Ngọc Duy (4):
  unpack-trees.c: add performance tracing
  unpack-trees: optimize walking same trees with cache-tree
  unpack-trees: reduce malloc in cache-tree walk
  unpack-trees: cheaper index update when walking by cache-tree

 cache-tree.c   |   2 +
 cache.h        |   1 +
 read-cache.c   |   3 +-
 unpack-trees.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++-
 unpack-trees.h |   1 +
 5 files changed, 166 insertions(+), 2 deletions(-)

-- 
2.18.0.656.gda699b98b3

