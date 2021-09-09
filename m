Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD700C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97CE61059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbhIIOUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbhIIOTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA367C10DC46
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so1402961wmi.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4+ryNm5+CD2dBR5sVF6+8JwaQ9mh+UY5gTpMjTHb8k=;
        b=Vdw9k6Qc46ua/wr+fWhx1yPtVMv/cXamfT4/x0WaQ3pT3rSaSMtKrnAHtvw1gk3jnC
         8EF0n4CzAotQorGEs8/M1TAA0GLbz6at5R2/AE/U+BcoXmeirVcgw582v2ONiQKBgtzR
         E/tvdLi5Zgleb+6pmAHykQbEDMRCioU8rf3YHCUEGxj0JuKjySxWuDDXst6Cu8E6GmoE
         +4CYeS8Xm8w9zUQeOShf95zHIU1+rm38hoETTpdFqNBTRQerVenVfG1zyoADYZRMsIRl
         0vfZMrU6tYDv8YghzETfGZ2lcz3zYRmUwdHNjNbNKRTZCDodgy/hqioJAI0hXkNyfHBX
         jr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4+ryNm5+CD2dBR5sVF6+8JwaQ9mh+UY5gTpMjTHb8k=;
        b=o4EvBdBoL5b+J2ThphVTogPBi2hDXNOYg5Xmkx2vdO6kdcFTtWpDd4LM4YEvEdbsRZ
         Jgs5FhNIBXSUn+oRNCvui041fxdoIjbkMKFaQHWjBMv/uhE3Pj4K6YU3kzE6oy+06hjc
         JPxuwVQ88p0x8/1nwDAy2iK5lU35rINfnE4A8663S1QJeEX7oonTNQuUnDl7q8S6P1RQ
         ASv+O8uWrA5In/NQ2+N5mdUd6lruzEJ7TNKB5MQjvrPJ1F4r20fn1Te02/h7qF6bwio4
         kZk5waS9F2B9rS44VAXbfXUHL0I/PRcWvMhcF5PkDFL+qQvCxE4EcWQ+HSnbpxrJ1Dac
         ZskA==
X-Gm-Message-State: AOAM533Bxh3obDdujWUgV/ukjzl138xsLHFxjpatxPohbYpiVvWsPdh4
        r2vhWSQUw/wsu5niCMgJDiUPjymwQVspOw==
X-Google-Smtp-Source: ABdhPJz5Bl+rJmoDOrxIafliSRcrskYZtYCJeWIqi/Q51ScnapMCUVFQifiTLGfGhSCKcW/+OaglAQ==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr2832671wmc.114.1631191332050;
        Thu, 09 Sep 2021 05:42:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/5] hook: introduce "git hook list"
Date:   Thu,  9 Sep 2021 14:42:01 +0200
Message-Id: <patch-v4-3.5-3e647b8dba7-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

If more than one hook will be run, it may be useful to see a list of
which hooks should be run. At very least, it will be useful for us to
test the semantics of multihooks ourselves.

For now, only list the hooks which will run in the order they will run
in; later, it might be useful to include more information like where the
hooks were configured and whether or not they will run.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hook.txt |  5 ++++
 builtin/hook.c             | 52 ++++++++++++++++++++++++++++++++++++++
 t/t1800-hook.sh            | 14 ++++++++++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 79e82479ec6..88588b38143 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
 	<hook-name> [-- <hook-args>]
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
 arguments (if any) differ by hook name, see linkgit:githooks[5] for
 what those are.
 
+list::
+	Print a list of hooks which will be run on `<hook-name>` event. If no
+	hooks are configured for that event, print nothing and return 1.
+
 OPTIONS
 -------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 9b6272cfd3b..1e6b15d565a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,8 +8,11 @@
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+#define BUILTIN_HOOK_LIST_USAGE \
+	N_("git hook list <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
 	BUILTIN_HOOK_RUN_USAGE,
 	NULL
 };
@@ -19,6 +22,53 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
+static const char *const builtin_hook_list_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
+	NULL
+};
+
+static int list(int argc, const char **argv, const char *prefix)
+{
+	struct list_head *hooks;
+	struct list_head *pos;
+	const char *hookname = NULL;
+	struct option list_options[] = {
+		OPT_END(),
+	};
+	int ret = 0;
+
+	argc = parse_options(argc, argv, prefix, list_options,
+			     builtin_hook_list_usage, 0);
+
+	/*
+	 * The only unnamed argument provided should be the hook-name; if we add
+	 * arguments later they probably should be caught by parse_options.
+	 */
+	if (argc != 1)
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_list_usage, list_options);
+
+	hookname = argv[0];
+
+	hooks = list_hooks(hookname);
+
+	if (list_empty(hooks)) {
+		ret = 1;
+		goto cleanup;
+	}
+
+	list_for_each(pos, hooks) {
+		struct hook *item = list_entry(pos, struct hook, list);
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s\n", item->hook_path);
+	}
+
+cleanup:
+	clear_hook_list(hooks);
+
+	return ret;
+}
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -94,6 +144,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		goto usage;
 
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 6431b19e392..7a1dae4e95e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -9,6 +9,8 @@ test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
+	test_expect_code 129 git hook list &&
+	test_expect_code 129 git hook list -h &&
 	grep "unknown option" err
 '
 
@@ -97,6 +99,18 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list: does-not-exist hook' '
+	test_expect_code 1 git hook list does-not-exist
+'
+
+test_expect_success 'git hook list: existing hook' '
+	cat >expect <<-\EOF &&
+	.git/hooks/test-hook
+	EOF
+	git hook list test-hook >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run -- out-of-repo runs excluded' '
 	write_script .git/hooks/test-hook <<-EOF &&
 	echo Test hook
-- 
2.33.0.867.g88ec4638586

