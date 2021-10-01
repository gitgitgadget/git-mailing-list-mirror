Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF996135E
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354587AbhJAObb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354523AbhJAObP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73281C06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s21so15777606wra.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io7SYrdxgMSJ9sByVo2eBI2ZJl6RhY/Sms8VaXoXdpg=;
        b=oA1SKzI/6vLDCPZh5oc6+6HyaKzs9CP0SygVLW5juwQzKaWWUtsEG1ZG1tYdwnJIpK
         Y9jA+Twz2iPUCViFnvEc0W7Rp7lP/jCC20TtC+RmOkmRMVkSfbtE0hXtLgHFAzx118Gs
         feISqlG7r+eVvkqRhiEXwuR93HcdoIaKnAUgdm67MDmZN4hcgCw2YPhg2ytg5tD64Gux
         vmHriYX0unkEwTyk4UDrboa9Mx2Thyr7zUBf/Kc6DxgyTvUIiC7h+/zfjOyT4JZybEvp
         qoTupIDW86vA2LLlCu8x61Fryl0zOvByAoQ3u9YpFalX75Eu8fwZLA8dxFFx4ISgqfof
         omiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io7SYrdxgMSJ9sByVo2eBI2ZJl6RhY/Sms8VaXoXdpg=;
        b=diImoojlMFFlBApGGCfSlRPKc9OkeV33icLacJhTHOX/MR41auY56Mybzaeidl1mPs
         n2+v4rosSGZT/8N4WOgXAh71cAMCsB4BnPmGYjQsA28+dpfH6TNABgGaILsZ+CR6s6nq
         uLseCYYMVTCmy3XsbZXBSSG6i5mPvwys9eAp0W0mM/bwiN+bl7tYajnW0PeSGBzvWc7t
         tgVmM/gS2v24YY3lY3kvLESkOZtZ7cmCuytXte6Z8z0Z+hxYYJWc1xTpZg9OLgmtKIXn
         ENkxZsVj+FTtS2HyAeVmJ7QbqBiJqAbFoa6IZrq3+v5XiMRhnCTYcVLiEg5nsitI7BQJ
         Y/OA==
X-Gm-Message-State: AOAM53355W5Z2Nzs4icc/IIIlcE8/ogxrfiJ3rxsuKJ+M2bPto0m1Jl4
        lBsu+OZsYPF+IZhkjy+KADSHfoLCAw033w==
X-Google-Smtp-Source: ABdhPJx3SXPVudFEfa/3qQxK6qc9oqX8tJfLdwJspUIFGsiLK0lTefjeuRWOl03urCPPXODB2nsTaQ==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr13036621wri.113.1633098569738;
        Fri, 01 Oct 2021 07:29:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] parse-options tests: test optname() output
Date:   Fri,  1 Oct 2021 16:29:16 +0200
Message-Id: <patch-v2-10.11-f727f683eb1-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were no tests for checking the specific output that we'll
generate in optname(), let's add some. That output was added back in
4a59fd13122 (Add a simple option parser., 2007-10-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0040-parse-options.sh | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index da310ed29b1..d6f391a497b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -168,9 +168,45 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test_expect_code 129 test-tool parse-options -s &&
-	test_expect_code 129 test-tool parse-options --string &&
-	test_expect_code 129 test-tool parse-options --file
+	cat >expect <<-\EOF &&
+	error: switch `s'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options -s 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `string'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --string 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `file'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: boolean' '
+	cat >expect <<-\EOF &&
+	error: option `yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --yes=hi 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `no-yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --no-yes=hi 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: cmdmode' '
+	cat >expect <<-\EOF &&
+	error: option `mode1'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --mode1=hi 2>actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-- 
2.33.0.1374.gc8f4fa74caf

