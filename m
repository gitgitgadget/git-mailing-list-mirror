Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CEC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKYJyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKYJyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BB43AFF
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so5067822wrr.8
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hW2KTyxus2ppvmUB3uvyKVcUx/GbrOjdVbG8l84bF8=;
        b=qkwllmOG2R7dk1d9RLW6F08SKG9E1pQluX7vm+1CLZzGt9gF3t9Vw7QipuyhDO3iRe
         qbZxaQ1tmHatJk4zJe5wjk8nUV8kvR8H0wr36hcq54YEBfGvbqAjl0LrxmUcKFFvGlWY
         Ov2KgNCG8HEvthXyP+RmMJhjfmqIZQOvSqVFvPh74d+lSmtcVR6My73s3JG7STc5H/94
         UT72zy0A5qk8prHwXahu9nzWnUMYwCux56erdHJ1XZaTs/wpQgW2xY21z0Okxk8xsux4
         XDeQBCgUj3c+8tJsWS475ilK2EW4Yp6AJR02qhYBtjJ9oFpvxR5T979TtWQF4PS78CBw
         MyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hW2KTyxus2ppvmUB3uvyKVcUx/GbrOjdVbG8l84bF8=;
        b=ZePocbAp7/2fYAo7Mb6IFqiGrpOCKw/c02+KRabO9NxXYgDCe7dv2acUCNBrzAlu8e
         7//BAe6nxWgebwaJGtLdaWcDzclgjocjFhaoe5nhTu7oiQ5t8pmV2ImqbOrFYqf5FYQt
         MXMH9VLBQz4+oOaUR8GcuC0jDuXgjsGOncdU650OMC4XCI+wULyp1uMWSn3RMLqXQdDw
         70WKxk4gj+r4F9IrGxl6+OZgpf/cl9KCjOBmVcAR4BZO0wraw1WoJ073AJQJSTgu1J6v
         G7ZANAl/4Pl1ZPBU//DziYI1Y33ZPJuOJ3at/3hb1Q3MuMG5E+kEUQCu+tPJgLgamKN4
         j6ow==
X-Gm-Message-State: ANoB5pkn5/mLkh7uwSJQZPRcBiDo3R44IrBMQPgr9phaxLk7m24xu07F
        L+f5mt5UyGqUWgFmYyFQ9t8sUVo2vtbIHTi2
X-Google-Smtp-Source: AA0mqf5Lkr0UUtjPvTkLyZCEmACQoAqR8aR5rNGSTMF5UDGvuIk9CuKoFZ1Q35ZjCRoZRIfYapmO5A==
X-Received: by 2002:a5d:5702:0:b0:242:569:3028 with SMTP id a2-20020a5d5702000000b0024205693028mr1481267wrv.435.1669369884519;
        Fri, 25 Nov 2022 01:51:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Fri, 25 Nov 2022 10:50:04 +0100
Message-Id: <patch-v3-3.9-14b08dfc162-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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
2.39.0.rc0.955.ge9b241be664

