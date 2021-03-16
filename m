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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A9EC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3509F650DD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhCPEF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCPEFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:05:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EEDC061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so9739109wry.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jIpZv690yN9lyIKWdYMAfWmPaHOqcOUZdQkxX5zhM4E=;
        b=BxcsmH6VIPSWhBOG7ddW2viroFNVHDnl82aQmVDhnsAkkF/mYcb39dCCCB3b2EQEU/
         aM/wtZcqvf483Imf8OcLMu5MNmfQEu7+19c81u8QA5CoPoTRkXJ6fe2tA96JrrGhnneF
         rndF7X7Qc7WVsax8RuAQ/5N/GCt401lxQ6Jp5JldINljnwEizwO7PtVjuZYDx60a4cuP
         Tg072LkU0xwSQodbwmXe/q1qVW3dNT5G7IlGwYRMlAmvwdm86P9ydAwD86A24gSQ1RUQ
         tlvWSRzKCHYZ9QvJoK9DMmCZfNiMsuWlYF6Nic2edJ6PXrIvGtz17Tnj5kvh7Ghfd6B2
         +X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jIpZv690yN9lyIKWdYMAfWmPaHOqcOUZdQkxX5zhM4E=;
        b=uY96MHlZzesUwQw8FTKYYfXhPxyIGeZL1E08m0ArtM6w1S+F2DEzz4QCX2k+A69spB
         JVkx4JD0C5pI6EP8Ns1cOFao7ux8mpGO5+rAHjaxS3crY2H5YIRhiKC5qXzvSsnovPWC
         sS77cdDAz34Bl5wEjzm2ZqJZ8PTQatsGr12Mv3i5Xsl4ze+4RnPnuv9Fu6Q9+cToBDA9
         KuJqWcU91fGMMjNC/0omAZp5GIhxa5k2irr3JJYx20L4FO0ZhM4X06VIAI8980RPPy6e
         B0kldh3HNki88yny9Gh/XJjUilfeHpFL17IN0jz8PMhxADFANS95zoyHVgosUUg25XPp
         eg5A==
X-Gm-Message-State: AOAM531k1f7l/XCDEWeM/ReBYCc+w0z1TS/zuiJJQHcGNE6+u4cukmdf
        9ECCe4RvnnzypxqEE3rPItlorq5OpGc=
X-Google-Smtp-Source: ABdhPJx2JLubNVjHSY0AT+bOTC2i1wSk1emZY8kCUNqf0BIlNnONH9W9YB/w/s7m1xxyibpNqYguHQ==
X-Received: by 2002:a05:6000:1ca:: with SMTP id t10mr2588341wrx.45.1615867504971;
        Mon, 15 Mar 2021 21:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm2329650wro.36.2021.03.15.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:05:04 -0700 (PDT)
Message-Id: <7a8e26638a16edcd2317a28a3cc106321ebda5eb.1615867503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.git.1615867503.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 04:05:01 +0000
Subject: [PATCH 1/2] Revert "merge-ort: ignore the directory rename split
 conflict for now"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This reverts commit 5ced7c3da009090c5a926e3123a71314c7f28d42, which was
put in place as a temporary measure to avoid optimizations unstably
erroring out on no destination having a majority of the necessary
renames for directories that had no new files and thus no need for
directory rename detection anyway.  Now that optimizations are in place
to prevent us from trying to compute directory rename count computations
for directories that do not need it, we can undo this temporary measure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7f5750ce6ab0..60270feadc54 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1562,18 +1562,7 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 				 "no destination getting a majority of the "
 				 "files."),
 			       source_dir);
-			/*
-			 * We should mark this as unclean IF something attempts
-			 * to use this rename.  We do not yet have the logic
-			 * in place to detect if this directory rename is being
-			 * used, and optimizations that reduce the number of
-			 * renames cause this to falsely trigger.  For now,
-			 * just disable it, causing t6423 testcase 2a to break.
-			 * We'll later fix the detection, and when we do we
-			 * will re-enable setting *clean to 0 (and thereby fix
-			 * t6423 testcase 2a).
-			 */
-			/*   *clean = 0;   */
+			*clean = 0;
 		} else {
 			strmap_put(&renames->dir_renames[side],
 				   source_dir, (void*)best);
-- 
gitgitgadget

