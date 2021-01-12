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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5DC10DAA
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3E23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438062AbhALVhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436866AbhALUTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76EAC0617A5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r3so3871853wrt.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QQWYtmAHJxXWtlODKa3IWICvGBvVoeTSt0o6QhaXss=;
        b=b7tw1zaP6JlMD6YVFbbn4zO0sLbastdVL/4E6z5MirJL7XfzAifKzFq1HRMTwHUlJD
         hnvSkuRIaC/5ingLmXypiHfUkWRkgWPRIVs/tgaouAk0l3k5aEtDVxVxfP1L/fz0TNP0
         q7Ut/cibkCaTXvJtXcmB4QYbJujMy6mAAMjrzjVBhmCZ7YuVVIXFYhwpqPBjbACEF+ol
         ODRGfJ2B5g51fObz3HFa+DKkC+tnrtgJQe7LEw7HwgnltuqGFwVaGWLHO09Gz+S23vjd
         TF4qnPGL1iVEWdVN0WOQw4CSmbBSOJLhWkmOWMdHUvlv7GAhlTBuVuNmzUuU5hG1a/Eo
         BAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QQWYtmAHJxXWtlODKa3IWICvGBvVoeTSt0o6QhaXss=;
        b=GjR9NNqOaUb92eiFV8Sq6+9HFYNItiWTx4PXRPzmd1rZYCuf32/NUXevynEfqFZOB4
         gqWKYPb7JJjHwGNvxZ5uqtf3LOfa4hkLkfbkEReJgkaU5i76R/1sOa6SiQ1ueyif2osf
         IKwJmgVdolXGBLKIVLWjpvvXErxTdeoi6v1m21yhWQNnMO/WnyPT8DPd1WELijcjn/J0
         wveYlAMy5vASlWOZWO+qV/MARVeYPe04TN4baRRfWRrIse44mISc+oxACXdvNpf15bK4
         Wv9jsFc4AeQodoEOwb8KTn17WWLGnwO0v8Uz+TH0pNNnEZDbqqqJ7nBrEUBdsAhKZ61w
         bS/g==
X-Gm-Message-State: AOAM530HYDa7IbMlzqCShln2EcFoj1ZJAJD7hoRePNr50PWMuAMM/dIZ
        3yVLAx34/DVmbJCdwLMpzyvMEhlXkcXKJg==
X-Google-Smtp-Source: ABdhPJxESrGLQvoM1zEqFY1m80fWG3lAdo95/WdPdKG99GhPZkgkgT5SjVmJQ/tpJw4SCMMY6GbZEQ==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr498125wrv.427.1610482705178;
        Tue, 12 Jan 2021 12:18:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/22] mailmap tests: improve --stdin tests
Date:   Tue, 12 Jan 2021 21:17:51 +0100
Message-Id: <20210112201806.13284-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --stdin tests setup the "contact" file in the main setup, let's
instead set it up in the test that uses it.

Also refactor the first test so it's obvious that the point of it is
that "check-mailmap" will spew its input as-is when given no
argument. For that one we can just use the "expect" file as-is.

Also add tests for how other "--stdin" cases are handled, e.g. one
where we actually do a mapping.

For the rest of --stdin testing we just assume we're going to get the
same output. We could follow-up and make sure everything's
round-tripped through both --stdin and the file/blob backends, but I
don't think there's much point in that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 61d1b62317..dbd365681e 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -13,11 +13,6 @@ fuzz_blame () {
 }
 
 test_expect_success 'setup commits and contacts file' '
-	cat >contacts <<-EOF &&
-	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
-	nick1 <bugs@company.xx>
-	EOF
-
 	echo one >one &&
 	git add one &&
 	test_tick &&
@@ -48,24 +43,53 @@ test_expect_success 'check-mailmap --stdin' '
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	nick1 <bugs@company.xx>
 	EOF
-	git check-mailmap --stdin <contacts >actual &&
+	git check-mailmap --stdin <expect >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'check-mailmap --stdin arguments' '
+test_expect_success 'check-mailmap --stdin arguments: no mapping' '
+	test_when_finished "rm contacts" &&
+	cat >contacts <<-EOF &&
+	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	nick1 <bugs@company.xx>
+	EOF
 	cat >expect <<-\EOF &&
 	Internal Guy <bugs@company.xy>
 	EOF
-	cat <contacts >>expect &&
+	cat contacts >>expect &&
+
 	git check-mailmap --stdin "Internal Guy <bugs@company.xy>" \
 		<contacts >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'check-mailmap --stdin arguments: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	New Name <$GIT_AUTHOR_EMAIL>
+	EOF
+	cat >stdin <<-EOF &&
+	Old Name <$GIT_AUTHOR_EMAIL>
+	EOF
+
+	cp .mailmap expect &&
+	git check-mailmap --stdin <stdin >actual &&
+	test_cmp expect actual &&
+
+	cat .mailmap >>expect &&
+	git check-mailmap --stdin "Another Old Name <$GIT_AUTHOR_EMAIL>" \
+		<stdin >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check-mailmap bogus contact' '
 	test_must_fail git check-mailmap bogus
 '
 
+test_expect_success 'check-mailmap bogus contact --stdin' '
+	test_must_fail git check-mailmap --stdin bogus </dev/null
+'
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):
-- 
2.29.2.222.g5d2a92d10f8

