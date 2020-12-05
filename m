Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA46C4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F237230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLETym (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgLETyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:40 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE77C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:29 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id y24so8753578otk.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Th18jmzz2gIJS7cam+Q1w9jY+++oT0tBsLHK7wsR/c=;
        b=iKcZ0xJd0AU+NIM9/PuaOdR+nTD3dDC7lvFCDEOHyWfCjNR+NKXd9wCa0ihD7nltHt
         lV2ybAY7nT9qMbfozQDXpsfFUk8a74A8/9c5kqolXzkXFBge1Qi+dMsZka2E9u1wbOtr
         10ett2BCeRdvPUKX9fLnTTCpCtXGmMtXZD9cJkQfTSrSyBuMBtOCvj8DX+SYRXxgSVgk
         i+Hws8g2QJ2FVxGrLRpgM6OZVM7UzmmnsscmBNjXY94QRwoSate1ZwMD5QBefMVLi604
         kvsJJyzuBdQEAOLv0MbXZHii0Jys1Z5Ak9SNHSjtoDfel4z/PrRdmb79urhNSnenAOmR
         eeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Th18jmzz2gIJS7cam+Q1w9jY+++oT0tBsLHK7wsR/c=;
        b=GlrTfWDdXQMC/H40QTWfMWbO6eINSHQyRCKk1/7KddNGe9+jxqQKceoB7TsK8fgZhX
         D1x0QhRkuclbT+8eCtiOd2cLookGR5BhrpxywYdFvcP27dczXS9uiP27NiiP3xdl9tkf
         9YnqijPnuK6Vby0OI5xdssnpfuCNpv3GsfuRnlVO/KMR6qOxUjCb2AqP2CxxtHm4zGl4
         b7YjqGDnImYzy2qG05Qvr9HNvOQYPLVAtS+3J38SmkU9ctEj9WXZqZzVukkdDZk9YDEB
         qSUCEfeyzTO1SCBq8x5GfoI7JSCPZ+iO5pKwPKOImPxzECiSlumHkCm703MaDGwD6up1
         OJ/A==
X-Gm-Message-State: AOAM533/bfOZbwiTBdi+7pVJ4pWCbzBWyxbQseZeAJTMUEjatW6KBF3m
        9doC4Kq+e2Lt2ww3DqY5oayvaMziUnyXgg==
X-Google-Smtp-Source: ABdhPJxhI6Plpb/eV4z6zwTQa1NFtEYiEOUlNaqfdoueLd+FQ4JeBmCL5lQSj5cKqmU4eFn59F4fFQ==
X-Received: by 2002:a05:6830:10c3:: with SMTP id z3mr2058743oto.143.1607198009056;
        Sat, 05 Dec 2020 11:53:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q3sm1542775oot.33.2020.12.05.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/16] pull: trivial whitespace style fix
Date:   Sat,  5 Dec 2020 13:53:05 -0600
Message-Id: <20201205195313.1557473-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two spaces unaligned to anything is not part of the coding-style. A
single tab is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 300b17b962..cecbacc549 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -128,9 +128,9 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-	  "(false|true|merges|preserve|interactive)",
-	  N_("incorporate changes by rebasing rather than merging"),
-	  PARSE_OPT_OPTARG, parse_opt_rebase),
+		"(false|true|merges|preserve|interactive)",
+		N_("incorporate changes by rebasing rather than merging"),
+		PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-- 
2.29.2

