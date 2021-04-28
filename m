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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D38C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4188861040
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 11:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhD1LkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhD1LkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 07:40:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1905C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 04:39:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s20so16816639plr.13
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDzz5E3nd+O+JZ6mCLh6xkGkgnHm1oZAPfugG2WvWt4=;
        b=HCQICwvfGVqWCHqez/H42/GCsTZ+fK3NF49RVFaUj4JIHHTOX8aFfdSrptRN1ukaBY
         cSnh9hOIXEXs27eAngRQrNI0R1V8KqjVnn9qhidlfkzGF5OJB7AhkQmq2KdUuatLZQmY
         bdYpSeYC88RJx8EkFd18uVHQ+7U0u1fc+cbjhAFsc0amszCh9sQnjjGYnYWu2DnxUtjg
         2bBbwJ+S55XLWRoNgOlAoabm8O0jC1ZCwnPNqmsbM3AcPiMaitvc1nbiP0VqNICwYKCE
         UoqQbMGna0paarhHSUA+r98MEj4WvGAC2/4NJQ/G0H0o9wq7v/1yOp/XD+KeJ5AV/29+
         ghHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDzz5E3nd+O+JZ6mCLh6xkGkgnHm1oZAPfugG2WvWt4=;
        b=eEqIMpL1DfUxIiFq/ZHr/jW8bPQiH79nUBoHolhx8PHk8wuiggn1JR9Zv/FSnRHlgb
         EtIK5gzsHfJn0GO8N7S/R5NWSM3YxKHF9rZwUeV6bUgtVKUyvblLbvyhqfeUErCiY3E/
         1oCZjHGEqWGnRlV2pUgP90ze33y8PlmTj/PPyidgwha7VPjEybT8bU+YBMSvf9AJZQfv
         hbQndRsI1gzCYnBO44yYq9KJwfEQETx+elGw55H4DriI+2Y4P3y5mGklEYHczJ3SNx5s
         HBOPy4iXtJ0yvdK9JmxE9fKVC67WlX6fPt4wNJ6EDCvUXC5uRO7uIinT4/moSC19YemS
         mdfA==
X-Gm-Message-State: AOAM5334JDSV3Sceq6IF/aTA9MvcthgJ4wnWBMei39odE1lcypmHB24d
        CfyOH7vPmiOAdmwqkUqAGuHmV8hj9RcmLQ==
X-Google-Smtp-Source: ABdhPJykiSRGasAOhGQDJLeqEjQsIruxodcFVHddBd28MrOkHit5IjCBUTJCuvJBBLVkdAtS8kXHoA==
X-Received: by 2002:a17:902:d64f:b029:e7:1f02:5741 with SMTP id y15-20020a170902d64fb02900e71f025741mr28978942plh.48.1619609975794;
        Wed, 28 Apr 2021 04:39:35 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id s2sm1775937pfs.8.2021.04.28.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:39:34 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chriscool@tuxfamily.org, pranit.bauva@gmail.com,
        ramsay@ramsayjones.plus.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Subject: [PATCH v3] t6030: add test for git bisect skip started with --term* arguments
Date:   Wed, 28 Apr 2021 18:38:06 +0700
Message-Id: <20210428113805.109528-1-bagasdotme@gmail.com>
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
(not changed).

The breakage is caused by forgetting to read '.git/BISECT_TERMS' during
implementation of `'bisect skip' subcommand in C.

Let's add the test to catch the breakage. Now that the corresponding
fix had been integrated, flip the switch to test_expect_success.

Reported-by: Trygve Aaberge <trygveaa@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v2 [1]:
   * remove double quotes inside test name
   * double-quote HASH_SKIPPED_FROM and HASH_SKIPPED_TO in the
     test comparison line
   * rename test name to be simpler
   * commit message now includes proper explanation why git bisect skip
     is currently broken
   * because the fix to the breakage had just been landed on seen, flip
     the switch to test_expect_success.
   * give credit to Trygve in form of Reported-by

[1]: https://lore.kernel.org/git/20210425080508.154159-1-bagasdotme@gmail.com/

 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 32bb66e1ed..ca3a1de433 100755
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
+	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
+	test "$HASH_SKIPPED_FROM" != "$HASH_SKIPPED_TO"
+'
+
 test_expect_success 'git bisect reset cleans bisection state properly' '
 	git bisect reset &&
 	git bisect start &&

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
2.25.1

