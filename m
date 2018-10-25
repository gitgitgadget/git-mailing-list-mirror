Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A15C1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 12:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJYV0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 17:26:48 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40513 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYV0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 17:26:48 -0400
Received: by mail-vs1-f65.google.com with SMTP id y195so5400671vsc.7
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aq5pbAqVW4e6QfQH866/USsMIFQQNLIYKVde3gkQ4os=;
        b=Nx+nh92smufKfRPHgK4DD8Ai/z59I4CicO4hO+t+CvAY3bfG+e+1Ou9Zx7HmjDdvVB
         zJEbnPTg/Mka4XmsDRcacw+5pEI9HaRlcz+7TJm6xQVDWyX+U1Lp2L9aHy/PMTXCof1W
         Tm9kyAU7Yqn5/bvrltNqEHYF1N5Narp+S3R36oic0vifc4ERRE7Y7ajtn4AY1X9WJXB2
         gOXEmoPhrUAKt68IO4ZILOdOJYWxIoWx55CartwO2/aFBr17pJiyT/yNLc863PPcAdG+
         THxbtNHJ8Lz7/eVAdQTM7/ZHa6JRLuYzK3swzg8jCIXAOcdM0Hq0UUhBaq2MPRBAdqrx
         GFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aq5pbAqVW4e6QfQH866/USsMIFQQNLIYKVde3gkQ4os=;
        b=WqJxRFPkuFzCWzlDfWsJ7C5oGkCFNnZdvUbjWnqNXe9cFuOxi10x4kAqvYmnLY3UUd
         zGS0m39TxYXp52CcueBU/Mm5DgsbD7DBl2a/QvA8KpdLpQgrz4BOpRe5S2HWzVw0XPe3
         EdNRUp3aNp7XxcGcLb4a2gb3OqCdcRFj6jaHfUnv9iQk8eAaTExnpgTd88+Bc3Zzfsll
         RXykCb8ch6ArjPm8++jES2aPFyXQnIpwBPzvfi9XBMNwCNH3IXYL7kdgPZPLokVfwtyo
         rTj1nVvBE3AObDrLajO5yVEXSZ7lFCYC1CrG4OBNbnVku4o44gjO8WLc/9nG45caXXIz
         5otw==
X-Gm-Message-State: AGRZ1gJreasptA7IfvEKAyFxV53WRfr+dN/6he1eCn4AmCKac99EmCj1
        iNfnI5Hapi2H1xhanE/xqG1Up1sp
X-Google-Smtp-Source: AJdET5cWAh50bjbX/vsx/Ic6JFHyHJ0DOlI56qwDC+IUPErc2jV+VJnjAiAR9yQBX25ffD/gG43Htg==
X-Received: by 2002:a67:f096:: with SMTP id i22mr637693vsl.174.1540472049383;
        Thu, 25 Oct 2018 05:54:09 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id 126sm1836361vku.32.2018.10.25.05.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 05:54:08 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH] packfile: close multi-pack-index in close_all_packs
Date:   Thu, 25 Oct 2018 12:54:05 +0000
Message-Id: <20181025125405.30351-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181025111557.GL30222@szeder.dev>
References: <20181025111557.GL30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever we delete pack-files from the object directory, we need
to also delete the multi-pack-index that may refer to those
objects. Sometimes, this connection is obvious, like during a
repack. Other times, this is less obvious, like when gc calls
a repack command and then does other actions on the objects, like
write a commit-graph file.

The pattern we use to avoid out-of-date in-memory packed_git
structs is to call close_all_packs(). This should also call
close_midx(). Since we already pass an object store to
close_all_packs(), this is a nicely scoped operation.

This fixes a test failure when running t6500-gc.sh with
GIT_TEST_MULTI_PACK_INDEX=1.

Reported-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Thanks for the report, Szeder! I think this is the correct fix,
and more likely to be permanent across all builtins that run
auto-GC. I based it on ds/test-multi-pack-index so it could easily
be added on top.

-Stolee

 packfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/packfile.c b/packfile.c
index 841b36182f..37fcd8f136 100644
--- a/packfile.c
+++ b/packfile.c
@@ -339,6 +339,11 @@ void close_all_packs(struct raw_object_store *o)
 			BUG("want to close pack marked 'do-not-close'");
 		else
 			close_pack(p);
+
+	if (o->multi_pack_index) {
+		close_midx(o->multi_pack_index);
+		o->multi_pack_index = NULL;
+	}
 }
 
 /*

base-commit: 0465a50506023df0932fe0534fe6ac6712c0d854
-- 
2.17.1

