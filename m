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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10975C433E5
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38ED61986
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTAEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhCTAEG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE5C061762
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso102222wmq.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vNEoqUX4A42360elOoDcA6cH0Od98QxzvF2EIqCVNu4=;
        b=IB1mRrJo7u6rMsbhRyzJApoc9prOSUMdzyfCun/KQ+e5DqULYuzeTYgEKHvObKffki
         b4eO1Y78dG+EhcAS4RMJGyCmwRgwfERbtN7h/ZyQwyKmmsBNlUh4agA0MvmTg2fSsISK
         FXs0Y1cULL4GZH4FrfXHwHXYAA1uIBDg3neDcG+cblt0xLxOwFORzhqDE9nQlHYittde
         SUltb0OksGca0bFjbyJwFck36EoML+Na9nDseVFgm4jfuSw+9yTEB1iujemNVJAD5n7Y
         lE1i5QIavTbQTeZL0Z80upSgL6nIFLosthC1p2ny3flEiPdtWq3XMtdHLgEDFG6tJhGg
         HzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vNEoqUX4A42360elOoDcA6cH0Od98QxzvF2EIqCVNu4=;
        b=NHrMpKNcAcUyw5/hT3gcdiUBwSbhOTzviuhqCvjEMCrMruTbY67D2a/OYvbvQuj3VX
         YHBYIqWcbKN8iXg6LcwYs+D/vcngdmepACfjBA4pxDsDrbE869JGHzOgZjcp4vAIi+Mp
         +bplptI6IlpG9uifcPcYthV18WmHZebVV/jScqnBA0gwKB+rrJpULm4j0yiSR+IeCk0y
         aZ8aq/u0wdSBfxs80P3EyxxvOd9b5Cce0geFyEr0ZFfvryzzxNeYcQySzyEW3PBS4U0c
         lP7tZFeMAzPu5NASWPjXtdQ4KYvdK/mnVLMbk7eLrYvF6c3eUHxiv0S4BTFJEBrN81iO
         NqKw==
X-Gm-Message-State: AOAM530m9xRnS67VS8FGBcWGmTeuRo2vay2bNOnFWzP3v9PGRZKV7Ayi
        OnnP4nVLmQokLqqHhdiKOnQb2N/Jtzk=
X-Google-Smtp-Source: ABdhPJylJMN8IRWuFNxSmnpNwOk1ts2LQIedzP37/YbapJsiDpR2wUB1WP7+o17u7GGGy6d6mzNPNg==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr5592961wmq.71.1616198644365;
        Fri, 19 Mar 2021 17:04:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm9873457wrt.94.2021.03.19.17.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:04 -0700 (PDT)
Message-Id: <6bda855f29806475be14d133e185fec222c8b0be.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:54 +0000
Subject: [PATCH v3 11/13] Revert "merge-ort: ignore the directory rename split
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
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index e8f1a435f99a..8258d3fd621e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1636,18 +1636,7 @@ static void get_provisional_directory_renames(struct merge_options *opt,
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

