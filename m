Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AE31F597
	for <e@80x24.org>; Tue, 24 Jul 2018 00:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeGXBkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 21:40:09 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:37920 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbeGXBkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 21:40:09 -0400
Received: by mail-yb0-f201.google.com with SMTP id g6-v6so1260635ybc.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r7UWFCR8x1cDvnlo2yhIrNKLKHGMN9GrchrgUtH9AQk=;
        b=o1XOJp4fInQQJoyFOFLocntBsFzp4HAsw5Pn6YpMPfBuBXfpjytA+DdD4lSrM5802s
         RYjPufD0mA4meAu3Q8ujgCHmTUu2kIg+ebUzmUB/nDwBx7zCmjcTKVY6uy4MXIE83xSw
         LKJeaWiarJZBhGbKRpM7p2R+7Ddue6em4DHyGEiYg1+FV0uzenbZ4byfvlXGf6XNdGas
         87rPIDWwB3fNocCi+6htw0MUjbPrXFJwjBNv1icq/ntqTF3eGMdykds6KylcnrvfT0vf
         g/39iuFT4cIjlEPCl3DU7AD8wvY+3qn0txVzl58RJnDUjuXWUTpZJ6OmF0aQs6EqLet2
         9wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r7UWFCR8x1cDvnlo2yhIrNKLKHGMN9GrchrgUtH9AQk=;
        b=iBJo7F9rzNGDxi3EBPfxXdiTwZ8beEnSVNg7zOPF7sWdYiqmBcQSckhN26bh9ncrwE
         CbNpjXTJR8tFVwALjGd7Y/liBWCW75mlY7JlZSrGI0wDehoVGUv2iwZObQkeacL48ahq
         nZRpVQLpqP6FT/ZkXxyC6t6yncA6IVtkkGYGbFAYhanH37VzkODIVEp9dqdHO8u9v2SH
         9t8IEyfnkiNg1Lp4YMfkpI5CnlXKws4gs1u2Otp/uEJIBF1Lva6ZRdrHxkiGfcUxFY5z
         f2zVY2utpeJTTbBJb31xGtpOccDPNWxm4AMgLKFCH0mlcZ9c1QbveCdcwv07ZiPoUBK+
         +r5w==
X-Gm-Message-State: AOUpUlGRPKwvT6Zksv8W8cibAQvXfTzdYDWfshTMdnBwBbBd2N/AS+SJ
        ePt866jN0qMUzR30ZRrbnAg2GeETzUchpyt4JmOGxwGpVOUsA9+PTGQhz1tAt+sk4bBcFZYYQYm
        4uLQyLqhz2qvaG12L5goYhA9MshvILLIShHnz8qgvytQ4Q4sD+p8rczBf6Z21
X-Google-Smtp-Source: AAOMgpfKrDywZw2pGHhXq2Sg5vzpPr++QB5cWNZPKtY2VXPlkA9mIvOwSTWjg5OZtKtL1zk5mKrSaUSPi6Et
X-Received: by 2002:a81:328f:: with SMTP id y137-v6mr4686081ywy.148.1532392583166;
 Mon, 23 Jul 2018 17:36:23 -0700 (PDT)
Date:   Mon, 23 Jul 2018 17:36:19 -0700
Message-Id: <20180724003619.185290-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] Documentation/diff-options: explain different diff algorithms
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a user I wondered what the diff algorithms are about. Offer at least
a basic explanation on the differences of the diff algorithms.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f466600972f..0d765482027 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -94,16 +94,34 @@ diff" algorithm internally.
 	Choose a diff algorithm. The variants are as follows:
 +
 --
-`default`, `myers`;;
-	The basic greedy diff algorithm. Currently, this is the default.
 `minimal`;;
-	Spend extra time to make sure the smallest possible diff is
-	produced.
+	A diff as produced by the basic greedy algorithm described in
+	link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations]
+`default`, `myers`;;
+	The same algorithm as `minimal`, extended with a heuristic to
+	reduce extensive searches. Currently, this is the default.
 `patience`;;
-	Use "patience diff" algorithm when generating patches.
+	Use "patience diff" algorithm when generating patches. This
+	matches the longest common subsequence of unique lines on
+	both sides, recursively. It obtained its name by the way the
+	longest subsequence is found, as that is a byproduct of the
+	patience sorting algorithm. If there are no unique lines left
+	it falls back to `myers`. Empirically this algorithm produces
+	a more readable output for code, but it does not garantuee
+	the shortest output.
 `histogram`;;
-	This algorithm extends the patience algorithm to "support
-	low-occurrence common elements".
+	This algorithm re-implements the `patience` algorithm with
+	"support of low-occurrence common elements" and only picks
+	one element of the LCS for the recursion. It is often the
+	fastest, but in cornercases (when there are many longest
+	common subsequences of the same length) it produces bad
+	results as seen in:
+
+		seq 1 100 >one
+		echo 99 > two
+		seq 1 2 98 >>two
+		git diff --no-index --histogram one two
+
 --
 +
 For instance, if you configured diff.algorithm variable to a
-- 
2.18.0.345.g5c9ce644c3-goog

