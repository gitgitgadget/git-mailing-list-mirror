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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221BF60FDA
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhIIO2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbhIIO20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:28:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3FC0251B0
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 06:09:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so2588176edw.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZjG0t4UKgMchuFKgrlMtmGHVRJff/EBFljSK152bPI=;
        b=X1bFoB0rEO9KlVzFFJDxPKSttWrVib1804Jut3LMiKeYl4NZdBs6z5HCeEFsbHHHNb
         pFoQXyZgXDaXzfupFzw4iAKkIpgJSyu+dnq5UhLgbYa1HyIr/188MPltjrZwMVv2VtUY
         Gbk05Apx95RL4RY5BNsnrP61XX1Il9cRHXHPdFBt5i2MMHQLof5EfXgYPCsvwoSO6tDN
         zfDuIuewOs3ydZi7X48KX3o5Ll1rg8dRKYmq4QhgghMFmRhZCO4sG8mAXeyDvEPIzqpH
         Q18cpAYRh0TGZufKdO1VjZ4Rjk8Q9JZH9ySThIqno/uEoBwrz972jXbgp7rainzrFAbc
         M1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZjG0t4UKgMchuFKgrlMtmGHVRJff/EBFljSK152bPI=;
        b=F0md+/mZuPcpZR5qzHrNH9E7iJld0un+5fKpbFxyNkKU52vhxtmCmi+DY74mDuSuwS
         ihEQlBxBknAET3w+gzZDq+OuAoWwlyCWGVW80R714YsgIfv7MEcyYgrGwvrIg5ihxjfW
         mjYEgz2U+Xo9FSuF/Yx4bQ0vKAp7EPsVq4t+M9kgOgmhIwooqdD3k6AYsKOujHVhsubw
         WC5kTOaF3nrPp5btkp0xGWBPEsztcgjPkGY02UdUxum69NjpLQOAl9igioqRUcLEY3xb
         xgcl9U3dldR69LfVzPiz3gY7ORqQmL+8MK8OZ+JoTdEkPTSgVe+OwSYkIHsv+Ii+qBGR
         B9cA==
X-Gm-Message-State: AOAM531m1UwdhOgi4UURgRqq97qE7w6mbZOkMOFwd2QPI9nkxC7xxFx/
        iu87MAP7gCL/+Mnf7OZrtVeVdotvxsa9Eg==
X-Google-Smtp-Source: ABdhPJyUKRIorJX3ngyoMwKFj97RaqX+qsmBaF+Ee3zUGyUePkK+PtEbTUgB/3jUkeT1+aqSYjKSvg==
X-Received: by 2002:a50:9e02:: with SMTP id z2mr3023536ede.249.1631192994711;
        Thu, 09 Sep 2021 06:09:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm1055858eds.83.2021.09.09.06.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:09:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-tool run-command: fix confusing init pattern
Date:   Thu,  9 Sep 2021 15:09:51 +0200
Message-Id: <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In be5d88e1128 (test-tool run-command: learn to run (parts of) the
testsuite, 2019-10-04) an init pattern was added that would use
TESTSUITE_INIT, but then promptly memset() everything back to 0. We'd
then set the "dup" on the two string lists. Our setting of "next" to
"-1" thus did nothing, we'd reset it to "0" before using it.

Let's just use the init macro for the STRING_LIST members, we can then
remove the already redundant memset().

Note that while we compile this code, there's no in-tree user for the
"testsuite" target being modified here anymore, see the discussion at
and around <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>[1].

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This patch is the immediate reason for why I submitted
https://lore.kernel.org/git/patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com/,
since Johannes would prefer to keep it let's fix this init pattern.

 t/helper/test-run-command.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc7123..8e42516bdc1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -56,12 +56,15 @@ static int task_finished(int result,
 }
 
 struct testsuite {
-	struct string_list tests, failed;
+	struct string_list tests;
+	struct string_list failed;
 	int next;
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
 };
-#define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
+#define TESTSUITE_INIT { \
+	.tests = STRING_LIST_INIT_DUP, \
+	.failed = STRING_LIST_INIT_DUP, \
+}
 
 static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		     void **task_cb)
@@ -142,9 +145,6 @@ static int testsuite(int argc, const char **argv)
 		OPT_END()
 	};
 
-	memset(&suite, 0, sizeof(suite));
-	suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
-
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-- 
2.33.0.867.g88ec4638586

