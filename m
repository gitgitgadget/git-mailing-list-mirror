Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F626C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFAB2087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSe9CgDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIPCJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgIPCJU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 22:09:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E87C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so4951236qtq.10
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9eKDJy4hWkm3jAbJQ2aVJclDrVaJIewda3Pxwtaktg=;
        b=pSe9CgDt4Pb6T7jZts+K266rFCHYhJiOvjLzHgbhV9DlJbbTL/Q6JSdFitUHcv6Lkf
         yeYzZjQ2qwIj+pUsnPieP4OImFn0Tw5FLNdxJsu7iImSU2bCqZEsrrExGK6pVtvJEFOi
         d0uI15srx4Gw/NJ+KUBI4Y7+GaDDX5gKBiw8BRWZFrnnz8hi3cbZLCFROqfHB5iDRXfU
         btnf3CgNgaQgUuyX2oCE34KE0PWf4ItiNM+LU8b8EgHPzqqoKxEk/XsD109MX19tOkJS
         wYrSbJS+zTolcF/gA345CrxASw5yVHmY21Ll+7a8w//g0r6zDEUfGvJxz5igb6TH66fd
         p7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9eKDJy4hWkm3jAbJQ2aVJclDrVaJIewda3Pxwtaktg=;
        b=oMEwcyRq/4DfPubSV7+hjsmjt9elAU1XDfc6tqZklmSemccv5NX/rMqQE67AVwDIJZ
         2H/xlowlw83/jFDX150P0P0SbNcJ0g5k+T7PK8Gnd6GBAZrAzBvrptlFoqQ7/dWSjf1T
         Liao4I5MbB49OcMtj8ab7YVnMjiN0I39c5+PcIFgSp+1pdNuYaQPKVk3biNmuHGgYj4J
         qLirEWt1XfxQ6lLWxr6YhgNcqw9PmKVNofLwE69WQKt+Uuq0dTbjN08cCCbSrf4Eta1u
         yd7Hlp70Wr3HRuwr5jau7tI57dZ3Crk5J0a2QNDj0hJvLHjO6YtJicqltE9nCwRwXEgT
         ngEQ==
X-Gm-Message-State: AOAM533/Gm+f1659eHEuBHaJdkxy1Xr7bWwKRKk+vY1rwy7/83L9tM98
        i0fIr9iCijk+vrl2q7MQKhLlOWqAKIzTqmtz
X-Google-Smtp-Source: ABdhPJwdxRHkSm7ulFuFWu/ftiqwdIpl70Kn6hagKb6Zb/KgKYVuVZ2hH7GuRnX6KSOOrFfB0uP14Q==
X-Received: by 2002:ac8:17d9:: with SMTP id r25mr15860424qtk.107.1600222158886;
        Tue, 15 Sep 2020 19:09:18 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id k52sm19380373qtc.56.2020.09.15.19.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:09:18 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 1/3] t3201: test multiple branch filter combinations
Date:   Tue, 15 Sep 2020 22:08:38 -0400
Message-Id: <20200916020840.84892-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200916020840.84892-1-alipman88@gmail.com>
References: <20200913193140.66906-1-alipman88@gmail.com>
 <20200916020840.84892-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests covering the behavior of passing multiple contains/no-contains
filters to git branch, e.g.:

$ git branch --contains feature_a --contains feature_b
$ git branch --no-contains feature_a --no-contains feature_b

When passed more than one contains (or no-contains) filter, the tips of
the branches returned must be reachable from any of the contains commits
and from none of the the no-contains commits.

This logic is useful to describe prior to enabling multiple
merged/no-merged filters, so that future tests will demonstrate
consistent behavior between merged/no-merged and contains/no-contains
filters.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 t/t3201-branch-contains.sh | 47 +++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 40251c9f8f..3cb9dc6cca 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -171,6 +171,42 @@ test_expect_success 'Assert that --contains only works on commits, not trees & b
 	test_must_fail git branch --no-contains $blob
 '
 
+test_expect_success 'multiple branch --contains' '
+	git checkout -b side2 master &&
+	>feature &&
+	git add feature &&
+	git commit -m "add feature" &&
+	git checkout -b next master &&
+	git merge side &&
+	git branch --contains side --contains side2 >actual &&
+	cat >expect <<-\EOF &&
+	* next
+	  side
+	  side2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple branch --no-contains' '
+	git branch --no-contains side --no-contains side2 >actual &&
+	cat >expect <<-\EOF &&
+	  master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --contains combined with --no-contains' '
+	git checkout -b seen master &&
+	git merge side &&
+	git merge side2 &&
+	git branch --contains side --no-contains side2 >actual &&
+	cat >expect <<-\EOF &&
+	  next
+	  side
+	EOF
+	test_cmp expect actual
+'
+
 # We want to set up a case where the walk for the tracking info
 # of one branch crosses the tip of another branch (and make sure
 # that the latter walk does not mess up our flag to see if it was
@@ -200,15 +236,4 @@ test_expect_success 'branch --merged with --verbose' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'branch --contains combined with --no-contains' '
-	git branch --contains zzz --no-contains topic >actual &&
-	cat >expect <<-\EOF &&
-	  master
-	  side
-	  zzz
-	EOF
-	test_cmp expect actual
-
-'
-
 test_done
-- 
2.24.3 (Apple Git-128)

