Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97827ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiHaXS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaXSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E214C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d5so8111671wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+9Ce/NUO3YdqOO6NBtfUx5y12ik3ZPYt18dNfTT3yyY=;
        b=GXLNy3h5LedvD4Uix2F2r1/xnHH0c6ekn7Q9wQ9Xkq7Ld+LjKHBOtJwpgdjjE7rvVx
         ySLBR5c8dDPvGLOh9uGJn+U7d/y8toC3MgGIs9+WTrf+JgfdVyJI+Rbm99rz4jCJ8aQM
         /uGjMPgNPPun1XzDYRxNbVNQjFx2OP9B+9fgDxLFC/QcstmUPHYobxt7fHJuflTNv/dR
         aunfQ907669U9kVHVuuH0v8+hyeRdVuzBI2km33qkj6OU1phA8utG1AZYOdE+r9Fj7RG
         N1vpg5sCD7K/WrA2vmiCTNwYeLrowzzYVK8kA6MAgJ+etdq75EC3Hep5xE2N5DyLROt9
         DFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+9Ce/NUO3YdqOO6NBtfUx5y12ik3ZPYt18dNfTT3yyY=;
        b=l42yUeoPy09TSWFe0ce0uSmXhqBP9qHwmevR0aMq1t3S5AckcgcVzgf6suuaLytZdq
         PiZ2KeFltDvk5UzGMND9n73Yhko1E9kdiMaAIYLN8lqoUteFplqTdn55C5Q/xsZ2p5H4
         nNU0mT/8SW20GY8WVv/3gDbek6iAOBfwbwPaC64vhR4GdO++cxxjec9zu331dGD/te0y
         tJ5saDI7VN9VBG1ZW0eHo6uniIxIrVUVv/Czf342JybNLjqfsL8wNG3tz5PqLHaY8QWF
         d/MAyo5G59KsFgfKRm6EW7JvbdExiDJqi1nnHavl0Uum6NLFbKXPoCjLf+Lrv9+b7GhV
         iZcQ==
X-Gm-Message-State: ACgBeo1gO4pTG8NI1IAQYuP8dsWvsK0eqSHBk1rTp2s2T4Z5WUe0ja7A
        OytRFBbkOiDJTdBP0ShTswhH+CVzRBi2ZQ==
X-Google-Smtp-Source: AA6agR7B5SWritNi/KMfmk/IbnV6BKLdB7xUcygde9c9J/IH89qPDt9MWJzXz5anAetO/hixXdbAZg==
X-Received: by 2002:a05:600c:502b:b0:3a5:d36a:8b93 with SMTP id n43-20020a05600c502b00b003a5d36a8b93mr3269901wmr.180.1661987901346;
        Wed, 31 Aug 2022 16:18:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/33] submodule tests: test usage behavior
Date:   Thu,  1 Sep 2022 01:17:43 +0200
Message-Id: <patch-v4-01.33-2e882837026-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

