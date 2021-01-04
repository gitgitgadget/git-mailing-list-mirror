Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677EC4332D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A757B2151B
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhADDKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbhADDKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D26C06179E
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so17192075wma.5
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JVX1YwEI15ACXoHGSLfoBMSCsKP/lX3ZPnVK+ClcBPI=;
        b=Mgcf6rmRBJuFuxs0lPmcv99DBS8vTzYSLkwlP26j5tCu31OE0xDrOL9F1qQSIkOWwY
         8WwD0y4KPxBScKam6d2lmsLQlRv6yaDkqZE/YxFki5G49lMqznW10cNhcmwL1pGIruyH
         TFLG4mk6eP1yDL6jTi8oJlVYVg1FZu33XOCL/R0zW1m1JA0uG+5CO2htv9pvF0S1SABO
         3As8Y4dIDxA5jeQ4Y7RZBoa3hECA02bfSaD4AAtwLCzpFGKCQ36bQu0veMAktvodYoKB
         frIIljYNopFyRe4Z15QI1VyatxUcQlOzqtWMC1wFhE5vvl7Ve+3MNUPTuO/ENBT8u4b3
         Ch4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JVX1YwEI15ACXoHGSLfoBMSCsKP/lX3ZPnVK+ClcBPI=;
        b=hscPngnpJBxzBQGkT2/rSyEYdegtsjftRGr4k5k7XX0pBPj5Y/G8+r5GffJRY5hwbp
         WZ6ZfO+sMPgcSId4m/jStvNtgwcp01GkDLlLHgBU2iFvVZuJTwLyTSg7pEHGkWhN6sGA
         97wmubCzF4zdP9/cQZbNJwaVZmRE1c3U1AgMXwqvedDYqvC+iuyhNNoqeb+5ADQezCLV
         1gJj1JyDdftBXOgwwTcGojnQG9/2U3E9rrb5k9QybWMMX431/Efh9dIf2eb1IJmqQ1A0
         9IVBHoByw78w4D8qTDhhg0JkzfcprSSIRzNw9B2CCUQfV1JH81brqx9ohBHBvKXmf82g
         otLQ==
X-Gm-Message-State: AOAM531/GiU5HO+WPUB0UezGNP2cf8A/UVz2doQZ+SvHXNSbgTeFEgCd
        wb2OI3oTdZ/gPjs+lNpA6XW7jp7S18M=
X-Google-Smtp-Source: ABdhPJwDwliPZYLn3LcC0yNhaczwCldizjfef++Z0dOBtQA/6FNL0dHbhG7AMeKegU4LW17iTKzhEw==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr24795483wmb.76.1609729766106;
        Sun, 03 Jan 2021 19:09:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 67sm33108030wmb.47.2021.01.03.19.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:25 -0800 (PST)
Message-Id: <b2bb141a254ab3aa0b91886be3fe8efe52732783.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:16 +0000
Subject: [PATCH v2 7/9] index-format: discuss recursion of cached-tree better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The end of the cached tree index extension format trails off with
ellipses ever since 23fcc98 (doc: technical details about the index
file format, 2011-03-01). While an intuitive reader could gather what
this means, it could be better to use "and so on" instead.

Really, this is only justified because I also wanted to point out that
the number of subtrees in the index format is used to determine when the
recursive depth-first-search stack should be "popped." This should help
to add clarity to the format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index c614e136e24..2ebe88b9d46 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -198,7 +198,8 @@ Git index format
   first entry represents the root level of the repository, followed by the
   first subtree--let's call this A--of the root level (with its name
   relative to the root level), followed by the first subtree of A (with
-  its name relative to A), ...
+  its name relative to A), and so on. The specified number of subtrees
+  indicates when the current level of the recursive stack is complete.
 
 === Resolve undo
 
-- 
gitgitgadget

