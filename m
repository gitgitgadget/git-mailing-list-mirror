Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D878C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AF360EE9
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhHDXvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhHDXvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291BC061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so2444187wmb.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N3bRxUThchrqUgojwudTfdfXJqv0noPhV6RzsW4nUuk=;
        b=ZhE59u4MzVvihZeWQfSc+cFUeJlTZwzB4BHMgUC070iUrlDoAMLBCSSNjj7fc6VFc9
         P4t+Vr/Dm4DO49I/mrlg+EPNnkhs0O6kHb0dQ84/beRpOoNnEd80YROL9zgKxKWma1Fo
         mQuGXLSSUbnwkOBNk/PdsZGnPLVECptaXWxJecriJX3WnQ5wS0QwVzCIFG7USr0R4NpC
         ObNTzrydLcrqjgnT9xm5P5o6xiFNd0FECxdD1kcRQ0weNnTBkHEbCT53By3cFWixKaae
         sTScIIZN7LDEzmeXdnCl7YHYTqklOnbu9hsyS3HjEc4QKRDsGsv3HUdy/hkYAuNMlrNK
         96nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N3bRxUThchrqUgojwudTfdfXJqv0noPhV6RzsW4nUuk=;
        b=ccaunkmrtzisw89LD+lUf6odniuJ2q5zMggezg8qUZ5dAGdTk/uqSlzGKBNk4uXUFV
         Ix7S18+L3TMMoGkSwMBHJ4UZJNh9XGExSFE0Ac51bc18IlVPjFoG5jYP5W0/lr86RQSF
         TwE6GOZU5Z7/8eEh7sudYqMH66UZx95DOMzc+YRx/m/4PGkGFNeBU+pU1isS91SNJZ3b
         RUcV9H5OU9+NdGRfxsvOYRzS2zVGZt7Slab58ALdMOLTK9Wc3maXqrTUyFRQg1BxqfRi
         O2Ty+Lbf2yyGrSustNIOdPh+sBviiQsAhanlTspPgRpHR/q3XbVZ10i8UKTnujpIqRJS
         Kzmg==
X-Gm-Message-State: AOAM5334HxoEW/+RTbLOHgpu+OlixQgrQhGqo3F+mVFNIgDELLQmrVPL
        +Xw0LLsp5iQJG3rolkISw+3y+BM2JRA=
X-Google-Smtp-Source: ABdhPJxtBAQcDK0dPwiDQVaYV4oKL7j/wh3pZpqCXCV4YzK+/vutQjeAmoh7k1tC9C98d6ONJu21tA==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr1777407wmz.177.1628121062709;
        Wed, 04 Aug 2021 16:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm4760734wro.63.2021.08.04.16.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:51:02 -0700 (PDT)
Message-Id: <0b881131b2b103605cc2ceec5cca6270694844b8.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:54 +0000
Subject: [PATCH v3 10/10] Update error message and code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were two locations in the code that referred to 'merge-recursive'
but which were also applicable to 'merge-ort'.  Update them to more
general wording.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 2 +-
 sequencer.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..d7b14bf4a7f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -738,7 +738,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
-				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
+				die(_("unknown strategy option: -X%s"), xopts[x]);
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..a4e5c43fcf2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2065,7 +2065,7 @@ static int do_pick_commit(struct repository *r,
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
-		 * that represents the "current" state for merge-recursive
+		 * that represents the "current" state for the merge machinery
 		 * to work on.
 		 */
 		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
-- 
gitgitgadget
