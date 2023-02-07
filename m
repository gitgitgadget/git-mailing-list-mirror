Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD87C6379F
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBGQLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjBGQK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:10:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5677FF22
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:10:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ee13so9668377edb.5
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0aBB27V2yiwNnkvOsoFaFoxqnsENoyUSG2aEzx8Ods=;
        b=LgsTFJqb5RtM5cCDEtAGs1DlUf8XDK5OeilgKQh08Di96FXM46nTcV926KVGM8JoaV
         lzewozQOPDiwINw1t/FhwdY1RKs0vVZ4tITaVyGzB9Lc15xwGcmYrwzo5bEzeSrFLq8o
         OZy3ehkXhxOdkoqviokqpSyO1srK0sRv0SXmn8BmyRWPMMkehd+J/WeXus0f4AC+G8rW
         l724AVyQcTUc1lcjRopG+WEQjcDwvhlxblXByrBZMwcd16oWmJO9HpTof5Y24mvO3UzN
         ue9wYz58+6Q1uvU8tT0fnIzw1WCBLGFAEqqM9d+6DiOpGQVCCzyJmgWZbQSWxLU0qKfI
         5qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0aBB27V2yiwNnkvOsoFaFoxqnsENoyUSG2aEzx8Ods=;
        b=rqsIw8sTk8UwZC9eAI2l1pyenvxcEwyMyN9IWzgGsc94BOrMB5vPctV9l2dtk0RABH
         jrI5O3y745BlCVd5WwR3Z/tdlxyjcwLZXpHz8G6NWwxGLADo3zqbJDwB9aJz+ORxlEkK
         YoZBxi8sWaabH059KVxj/v65+C4HqCqPqxosg3mRGBvJnEtMbryWoRfzOavim7gjSa/g
         odaOzdHFMgytmsIxhqcFKiknPH/LRNpSsyUjw2AWnFin77lWmu/ar+UqDbcP/3jF6bAo
         +Plz18mNMyL+pLF8WvSGoUt9V6/3Rt+GEC/961KupyU22oxtPUJVbVQ2om2V0tZYLWOQ
         Q5LQ==
X-Gm-Message-State: AO0yUKVlaZdiKRoeXIMkCn4xtdjyjcMm7P65VIo4cjCA8Ng5yOP0J/vf
        zUIR2fUZzFC1ZNf6ftke/npAoZiHM855aDEu
X-Google-Smtp-Source: AK7set9Ew1QW6sBn2SnbLf0WsnpDYAae64A2MDSdrD6vIddtCagTnBrTM+xueeE0Yp4QAF05gG/xuw==
X-Received: by 2002:a17:906:6d4e:b0:8aa:1971:bc75 with SMTP id a14-20020a1709066d4e00b008aa1971bc75mr2417736ejt.15.1675786257067;
        Tue, 07 Feb 2023 08:10:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:10:56 -0800 (PST)
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
Subject: [PATCH v5 02/10] config tests: add "NULL" tests for *_get_value_multi()
Date:   Tue,  7 Feb 2023 17:10:42 +0100
Message-Id: <patch-v5-02.10-91a44456327-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
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
2.39.1.1430.gb2471c0aaf4

