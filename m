Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D8FA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiJZPhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiJZPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:37:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3340513331D
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so18786231wrq.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjR5MStriQ2BWCyiFta0V5akmF/RpPVp9tflD5MZrQg=;
        b=LgKyjIfy97Mrgq3S6Mba7e6eghdbQ2PWk3XcahlDcb93b7F4UJbzGypz9Ng6ohjMGi
         DiV9YR2o9egWSfoCgv8zIKVnp7ydWCgE+ctq7xlgO90YqrTZR/+AEKm840USkFjaQQge
         eRnCyebS3fL+RMoIii28g5nVDyJDyOogcaGKC+yaBvuc1iiivgOVWFrzGw5PfpNIOFxg
         VWmlGGH/5+X5FjsuTObenp4S82iUaRxlAVGX5D3jttse044cGvTKD/CffQzQBNzGvE3D
         r6iap0MFl9qJpUModXPuh3wjM7npZDY7moEEUs/zIcYN2r5IVGp8aJ89qYEfqZOHlqkx
         xGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjR5MStriQ2BWCyiFta0V5akmF/RpPVp9tflD5MZrQg=;
        b=LozG0NHB1rDA3D3bvbBMifpUiAMXM0KDegguTp5Zk4YieqXDxOZkBLisuBcdiEe6As
         LgNoo2JESmKpzVbt4ynyzWnUhWax8BAnPOu6TIbvQUfkQ6x2/CfHF6Reewu1dqvMXGOH
         eYf+xFKODO474AcWrJPHdK5RA7vzesn3ieI00iQwd3kiB1xhmNS+yQKihtoOO5fYeZlo
         mebvRybit4DzXyzt13jybbFFfLnhMTQd1KVO93L5VftjvxoEWGTmTU4LEh4ilsEpYQo6
         B1XNxUBxeW6z7wDrmIFynCCf49rJQwrnpeaz28QYm7AdvJgYXt66oKxBwJZ22X4QBvDm
         W0dw==
X-Gm-Message-State: ACrzQf2IeDYewHU4hGb1jdKJnF5rs9wr1oUtct5GwWniH6tRzpNoSazd
        9sk3sHxZftkzn1FSPp/3O8gJp5T5ovZNjg==
X-Google-Smtp-Source: AMsMyM55zis9UakqjB3OSY6vTjPsemaneCU8+juRyn5xDHOp8IrvWnXa3vLo9nw2+LOlyzp9BtrPPg==
X-Received: by 2002:a05:6000:1562:b0:231:1b02:3dbb with SMTP id 2-20020a056000156200b002311b023dbbmr29425081wrz.685.1666798609220;
        Wed, 26 Oct 2022 08:36:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Wed, 26 Oct 2022 17:35:23 +0200
Message-Id: <patch-10.10-b59cbed8f61-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
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
"*_multi_string()" version of the *__multi() API. This change is
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
index 16e9a76d04a..125901f2fc0 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -43,7 +43,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	err = repo_config_get_value_multi_string(the_repository, config_key, &values);
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
2.38.0.1251.g3eefdfb5e7a

