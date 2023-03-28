Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ECC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC1OGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjC1OGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5AC179
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4194508wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=fPrL60inMRKj9Z0sovxuWaygRd3u3b+sgVSTOXhB7EPzXNBWrGyJ7ON1HgrkgDRb3f
         6Si9tJCIQdrrVrg1SXNxYtSg6V0dayNQAUHbMbGICYvPY1lPeMFfpO9uSoHSjcDULnmZ
         di58Bj2nlMPWJ6S5jdu2NiwjuEYkx+/2VFwv4xBfkQ4f6JhrYKe31KarOWALVJ3md1rI
         KHz5QrWRDZwSmK35VWDX7DOMhtc7Ir8xjPzJw9f1Z49JEtmoF4NukciX7ZvFZxytFge8
         0fw4Xd2X5tyTly/jtpM9RnH56RueLWLuHbxMhTJbtMPyyCVCXVWZ63lye6cQKHEjCRrH
         e43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=DqtTUfkxqVzoKCjuWH98JiuRz6ksI3OAzr850Xr2B77q4aBnvJZLMJZimTd+IZkce5
         eufLuv2hxJpGDlvpNmU9zr47vUuRmOJv06TtCZn9dlEmPfItUtxKWFhoSv/38LFlcvdo
         YFg2Inrb2IBHxZAM6NCzARE9cnus1Od4i0B3OwmUjOsFPrVXiTTXeqkf79G5QFE+ZvSx
         vxx7HI4Aqv2YsohXaQXzkaFkc1c0KhHQUttQj35wMntJh/NRjbtg4GCzONUtwVsQ3wvm
         CzNT9SbxmMwn6iCkC0cqI7JgI1x7jHPimbcuoQcfqKxqc6jT43um0C4kEj2tkvI1VRjp
         SfFg==
X-Gm-Message-State: AO0yUKVZ6NY+3+olEYDq0sQ/wI5d4+FBTA2ZPrryBACcJ1M4bna7jNG6
        C9XQcHB3DsQ0+LjxvnurMeijC0+zoIjLXg==
X-Google-Smtp-Source: AK7set/NtqIRxTMq72QrCQ/eHjseET4A11QZlarpGMcEPw4VJj1W3710XQ37EZx7BckerGkjBUgd+Q==
X-Received: by 2002:a1c:7702:0:b0:3ed:4f7d:f6ee with SMTP id t2-20020a1c7702000000b003ed4f7df6eemr12399504wmi.14.1680012278343;
        Tue, 28 Mar 2023 07:04:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:37 -0700 (PDT)
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
Subject: [PATCH v8 2/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Tue, 28 Mar 2023 16:04:21 +0200
Message-Id: <patch-v8-2.9-49908f0bcf3-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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

