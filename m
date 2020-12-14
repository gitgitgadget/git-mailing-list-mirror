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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7669DC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B9022515
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLNXVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbgLNXVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:21:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A5C0617A7
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:36 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id k65so3559315pgk.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dABHOh5k0lYiGsBullpl2hg5cryd8LNzhtGTrRReXvQ=;
        b=n9e11sSttRhI0YVqcPx+LzBhH0XTR6CQc6MEM8OlyX+vBLcZWDMlvw3tY+aUF3YSWJ
         qVxlhK7ENMk5uPiNR1qZye2/qc0qZnl7cuVyCnHklN+d5pPL1wmkX6sVSuftYivWUrpQ
         C4N+X2ToZS5tjUSl/15GpGvh834cYW8WLL+xq0gE3KG9VuN7Iwo5KYJAuXzJvnW3E4y6
         ZUWeRXwn9XdGjHdUdreyJQIhh1jQ3wn0FuFimH5S28rPxzQ6N6NLir9VJ8zMh7IxrNbP
         YtLHChWROkCojG422HUb/2y1KLjxJ4vPtfr6G96MfTJT1GfapEnMN6M1SBKpPeDErnCN
         HjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dABHOh5k0lYiGsBullpl2hg5cryd8LNzhtGTrRReXvQ=;
        b=neWS3jNDTVHCGC3/CuGiLoq99BwAgma4w9z/oCdxy6USRL4f81BAew0y0d5bmnyuvW
         lVZTPZkUQTd6u/hXjyKfFkQMhvGrQPBvI7XcazgpSF3qraL08Bvsr7nBNjYcK7GdrDFp
         I4dct3Ee01OCIK5Q89xxRNAeFNFAhXg6ZZ9BGOqxoe1ItXM+iLriiQr68g94VUgEa6Y1
         dXdatzZwu4KG8L1sektxcioCIBKNYmZWPoQB6maQViVyxsN1wU3tLS3Cdj9qXsLEY2zn
         2sFP2AtEpo/x5LWYuBSAgD3W2K6D4dJ3jRjjAcPM6pw62ERt3AmXFXHodyzrEmJQ0oaa
         wiaw==
X-Gm-Message-State: AOAM5301TIxKfXl1RNIJgi6LTw4rWgJf+NUK66aIihhJH4W623YonNvR
        dV9+wEZXcHSI6Szbm3nJqtQiX49iNOjLzw==
X-Google-Smtp-Source: ABdhPJyPjh5LB8iZLjyAgMRAIEIYQsyBf4X2UNQrEsWFEUtxwC3g0old22snFgfX3wJ4A1nbDSs2ew==
X-Received: by 2002:a62:37c4:0:b029:197:bfa9:2078 with SMTP id e187-20020a6237c40000b0290197bfa92078mr25927699pfa.15.1607988035607;
        Mon, 14 Dec 2020 15:20:35 -0800 (PST)
Received: from localhost.localdomain ([27.56.186.8])
        by smtp.gmail.com with ESMTPSA id z10sm21282983pfr.204.2020.12.14.15.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:20:35 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v3 3/3] t7400: add test to check 'submodule add' for tracked paths
Date:   Tue, 15 Dec 2020 04:49:39 +0530
Message-Id: <20201214231939.644175-4-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214231939.644175-1-periperidip@gmail.com>
References: <20201214231939.644175-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test to check if 'git submodule add' works on paths which are
tracked by Git.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 t/t7400-submodule-basic.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4ab8298385..d9317192e0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -193,6 +193,17 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 	)
 '
 
+test_expect_success 'submodule add to path with tracked contents fails' '
+	(
+		cd addtest-ignore &&
+		mkdir track &&
+		git add -f track &&
+		git commit -m "add tracked path" &&
+		! git submodule add "$submodurl" submod >output 2>&1 &&
+		test_file_not_empty output
+	)
+'
+
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-- 
2.25.1

