Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1DC47247
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465A7206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iFC4IeAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEFAH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgEFAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E75C061A10
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id y6so70333pjc.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHhSGMGzCi6ysuU18iYcv3qCsk++2Ddth7iq5fAYkqc=;
        b=iFC4IeAVco4OPh7JDyQeWBAZ0EHZlHzJfYHeOaVQIHaqSsUlfVOyc2efllKnUm6nd2
         XBdDuL8ZrfMDFSF4KKEjHrqIL5DaiXkmkqmrGZaL5H6ZUbC+++dYL+VxXZ4DIo6jC8ew
         f27hCwIsSk9Q8q6LM6dGeWp03ojXOepnykYDszm1sPwqhBqS4VvSjVcDeHqiVQ2WcGx4
         Au8t5zG75aZbzcxy+BY7DK6Hyqj90DHl9X5SU83LyILMSz0/d4aAnIfT7Bv1J8TGWksF
         gpbCjSzCn02kBy/Kwv0r+7ZPcsxynXO7x7pJDndlawoBsKYJfNlgHOMwr2AqU9k8Oc1C
         tKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHhSGMGzCi6ysuU18iYcv3qCsk++2Ddth7iq5fAYkqc=;
        b=HmUnUbZjOFEg+x/MKnqxG2xAB7Lo+Q3U51d0B9ZdfXe+ADyuekR4FVg0tb4Lf90nFc
         9lkGStixCJNW6cmfyj7wNEFH0HSedNQhKj0h2tkjIoaWm0NjsaRLAqHJ4+IXbyAjJ/lg
         lDpgTf3EMnZfXvNzlzuj8x4BUifu0xb76uR7Kp5L7cBHy1CFsGbQBiT5ljntma56ka/n
         elodEPXHkni7FM0ZTdBkukFFl1bHJ99/x6qMF0EvW+l7Klz+NsW/xDHudrTSHffnqZpk
         94bQ0SCF4oOjlk2qOyzYK05GHcvJxCUDQf8ZoLZZvlpcBlKf/NpZ+pJpLuMRKQGeXMf0
         4fxg==
X-Gm-Message-State: AGi0PuZyXmSvznAGeec0Vl7UnWZdj4u4Rk3T/WisdnzIwG3HuUUWSXTi
        YdtfW2stPaZ0XZs2fca4lJFYEiNuJGY=
X-Google-Smtp-Source: APiQypJs661ROWPLBEjvnCtBAOzvCjjMtArMSZfUjGQEMdjAYpXYa4pBUi6IxMp6cPBULDJlrfJ0og==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr5059950ple.271.1588723676662;
        Tue, 05 May 2020 17:07:56 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o21sm2900251pjr.37.2020.05.05.17.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:56 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 7/8] t5318: reorder test below 'graph_read_expect'
Message-ID: <e393b16097dfdf9a136f6726486561074f5f3b1c.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the subsequent commit, we will introduce a dependency on
'graph_read_expect' from t5318.7. Preemptively move it below
'graph_read_expect()'s definition so that the test can call it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 39e2918a32..89020d3d44 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -42,15 +42,6 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-test_expect_success 'exit with correct error on bad input to --stdin-commits' '
-	cd "$TRASH_DIRECTORY/full" &&
-	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
-	# valid tree OID, but not a commit OID
-	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "invalid commit object id" stderr
-'
-
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
@@ -91,6 +82,15 @@ graph_read_expect() {
 	test_cmp expect output
 }
 
+test_expect_success 'exit with correct error on bad input to --stdin-commits' '
+	cd "$TRASH_DIRECTORY/full" &&
+	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
+	# valid tree OID, but not a commit OID
+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "invalid commit object id" stderr
+'
+
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-- 
2.26.0.113.ge9739cdccc

