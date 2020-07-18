Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C45FC433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 09:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5366020691
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 09:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyqmbwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGRJtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRJtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 05:49:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FCC0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 02:49:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so15366997lji.9
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuT9g02S4z9WBKS7UTxAHOkYxmWOMk5mgICtGD0Mq3Q=;
        b=LeyqmbwCQoa/wWfI/WjoFquzldXrLe68oDx4DIr11XFbIVNB+J+pPpfFE3ixcAB7Bc
         gMVq2MuA8nRL11CM+VVmX42uDQQifFBSSU2KPcxulrcQ72alwTLQoOTKaiGzp9fmSLGu
         hy8j1l2J68s8FtfQ95oFNSKKWMFdmOBRvbljcVrNmw5IobAteg+vCbwFCIY91utKaNPG
         EABJGZRU8UDpT8/PdtOZ+LXriAbfwNTMNQfZQqkU88A78jZnrJ3fC1V4ff1PRnxi15Gt
         mXYEMNuCITvEjebyD3yO2VgA6qiE/BdsFoLr2Fe8zYzp7y+QIhTbxO2WmpbKCUp0myFA
         JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuT9g02S4z9WBKS7UTxAHOkYxmWOMk5mgICtGD0Mq3Q=;
        b=Tbs4PgStNblt+23wPAs04Qb5lo8X5TTHjaz+1Gfr/oSXmSHtY+ZlWzdns2L58JpV+e
         etRJaOt5+RArM1yN4a6Bwkkt826jtr23QN0nhhMylY9Wt8e+3YNZFrfcHxaQustp+wAa
         0yiRrVvVQAMwRBYmnPYKJfepnaOmUjqP7sR4Z1XIxQNwmDU/9R4UqPourlmwLxakh/A7
         PDJ6ZYkCsT5Dfc5GoGvyowmojYYsqafq1XilzmuwjG4pk779wmI3m7U3rWdmrl/yNuzo
         5rZF84pyntahkGywAgicvdvX03Z/ibyBPSjefCXyy4Pg9wDE72FGDT3+szu07z+cJM7b
         iUBA==
X-Gm-Message-State: AOAM530/zJT7MeQ7I/+16ga7BOBFRmtCP4mVLmw4DDnNYj5St9lrph0u
        3fc9h3ktbwrxq2z9yxmtveY=
X-Google-Smtp-Source: ABdhPJy4CjkRmeVwI83tgEH2weose14ULR4n2bWsFg+AN3tTiJMemCQF3r8DbaW3JsoVV6xR10s08w==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr6650476ljp.310.1595065739791;
        Sat, 18 Jul 2020 02:48:59 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id x18sm2096581ljd.123.2020.07.18.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:48:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: [PATCH] t3200: don't grep for `strerror()` string
Date:   Sat, 18 Jul 2020 11:48:40 +0200
Message-Id: <20200718094840.31269-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <00d001d65c80$3519c960$9f4d5c20$@nexbridge.com>
References: <00d001d65c80$3519c960$9f4d5c20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 6b7093064a ("t3200: test for specific errors", 2020-06-15), we
learned to grep stderr to ensure that the failing `git branch`
invocations fail for the right reason. In two of these tests, we grep
for "File exists", expecting the string to show up there since config.c
calls `error_errno()`, which ends up including `strerror(errno)` in the
error message.

But as we saw in 4605a73073 ("t1091: don't grep for `strerror()`
string", 2020-03-08), there exists at least one implementation where
`strerror()` yields a slightly different string than the one we're
grepping for. In particular, these tests fail on the NonStop platform.

Similar to 4605a73073, grep for the beginning of the string instead to
avoid relying on `strerror()` behavior.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Hi Randall,

 Does this fix the test for you?

 Martin

 t/t3200-branch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b6aa04bbec..4c0734157b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -870,7 +870,7 @@ test_expect_success '--set-upstream-to fails on locked config' '
 	>.git/config.lock &&
 	git branch locked &&
 	test_must_fail git branch --set-upstream-to locked 2>err &&
-	test_i18ngrep "could not lock config file .git/config: File exists" err
+	test_i18ngrep "could not lock config file .git/config" err
 '
 
 test_expect_success 'use --set-upstream-to modify HEAD' '
@@ -901,7 +901,7 @@ test_expect_success '--unset-upstream should fail if config is locked' '
 	git branch --set-upstream-to locked &&
 	>.git/config.lock &&
 	test_must_fail git branch --unset-upstream 2>err &&
-	test_i18ngrep "could not lock config file .git/config: File exists" err
+	test_i18ngrep "could not lock config file .git/config" err
 '
 
 test_expect_success 'test --unset-upstream on HEAD' '
-- 
2.28.0.rc0

