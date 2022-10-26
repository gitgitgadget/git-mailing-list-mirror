Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5ADC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiJZPhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiJZPhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:37:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D90132DFF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y16so16547732wrt.12
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ua905TbBf8B++yzE8Tff48m+J1eagMgWNViFnhjuZM=;
        b=IKPvWaAgkWLnJiif4uYUpkJBDWC6QQPV9PzqNfDCj2cgpEfKwCJrRUezYtexuvxuzE
         Jl+J3v6+rblP9WFquvONz0Gi6jiPtPUaXp3G2S8cuStmoNwJKQSMNSXUSyAko7YykXKK
         OiMFCvwwdubcVZKa4x+zgpUeqfCylUlXlcHTXCdiWrbrf7+8/IeVlgNxUAB8f+IgyEbu
         R8Mz0eR3phOA/uzBMDhrgZ+XBK5zYjOooE0X14h279Q6KUlHs2Mn+nF/0kZPHG+sR9IN
         KuaPdaNvigS2dOw0+YWVfwp5fKXQ+2zU77hls50G+1mgySoPYcJ2k8HdJycCGeWtw4uM
         30yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ua905TbBf8B++yzE8Tff48m+J1eagMgWNViFnhjuZM=;
        b=Aj+dhZSu9Y0JNGQOCvH+mBFvxiC4C7Vnq49/1DAIqu4qcuPwCfPdw/5mQkFkpJZ6Po
         0Nh2qUfdy4qbka2HgCOAsQ2OnQf+zY4i6e3AfTv/0VCt5fL+IPzzKlVJiuwhKST+N61k
         6VfNM5VzUUbCHBvADwNIExxme2BzPt4Du7YQ64pRiBWqUZVebB0L1Jl33qZNVOYlZw7B
         eVBlHg+YRN1RehAveq2N1NzF8aNKn0TmLpadKMXWn8Q1Xkko/AVj3d37tuUQK7cnMPpZ
         wU7MxO8LvtQTx8hSPkDGtoy0ilqLjNr3m9OOG54GVrZAz8O9FWiMJvizS/CLvURFMPVM
         Z6mQ==
X-Gm-Message-State: ACrzQf3EI4dOQqAeJ+08d/p6MUiCWHy01dlpVNQJHf+3/OeJc1yG01++
        e6lpTnJO3QN1NQfTyAHQIc5TrHUoys61cQ==
X-Google-Smtp-Source: AMsMyM4QPoL8nBthiqaOT2EGx0vCb+qaIHkdeAFbnXQtOlRVpmcEzk+A4zD/9PvbOxLbaqxYYU6L4A==
X-Received: by 2002:a5d:598d:0:b0:236:8ef4:7324 with SMTP id n13-20020a5d598d000000b002368ef47324mr1936683wri.84.1666798606542;
        Wed, 26 Oct 2022 08:36:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] config tests: add "NULL" tests for *_get_value_multi()
Date:   Wed, 26 Oct 2022 17:35:21 +0200
Message-Id: <patch-08.10-e7568dbe6fe-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
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
2.38.0.1251.g3eefdfb5e7a

