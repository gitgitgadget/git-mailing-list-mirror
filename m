Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA301F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 07:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbdHYHg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 03:36:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36467 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbdHYHgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 03:36:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id j72so1699265wmi.3
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6JCuUK1J3DzFpKDYoOm6tfHcGH/Ibdfu6+8E/ko9hOM=;
        b=GPye0OeuZYzQ+xL2Mz0Th0AyeXc/xlq6KudOf8fmvkHBJfnZ2dwugSVX3s75P6VttE
         ai0u7N8o/u/Xxd5M9JgAoDqcEgp8RnqFi0OYc4pvtV1SsvgXcULK0XZA+uw2DJoAI70g
         7akgST5jjRj1YFdWbvu/pZlSOmusmPBzUbOnpZZdAUY8bS1uBEVOeUcCmIZpb1fUueB4
         bY6jYAM7WdMfUtVWsEuTNtmyeSQxkgDlH0TpuOHOIhkR2GE1S9NlxZfi9E/dU7DGZoR2
         SSxBUVgETWwdFIZB4sUsayub+95IgfEEsLSoPq3hjufjAAu5gSuqczoKtzB8ToxOnAG+
         c5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6JCuUK1J3DzFpKDYoOm6tfHcGH/Ibdfu6+8E/ko9hOM=;
        b=rRWVRX92DGqQrpB/vbXktWfuNjk/2KjQDt9U82gxBdgFztjMUO6q128fpRz9wI9zyw
         3oZynRmcHNn0cM9CbxHlE0M4mlV/ZjvduntZPQXqSrs1+KTLzlzATiuXm4n26gxrG32h
         11RQAiCBqwXAfbJ+uW0/Uj87r5mUt2Y+FXZaHDXsPDxvyMaEDNmBJpEzz6zhO8Q1ShEE
         D9CfzsqXGPS3H0D/rR1mMS4iCdyLymG+Q5Jih1BIRdr9KjS9niH90l2JjI03X8hHrxsF
         jXNKylaYDqAq82UFIxFBafZGWhPmkk7LQ9GROSH4PnmD47AhI0WCKpfUyEK/ZuUwFZRm
         Ldjg==
X-Gm-Message-State: AHYfb5hNP9RBbaJ3uiHi3hVRMfYG9mniFGbC77wmeb9pLUzsdvj7DfkP
        KEdtzmdoLVH5Nexv
X-Received: by 10.28.203.66 with SMTP id b63mr959275wmg.73.1503646584248;
        Fri, 25 Aug 2017 00:36:24 -0700 (PDT)
Received: from localhost.localdomain (2.172.124.78.rev.sfr.net. [78.124.172.2])
        by smtp.gmail.com with ESMTPSA id 9sm675392wml.37.2017.08.25.00.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 00:36:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] sha1-lookup: remove sha1_entry_pos() from header file
Date:   Fri, 25 Aug 2017 09:36:13 +0200
Message-Id: <20170825073613.13853-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.326.g3dc57ebfbd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f1068efefe (sha1_file: drop experimental GIT_USE_LOOKUP search, 2017-08-09)
the definition of sha1_entry_pos() has been removed from "sha1-lookup.c", so
there is no need anymore for its declaration in "sha1-lookup.h".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1-lookup.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sha1-lookup.h b/sha1-lookup.h
index 20af285681..cf5314f402 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -7,10 +7,4 @@ extern int sha1_pos(const unsigned char *sha1,
 		    void *table,
 		    size_t nr,
 		    sha1_access_fn fn);
-
-extern int sha1_entry_pos(const void *table,
-			  size_t elem_size,
-			  size_t key_offset,
-			  unsigned lo, unsigned hi, unsigned nr,
-			  const unsigned char *key);
 #endif
-- 
2.14.1.326.g3dc57ebfbd.dirty

