Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D295E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 10:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfCYKjD (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:39:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYKjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so8429396wmf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdiNfz4/+wIYB2MTq5EfRQdUv4voVQqxbk5jwoS1IiY=;
        b=ZRd7Ub6cMyc9ghkmmKa4BMEr+ZnqhVYHh6vhy/W8MipBaVbyGb+RAzqTu1JY0lLPt+
         v2uG08wVLAIBikOMiKZTDF2bKYUGJGD77RxuJp3DuK61ubTjJRrx9SruWRBy+G116NQW
         dbXshAJeN2FVdAlFORf+KJ88bJeVU+R77dQ52XL0FtpRxUnoM0LaozWX8TeL1lQSHVqU
         1hO029seYdYykoC8284nQPmpVi4pCutiOUrCA1At4m2VjeNEcCRA9nrZPOPXPeysSaMY
         cJm0ZuvZ1N/DRhJqxZcRRexIB9aVXhNzRKNaMtsjC9e6AKpQmIwJ1wCIFAqTtuIJQ9c4
         /DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdiNfz4/+wIYB2MTq5EfRQdUv4voVQqxbk5jwoS1IiY=;
        b=KUuXmQT5XKihdG1j5Lg7WX8ij9ny3cUIufuXjn1q3cYNbnKDCgK0Z6m+hUmELu5md3
         D0xUgMaaZFLQccSS4TX83fSp0fr2RTiz1YoEJKKVyMcok/JwRL2Ys8HyW7YMqJBniF7j
         wFECzmg+1xYV2bDfo20Tw0GK7RZyIjhExI192r/j2I7Vsc70AieCZCV5m9bEBQuJwrry
         QYFXaJjvkIbKcNg+cIQmc39RClD+GjoozkxMnWfUyKLKuvkwv+DrOhmft+dQrU771ENX
         FzcY72UEIx34zP1gZc1M4jbx3gWuKME/1PexeSiaPKwzTP9dLjfRqvJBXtVwv3ud5dxJ
         53zA==
X-Gm-Message-State: APjAAAVoz69P32nAXbK5C3hrieucc+s7BCpZNZrCJX5awXHxgKtXcwiu
        bqWNi7Rw5kuLYi/X7CSKHVCZQ1VSoZs=
X-Google-Smtp-Source: APXvYqwqTniTpgacVBeRFpg95IUL6z1ee6thr5tk3ozrxfbsa+hENBzvgLg5Y8BUUn8vfQ/HcciA8A==
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr5006544wmh.104.1553510339521;
        Mon, 25 Mar 2019 03:38:59 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:38:58 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] progress: return early when in the background
Date:   Mon, 25 Mar 2019 11:38:41 +0100
Message-Id: <20190325103844.26749-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a git process runs in the background, it doesn't display
progress, only the final "done" line [1].  The condition to check that
are a bit too deep in the display() function, and thus it calculates
the progress percentage even when no progress will be displayed
anyway.

Restructure the display() function to return early when we are in the
background, which prevents the unnecessary progress percentae
calculation, and make the function look a bit better by losing one
level of indentation.

[1] 85cb8906f0 (progress: no progress in background, 2015-04-13)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/progress.c b/progress.c
index 02a20e7d58..b57c0dae16 100644
--- a/progress.c
+++ b/progress.c
@@ -86,28 +86,30 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 		return;
 
 	progress->last_value = n;
+
+	if (!is_foreground_fd(fileno(stderr)) && !done) {
+		progress_update = 0;
+		return;
+	}
+
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	eol = done ? done : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			if (is_foreground_fd(fileno(stderr)) || done) {
-				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
-					progress->title, percent,
-					(uintmax_t)n, (uintmax_t)progress->total,
-					tp, eol);
-				fflush(stderr);
-			}
+			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
+				progress->title, percent,
+				(uintmax_t)n, (uintmax_t)progress->total,
+				tp, eol);
+			fflush(stderr);
 			progress_update = 0;
 			return;
 		}
 	} else if (progress_update) {
-		if (is_foreground_fd(fileno(stderr)) || done) {
-			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
-				progress->title, (uintmax_t)n, tp, eol);
-			fflush(stderr);
-		}
+		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
+			progress->title, (uintmax_t)n, tp, eol);
+		fflush(stderr);
 		progress_update = 0;
 		return;
 	}
-- 
2.21.0.539.g07239c3a71.dirty

