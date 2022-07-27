Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD82C19F29
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiG0XOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiG0XOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE14E623
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 2-20020a1c0202000000b003a3a22178beso89948wmc.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vNyikXM08Os+KaO7ckRV2QtRpse8QkML1oCapuMk5aE=;
        b=jUoNGeaGJB3EkLrFFS37d9EwMSTHM6hWYTEAxCw87w8XGq5h16Gml8JuyEdFibXRJU
         z4+b6npXAXq7JcTwOdNmdj+fK/dnFldYOH6r40Qgh23cEIOibcAQ7S/JJCfo99mehyZk
         XXkVuBxr3S9BVN2yEnGYs6hBHABXqRLbdoUK2i+AZk55YNij5VyxUaJsShRay8e4j+4b
         vec4LFN8PbsmdHOEUaR7SAsKUhB9HH4oMY4s0wozUnshQnEtL5A/wsdvdGj1MS3tgJio
         qmgS9vScFSmUzGJx3r9uklgRA07c05N8D2iKCeXSKHZnIpf4YkrtppvakvWX+K2HhmJp
         W1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vNyikXM08Os+KaO7ckRV2QtRpse8QkML1oCapuMk5aE=;
        b=QRXRGHf+tLx1FgTepDm5G4K6e4NHc4eujT4TqztnWQX3btaRXA6/9rmZsWiVrrE+Gy
         cY0iqA+f4+gKZE17S7W7MljQIYp+9rNduGMceg/qOW5H68+h4leBSVycS8SSPbNf03iT
         e+dCR/5870j7EQQ3MnVdTHUQz8nRL+8f62e7MTlEhEBKtmvcu15MbFhmioYmmKHteyK5
         0jKs6ZX98G2BCyn3ZZ97QjoekPtU4rsFbTaBI4CDPdt+gel9IMHpYoDrtshDi7O0kYE0
         eo+4CHEf7OkZ3X1jWzr5JrMPOj5NRO6a8PlEPTQgDJHIcHPkWvLO0s/J5U8VbzHXLOKh
         HFFQ==
X-Gm-Message-State: AJIora+oW8WXlMKvDVQKDay+e47Gv7uNTWd/OtlgDlPVqwzrPr48IPbO
        5kj7bCM+QSyoVCgRPS6hIaX8LyKwUeT0Cg==
X-Google-Smtp-Source: AGRyM1sj0qCEmslo1QKEcwDVD5SGjDfLM4oHBAGVCkqYJQpoEyKlmayVLkB8xFpQ1ZsFysFmdwF1Tg==
X-Received: by 2002:a7b:cb53:0:b0:3a2:f19e:b764 with SMTP id v19-20020a7bcb53000000b003a2f19eb764mr4407435wmj.101.1658963646407;
        Wed, 27 Jul 2022 16:14:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:14:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/15] CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks
Date:   Thu, 28 Jul 2022 01:13:43 +0200
Message-Id: <patch-v3-15.15-e4acdb18ec2-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a preceding commit the leak checking done by
"GIT_TEST_PASSING_SANITIZE_LEAK=true" (added in [1]) is incomplete
without combining it with "GIT_TEST_SANITIZE_LEAK_LOG=true".

Let's run our CI with that, to ensure that we catch cases where our
tests are missing the abort() exit code resulting from a leak for
whatever reason. The reasons for that are discussed in detail in a
preceding commit.

1. 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
   CI, 2021-09-23)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index f095519f8db..1b0cc2b57db 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -276,6 +276,7 @@ linux-musl)
 linux-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
 esac
 
-- 
2.37.1.1127.g4ecf1c08f67

