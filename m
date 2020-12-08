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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA1C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE29239EF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgLHA20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:25 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB46C0611CF
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:14 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id w9so3632005ooh.13
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32vlhwz0aXXfZWItJvhvqAt2z1EPs0fSK/cBA/4mVks=;
        b=EhmLsuYR3gEmycMKiV5g10wWJ6QS+dsrwgWHd8ZulfFKxuVkITDi9LnhkUMJX+RsAv
         U9LNybItlL5RJekn8d7a94AgOAMnshz7B8y90TotWCLjhlRx7FQqdfg3SPHuNlQHI4dn
         RH+zYowPfkrDNlvdZAZTF2xkT6u0ul+AGwc4Kc6v4ncdcZc8ZC+BZ5kgnml/53FKSrO2
         xKurAdyDLtUAo+nt0eLPnxc9KHdz3cp0Nf2Tq6TfA0h+bg83C3CCCTvo+tpeOUvmoQGD
         b89YcjVwD4ZkjGkzxIxz6smcv4aVxmjHndQdgj5lmJVMtM4/UpGH3biAbvsMgIoXIWDJ
         q4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32vlhwz0aXXfZWItJvhvqAt2z1EPs0fSK/cBA/4mVks=;
        b=cJrr4ogHV8GYQY4PgNZPzzJT5IjDT43Eg4Q8QJR6cxWZNoxcERPmk7BYa9qHmid0F6
         K52wTZH+aFXjARvLINRd9XNKE0/R/bYO+zfln/6M5vzgh6KLBZQXepGRC38b9ReC7VXI
         li4sEEDm8DXOOU6DqQtkLTSH0hnRLgeMbz10cN7djL3xtNRygrb9DjsjYNiHdVOaGvQ1
         VMa7Jc/vBDI791wG+hIgO49EcKc+eCEWfwpPbrGiLSL2mV9owye6aWXnUpvtt0Rt9OTL
         AtYbNocr8Dez/dZVFv5ktxRmmM3HWEPiCOZ3+cF/WmU/KVKNjdMY+9fJfS5SF7cAaWNZ
         P/GA==
X-Gm-Message-State: AOAM530NuMNjFmXQ/Ws5END090bu3svx0inMlFVMA2aKPYj0/vQ/OXfL
        L5z0wPJgoE3ibONdTgZgG//N2m8AgU+QQWlh
X-Google-Smtp-Source: ABdhPJwbgL8dyulDnto0F6Phgie7i8pzDZJYKRBqbtt5jLZS+D1rnIr/CPJyWwbnc9duQZLaXr5UWw==
X-Received: by 2002:a4a:8606:: with SMTP id v6mr14457893ooh.37.1607387233355;
        Mon, 07 Dec 2020 16:27:13 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k10sm3023244otn.71.2020.12.07.16.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:12 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 14/19] test: pull-options: revert unnecessary changes
Date:   Mon,  7 Dec 2020 18:26:43 -0600
Message-Id: <20201208002648.1370414-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d18c950a69 (pull: warn if the user didn't say whether to
rebase or to merge, 2020-03-09) changed a number of tests in t5521
and added some new tests in t7601, but it was not explained why the
changes in t5521 were made.

The reason seems to be to silence the warnings while running the tests,
but we want to see the warnings if they happen.

Cc: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5521-pull-options.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..1a4fe2583a 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q --no-rebase' '
+test_expect_success 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
-	git pull -q --no-rebase "../parent" >out 2>err &&
+	git pull -q "../parent" >out 2>err &&
 	test_must_be_empty err &&
 	test_must_be_empty out)
 '
@@ -30,10 +30,10 @@ test_expect_success 'git pull -q --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull --no-rebase' '
+test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-	git pull --no-rebase "../parent" >out 2>err &&
+	git pull "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -46,10 +46,10 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v --no-rebase' '
+test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
-	git pull -v --no-rebase "../parent" >out 2>err &&
+	git pull -v "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -62,25 +62,25 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q --no-rebase' '
+test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-	git pull -v -q --no-rebase "../parent" >out 2>err &&
+	git pull -v -q "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v --no-rebase' '
+test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
-	git pull -q -v --no-rebase "../parent" >out 2>err &&
+	git pull -q -v "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
-	test_must_fail git pull --no-rebase --cleanup invalid "../parent" >out 2>err &&
+	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
-- 
2.29.2

