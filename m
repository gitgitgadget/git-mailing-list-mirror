Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4938C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKAXGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiKAXFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C02201B6
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so40867073ejc.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvW/vsitOlOepfFrt4VnD+xXlIsGDKeqjXxPxyR87NU=;
        b=ovaFj18/3vT+7TGhhelR2960Hz1gWhx8n9NgJPYO0vwgZGXeJhKjPNhRYNgJ3GqWLc
         +AJChm/3ywgzNMI795mqbdTeUT2C2hHEROh+pQq8G634vvHocJ1Iex2OxwbVGBgJOD5u
         b2sJm7EAQB2FfbHGt1x7jyxOe67OLpAba5Z6JysaCFLRivbG7UcLMM080LDk4/sSnma3
         iaouRPuQnVvMZ/bRcFbvgZ3IsoOKfwTAAEmwChyRY3Uxbp4sYA+Pog6e8nvV0/8rmuq8
         ddqsFMdV64NAmogWO+Jc/2p20ZwNjjCgHjbmPSnTNkcpsPceZbkBxQQTUFGEgeCBKoJY
         F61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvW/vsitOlOepfFrt4VnD+xXlIsGDKeqjXxPxyR87NU=;
        b=i5FOrbnlF/Duz5p0crBZSho6AWyv+nbOUyIyA+9KSKEYt0g80ikG08L+KIlst4gSbz
         BZH2wlUVXefsQWhjk3Z7FpqG/UKG2/mdoBxhHopj4p/swX3boxm71o/aKNcamt87CIzu
         jusNG7zfpURkEhbPBVhzn+XU/UWhrVtOtt4sMYTVk/8kQGHs9uaAK55srlvhZT54v0ne
         cHNd4nf2aqGFiSA4D524LXcCjaBgMe/AL/KG14Tr4eRIe9F/2LEOMhXmsjuUWWhUYmqj
         /aNHv18tnuOZsgm61AXI7gJ4rXuQ0YhYAD35HVYcCUMj2grq5fatrS/zbh3y88PJ9rGo
         Xy8g==
X-Gm-Message-State: ACrzQf1AbtDx0Hbgoz0q+S+uga+xzZtjYfKkIrUz4GatG66w/EZifxjz
        ppDH4Kq1Qabfc5mcm9SJc3OflcXYNV1o1g==
X-Google-Smtp-Source: AMsMyM6PxA8H72W1LF8fi2+aAYtQKCZYMQNnuyS1zNw7Oa+8YoPGlvYqtzRF6ohJ72nsXHKPxHfEmA==
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr21043818ejw.203.1667343940748;
        Tue, 01 Nov 2022 16:05:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Wed,  2 Nov 2022 00:05:20 +0100
Message-Id: <patch-v2-9.9-e2f8f7c52e3-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in 4950b2a2b5c (for-each-repo: run subcommands on
configured repos, 2020-09-11). Due to assuming that elements returned
from the repo_config_get_value_multi() call wouldn't be "NULL" we'd
conflate the <path> and <command> part of the argument list when
running commands.

As noted in the preceding commit the fix is to move to a safer
"*_string_multi()" version of the *_multi() API. This change is
separated from the rest because those all segfaulted. In this change
we ended up with different behavior.

When using the "--config=<config>" form we take each element of the
list as a path to a repository. E.g. with a configuration like:

	[repo] list = /some/repo

We would, with this command:

	git for-each-repo --config=repo.list status builtin

Run a "git status" in /some/repo, as:

	git -C /some/repo status builtin

I.e. ask "status" to report on the "builtin" directory. But since a
configuration such as this would result in a "struct string_list *"
with one element, whose "string" member is "NULL":

	[repo] list

We would, when constructing our command-line in
"builtin/for-each-repo.c"...

	strvec_pushl(&child.args, "-C", path, NULL);
	for (i = 0; i < argc; i++)
		strvec_push(&child.args, argv[i]);

...have that "path" be "NULL", and as strvec_pushl() stops when it
sees NULL we'd end with the first "argv" element as the argument to
the "-C" option, e.g.:

	git -C status builtin

I.e. we'd run the command "builtin" in the "status" directory.

In another context this might be an interesting security
vulnerability, but I think that this amounts to a nothingburger on
that front.

A hypothetical attacker would need to be able to write config for the
victim to run, if they're able to do that there's more interesting
attack vectors. See the "safe.directory" facility added in
8d1a7448206 (setup.c: create `safe.bareRepository`, 2022-07-14).

An even more unlikely possibility would be an attacker able to
generate the config used for "for-each-repo --config=<key>", but
nothing else (e.g. an automated system producing that list).

Even in that case the attack vector is limited to the user running
commands whose name matches a directory that's interesting to the
attacker (e.g. a "log" directory in a repository). The second
argument (if any) of the command is likely to make git die without
doing anything interesting (e.g. "-p" to "log", there being no "-p"
built-in command to run).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c  |  2 +-
 t/t0068-for-each-repo.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 96caf90139b..9f52d6e0568 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -43,7 +43,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	err = repo_config_get_string_multi(the_repository, config_key, &values);
 	if (err < 0)
 		usage_msg_optf(_("got bad config --config=%s"),
 			       for_each_repo_usage, options, config_key);
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 115221c9ca5..c27d4dc5f71 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -39,4 +39,17 @@ test_expect_success 'error on bad config keys' '
 	test_expect_code 129 git for-each-repo --config="'\''.b"
 '
 
+test_expect_success 'error on NULL value for config keys' '
+	cat >>.git/config <<-\EOF &&
+	[empty]
+		key
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''empty.key'\''
+	EOF
+	test_expect_code 129 git for-each-repo --config=empty.key 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.0.1280.g8136eb6fab2

