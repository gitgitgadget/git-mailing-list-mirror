Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE073C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0A622D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405686AbhALItI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405681AbhALItH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC27C0617A2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t30so1592004wrb.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=akonExXIDLh4wqzHHffyLGc/w8EnHnTJkjh04ukIngI=;
        b=n7oi7objkdD/o5WCitX42wAT6NhAsmsTsahJ+SAJKiGxUc1sUrsKQ4kVihb58DuNUl
         y+PtmwzaV9we74EwoWhsnXsl+1ZWVdavuG13Bk5/dLfNY+BWRgELmCmp9wps0i9gzNDi
         ldQtAkI7J882q6b3LfT/W11P3EKB8g+WyjRB3a7TIYQ8APyWnsMYXthTABISOylrrcaC
         WTXPy0bp4ASEBoIJaLRqAuh4KOTRHPPWCg0wzy1CN0J7hT9wGl9zHcxlOugka1bjES2W
         IOIEcio6nWqTmu34XNMg+9w+2Mt6Jcvk5Sx+V3l/eJAkJEHwv+nqniMZCDmR3Qjnlm4n
         BsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=akonExXIDLh4wqzHHffyLGc/w8EnHnTJkjh04ukIngI=;
        b=D9urqDA7s1qgdSZC7QpJz/5i8mUEEhgvQ/VAbl5KquovM6Ww1GoV4qpd40l9VznDaV
         w/HtKtSwOtpE+p1exVGCf5MOUYN4muLq8vTERARfpHSdEhAcru/9nCNAJpIUwNyUKKid
         mMWf12uB6+cUzIdHejtEkJOq+YOrDqVzIz6hkRn9xoVkk0+AiVCpAfjukyB7lIoCkoDd
         kdHOE5/oS9W+IxWfvonQ2hnD0QDXWMnEWzWdYbj3xqwzYPTsEqkzXek2OXBe7wPr+q2i
         IUpWfyHJKELi+x8mjR6Z1pPf8OvbwqHb6Sx1OFUHyWMorshTMbAek+y/T7OlKsPZw2mt
         SI5A==
X-Gm-Message-State: AOAM531amoh3t/zdH4Pj8wwasUZ6jeYET9l0oCWurwZZRHMDmOagiVCs
        sGrXDsO65ZAp0aJNvjJeZc3LB/mc4to=
X-Google-Smtp-Source: ABdhPJztCD4ZXV/BIAFKhtupT9RGgTDmja/Ebmu2aq+hsACJmBQursGTVoOXO9yBydGL3b6AVOFdFQ==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr3141337wrv.51.1610441269299;
        Tue, 12 Jan 2021 00:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm3471394wrq.64.2021.01.12.00.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:48 -0800 (PST)
Message-Id: <a6ea5a7327e5fe9079ac2f73816c5c1b6ad05253.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:36 +0000
Subject: [PATCH 05/11] t0006: use `test_i18ncmp` only for C locales
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We cannot really test anything else, as we do not control the output of
`strftime()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0006-date.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 75ee9a96b80..9f27e202d36 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -9,7 +9,7 @@ GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 check_relative() {
 	t=$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
-	test_expect_${3:-success} "relative date ($2)" "
+	test_expect_${3:-success} C_LOCALE_OUTPUT "relative date ($2)" "
 	test-tool date relative $t >actual &&
 	test_i18ncmp expect actual
 	"
@@ -137,7 +137,7 @@ check_approxidate '2009-12-01' '2009-12-01 19:20:00'
 check_date_format_human() {
 	t=$(($GIT_TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
-	test_expect_success "human date $t" '
+	test_expect_success C_LOCALE_OUTPUT "human date $t" '
 		test-tool date human $t >actual &&
 		test_i18ncmp expect actual
 '
-- 
gitgitgadget

