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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB05C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1348613F6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhDWHIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhDWHIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:08:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548FC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:07:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t22so3127037pgu.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7UUmNPJhWZTVQdnpebn74V7xU9ggH5sEAPs6dmvyjI=;
        b=nywEE+i6+rwVNUkBqrxRn/e+NX5zfeXgCQSvDae20LtAt65LcIsipeFikp76nR2FAU
         3QVHmjCdddbPrugvmnonpu2fMwPPDdIZwynBcr0mdGEWwObMXf0fCi7NnDXG96u3ltsL
         sAmyo+rt2eGVNpdISKjlWMh8SB3KoBpRMPausmKyeiakRYSTCi8qO+s9LefDsOpRnZ6/
         al3jhVw3x38iMm6WjLmfly73JilLjpCbD9mVd5yN/uyB+trWT47XSFKY0D/Zwxh2yW3u
         7tcZ77MEw3ouApGn7ea955pjbjMx0ZOpxwhkmwC9CcKTZWEwlzpSJsmujvBwateNeg0l
         IltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w7UUmNPJhWZTVQdnpebn74V7xU9ggH5sEAPs6dmvyjI=;
        b=m0bPlmodY7piZVqV5PSsu+qXWIZqEagsQJfabE/OOY6HY2CodXoISPweq8g4K7JnS3
         zyQjYI++gCG7FTs/FXHtChuF6GM4UeaKf/QYE9H9wZpdMUny6MU5OjiZ9Hs5zolfUlpu
         XGt9cC/we5NPs5Tq6KMgEois/DukPAfRxx0ZK33NGdES3cz027vPO1AYXouGkL6jwRpV
         e+9ET0Tt1SK9mMQib83Xn6GCjTn90M3sNtyfZmtCRGlywVT/N5KuIm6FYdTpjsS8tj+d
         YizqWrR6LnvKRb9eyOlt+OJqIZoY6GeB7Nhb6+Ca6WS01D+3aHq7KCqh9HZ8GkByYPMr
         e9CQ==
X-Gm-Message-State: AOAM5302rIzTQlFDwrzMcmr/DnsH08OXiiIGFpCVa5pIJbC0paLOzMee
        kARXqK+Qzpc4LP58lMgixA5zO+rqMsUaKlp9
X-Google-Smtp-Source: ABdhPJyunWECiKOfI7cg832MHxpNnPBcU5Jan8+Y+5bVRbNcCZ21DUUnQRA9O/94YNESBWkSXdqQnQ==
X-Received: by 2002:a63:ef06:: with SMTP id u6mr2470828pgh.252.1619161659393;
        Fri, 23 Apr 2021 00:07:39 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id j27sm4268230pgb.54.2021.04.23.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:07:38 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     trygveaa@gmail.com, gitster@pobox.com, pranit.bauva@gmail.com,
        tanushreetumane@gmail.com, mirucam@gmail.com,
        chriscool@tuxfamily.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] t6030: add test for git bisect skip started with --term* arguments
Date:   Fri, 23 Apr 2021 14:03:08 +0700
Message-Id: <20210423070308.85275-1-bagasdotme@gmail.com>
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

Junio suggested that I should had written this test in t6030, not in
separate script as per [2], so that I could reuse the history from
existing tests.

[2]: https://lore.kernel.org/git/xmqqa6przh08.fsf@gitster.g/

 t/t6030-bisect-porcelain.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 32bb66e1ed..c500fa893d 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -299,6 +299,18 @@ test_expect_success 'bisect skip and bisect replay' '
 	git bisect reset
 '
 
+# Bisect is started with --term-new and --term-old arguments,
+# then skip. The HEAD should be changed.
+# FIXME: Mark this test as test_expect_failure. Remove the FIXME and
+# mark as test_expect_success when this test successes (fixed bug).
+test_expect_failure '"bisect skip: bisection is started with --term*"' '
+	git bisect start --term-new=fixed --term-old=unfixed $HASH5 $HASH1 &&
+	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
+	test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
+'
+
 HASH6=
 test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
2.25.1

