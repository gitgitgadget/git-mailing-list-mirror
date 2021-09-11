Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DADC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15E60F51
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhIKS17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhIKS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 14:27:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E8C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:26:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 140so111756wma.0
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WP2SeFZpZUl2kAu1FBKsgx8U63a8Sc0YBgAzaVlMFy0=;
        b=gC0XpH8m4imp1M9m8WDfa/IIyxZJQSODeEQERQ3mY+zYh/SQllmyqN0zsED5+2zUMW
         o1MuzVJE/bnMBzNdcYqslaz5kF0HSu/uyPs0aC0lbYG/E1srZ3+JjLnFCI4QOUpP341e
         hgXhSCCJIFaipteHgVIAqSj0vGCFU6siuUVuSPxkskioF0rgXOWlNhwexImjV08aoWz8
         IprS7Ke8X+xdzSZddEPzRM4jRagKgtvWful3W55gHoMO+63zWAQlhr1IAcoOqNn3RK5V
         wlxlQ/rcnt3TdMZ+ZYsxgnujGPG5IuYJ435TizJ6YHduHDoLdiuQUkz+ZCWLtIL5SeLl
         Bk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WP2SeFZpZUl2kAu1FBKsgx8U63a8Sc0YBgAzaVlMFy0=;
        b=yCpZwmGouOfhPOYyn42gkQdDcCM9bPSQbvTFg2ACHWeqiiaGzi1ozC9wTDv/gxvoo3
         d3UUluJe0UlFpWF2WL1Kg8LA2+rJJICJb+FBWFwwXLqYbzFlurGmfOB/KFF8ozft8w1i
         AKc6G+EeXb6VM5HgrImY3MqQ8s8qHzal88vIdnUce2jaWp8x8piN/ZiA6ybHCAunYhEN
         a6vtdL6begBbWlLVR4gX1BwynkeGoeZWckGKI+y0jh0Lpfa8TCKozeYfkmfdMMauVAeg
         whVQnK9hYK+DRROAVgwlExjXMFnYkSc00ivcnZMg7l8V/dnFVHmjKu6Hsp6q1ggi+U6v
         P74g==
X-Gm-Message-State: AOAM531n6ip5j0wZziWVTL7Gxb7kZt4XA8ihMZ0U75LNchuGiJOz7JFq
        75zpsRQhBtZqervczbnRLjp3YPxHic4QPA==
X-Google-Smtp-Source: ABdhPJyPNeOjcCz0o2SDXYatbuLpyy7IhWLpHbVk3pJK2IvhR3v6BOoN5aF+BPD9bwgYSdi0Ae61AA==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr3659226wme.42.1631384803843;
        Sat, 11 Sep 2021 11:26:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm2385286wra.73.2021.09.11.11.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 11:26:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] test-tool run-command: fix flip-flop init pattern
Date:   Sat, 11 Sep 2021 20:26:41 +0200
Message-Id: <patch-v2-1.1-0ddf38b47ac-20210911T182631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
References: <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In be5d88e1128 (test-tool run-command: learn to run (parts of) the
testsuite, 2019-10-04) an init pattern was added that would use
TESTSUITE_INIT, but then promptly memset() everything back to 0. We'd
then set the "dup" on the two string lists.

Our setting of "next" to "-1" thus did nothing, we'd reset it to "0"
before using it. Let's set it to "0" instead, and trust the
"STRING_LIST_INIT_DUP" to set "strdup_strings" appropriately for us.

Note that while we compile this code, there's no in-tree user for the
"testsuite" target being modified here anymore, see the discussion at
and around <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>[1].

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  0aa4523ab6e ! 1:  0ddf38b47ac test-tool run-command: fix confusing init pattern
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-tool run-command: fix confusing init pattern
    +    test-tool run-command: fix flip-flop init pattern
     
         In be5d88e1128 (test-tool run-command: learn to run (parts of) the
         testsuite, 2019-10-04) an init pattern was added that would use
         TESTSUITE_INIT, but then promptly memset() everything back to 0. We'd
    -    then set the "dup" on the two string lists. Our setting of "next" to
    -    "-1" thus did nothing, we'd reset it to "0" before using it.
    +    then set the "dup" on the two string lists.
     
    -    Let's just use the init macro for the STRING_LIST members, we can then
    -    remove the already redundant memset().
    +    Our setting of "next" to "-1" thus did nothing, we'd reset it to "0"
    +    before using it. Let's set it to "0" instead, and trust the
    +    "STRING_LIST_INIT_DUP" to set "strdup_strings" appropriately for us.
     
         Note that while we compile this code, there's no in-tree user for the
         "testsuite" target being modified here anymore, see the discussion at
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/helper/test-run-command.c ##
    -@@ t/helper/test-run-command.c: static int task_finished(int result,
    - }
    - 
    - struct testsuite {
    --	struct string_list tests, failed;
    -+	struct string_list tests;
    -+	struct string_list failed;
    - 	int next;
    +@@ t/helper/test-run-command.c: struct testsuite {
      	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
      };
    --#define TESTSUITE_INIT \
    + #define TESTSUITE_INIT \
     -	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
    -+#define TESTSUITE_INIT { \
    -+	.tests = STRING_LIST_INIT_DUP, \
    -+	.failed = STRING_LIST_INIT_DUP, \
    -+}
    ++	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }
      
      static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
      		     void **task_cb)

 t/helper/test-run-command.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc7123..14c57365e76 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -61,7 +61,7 @@ struct testsuite {
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
 };
 #define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }
 
 static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		     void **task_cb)
@@ -142,9 +142,6 @@ static int testsuite(int argc, const char **argv)
 		OPT_END()
 	};
 
-	memset(&suite, 0, sizeof(suite));
-	suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
-
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-- 
2.33.0.995.ga5ea46173a2

