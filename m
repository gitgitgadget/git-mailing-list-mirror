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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48863C433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48864E99
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhB1Tzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhB1TzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33CC061788
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g5so24344722ejt.2
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xteS1T0oFHKWYlWKKIl7OUJRRda3GLCM+6E6yWPxTOU=;
        b=KrTLrL0hLT8BqmTPCt6YvQhiMBEmia9DdqrJapT8HYjSrGsGGALWhw2RCfF+CZQgae
         36j4dWrOmanj7qiMsQ7IQWMOagqGpZWrAoIcvTUEZIFhJaP9AtZnpEAHTAy8/BGwOxdV
         +y+fnxleKHeZp5CIyFAyhDtqX9H3+HYimDj41IcJ2iX+m1HCHL++QS5T58QSM+E9GGsU
         XdQvkeR/n1LPTT0+QMw6wCfyfHb8Axv73RTOANb0yEXBEcOCk7cGfPenbh34NkJeP5Ak
         wldrr8u1ysbl/8lhpTGM9w1D4Pue0H+dd8pQHcNgsCk8aRTDNrQOzpEB6vlO1JlW8+Ju
         x15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xteS1T0oFHKWYlWKKIl7OUJRRda3GLCM+6E6yWPxTOU=;
        b=F7pKeOlTFj6BbUloBdpaRwpex5X1HbXpA6+yduarQgJnvY08TJzGyzMsarLhR3Kfc2
         wYODekX0EG9UBfT8yEN7apoYEBlqTH52ZImwRbuw8ARsuSq+0VokRGulk41ZTIpy7/rZ
         sLQDzaD0bGr4uDZSMIGfwI3gTyMpytQmG+4GWmXfjQ6btoI4Q0Ddt5Zywv6dKg8yzrQQ
         BW6fFKDmj7vS5g9CvwU282QWzHnv6YtllGsB41laC6o6lz8IL2uG5mxWRm6nl++/592O
         EkIQBCmT7Pc1BwquFlchvP9pUgGvvoqR4EFUAJLYwnTVjRLiO0SVZJTFfSaR1x8z1V/V
         tQEg==
X-Gm-Message-State: AOAM531cFVpYdPJHX3+qcb07xlK3zMCalVoqHw618FjbgUxrivXW6yG6
        IWeLNLScKtElTv8kp8HnfldlCMeBcPPT+g==
X-Google-Smtp-Source: ABdhPJwLvgbuZGw9yTuheeNxWWRmNQij5jRucXrGk4a9KBP+tXhKlhuY79j5aEaJMIkWTAs3kxiEYQ==
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr12728360ejc.144.1614542076734;
        Sun, 28 Feb 2021 11:54:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] describe tests: always assert empty stderr from "describe"
Date:   Sun, 28 Feb 2021 20:54:07 +0100
Message-Id: <20210228195414.21372-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Invert a test added in 3291fe4072e (Add git-describe test for "verify
annotated tag names on output", 2008-03-03) to make checking that we
don't have warnings the rule rather than the exception.

There was only one case where we expected and got a warning. Let's
test for that case explicitly, and assert no warnings or other stderr
output for all the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e4fd5d567f..ef70c695be 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -21,7 +21,8 @@ check_describe () {
 	shift
 	describe_opts="$@"
 	test_expect_success "describe $describe_opts" '
-		git describe $describe_opts 2>err.actual >raw &&
+		git describe $describe_opts 2>err >raw &&
+		test_must_be_empty err &&
 		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
 		echo $expect >expect &&
 		test_cmp expect actual
@@ -122,20 +123,17 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 '
 
 check_describe tags/A --all A^0
-test_expect_success 'no warning was displayed for A' '
-	test_must_be_empty err.actual
-'
 
-test_expect_success 'rename tag A to Q locally' '
-	mv .git/refs/tags/A .git/refs/tags/Q
-'
-cat - >err.expect <<EOF
-warning: tag 'Q' is externally known as 'A'
-EOF
-check_describe A-8-gHASH HEAD
-test_expect_success 'warning was displayed for Q' '
-	test_cmp err.expect err.actual
-'
+test_expect_success 'renaming tag A to Q locally produces a warning' "
+	mv .git/refs/tags/A .git/refs/tags/Q &&
+	git describe HEAD 2>actual >out &&
+	cat >expected <<-\EOF &&
+	warning: tag 'Q' is externally known as 'A'
+	EOF
+	test_cmp expected actual &&
+	grep -E '^A-8-g[0-9a-f]+$' out
+"
+
 test_expect_success 'misnamed annotated tag forces long output' '
 	description=$(git describe --no-long Q^0) &&
 	expr "$description" : "A-0-g[0-9a-f]*$" &&
-- 
2.31.0.rc0.116.g45ec00aa00

