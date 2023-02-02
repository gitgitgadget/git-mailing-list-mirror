Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4366C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjBBN1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBBN1x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:53 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F78F24B
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1398712wms.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIVfkWFemhCYepVOzHTkqvP7n8I4Nt6Qxao618nS0R8=;
        b=nn5Da2qDA1wmTIefJpK+QepMrwHIAFh+UXGULUgc/huWDFdggtKnH0P9LxIdxZ45rh
         pukU5rUUIrkgMFMCS7eP2JJqRDDlEmF27lKUk25jzmV+qVE0q9QDi6yEo7AyX6gw8F2h
         XHFPN28abdOqBNiAdsov8zY/ve2PspzJ1VzGVt9d0Cs2TQSVGbTgQETKk8b7z/PoNUd/
         TMVVmlU47dcxXNnO4h2RtMmGW15TG/hUV4Vf6wsHMsFN6SRmygsQeDdlclDwNcmZaIew
         VolZPCPlrscN2FlDeBBDVNnq3zCM968eIbyDxwVNCHpINKN+UGBjTKS2VEJSjYblcieu
         X9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIVfkWFemhCYepVOzHTkqvP7n8I4Nt6Qxao618nS0R8=;
        b=jZ3sQieX6wZ8lw5WeZvlLk/9mhUzVzOGFP1TsGVdjEGNUyfS7j42hTEZXgUJIwd8cR
         1x09BF/Dze4/fDSRv+Bj0pIbGZ4FR56mxvPbvq2J+kFYfiMh/TzisZ9LAYdt2Gvfs0aQ
         nZ+AUe1kXRcgM/KMuMEtNDq7wRMLVRmscSYbPPll4rI2dXEqjn36m0/qxUgpCEmeldyh
         v1cRHGXVaodJXfLGuGCd+1ZxCi0kZu41ePoeOEjPlqdp0wDpWT+pEWWKrzLatv6EN1mt
         0HlRfMTsgKgvBE/KHR8VJOLX8lXWvJg4cam++eLd90uY3qCwJo8IXycGRhgDsobkjLqw
         VHSw==
X-Gm-Message-State: AO0yUKVV7llTW9T2pz0NLw3BbPiCysRllryfrldk+K0AaLWypyOjrwa4
        w0byhl0aihv9MExc6GKTKo6QKJIksYzrgcgQ
X-Google-Smtp-Source: AK7set+k7b/V6DjJt6M+0cI1PX2rzckhkfRz0vkC83yvyy5J4ucLouG7R5eIW+kqZudydPrU75y/5g==
X-Received: by 2002:a05:600c:3ba9:b0:3dd:daac:d99d with SMTP id n41-20020a05600c3ba900b003dddaacd99dmr5658658wms.36.1675344450516;
        Thu, 02 Feb 2023 05:27:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:29 -0800 (PST)
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
Subject: [PATCH v4 2/9] config tests: add "NULL" tests for *_get_value_multi()
Date:   Thu,  2 Feb 2023 14:27:14 +0100
Message-Id: <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
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
 t/t1308-config-set.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b38e158d3b2..b172565f92a 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -146,6 +146,47 @@ test_expect_success 'find multiple values' '
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
2.39.1.1397.g8c8c074958d

