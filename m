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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C5C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF83561431
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhD2H0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhD2HZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:25:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A664C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:25:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h11so5853698pfn.0
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uyl0+FDG3arIKQnhAmda7kJG18b9LFMV7BDfqnTgs4E=;
        b=emOA9moSnYXaPrnMQHM8xG2L8U0MUtEBjQjWyOVuNmoSLDGAVppVrNVHeozIFQwSxe
         XOY9MkuOKfHJRTcbhYYRvd2r27GYbeUjiA0Cod/G4hKSJJcwb40DInPrYahMoE1mt/eP
         dLvTCcHbnVlNSy2nIYc4f4U9G2c24x9GkzQGCSomhAj1cLUUHW/3cfcZaILLrGAwYhqe
         D9wg0pLdNwYC6Vfi2Iuaqwly0hHB3XWn9qdx0vsXflbEwL7NWdGbSpEtxNAW4A7y5Ovl
         RmCknThUjg3uwoucnCQ6bMhk2IMzImKE5yWDYj7zrW/1k1CuKoDQFs3M8XiOC7joKBux
         vUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uyl0+FDG3arIKQnhAmda7kJG18b9LFMV7BDfqnTgs4E=;
        b=TN8W7oKt+kjDdiAApiKjQN+aGVcmSIUt9GG1B1WTS4ou2DZNDCvtix/PdFItaxzbp8
         DsUGeaCEgyzRqMcJamwuIsXrlkWpoa7Gb57j3ishdw4w5PhV/uA/xeanLGOMeyfxBw0J
         p9AbCXtgtqr5nIlxkGhvajKqVkaGd29KzRZNSbyBxEz8uUdBkHU/83dd6K9V8eHq8VTW
         7izV7SmIl+AW8J+lxuMifGMevux1cQ4fAGH8xXbAQKvMaXmPBb2GrX3uCFr7aDr21fxZ
         TWys8m8PhgMrNME2QrS1bzpsUATv9vGqfGMhNAujoNXY0aLZVU6//ApbwFH4nE4gZa+e
         fxtg==
X-Gm-Message-State: AOAM530Xe92TYebdVUlzAC3OHmKNm/huRoT5bBoJqUF3/jd+CVIegple
        Yg3NMe1XbQaE0/geLC2flJb0KkQpAdIlYYU0
X-Google-Smtp-Source: ABdhPJx7hVJHg9/wBX3aJUwolkuWTthA1C0cYEQvq1PHhcNiJHRczENeBZQBMIR2mD1Yin1KlehBKQ==
X-Received: by 2002:a63:4550:: with SMTP id u16mr30832704pgk.440.1619681112771;
        Thu, 29 Apr 2021 00:25:12 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id e1sm1645913pfi.175.2021.04.29.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:25:08 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Subject: [PATCH v4] t6030: add test for git bisect skip started with --term* arguments
Date:   Thu, 29 Apr 2021 14:24:51 +0700
Message-Id: <20210429072451.38422-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trygve Aaberge reported git bisect breakage when the bisection
is started with --term* arguments (--term-new and --term-old).

For example, suppose that we have repository with 10 commits, and we
start the bisection from HEAD to first commit (HEAD~9) with:

  $ git bisect start --term-new=fixed --term-old=unfixed HEAD HEAD~9

The bisection then stopped at HEAD~5 (fifth commit), and we choose
to skip (git bisect skip). The HEAD should now at HEAD~4 (sixth commit).
In the breakage, however, the HEAD after skipping stayed at HEAD~5
(not changed). The breakage is caused by forgetting to read '.git/BISECT_TERMS' during implementation of `'bisect skip' subcommand in C.

The fix is in commit 002241336f (bisect--helper: use BISECT_TERMS in
'bisect skip' command, 2021-04-25). To verify it fixes the breakage, add
the test.

Reported-by: Trygve Aaberge <trygveaa@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
  Changes from v3 [1]:
    * Lowercase local name variable hash_skipped_from and hash_skipped_to.
      Christian Couder and Eric Sunshine argued that uppercase local
      variable names make the reader confused them with global
      variables.
    * Mention breakage fix commit 002241336f in the commit message.

  [1]:
https://lore.kernel.org/git/20210428113805.109528-1-bagasdotme@gmail.com/

 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 32bb66e1ed..a1baf4e451 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -922,6 +922,17 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+# Bisect is started with --term-new and --term-old arguments,
+# then skip. The HEAD should be changed.
+test_expect_success 'bisect skip works with --term*' '
+	git bisect reset &&
+	git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
+	hash_skipped_from=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	hash_skipped_to=$(git rev-parse --verify HEAD) &&
+	test "$hash_skipped_from" != "$hash_skipped_to"
+'
+
 test_expect_success 'git bisect reset cleans bisection state properly' '
 	git bisect reset &&
 	git bisect start &&

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
2.25.1

