Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685FC433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2CC20760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCBmgwA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFJVTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgFJVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9CC03E96F
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q11so3945303wrp.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4TehjTYHnYPxGBg2m16YLZF/MTIB9KtqJyNEKuglwKU=;
        b=NCBmgwA0e800ZmC6cGz4vuKrrqaEIHULqjCF/x74rbwg0o0kdJTHeBL+QRvCdon6Jj
         NokXGQbJhBS9cUZ1U6L5FO2IH8gOD9WLtT2r1H6UQaFNvr/wThzIug8zUv/vUbMPZr+B
         2KT2ka09KVLVooAJbPn8rG9NKDa0SCkHxU+xnsKew9qV0BhdIQKSXqcLaOpx0VvZXeJM
         IHb6ZYJOoDoNHesVVMfrJNKKr1PvSRDd14FlX1ynftc1rAQMReao8fCBMILe8h2qTMMd
         DKovM47nXFf7jk80WDLOUxsjSeN/iS7INzMc56VXwFj06Ia9kEXa6e20/l0nuCWqWLed
         QggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4TehjTYHnYPxGBg2m16YLZF/MTIB9KtqJyNEKuglwKU=;
        b=a520qZN2hO6q2C7X+gYdRb5eZTQTgVy+tDZRlAoihZ7Yr8j8+yJ7WM/+4PdurogvvR
         eVvonc52m0RvDG5fpwxmi2Y9RgzfahmEvrhJkTHB72SitvLULL8xVIu91Rj1YNqw6ZhN
         CY12EOQ8LXP0A5mrfDs2WnGT1rgX0OH9y7ZXx7KkY9qITVrS0zmiT/42QCKemmB9MzSM
         E06hORB3xYkwbSTqc43rwSqL95SifsJNvWnp97iiU9BvbFCAdvsxPLU9bW19U2woJHYF
         PKCDCf9YvBV3ZMta4JgzETP4yGc7rtSRMTQBHOXnKK07ckscuAXK5NzSrvCiQeXcjV0i
         8czA==
X-Gm-Message-State: AOAM5324u+V2v27P89NeQOD2aXlFf6J1AcF3pmT//IXQHU4N+awtoD1G
        SQE/D/EURJFsLjGJB5tL1yYf/hVs
X-Google-Smtp-Source: ABdhPJzTTw4q8n12brS1zwVnEvCk1607WTnt5PcyBiKUpsOVq/TFtXsTHSeQwotu4unIlq69H+nSSA==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr6018872wrm.114.1591823980182;
        Wed, 10 Jun 2020 14:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm1083983wmi.3.2020.06.10.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:39 -0700 (PDT)
Message-Id: <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:29 +0000
Subject: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When anonymizing commit history, we are careful to leave the branch name
of the default branch alone.

When the default branch name is overridden via the config or via the
environment variable, we will want `git fast-export` to use that
overridden name instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162eec..028dd9969a2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -515,13 +515,17 @@ static const char *anonymize_refname(const char *refname)
 	};
 	static struct hashmap refs;
 	static struct strbuf anon = STRBUF_INIT;
+	static char *default_branch_name;
 	int i;
 
 	/*
-	 * We also leave "master" as a special case, since it does not reveal
-	 * anything interesting.
+	 * We also leave the default branch name as a special case, since it
+	 * does not reveal anything interesting.
 	 */
-	if (!strcmp(refname, "refs/heads/master"))
+	if (!default_branch_name)
+		default_branch_name = git_default_branch_name(0);
+
+	if (!strcmp(refname, default_branch_name))
 		return refname;
 
 	strbuf_reset(&anon);
-- 
gitgitgadget

