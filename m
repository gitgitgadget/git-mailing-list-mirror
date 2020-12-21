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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E63C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AAE22D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgLUSMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgLUSMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:12:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71442C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b73so10428329edf.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwxhloLxTFP3moDBxkNUyzlkEm1dzWlIdODHya7imMk=;
        b=fTx4/edB/lMtIPIWuiYdKNS2QkHMyxhox5cYx78seuk7c7gDPGGDPWygfHPfJFAxNe
         A2WK685ZKAmtTMXnqBfl3f2eEbtTBIpw8DqyIW5CFDz0KEwpOwBiFwm7nTUOAedHZx7H
         la4Qpoa5JibD2+9wOlq4M4dm4T6Ooohmgs+4jDG+yrlYGjBxmbNo5Nt6F0nBUpg21fI9
         y6McJ4NQDpK8CFTijMYVXHAaf2Xwem0yRDt8UDE+vuxyrHJ3wU817gv5Lia1mevRVdem
         gC4bRT0UkDSjWc3wX5q6B/UE01C7fnRcATiLBL12pk9BsMTAD3ISOSbiY0FP1NfDmr16
         70wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwxhloLxTFP3moDBxkNUyzlkEm1dzWlIdODHya7imMk=;
        b=Up5boE+sy2E4SKc2CYsNgjS1XDSGfCwarFgdLiPJs5uAe3EuppF8hCopvZV214biMJ
         trVrVXBPejwgibHL3PJiehARvjl72/1/oRLBVxN3pXZbSKbR0gfz+byifLqnBmvHwYXJ
         eKojxTA8J8MMUtcMrl/3uZ56a4ZZbwTtpEtGcPdcOjtLkeaRFLK84gf4v+aHnkJdjtdK
         GD/vMGV2JDLumfUO4ueNNy/qtB8/Bff1Zkz/mp6K9Gz6HJcEwNK0SkfhtjjnC05cziRJ
         puhWnBaYk3JnW5EovKEc+MOvvUKZqnm2ZZOiZTzIyK/o/2+rI7U3DtCJ5aDnUFhSvkeQ
         K6yQ==
X-Gm-Message-State: AOAM531OKSAVGg1cxBwu5ja/OAybhgTfLA7wIGOISYDFNqXym0YH4/ac
        Ldm6dQQdy7PusS1eSYq6Vv63IO6IeG0=
X-Google-Smtp-Source: ABdhPJymjQoN0C52VKc10VS4tjjn7L47UELHSLTGj5D1bhPr/4DhYEonTodDGdtfteam3rJiXvTigw==
X-Received: by 2002:a19:8343:: with SMTP id f64mr7295714lfd.542.1608564063007;
        Mon, 21 Dec 2020 07:21:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:02 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 26/32] diff-merges: add old mnemonic counterparts to --diff-merges
Date:   Mon, 21 Dec 2020 18:19:54 +0300
Message-Id: <20201221152000.13134-27-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds --diff-merges={m|c|cc} values that match mnemonics of old
options, for those who are used to them.

Note that, say, --diff-meres=cc behaves differently than --cc, as the
latter implies -p and therefore enables diffs for all the commits,
while the former enables output of diffs for merge commits only.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index ee91ed0db409..011bfff1f135 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -60,11 +60,11 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 
 	if (!strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
-	else if (!strcmp(optarg, "separate"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
 		set_separate(revs);
-	else if (!strcmp(optarg, "combined"))
+	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		set_combined(revs);
-	else if (!strcmp(optarg, "dense-combined"))
+	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		set_dense_combined(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
-- 
2.25.1

