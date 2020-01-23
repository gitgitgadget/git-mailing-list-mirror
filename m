Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B403C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543642253D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="na+Rs7Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAWTAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:00:35 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37521 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:00:35 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so2012458qvi.4
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLGPPynfLkDxzIHy/odRv4qCqUGwvmWbMIvWJkTDT6Q=;
        b=na+Rs7NacC/037RTYdJ9G/nV76XkyWmq4odRVM8HO0NUn+FlY8HPZi87Q1fD50g98w
         1Zyh+jvALEhdWC1CCK/3IKgkjYHFcemFehbRA2RM7wOpG6GE5RtU3xiNgu70+G5nEsgA
         Y7NNh2GStGikCsVjGiISWA4j1keVfC3DQPijWvYxrbjLZJ8xMNxJqSzIP0Tb3J56TgjE
         lw/IFMgC9BGmyFjyfUq9syuZUmfiIJNKb8iFAbxj6I9QprNXML2FP/lgbNN2al6Xu9rn
         /g6KJYCa+2zseMranQJeJL+3/BW2yaZC5hn5sx/GKXyo03+8KXPYfR9TuP06mdHyiS10
         dOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLGPPynfLkDxzIHy/odRv4qCqUGwvmWbMIvWJkTDT6Q=;
        b=mkE6NeBK2wqhqVZjcYYRMvn1ah284etP3fBbp8BVB8bj1MR7aSO5a39R3eKcVosUJm
         XtWRFDCxhr3P/UD/iIE43F6GX2C3QKV0gNFO/BNGAvecVFhSJ2SZGXK6aj4lBwBa3vo+
         56SQ0d0oVDLkilPvL29N4T0AJNWHC1p97UA4NvOBlF6ENW3or/ycTYQL+1IWuW/WgqMo
         i3O93lIUDqYdL5qVGQI2UOpBmFfwgCRaX8i7GhlOqlj7+Z+LWccC75hRRJcusnC97/ME
         yeR2KibUCvo4nhohzJN9mbL4zO3kGovST4HAnc+8eMfB/Ez6JF9EeQ6ZsxxnPicyBM69
         rmQg==
X-Gm-Message-State: APjAAAXYgRfGeVPLpR3A32ezVIv92uwv+VBguZ30xyfb9VE3iNXltoRw
        Wjk0cyd6NQICweZyQSEy1m+i/SCRwR8=
X-Google-Smtp-Source: APXvYqw8J0w/TnahpcmgOV4ULm7DQTtss6wTK7e5t8NYhhsiyjhVz4Rq9XGyN96q09/rvl/baMaX2w==
X-Received: by 2002:a0c:c351:: with SMTP id j17mr17977973qvi.80.1579806033850;
        Thu, 23 Jan 2020 11:00:33 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id l6sm1363821qkc.65.2020.01.23.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:00:32 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/2] doc: sparse-checkout: mention --cone option
Date:   Thu, 23 Jan 2020 16:00:02 -0300
Message-Id: <6ec39af930871496dd7694ea27eeca69d5d60c96.1579805218.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1579805218.git.matheus.bernardino@usp.br>
References: <cover.1579805218.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In af09ce2 ("sparse-checkout: init and set in cone mode", 2019-11-21),
the '--cone' option was added to 'git sparse-checkout init'. Add this
option to the respective doc file.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-sparse-checkout.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 974ade2238..542af98520 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -41,6 +41,10 @@ COMMANDS
 To avoid interfering with other worktrees, it first enables the
 `extensions.worktreeConfig` setting and makes sure to set the
 `core.sparseCheckout` setting in the worktree-specific config file.
++
+When `--cone` is provided the `core.sparseCheckoutCone` setting is also
+set, allowing for better performance with a limited set of patterns
+(see 'CONE PATTERN SET' bellow).
 
 'set'::
 	Write a set of patterns to the sparse-checkout file, as given as
-- 
2.25.0

