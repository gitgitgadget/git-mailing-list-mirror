Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE6C0015E
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjF0OLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjF0OLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:11:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD12D63
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fba545d743so8486855e9.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687875074; x=1690467074;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4qr7YF/TMYRbrmgfw+48pqTU5OLtOm+q3npZ5/8uInc=;
        b=OUQ8pIAO4qRwUmpHYvT8rfxT66dv91pEGLqpzZMlqp+LsvwSDD4bMCJZyni7lfjxuq
         /4HT3bVtsGd52rO4CTIQSlji8yfKeMog2Mrq7mZtnadP2AF7Em+UhptPbj2xrpwck1am
         m4Yxm/dIfTR3CsBP4vzEeq+D6bFZHfoPe9Ac0hFfhwrD/21uS6vlAhhzK/QfCoTm2f97
         GfUMn46Qh1HJXSfdpNiYusCMO5ftmA1kHEO+9LMlJR3eaR0PsYZ6KDa78o8XcwcIJqaV
         sgNWM0ZH7Eqae8T4qCYP1NdGKMbsYynwMyPjsV5tactuMjuBL9la+78J0P70effyqGzi
         vvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875074; x=1690467074;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qr7YF/TMYRbrmgfw+48pqTU5OLtOm+q3npZ5/8uInc=;
        b=OlWgWNb1zqPTng1JOTwYh5Tnrr10MJr5xRUl1Sf1Nr4Dba8ZkyaLl5ocvRK1UOFJJ4
         ckeqERAXXmLK7OyCXGlkeCr79lGO5tbjo1LZukyAuBss2PpCp9WjhBQMbHHeACbPIHG2
         F6hOYeKc6+yhQoUZQsZJnptzmYeXHGhSo3ewwfdyozoGJDUQG7DP2fQg+/bV5IRDPwq1
         l9Jj4ZHp4LHJ2/E5XrD5GfA7bgpvPefyn37BLsDyUek+ICK+OdeH4tfgcpxiIbJpGiYb
         jF3KS2jZuQP5M6IBO5bLVDyhnoiDXlepAT1bTsA+qm7s8t7QIEtAlRcsl0DzqSbfMX61
         vc3w==
X-Gm-Message-State: AC+VfDy9Nm4lRkdRHIeIp3Nva9JtaiQgUdDOWoVuxE9jfFUucazQtGft
        hOxlKy602xB/KuDp332YLyCTx63wiKE=
X-Google-Smtp-Source: ACHHUZ5Lr7TFh8MIrWBHK6qj1HQiS3Md7hIASVAwXJrrQ5P6W4+Oe8ltJTAnSoBml2s6O1pAy13+WA==
X-Received: by 2002:a1c:ed08:0:b0:3f7:4961:52ad with SMTP id l8-20020a1ced08000000b003f7496152admr28554013wmh.3.1687875074070;
        Tue, 27 Jun 2023 07:11:14 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm2581935wmj.39.2023.06.27.07.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:11:13 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] t4054: test diff --no-index with stdin
Date:   Tue, 27 Jun 2023 15:10:15 +0100
Message-ID: <b94d59034f53c9f49fda815a80d1a4795722f058.1687874975.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g22d29fd9ba
In-Reply-To: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git diff --no-index" supports reading from stdin with the path "-".
There is no test coverage for this so add a regression test before
changing the code in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t4053-diff-no-index.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 4e9fa0403d..d14b194ea2 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -205,4 +205,22 @@ test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not lik
 	test_cmp expected actual
 '
 
+test_expect_success "diff --no-index treats '-' as stdin" '
+	cat >expect <<-EOF &&
+	diff --git a/- b/a/1
+	index $ZERO_OID..$(git hash-object --stdin <a/1) 100644
+	--- a/-
+	+++ b/a/1
+	@@ -1 +1 @@
+	-x
+	+1
+	EOF
+
+	test_write_lines x | test_expect_code 1 \
+		git -c core.abbrev=no diff --no-index -- - a/1 >actual &&
+	test_cmp expect actual &&
+
+	test_write_lines 1 | git diff --no-index -- a/1 - >actual &&
+	test_must_be_empty actual
+'
 test_done
-- 
2.40.1.852.g22d29fd9ba

