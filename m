Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B30DC19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiG1QR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiG1QRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999786FA31
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h188-20020a1c21c5000000b003a34ac64bdfso1118255wmh.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=o4aY6SRxds1CZ9FzY4pwNY82/yp7+O9ucsF2/nAlNl4=;
        b=QS/mBw14NqnlZMX1m0jPxE1vPqcjZpITGReXbfH0/qvtpHoDH3AjE/xcJ4cXcUh9EK
         kdAiRX8HueSco0L/yevpFuVC66uJofUgqKaEoOoeCNem3ykF+Y8fahR+Hrsvl/5xT9sg
         IB/EOKsKzshON+1tDyU78txGx5Sv4s9JEAUIBcUpTIIezv2W5CdXzktUUlxv3T0HJpA8
         0XCY8Xsns6RjnCk3L+nczOg9PNBGMZc6QPyd3lHAxWsEsqdy4YbSJv6I4HwtlerKr+4o
         ibkYjuWfSM9Eq6a3dxOq+2RMWLqdVJHQjBUmFzt19Y4Yr5VKeRk9wMKAPpiFpyJwwOnX
         7X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o4aY6SRxds1CZ9FzY4pwNY82/yp7+O9ucsF2/nAlNl4=;
        b=7tSBgv6bbSIoy4KnlDvAxKziN2q7EUqhLFZ1qJB3LCczBx2Z1egu57mfW8JAV686Mv
         UHrNDzakPOsGCrz76M/9NuSG4e8hwb31b5ZgQ/3GZq2Za9gwKa90UwraYm+CbXXOdv7X
         gzCUbYiCbxTREhHl1xI5Upr7BvwhXHVwN5Up7JnID1ByB2Ena32/CohfVU2yGkuDb+oj
         18mC7z0Qu7eBgUHvsuGgK46fvHzxw6grtjL2VXPn2DJHxw+aokTDNJAq1VvowGv9xCC5
         3mLCo219lRfd4t8wWhthfBYyRHtkUIrcl7sSSGqNRjV631bUXs6NK3h0vhEqcHWV+1NI
         oFag==
X-Gm-Message-State: AJIora+nzlcA2v735AFwG3xlbrhp5w1RN44dhgRKHHrDjuQZpYU57OWP
        lSb65oPa/3XqxjRrXXHr++E+BEVSxOu78A==
X-Google-Smtp-Source: AGRyM1vrSv/81Khhm2VsG2VeVK5ALEe1+v9hrJsy5PJYYRhA9ScN6KGSsmfjnXmg/gC+A8DC9g5YnQ==
X-Received: by 2002:a7b:cbc4:0:b0:3a3:745d:ae5e with SMTP id n4-20020a7bcbc4000000b003a3745dae5emr133714wmi.12.1659025030582;
        Thu, 28 Jul 2022 09:17:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/20] submodule tests: test usage behavior
Date:   Thu, 28 Jul 2022 18:16:46 +0200
Message-Id: <patch-01.20-84b05bda016-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
behavior, 2019-02-15) and tests that when "status" isn't supplied we
don't support the "--" delimiter. There's no intrinsically good reason
not to support that. We behave this way due to edge cases in
git-submodule.sh's implementation, but as with "-h" let's assert our
current long-standing behavior for now.

For "--recursive" the exclusion of it from the top-level appears to
have been an omission in 15fc56a8536 (git submodule foreach: Add
--recursive to recurse into nested submodules, 2009-08-19), there
doesn't seem to be a reason not to support it alongside "--quiet" and
"--cached", but let's likewise assert our existing behavior for now.

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
2.37.1.1167.g38fda70d8c4

