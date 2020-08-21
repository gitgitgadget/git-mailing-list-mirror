Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD4C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74B520791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tstiaWAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHUVGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHUVGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:06:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877DC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so3105378wmc.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RtHmFdUygzahr63EplhuUWi4GrSbkocacAhyc4+oI5E=;
        b=tstiaWAzTui7JJP1U5K6gZh9MF22VxRKAcb3hU5+MGunY/HU+bOGdHoEgLNSGL5A7G
         leESFBQxT6LPPgV5Udg32cL5cAX1IIEt909SA78VHKInsjlORsVVciqgpTVC3RbO0ESJ
         NAk80BcocCQBkwMps8zYmM8tRIqUGTJBDaMFVB526D9msgcvuGiwcj3cWxeVd7GN+IuO
         l7MYRuwTAZub2hPV6L/GIpQabOP3HEEzDrjMqWYg5fwhDv9OdkyVRNxim99pFGutwsEx
         JEqTwdd9K09GkWTH3W4SAuLeC+20FEUt6MquXIXuRcMZh21Nb7+llnc3O2Ztx9h2LqKY
         JoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RtHmFdUygzahr63EplhuUWi4GrSbkocacAhyc4+oI5E=;
        b=rn/mYagMA0XXRK0lvfGsppG5MUrmVdVMVbhcdVTvLIlRxe2iO4J1Vu6Om2h4gXbiy+
         dZ3LuJyOY5ZuOwOJ7rS7CI1aWlxgVdYEasYdP6oIe4EOeLYNcbKGckA40+BqJyFW8pJo
         3YbByje/E340Ghc6yr/J2gHrHOdzlIeQo6Z4j739CXQ15w3tKEhHFszaZ3ytfsB9m4fG
         BAZn44h4i/B/+wNJVzo5Nv9KMk/4Uxss1P8nMFD/y1tHDWT4miPzqyUZejKNSA6bcqgo
         PP69t5IgFFxQa9R1FIf09vGEmlGskmJreKkJ58czfbH9xCAdHxGh33+mAxunzIjJlsOv
         I+wg==
X-Gm-Message-State: AOAM531ihpDJUhzOAVihNDoeM5T31VfWm/M2JG3IRD9tzcEwckugK45z
        rjB9ydXF5M0DI/e2+dR0Xeo1ImApZa8=
X-Google-Smtp-Source: ABdhPJyblIYZ7C3H5FB2oQasE7ZhBNk3ChC/jK1Y/vXgAk8uRaWLGfSS8M2DDtlLYzpA4td/QMEkkA==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr5602126wmj.153.1598043978062;
        Fri, 21 Aug 2020 14:06:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm6572912wrw.78.2020.08.21.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:06:17 -0700 (PDT)
Message-Id: <383476b1778eb0d62c6cf013008388f72065beb0.1598043976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:06:13 +0000
Subject: [PATCH v3 1/4] t6300: unify %(trailers) and %(contents:trailers)
 tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Currently, there are different tests for testing %(trailers) and
%(contents:trailers) causing redundant copy.

Its time to get rid of duplicate code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t6300-for-each-ref.sh | 56 +++++++++++------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a83579fbdf..0570380344 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -776,61 +776,40 @@ test_expect_success 'set up trailers for next test' '
 '
 
 test_expect_success '%(trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
 	{
 		unfold <trailers
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
 	{
 		grep -v patch.description <trailers &&
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
-	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
-	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
-	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&
 		echo
 	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
-	{
-		unfold <trailers
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
-	{
-		grep -v patch.description <trailers &&
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) work together' '
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >actual &&
+	test_cmp actual actual &&
 	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
-	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
-	test_cmp actual reverse &&
-	{
-		grep -v patch.description <trailers | unfold &&
-		echo
-	} >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >actual &&
+	test_cmp actual actual
 '
 
 test_expect_success '%(trailers) rejects unknown trailers arguments' '
@@ -839,14 +818,7 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual
-'
-
-test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
-	# error message cannot be checked under i18n
-	cat >expect <<-EOF &&
-	fatal: unknown %(trailers) argument: unsupported
-	EOF
+	test_i18ncmp expect actual &&
 	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
 	test_i18ncmp expect actual
 '
-- 
gitgitgadget

