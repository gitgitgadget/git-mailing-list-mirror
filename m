Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902D2C33CA0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685AF20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA34TPN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfLCOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37536 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCOCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:30 -0500
Received: by mail-wr1-f54.google.com with SMTP id w15so3826811wru.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=WA34TPN+wp2JvsyyTxCzc5Es74iFAoRtI/00NY0VSMs5BQdmMJoGH2Z2QwdKfldTpW
         4fxc18JdtLUxpcB3qKvLByGjsnhXTaB+bT//1VRgG9soDfjW+llTKGDSysoLW2uDVnS8
         CMd7SEF4XrJSpyPUQmkXD3JJIDlMgOucFSc2b8FtVjaMTBNsVcsAHZeu4rV9enUQjCgl
         cT3k8A6nA//rVpZLFPGZVQ4FWy6wjykCZv2Hq4RcvrSIpRH0t+rJ/NBTpGIijZkZfaRJ
         3eEfl1SP82VeIc6Qe15D5XpH/hKnX+AUBziG4vfnI5NYSlcwyTLOGGwbli2tr2o+C+mz
         o1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=VTrr/VkNJSxKTk9rIZubafb8rZL3rv31Q+U8YdeTyOrMstgVS50MJqL7c9YUgkhyQT
         g9pBuHe2RwCrZxWQCVHv6ZQbK66y5/p+jdDvzVybgDwKD+UHE/RbD3WC288WFFcDOck1
         V9jLrn01loKB7skr0iJg4r8Uqk7MIchsvgcX6+bkjmtvTLk9yci1XNZcIk3KtLibXH9i
         4Le052C1Xp92JDWtU6AqD+Q4TvEDrXf57wghkMYjby2i0molHtYMmiNi76h9lQ8/KW2F
         /K5x2+JrJfHU514WjPgWSI6rZueNFCSxL/o3LU3MN44b/yBqKMdx1yVe5TeuRx/90/Px
         frRA==
X-Gm-Message-State: APjAAAVS4j2GnGHoH+B5oXQH8g4sVNG8RlwV/Y5TFfgidVQNbZlsPaEv
        +vZsctzMI22w7GyC/GmhuNRMTvHZ
X-Google-Smtp-Source: APXvYqzy3GEYJaPyh23rU0hqywfzxm/XW1qCjWtnGBUZgV12ncuJ/us8Nx5sE4b/dOzhNwXgwRJxaA==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr5034343wrv.55.1575381748408;
        Tue, 03 Dec 2019 06:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm3711159wrr.76.2019.12.03.06.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:28 -0800 (PST)
Message-Id: <a498dda97be76bc49677d8491457102bfb4af405.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:15 +0000
Subject: [PATCH v4 10/13] doc: checkout: fix broken text reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2011fdbb1d..d47046e050 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -95,12 +95,10 @@ using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
-	This is similar to the "check out paths to the working tree
-	from either the index or from a tree-ish" mode described
-	above, but lets you use the interactive interface to show
-	the "diff" output and choose which hunks to use in the
-	result.  See below for the description of `--patch` option.
-
+	This is similar to the previous mode, but lets you use the
+	interactive interface to show the "diff" output and choose which
+	hunks to use in the result.  See below for the description of
+	`--patch` option.
 
 OPTIONS
 -------
-- 
gitgitgadget

