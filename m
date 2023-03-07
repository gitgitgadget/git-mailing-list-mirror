Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE6C678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjCGSQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjCGSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:14:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BBA188F
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:10:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id da10so56022696edb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=lsqD8iB2W3HAKReyokFm4c/imIp3WTG6gboBGesgoJEhZz8iPeP8SbmOU4wb4FQsIY
         46pBZWX9qIKWFLsbcTVf2U2kNWap9coaE0ZRdedi9i6knX9npl/M0sJLdfWKY+VRFG7S
         oIjLCRpKGzjy0luWo4ivN3lalVjJ9DXLBQGsCbwNDlktqi+11bnUjRGUgPdytXu3sEF7
         pdu4jGpSDCbVjhD66eS6PvrGQ4CqNf2uv812suPh4n/2SAyZoKs3DuExD3N887G3i9Oq
         0sbDslWshuZDELNPi5wi6RjVHibFbwiHebJPYgujVcAzxZOtOaPu0GN218eFV+D0C3VS
         dguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vhB/VvuxpEFLBgJp0BccsdhTjWfa6KSYpVrKo2IRgo=;
        b=MOvCN/QJvGnnduhwjlkvhMeyU69Zp35nxnopsr1HUzQ3wEZ3YwR7I0MtnTBqCiiFwL
         ELk++dC3eG3dhmQ0d3OzdPyzgvl/jgR+BppR9LDSKezrwm1+25BLb36imSe4jUbrV7B2
         HcyD7LedYgoLreB0rJbTkQVx+wm4wikT//FpwZch15JP6pWsfqyt2ZuKnpa+PgEsDRdv
         ebhb/uFqpTNlzoa+KVtcVF9AUIBvDAguvkyFZCl+z9SOYfTcaaK+cTNQH0EBSuqG8bkT
         UG+9ldqLKLghz0t1/7/mgYZmLOlBW14Ii2Dwb/EvvzDXacOojHXlGu2OPghkMUk4U7FU
         rjMQ==
X-Gm-Message-State: AO0yUKWO1gApLV2SWEPshJnn0RGAnlH6nUjgR0UzEq6RftYMcSpbz8Ve
        pihatZw7+QBnjCdhsQtgfRAjLNgLfhdZ0w==
X-Google-Smtp-Source: AK7set+KsR1oQSTH3bQWgRfZiNJ7NBNfrh8Y3nXwt/Hxm/pKlNAmpDA2PYCtXh5yC0GTNMFx5sKnSA==
X-Received: by 2002:a17:906:b751:b0:8f7:51e5:99d1 with SMTP id fx17-20020a170906b75100b008f751e599d1mr16538754ejb.37.1678212603107;
        Tue, 07 Mar 2023 10:10:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm6401008ejj.215.2023.03.07.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:10:02 -0800 (PST)
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
Subject: [PATCH v6 2/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Tue,  7 Mar 2023 19:09:33 +0100
Message-Id: <patch-v6-2.9-4b0799090c9-20230307T180516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
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

