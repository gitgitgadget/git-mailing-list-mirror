Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61858C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCHJHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCHJHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:07:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6734322
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j2so14606736wrh.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=pXf5SHtP1srikS+eobM+qdAglUcn2n95dZsiZQyj+ZD6E8cAVkPlr0nI0nkwNDKLPp
         6qfWFpxNysiF/sVq98rsgMxkBE8x/7dp2C3hKEq8h4PPn4Wf1arBwdqMC9CZTuYaBiq5
         NxmH+/Q/VIJp+rKVwuwEXz+zudnvQ1czeKLn9UWL+1fo4lPYHJTrkm492Sh5BBWFQZJv
         19+Xzo5a7Q1QQJ8PI3E/eYBmQnUapdkztI3viNsVhIO2F99n3JL0wwRoDdeLL19PKUHu
         MmRMcsryWXfLgZA1llztjlePVKg5/EwBwa/L+yselLDOhWMXYMYbfwCA4mV9IJ/3hJnA
         QVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=JQnA+IGw0bSJIXTdohNpuDEHy2uOSxjZHBlRjAfh7HGTgDCnC616FtYnzFXxg0qPcq
         4EZwQTNpRCf7mklqJ5lNm/qTQNZtMD6ftgsSKHzJlneSvXl20AfHLL6I2ad8hdtcBPU+
         sMWESyS3TS1DZXk9Wh/wqpZusmWJU0SXaFJ7pjpwc4wNx5NVTzjFKwMED0HYzeZPR6fG
         zBhOinEoF8sFFwxx9vG0R0j4w0SyPxewv9jsgBFn0yDDM0Qxyf0FEKI0mshqqeyxE8mm
         NZ94oFSdNwHX18cLHYBVxE4KqQpvkycfsQemR+3S7akPpiOZroSfv7PAmkDxFEVIZDpz
         4AYA==
X-Gm-Message-State: AO0yUKVtFOshgjwIy0uqMC2pyaLTXbs3jGgq2fOPZdkv/2vPnvR4jOne
        ZoKKd/KUF7a3kRo6pL2HpvulxN+jHtc0LQ==
X-Google-Smtp-Source: AK7set90Aq/x8yB5CNI71KocvmOEY1saOpfkgMBXtn+5xI3w3rNJZ58cQu0J5QdJJtamOBhwm1lwOw==
X-Received: by 2002:adf:db09:0:b0:2c7:d75:373a with SMTP id s9-20020adfdb09000000b002c70d75373amr11579660wri.1.1678266440312;
        Wed, 08 Mar 2023 01:07:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Wed,  8 Mar 2023 10:06:44 +0100
Message-Id: <patch-v7-2.9-45d483066ef-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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

When parts of the config_set API were tested for in [1] they didn't
add coverage for 3/4 of the "(NULL)" cases handled in
"t/helper/test-config.c". We'd test that case for "get_value", but not
"get_value_multi", "configset_get_value" and
"configset_get_value_multi".

We now cover all of those cases, which in turn expose the details of
how this part of the config API works.

1. 4c715ebb96a (test-config: add tests for the config_set API,
   2014-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1308-config-set.sh | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b38e158d3b2..4be1ab1147c 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -146,6 +146,71 @@ test_expect_success 'find multiple values' '
 	check_config get_value_multi case.baz sam bat hask
 '
 
+test_NULL_in_multi () {
+	local op="$1" &&
+	local file="$2" &&
+
+	test_expect_success "$op: NULL value in config${file:+ in $file}" '
+		config="$file" &&
+		if test -z "$config"
+		then
+			config=.git/config &&
+			test_when_finished "mv $config.old $config" &&
+			mv "$config" "$config".old
+		fi &&
+
+		# Value-less in the middle of a list
+		cat >"$config" <<-\EOF &&
+		[a]key=x
+		[a]key
+		[a]key=y
+		EOF
+		case "$op" in
+		*_multi)
+			cat >expect <<-\EOF
+			x
+			(NULL)
+			y
+			EOF
+			;;
+		*)
+			cat >expect <<-\EOF
+			y
+			EOF
+			;;
+		esac &&
+		test-tool config "$op" a.key $file >actual &&
+		test_cmp expect actual &&
+
+		# Value-less at the end of a least
+		cat >"$config" <<-\EOF &&
+		[a]key=x
+		[a]key=y
+		[a]key
+		EOF
+		case "$op" in
+		*_multi)
+			cat >expect <<-\EOF
+			x
+			y
+			(NULL)
+			EOF
+			;;
+		*)
+			cat >expect <<-\EOF
+			(NULL)
+			EOF
+			;;
+		esac &&
+		test-tool config "$op" a.key $file >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_NULL_in_multi "get_value_multi"
+test_NULL_in_multi "configset_get_value" "my.config"
+test_NULL_in_multi "configset_get_value_multi" "my.config"
+
 test_expect_success 'find value from a configset' '
 	cat >config2 <<-\EOF &&
 	[case]
-- 
2.40.0.rc1.1034.g5867a1b10c5

