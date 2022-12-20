Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86033C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiLTNke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiLTNkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:40:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354CF18E34
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:40:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so11162762wma.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAM8fLL6nPTKKRKuCB3KncxAhNS6pj0vTCvdD8vDXfE=;
        b=Yt3xp/4B8ag2bZeJBamSmiwiZ8XGRGuYeBKllSZUCXJ3i6Do1gCHDwz10OpZyFmKJu
         LSzPKZVeaoqWPkm3Q9424vrwEfaGU4BmmRTZFJjCicoaI2X3M0riTMmrhmqbczu9fBNE
         jy7++aHARhiRoexCWffIZVeYtd71a1e2B+55JtRgEkD/WFEcb3bzrq6K/+ElACoEs0hw
         pyuwS0OprQk0aniUVAaMK+eLwEAbucT2I2YFB81gUHUow0oLOQ5kp9JP7dEjjszyRCxX
         FedAxJwmowPPPlGN39SKG3Nya8BxPHZP1mjA1RkRsIJ2HQppigpiWPlCuRlhhYryN/Rk
         dP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAM8fLL6nPTKKRKuCB3KncxAhNS6pj0vTCvdD8vDXfE=;
        b=wxTkFqAZhmiA8PDs2v1VXhraVOP1R5pkLuL5+oMmDYzKIoRdN7xiXAPhpR51mV2W/C
         H4zlVaIjDAzHSx2BPL+OmhQhKg4nCEGW2QjLg43BxzPP3pMOnyXU5NcsxaDl3pUX3WbI
         PU/eXDKdMjzFCwZEbr+SSeYmno3n7iXp6buPO6H5CrRDioXZzDhKXR9oRlUTbQURq1dW
         tFbjQPWxJOB6DAsAvKftThtcD6ce4EK7T08EFOjXWo/VfiWVZlpGswyCjMCh0Q0WPNqy
         bYS3iY7TMD7D6HzGsK8Dc5dj8BLi6vu3oQG8ir9FuKZZQ7SJMf0brvzDF0ZmUSenWHtU
         byzg==
X-Gm-Message-State: AFqh2kqWttwlkiK87UlOgwHxMDj9J9jmA36ueDu+SEIsSCnriO2wX/ES
        8Tsg8N1mIR0rDMviN6VB1nMClWKru0eO4Q==
X-Google-Smtp-Source: AMrXdXtLAJ6L1k/G1n3L1QVCsaIaT4qlp/xbfvHnKfoWRNKe9YqufIoO6ZZ34ofwkdQEdDOupBnCkw==
X-Received: by 2002:a05:600c:4e48:b0:3cf:5d41:b748 with SMTP id e8-20020a05600c4e4800b003cf5d41b748mr1616994wmq.36.1671543626371;
        Tue, 20 Dec 2022 05:40:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b003d208eb17ecsm16971713wms.26.2022.12.20.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 05:40:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bundle: don't segfault on "git bundle <subcmd>"
Date:   Tue, 20 Dec 2022 14:40:18 +0100
Message-Id: <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <20221220123142.812965-1-hubertj@stmcyber.pl>
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since aef7d75e580 (builtin/bundle.c: let parse-options parse
subcommands, 2022-08-19) we've been segfaulting if no argument was
provided.

The fix is easy, as all of the "git bundle" subcommands require a
non-option argument we can check that we have arguments left after
calling parse-options().

This makes use of code added in 73c3253d75e (bundle: framework for
options before bundle file, 2019-11-10), before this change that code
has always been unreachable. In 73c3253d75e we'd never reach it as we
already checked "argc < 2" in cmd_bundle() itself.

Then when aef7d75e580 (whose segfault we're fixing here) migrated this
code to the subcommand API it removed that "argc < 2" check, but we
were still checking the wrong "argc" in parse_options_cmd_bundle(), we
need to check the "newargc". The "argc" will always be >= 1, as it
will necessarily contain at least the subcommand name
itself (e.g. "create").

As an aside, this could be safely squashed into this, but let's not do
that for this minimal segfault fix, as it's an unrelated refactoring:

	--- a/builtin/bundle.c
	+++ b/builtin/bundle.c
	@@ -55,13 +55,12 @@ static int parse_options_cmd_bundle(int argc,
	 		const char * const usagestr[],
	 		const struct option options[],
	 		char **bundle_file) {
	-	int newargc;
	-	newargc = parse_options(argc, argv, NULL, options, usagestr,
	+	argc = parse_options(argc, argv, NULL, options, usagestr,
	 			     PARSE_OPT_STOP_AT_NON_OPTION);
	-	if (!newargc)
	+	if (!argc)
	 		usage_with_options(usagestr, options);
	 	*bundle_file = prefix_filename(prefix, argv[0]);
	-	return newargc;
	+	return argc;
	 }

	 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {

Reported-by: Hubert Jasudowicz <hubertj@stmcyber.pl>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A proposed replacement for
https://lore.kernel.org/git/20221220123142.812965-1-hubertj@stmcyber.pl/;
let's move forward & add a test rather than reverting away from the
subcommand APIe

 builtin/bundle.c       | 2 +-
 t/t6020-bundle-misc.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index c12c09f8549..61c76284768 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -58,7 +58,7 @@ static int parse_options_cmd_bundle(int argc,
 	int newargc;
 	newargc = parse_options(argc, argv, NULL, options, usagestr,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (argc < 1)
+	if (!newargc)
 		usage_with_options(usagestr, options);
 	*bundle_file = prefix_filename(prefix, argv[0]);
 	return newargc;
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 833205125ab..3a1cf30b1d7 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
+for cmd in create verify list-heads unbundle
+do
+	test_expect_success "usage: git bundle $cmd needs an argument" '
+		test_expect_code 129 git bundle $cmd
+	'
+done
+
 # Create a commit or tag and set the variable with the object ID.
 test_commit_setvar () {
 	notick=
-- 
2.39.0.1106.g08bce9674be

