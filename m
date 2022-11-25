Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA7C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKYJzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKYJyg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563FB48755
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:52:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so6024577wrb.0
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzYcG+zB3MBLBP80r/GiaD6DPW5CcLKPsFpk2Bj+idM=;
        b=lNqNpGTfK/HrAC12OAfsPzPYhBrai1Jcy/00epKq74GreEiDgGMMX0VONGegD61Ylx
         +iPzE6XGCd8RINmwP9G26xk4E1vHQBzXRabHI+U1DHQjs4IP2pbe/ZJAYLZuRg+O25Gs
         K+8N5WRn3VXremadEpM8pkeBaBwXzlifKGZjW6LOoj6+WRQ3uoJ0SXpqt6Sy1Or6yKOO
         QEK1yKcKp/T5XXkvffm/KRALL7zrbAGOLU740NZT0lAv7XArUdABSem9znUxXMvqwp2+
         nCVU0VfMHWQ16rcB0kvJRpkdvRJfA6iQVPWRRY/AHRUZCwGULYtZ4yM22HNYomigVuyK
         L/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzYcG+zB3MBLBP80r/GiaD6DPW5CcLKPsFpk2Bj+idM=;
        b=77FwcnUkIFc5sO1N34+FCLgFOdCfOKc8jgxyqpX5PTcV9itwKMoDmiV4CSAPCRlDRJ
         1jGAdNRf1jlmbcsh++AmoqIjlyZy4brlhUeOA4OQlAn39Lj+D+74oxPQAdoi6rIjkm0O
         HeB1Qza6Zaufa1AIpX2qVUD6128y5m1bD1rzlHtfxI9KDbqOTfqRxyAkLleyN9RRbIdZ
         FmU2v4J5B84CNkOwtlvPxpOcabCdTtj1SaW+8dUz3LhKoo2xEkYoOBdStjt7/ceRx2Lg
         UJ47q3zsUkjSBQlj5hVtbuQatYOheBuSB9NWPjOAh9xJwOeCBNlXJX2RPOP+WmYdLA7k
         qeVg==
X-Gm-Message-State: ANoB5pk4bdD49OzEVlI/t/wFVIlBefNXS0TRcmabXzBxUtZSQnn9t0Q5
        DjoRK5OtXKzU3Aax9NWjF3nQ355m1z4F5viE
X-Google-Smtp-Source: AA0mqf5tTFI/CKMBMsi3XEtSd7ETazJvAAxMIBlPNAIQKbSHU5TClfI+pEor8x4GPblW1w5+M2M6lA==
X-Received: by 2002:a5d:55c3:0:b0:236:c12b:6e29 with SMTP id i3-20020a5d55c3000000b00236c12b6e29mr22232131wrw.98.1669369890513;
        Fri, 25 Nov 2022 01:51:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Fri, 25 Nov 2022 10:50:10 +0100
Message-Id: <patch-v3-9.9-58ead3ca555-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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
index 224164addb3..ce8f7a99086 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -46,7 +46,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	err = repo_config_get_string_multi(the_repository, config_key, &values);
 	if (err < 0)
 		usage_msg_optf(_("got bad config --config=%s"),
 			       for_each_repo_usage, options, config_key);
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 19ceaa546ea..48187a40d64 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -45,4 +45,17 @@ test_expect_success 'error on bad config keys' '
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
2.39.0.rc0.955.ge9b241be664

