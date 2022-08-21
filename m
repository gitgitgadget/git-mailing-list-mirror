Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E27C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiHUN6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHUN6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F687DFEB
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d5so4362188wms.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vpUWgAite+njSsV0pix4nXdyE4UDKY1kaTgKm5eVWGE=;
        b=ZL1LiyjWmQi+htJ2b9U9+jleTDdF5WVSB1asNVxL4614ocSiH4bIjVsFHFg3ynvd2y
         f7whH9lOna0uQdjQyRNiYfjqIGsknTK8ly/KTnUYv1Hzn6CQMiGPtEbfZ7KJpSGsmcCb
         /M2DC6wnxCe80xJXaeqNZrJtaW0vnN0ry5ZEFUs1+IM4xyOQkSRNtzEe7WTWVTz++81p
         TTYTrO9sz+JerHPHDEH/1GI9ay/8v3vXiZL8b+d1pJaQmulKSlhquHld3rAvQyTkR/4x
         LNQQ0pqVJc4e8uGJU5ATcJGSzZGIoZHAZnyMftOAXnWdHx8WtlBL86RWIrfYqh0U9owY
         xnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vpUWgAite+njSsV0pix4nXdyE4UDKY1kaTgKm5eVWGE=;
        b=eq+AhrR03jNRLixkKcBwrlG8DsFMW7dv4NKqozGgnCwSeSsusBTkJ6RCy6nWEoHvKI
         htjNblwBIt+kxTDzb9MCsNcjXxkXENdb3Qjs0wbaVP27Mn7+9kLvNYptp4aBhj8bvFqx
         CssAw57YYquTN/uAKnHGABPXCxgih5jf4X7X9xYdxTpPCnDDiNunaox2ELj6zctv0i1j
         iFvjkA2NkkgYY/PAqkglcUrF/XC+EF6tOeLNkD9UvQ/F7Sm03e5P8YnVPAdVabWMXh8A
         MVRgjrAD53+TRwfHSBGhp98jSDsF6FZ+hG78ubL1jQw8ZtfROkc641Z9Dpm4sUsyiHCu
         95/w==
X-Gm-Message-State: ACgBeo1gJlZqEx/KgmTBU/xMmfUBBenKyoLsAdLxcKw/WMlL3Km7GTqn
        /jIemRkW9evFQkOp2NOydkl08shfLRHkaA==
X-Google-Smtp-Source: AA6agR4Fh9ZFAjDshL0GxU6ikzLiHDn6pLpNxcaFMz9HnHF6dTAa9l7smMzAH+RVHwhqgFroPWaYDg==
X-Received: by 2002:a05:600c:19d0:b0:3a6:2eb1:cfa5 with SMTP id u16-20020a05600c19d000b003a62eb1cfa5mr8009699wmq.37.1661090305880;
        Sun, 21 Aug 2022 06:58:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/32] submodule tests: test usage behavior
Date:   Sun, 21 Aug 2022 15:57:10 +0200
Message-Id: <patch-v3-01.32-77586985ab3-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test what exit code and output we emit on "git submodule -h", how we
handle "--" when no subcommand is specified, and how the top-level
"--recursive" option is handled.

For "-h" this doesn't make sense, but let's test for it so that any
subsequent eventual behavior change will become clear.

For "--" this follows up on 68cabbfda36 (submodule: document default
behavior, 2019-02-15) and tests that "status" doesn't support
the "--" delimiter. There's no intrinsically good reason not to
support that. We behave this way due to edge cases in
git-submodule.sh's implementation, but as with "-h" let's assert our
current long-standing behavior for now.

For "--recursive" the exclusion of it from the top-level appears to
have been an omission in 15fc56a8536 (git submodule foreach: Add
--recursive to recurse into nested submodules, 2009-08-19), there
doesn't seem to be a reason not to support it alongside "--quiet" and
"--cached", but let's likewise assert our existing behavior for now.

I.e. as long as "status" is optional it would make sense to support
all of its options when it's omitted, but we only do that with
"--quiet" and "--cached", and curiously omit "--recursive".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e7cec2e457a..b858871a953 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -14,6 +14,32 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'submodule usage: -h' '
+	git submodule -h >out 2>err &&
+	grep "^usage: git submodule" out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'submodule usage: --recursive' '
+	test_expect_code 1 git submodule --recursive >out 2>err &&
+	grep "^usage: git submodule" err &&
+	test_must_be_empty out
+'
+
+test_expect_success 'submodule usage: status --' '
+	test_expect_code 1 git submodule -- &&
+	test_expect_code 1 git submodule --end-of-options
+'
+
+for opt in '--quiet' '--cached'
+do
+	test_expect_success "submodule usage: status $opt" '
+		git submodule $opt &&
+		git submodule status $opt &&
+		git submodule $opt status
+	'
+done
+
 test_expect_success 'submodule deinit works on empty repository' '
 	git submodule deinit --all
 '
-- 
2.37.2.1279.g64dec4e13cf

