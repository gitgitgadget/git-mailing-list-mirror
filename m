Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D74C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6A260724
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhDYIHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYIHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 04:07:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E6C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:06:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u11so21624198pjr.0
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QIYIFfu3JHIm1StgzkK77KvVgGoHpCShj5l1WD6jcs=;
        b=WeOwFnka2fspOG/9mHeXAsu8MXLoERfehGpH3nfOulYyF78XaDaCsWXJebQVII1efy
         5IJ8m4o79PVqHzW6HGIu+3IYzYT4Mf5PyBdb1F0mf0Ni+RReWuabp/6sRD1hpHOSxYh5
         6U86X0HmFXV1w258KwfYcVQlFR2o90MN6pYqV9DiQZVN29sEC9+IX6KTA0Ram7yooOxu
         WEQYUyszVTS8fpACOmp7f85agccafEk62oRXZnifsDZv1pcfPx9A6skLw9O0w39RiLbN
         BnUMHvE3Aau4+YPW1GnQEeY8ld/1fID3JBdj7GC5LMjauxhO+HBAMQQ9DkBqy+2aE4gU
         FqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QIYIFfu3JHIm1StgzkK77KvVgGoHpCShj5l1WD6jcs=;
        b=sqgUlRWt32waP6h0yVdzV2yGTYYukBzs7r8hUPJnjEn2tkz6HCv1775ewGB66cRpsZ
         sorxx0lC1zlDThE+dUw51rHIqyDbFSIVRt5ejbtINwGmZhMGnARUXcPMcK7MbyE9SFTI
         /jN+1SVGF8YAsk51IHCgZWRcptS4gn1aUZbdHCjJ3w8pHT1zdfxcBeteqUR1Up+FArqG
         uhaa+dkjCAPphX1+eZ+h3Kg2ooH5+JDiJnpIStqDYh0uMQetObR2AqkvK4bQD8ZMnsdx
         z5YkhqXGhNTnjJt3yDzr/9XXBd4sRMMhgRF0d6Cm6HB1MBzsMwADnPtfCuzwD1LEZZ+q
         12EA==
X-Gm-Message-State: AOAM530D6nNfT152CGllCzDvZP+dCXlhviUjtvFw8tetzK1Q/cOwnyhJ
        1UGjmWCbb1f9uMwSqLc5xjePRKkle5W6AQ==
X-Google-Smtp-Source: ABdhPJxoo7OO+GcyT5ZaWxFhq8UllJxJpjnKYj7sxLKsUHfwEfpqf1dlEILm8IpdwZ4IvSZNJdhJxQ==
X-Received: by 2002:a17:902:d50c:b029:ed:1bda:a029 with SMTP id b12-20020a170902d50cb02900ed1bdaa029mr1175476plg.8.1619338013261;
        Sun, 25 Apr 2021 01:06:53 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id 123sm8480308pfx.180.2021.04.25.01.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 01:06:52 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chriscool@tuxfamily.org, pranit.bauva@gmail.com,
        ramsay@ramsayjones.plus.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] t6030: add test for git bisect skip started with --term* arguments
Date:   Sun, 25 Apr 2021 15:05:09 +0700
Message-Id: <20210425080508.154159-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trygve Aaberge reported [1] git bisect breakage when the bisection
is started with --term* arguments (--term-new and --term-old). In that
case, skipping with `git bisect skip` should cause HEAD to be changed,
but actually the HEAD stayed same after skipping.

Let's add the test to catch the breakage. Because there isn't any fixes
yet, mark the test as test_expect_failure.

[1]: https://lore.kernel.org/git/20210418151459.GC10839@aaberge.net/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes from v1 [1]:

   * Move the test to the the end of test script (test 74).
     v1 placed the test as test 26, and when I run the script, there
     are 9 more failed tests rather than just one (because such tests
     depended on previous ones). Now the test is placed together with
     similar tests (git bisect with --terms*).
   * Begin the test with git bisect reset, as with other nearby tests.

 [1]: https://lore.kernel.org/git/20210423070308.85275-1-bagasdotme@gmail.com/

 t/t6030-bisect-porcelain.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 32bb66e1ed..b1b847ebbc 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -922,6 +922,19 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+# Bisect is started with --term-new and --term-old arguments,
+# then skip. The HEAD should be changed.
+# FIXME: Mark this test as test_expect_failure. Remove the FIXME and
+# mark as test_expect_success when this test successes (fixed bug).
+test_expect_failure '"bisect skip: bisection is started with --term*"' '
+	git bisect reset &&
+	git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
+	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
+	test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
+'
+
 test_expect_success 'git bisect reset cleans bisection state properly' '
 	git bisect reset &&
 	git bisect start &&

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
2.25.1

