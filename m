Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26316C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKDDUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKDDS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:18:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D62657B
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:17:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v28so3379670pfi.12
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CKcdjSCNUr1MW5hI0msHVx5Uz3vD5IgqJLTtgpEb4o=;
        b=d7A9U8p312gwu1YxtcsjuYvoqwp9pu+PlhokMkH7svt/cgNSoQxNnA15RdeQIw4n3y
         Nw5dFyS7mhcBdETrehCjeUA2HMO6xQvOH9MRmJTN1b3r5DsnoYnR00XBPWZC2Bm3dQGQ
         QchOY0WBryFjfWL0sSPzlo1ej/VKfSaUuLj6c7sLbixlUb2visVSkF8UNnBJcXjM/4vi
         CP+v16Z8udz+zsBvn2gasZKEMYaeVcfoz+kRCBTlLas2De+7ox90sxXnxXd7jhn2SQjk
         BKYV9EPGJyyOjNOC7tEoDbRJi+RyBipI2ixaxbED9zZpGdqaCsCFaMJLpPZZw9/snyhn
         HD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CKcdjSCNUr1MW5hI0msHVx5Uz3vD5IgqJLTtgpEb4o=;
        b=myCNLcQ0Az21GJdAh2uU9UXVTSr5JtIufO1gE6R4Q9vobCt3li7Lzpv18OtpLh6tGW
         iSgbrgbli8HUNsqDJZvcxXwn3mlVENZ1b6FHTo2gkzlEyrpCHOyv2nysmlNS3Ftjhp9B
         8sKsGlhDlY/XkakhoGP9J38s8rojXktdu+CaL89MsF/vBcIFs3mTwlLBer1vOhd+ZVF1
         99B5EVgLJyXiHMntTOFr9aUlSm6oEV477u13yl6oNsUZphIvmRv00qvjcaRIgVe3ldTo
         XGsiI7beLppiQZsNrMWnCbBLkHiW+H9HJCUSXO8a9MfLTXRn/KxuBrAxZ2ga6r/izW9j
         pP1w==
X-Gm-Message-State: ACrzQf382JEGi1vCw6LE1ZRgOZapyAhdxOpNpTaWNytgee74Rh89avPz
        CajSQCRzIppHmU+unajp5Y0=
X-Google-Smtp-Source: AMsMyM5UvCLlpZzPFXhnU9STfgunLiMk7aKP9dMid2fs+nrkj3hAtPASTSpPw2FBNqbtEXfKPGhviA==
X-Received: by 2002:aa7:9f0c:0:b0:56b:c0a0:6ab with SMTP id g12-20020aa79f0c000000b0056bc0a006abmr33371162pfr.7.1667531846452;
        Thu, 03 Nov 2022 20:17:26 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172973d3cd9sm1442908plf.55.2022.11.03.20.17.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 20:17:26 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 2/2] pack-bitmap.c: remove unnecessary "open_pack_index()" calls
Date:   Fri,  4 Nov 2022 11:17:10 +0800
Message-Id: <7ac9b859f31b2b3efb4a04896892ccd094a98734.1667470481.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g35840fde1dd
In-Reply-To: <cover.1667470481.git.dyroneteng@gmail.com>
References: <cover.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Everytime when calling "open_pack_bitmap_1()", we will firstly call
"open_pack_index(packfile)" to check the index, then further check
again in "is_pack_valid()" before mmap the bitmap file. So, let's
remove the first check here.

The relate discussion:
https://public-inbox.org/git/Y2IiSU1L+bJPUioV@coredump.intra.peff.net/#t

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9443b7adca..503c95f0b8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -412,9 +412,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	struct stat st;
 	char *bitmap_name;
 
-	if (open_pack_index(packfile))
-		return -1;
-
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
 
-- 
2.38.1.383.g35840fde1dd

