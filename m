Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B9FC43217
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKAXFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiKAXFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D717A86
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f5so19377959ejc.5
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4P7iyVPaDMOq4HHoZUBqraXfs8v/BkifqQWJwRv4zE=;
        b=KYCW710HyR/gILGIcb34mCCRiAvM5FtS5Ki515p1rBMVuRHidJXIK2PWV/4mDB4nLX
         GYOdK3ItFLN40QWc6lT8pYuXeLE3kEZidx9Z5LPTVSeLScdZlSfNb/ztz6qs965gNGKh
         tnYGlH1/wN6J1hixVfTXGa4C8WfZS+CpB/d85vCFJm8TKo1M8KXaflAhgecjJyb0dsDB
         pYpgbAuoVI3TLRQoP/0mQgfirUfRLwz3p0sf5VuYrVlkswAJ69CZtpuTDBeWC2SulNxo
         Hu6LAhoFy5IHhg1ZJM9VKQxaR3kRMit4cIz3oYHBJ2OT9AAWmJIymfzpYBouzAzVKi5v
         2GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4P7iyVPaDMOq4HHoZUBqraXfs8v/BkifqQWJwRv4zE=;
        b=ji8tVGNodN40PwGprOreRcAv2g9tFTHSxVLqD8hI12CqGN7R4sM33Q9K9MtcbPnjNq
         nisoYvgLecAFIaghNYLFfQ/yj4RcDYai6rd9iMWP9vL2alxm8CMHoM2OD4/9y0p6pSl/
         tN8kr1KFChdQI7k0s9yQ31XTkweBMUA2L9GSXHlAlMmVokH63vZWtxt8X/1hFwv/zTvm
         qggtjDnwy+Up8gXqVoVNlHezgLEHiO7Mxj0i4X4MsjqSJYE1gSJkPSeqwLDOMtdGxyTy
         ascaz2Mu0QpdE6M2qaw2KnT23BDfBxp2eL88xGn+6MdHWRP7tOGak3NInp7zylWaPm9a
         PQLQ==
X-Gm-Message-State: ACrzQf0oUm8y240FGy0DW1jAPqSVUqPAS3uhk3MS194q4GTbm6hGZ/qN
        gt6NsOUQGl+sZRP7VD8EjUU2Ky6Pee7xmg==
X-Google-Smtp-Source: AMsMyM7Wz0vSqq5T3IxrHEJqdC8FdTSU3n/GDd12fRANA2QlSTaiUxsFWuh1D+zgBW15izLJHB1KIA==
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id ww7-20020a170907084700b0077ff489cc25mr20149487ejb.80.1667343934909;
        Tue, 01 Nov 2022 16:05:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Wed,  2 Nov 2022 00:05:14 +0100
Message-Id: <patch-v2-3.9-f2a8766a802-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A less well known edge case in the config format is that keys can be
value-less, a shorthand syntax for "true" boolean keys. I.e. these two
are equivalent as far as "--type=bool" is concerned:

	[a]key
	[a]key = true

But as far as our parser is concerned the values for these two are
NULL, and "true". I.e. for a sequence like:

	[a]key=x
	[a]key
	[a]key=y

We get a "struct string_list" with "string" members with ".string"
values of:

	{ "x", NULL, "y" }

This behavior goes back to the initial implementation of
git_config_bool() in 17712991a59 (Add ".git/config" file parser,
2005-10-10).

When the "t/t1308-config-set.sh" tests were added in [1] only one of
the three "(NULL)" lines in "t/helper/test-config.c" had any test
coverage. This change adds tests that stress the remaining two.

1. 4c715ebb96a (test-config: add tests for the config_set API,
   2014-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1308-config-set.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b38e158d3b2..561e82f1808 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -146,6 +146,36 @@ test_expect_success 'find multiple values' '
 	check_config get_value_multi case.baz sam bat hask
 '
 
+test_expect_success 'emit multi values from configset with NULL entry' '
+	test_when_finished "rm -f my.config" &&
+	cat >my.config <<-\EOF &&
+	[a]key=x
+	[a]key
+	[a]key=y
+	EOF
+	cat >expect <<-\EOF &&
+	x
+	(NULL)
+	y
+	EOF
+	test-tool config configset_get_value_multi a.key my.config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multi values from configset with a last NULL entry' '
+	test_when_finished "rm -f my.config" &&
+	cat >my.config <<-\EOF &&
+	[a]key=x
+	[a]key=y
+	[a]key
+	EOF
+	cat >expect <<-\EOF &&
+	(NULL)
+	EOF
+	test-tool config configset_get_value a.key my.config >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'find value from a configset' '
 	cat >config2 <<-\EOF &&
 	[case]
-- 
2.38.0.1280.g8136eb6fab2

