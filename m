Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0911F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeGSXEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:04:52 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:41301 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGSXEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:04:52 -0400
Received: by mail-yw0-f201.google.com with SMTP id c204-v6so5184884ywa.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WwEXJhUMUccgT51nsSDrT9Jj1Fy2iOhxiNkEgW4VMeE=;
        b=mVqp/+DD2mW+ITHbZGDwMPgimPZO40xj6t0tGG32yTwIUbjCNJuODaZABsTQQsahfN
         y31lG5FPhgovU2zPeTs+/Gc8fu4+i8YjP5F1QukdFl0VVCoAZdQ91zqwVkZ41l6DpTPB
         V/qD7n79mmYL7Nj5ktWLMKR6hnHxEucJnO/gDszn1A8KBbztO4XBfwvsAHudBEY3u+e3
         jUU1H4dTmTVJpn1GPyBUQHyaBSx63jweWqvFeo0zovSAn0EPD0RLePxe1Q/93l/YT7c0
         Sm/QG3MYDppT6xKCP2ti01iIdJ5uNslQtov+HQ9Q+xs/uAyFZT/VYmnj4NwQ/nFtGXy6
         JPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WwEXJhUMUccgT51nsSDrT9Jj1Fy2iOhxiNkEgW4VMeE=;
        b=CWzSXJeRgBWo+WWa5EvCre+rD8YOMYfdjn/+Fpl7JSmSkhNVpFTLQ+QsbQrS94IDOA
         c4Gu27D6C2jiEnzraCYu7atfA18f4C9+Ta+0XnW5AI6NgMltoaBPhVcDnPWVhcvEeqEx
         c0nWL+g3xbHjz9uUVhlVRf5hbPjcCNyakvdocNnqMXcaqoAGf8SERMz3Ow0s7eeBlKOQ
         kLhMszF7baHOAXFfz7aseGZCdiFWcjAzHFsAd309+N/Y+lcE/vxKSa5MwftUXInEWsPZ
         CqCkIT/1uAxV9Og+XxIOhz8Dv56XDiCB7zcTUxQaC4Y/NiOHg4RRB4Yp5Y4qbkMnBdjX
         gKOg==
X-Gm-Message-State: AOUpUlGroT16HRBJanJozFVyHJeTvbkPMx4H0pkioB2HSu5cwjOhA5Bf
        lJ78TccTZ7JlpocgPUXXQo3tDDQ85MjygMwhgCKel639HRb8CftXXD0UUrMWfNQ4NQaGmJ4EUat
        6eeQEzDdxqnhFBakcVaQUXnlQ4laLOytHTZw/XWPmpVgE3m9d//aMtx2XKbsk
X-Google-Smtp-Source: AAOMgpeBhYg9TcqyBWtVGXkbM1HXbEbjC6V4Bti/bz/JWR+nwCJLTwkSdmdrdBiNE1ZEGGMD/Qoag+WxTtGO
MIME-Version: 1.0
X-Received: by 2002:a81:278c:: with SMTP id n134-v6mr3719273ywn.214.1532038785616;
 Thu, 19 Jul 2018 15:19:45 -0700 (PDT)
Date:   Thu, 19 Jul 2018 15:19:42 -0700
In-Reply-To: <20180719185620.124768-4-sbeller@google.com>
Message-Id: <20180719221942.179565-1-sbeller@google.com>
References: <20180719185620.124768-4-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] xdiff/histogram: remove tail recursion
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running the same reproduction script as the previous patch,
it turns out the stack is too small, which can be easily avoided.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xhistogram.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index fc2d3cd95d9..ec85f5992bd 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,7 +318,9 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 {
 	struct region lcs;
 	int lcs_found;
-	int result = -1;
+	int result;
+redo:
+	result = -1;
 
 	if (count1 <= 0 && count2 <= 0)
 		return 0;
@@ -355,11 +357,17 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 						line2, lcs.begin2 - line2);
 			if (result)
 				goto out;
-			result = histogram_diff(xpp, env,
-						lcs.end1 + 1, LINE_END(1) - lcs.end1,
-						lcs.end2 + 1, LINE_END(2) - lcs.end2);
-			if (result)
-				goto out;
+			/*
+			 * result = histogram_diff(xpp, env,
+			 *            lcs.end1 + 1, LINE_END(1) - lcs.end1,
+			 *            lcs.end2 + 1, LINE_END(2) - lcs.end2);
+			 * but let's optimize tail recursion ourself:
+			*/
+			count1 = LINE_END(1) - lcs.end1;
+			line1 = lcs.end1 + 1;
+			count2 = LINE_END(2) - lcs.end2;
+			line2 = lcs.end2 + 1;
+			goto redo;
 		}
 	}
 out:
-- 
2.18.0.233.g985f88cf7e-goog

