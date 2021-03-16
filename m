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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA0CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE875650DD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhCPEF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCPEFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:05:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB593C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so6730935wrt.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=nimEsjQUD0wHzWvWbNPkigdvN0Sas4NuwdOKWK8ZDAimW5a27OUfCVCyvMbCZvsKDl
         nOZIUshgMfaLDiBLhHclg9jHZfhywn5GPD85qvzN+zXs0080AQ2bJ0KBGPM1UUu/T88j
         sjJbuplgjaOBTGEkCfEmDOfJaoXk2eIvaXMpYyvec6LauTQBZEy7PjeWUBni9kJbzANu
         IPJkqPLIQ7odOjYxbG2v7FdGuoQ2rKdJGVTfc7TBY1QkqhDNxqvKcjO9dR9o/MHFsmMG
         G6+vJW5tWBOXnplndu7YBHjEmf3E0oaWfEI9SM10y6qlkZJ9KydZMWi+qTPlXPoaGaG0
         3bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=YmpBUa+YDz9LW4p1VrDCuFjIQv5ofWd11gsUIAaVxqwvdJOSl5ImCZd0uA/pVZHa8u
         cfNCTbqLpXUrylxQoEaTNP5GNcMTxSuADkqmzmByBSkALtXIYenAVXaBjCBo+2UxxDyr
         ml/e4s3KUx3Nb9MlZgnG9UHJ1jsm8DQcTsiBASYiWfZPVjyQ8MRJ+e1ryeHbWJxhVo3O
         JESxCCGgpE+hMqPn4DaKVmsUHmWr738KZHyR4eDXIcnJz3PGpR2x0HuI9ybor3TiNM21
         1e9t0oMybjUfsmLfOHfSnZTFr5gH7cOax473EcaYiw/kIo9rXPdSHpsuwdAZfYhXqv3G
         pTzg==
X-Gm-Message-State: AOAM533dLkl4Zy0DJbb4u1WZRxmbVrVyfJI13XeLZaoMw5VnVBn4ibD0
        Q/uVDvGdjG6bUcgWYe99SUE9WyGZAWE=
X-Google-Smtp-Source: ABdhPJwPRGkXdQpXNYc1432dCWPEQa9Qq8aMZxZ0NSMZEfyknWi7omaInRDjFZzaHMSXKs9of0jAwg==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr2576734wrd.132.1615867505500;
        Mon, 15 Mar 2021 21:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm20404237wru.95.2021.03.15.21.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:05:05 -0700 (PDT)
Message-Id: <0d41038fad91f8e61eaff87884dd45e5c7d9275a.1615867503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.git.1615867503.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 04:05:02 +0000
Subject: [PATCH 2/2] t6423: mark remaining expected failure under merge-ort as
 such
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When we started on merge-ort, thousands of tests failed when run with
the GIT_TEST_MERGE_ALGORITHM=ort flag; with so many, it didn't make
sense to flip all their test expectations.  The ones in t6409, t6418,
and the submodule tests are being handled by an independent in-flight
topic ("Complete merge-ort implemenation...almost").  The ones in
t6423 were left out of the other series because other ongoing series
that this commit depends upon were addressing those.  Now that we only
have one remaining test failure in t6423, let's mark it as such.

This remaining test will be fixed by a future optimization series, but
since merge-recursive doesn't pass this test either, passing it is not
necessary for declaring merge-ort ready for general use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4c568050dd27..4c3d0b95dc5c 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4797,7 +4797,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
-- 
gitgitgadget
