Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09811F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeCUQmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:42:17 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46710 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeCUQmN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:42:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id o184so6092949qkd.13
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J8vTI876wTx/VPJGdpHhf6N/uDqfqxlMoUjUbAncByo=;
        b=Jlv3w9nQD1K85UIdtG/2BGgtj4VIDGBHR5CiOmeoBfD++jhodoPt9f8mOAjxcTbGso
         D9EqQou37qmt2mjU2+jatmp01EFRySYPDt/nTXwsxGMyaMhqIv5SVmZ6OlezE1ogrWsm
         2WT7vv4lQCAR+SSAkv0Zg/MwDTbGk/IREt2YyyWytm08PZXQKPhMbpEWvlMPOeO9u38C
         un2QoHxBeAnVLgWVKah5+/b0mGwHHSef4LhgVQaw+fevIDoQ8gr6N1dwDZT8RdtQHcCA
         AMOWAIz3LqXImQHixssrxDAJu0e8kHQdmdTXKNTdWKDeqcdGbpZztvbfAIp9GOsneeRT
         DI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J8vTI876wTx/VPJGdpHhf6N/uDqfqxlMoUjUbAncByo=;
        b=Z6b6H1YMrd+pSqN+dFTKQRn88cqxygqsEE7rwiwSgjYFqwTGdnf0OFtfQMGM6n/8//
         tJlXL41i02zB2ANTjz0yVo6200Glrbu6rvOyDQF/LLzDJqrCgxaAgLf6jGY25+UfRXt4
         JUw9IBtynjHAQJ5CS3029ChqPslQrJ4X/5cIUIHFDzaePquTGS0DCtDoAJmDDZXgS9vd
         8rn6TusI98k2WEb157bLCA0wtcsxoPD9H/RqHu2+WoNCt1zTFnXrkSRyNmNIKONivAyw
         DkYFOYcpL8seAqcLwqgcI5PrE2XlvBadl+0M5YooADRP6HC8M00W+yzr1+CFxzBbznE9
         fb1w==
X-Gm-Message-State: AElRT7GoMCb0PAEhTX9wGef2GYwa+bwhPLM/D/liLR8QQxiGS9QQ4VGi
        n4qW5cUr6g7gaC907OUzfW/2xXT6
X-Google-Smtp-Source: AG47ELuOcYc0eqxDm698/pMUi7/NN1fSaQpaq+UpVJPe9QDSI2OC8ji/0JT/G0essHOv9vv9Ewneeg==
X-Received: by 10.233.237.2 with SMTP id c2mr31159291qkg.156.1521650532496;
        Wed, 21 Mar 2018 09:42:12 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id m24sm3235584qtc.81.2018.03.21.09.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:42:11 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 0/3] Extract memory pool logic into reusable component
Date:   Wed, 21 Mar 2018 12:41:49 -0400
Message-Id: <20180321164152.204869-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

This patch series extracts the memory pool implementation, currently
used by fast-import, into a generalized component. This memory pool
can then be generally used by any component that needs a pool of
memory.

This patch is in preparation for a change to speed up the loading of
indexes with a large number of cache entries by reducing the number of
malloc() calls. For a rough example of how this component will be used
in this capacity, please see [1].

[1] https://github.com/jamill/git/compare/block_allocation_base...jamill:block_allocation

Jameson Miller (3):
  fast-import: rename mem_pool to fi_mem_pool
  Introduce a reusable memory pool type
  fast-import: use built-in mem pool

 Makefile      |   1 +
 fast-import.c |  50 ++++------------------
 mem-pool.c    | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    |  48 ++++++++++++++++++++++
 4 files changed, 186 insertions(+), 43 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

-- 
2.14.3

