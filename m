Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B5C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5743961992
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhCWPYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhCWPYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 11:24:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B18C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 08:24:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so21184747wra.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8T5gMJ5hIWIyynkkFupvDl4OX03Wqd2YFBLy/RA/syY=;
        b=i3iXcgYvI/IGBlTXx6/51GyyacXVy1AvGoMdJE9tVe4j7KkyMbryXT/bIhlTNAXnMT
         8+K+S7GTR5q4VHprGCH1Q8qsNWjFACwA0FH6vVH1jfNxG8Q7tZWJ0ozz7l+OHmfy47ri
         tbhZGNDjxWUaEPBQE6qWCucP0ycwuaARqcazpAllRQlrhHSjzDphhLwhI8clAVWocMry
         R+N13ti27pKfpgvC3xx79Ape7ycgWfkVlrVz+VJp/4I6355vN44vciDLqtyMjE40+HbF
         LoJ5Pf7R1Zl8rWTJSNB5/6t5brVVVmIjRcCB+ez+A5aRlkIwGN3wMRoyEllFp7L73eVH
         Lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8T5gMJ5hIWIyynkkFupvDl4OX03Wqd2YFBLy/RA/syY=;
        b=fUjJfTtza7UD3zc8flHIa2B+hjb7+KMDFDGE6wnsSbzrV7oTf+5JnV7A/v0gPpI2Fw
         fygyRPxXZNAXLTfgM0G0gVCZ1s+mguEb3zGytFt3GlQqMAtRYXyANHpTDLNcuwDmw2F8
         LmrHG7RYs6jOIEGK+dPsjnepb2/EZZ0l07LuwqMdSU78mYcX0klJ1WELV3HEvLZPvibp
         +sR0V8qIoqhrSJrIqmMJr71K5NVGmI8bmfyu0bO8vyLFR+eJX+9bCYN5bTa/T75m2Ivf
         YaATq90TZSAykxld0m4e6zNaERzNtofH8p4H64cghG130z6ebZtu4GWjvDWcG4+PMbo2
         5PFg==
X-Gm-Message-State: AOAM533hg9YRSc1th8lbC8ElMzxZyEVMQ+9Qtwris6Y/WFM3fiPMoQT/
        h9GY1vg+YkSXgZbBB+RKRqu82qeEuo8=
X-Google-Smtp-Source: ABdhPJziE5ws4wi9TEYXvuL4lSQBn2/lHUb3VRQJ4Yv26dpQ1XeMCQCMOetMCWGERqoGQ5rlJSVkuQ==
X-Received: by 2002:adf:f144:: with SMTP id y4mr4627411wro.408.1616513052781;
        Tue, 23 Mar 2021 08:24:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q207sm3141446wme.36.2021.03.23.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:24:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] rebase: remove transitory rebase.useBuiltin setting & env
Date:   Tue, 23 Mar 2021 16:23:58 +0100
Message-Id: <patch-1.1-df026b00b67-20210323T152302Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.g75c23356abd
In-Reply-To: <20190318110152.27246-1-avarab@gmail.com>
References: <20190318110152.27246-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the rebase.useBuiltin setting and the now-obsolete
GIT_TEST_REBASE_USE_BUILTIN test flag.

This was left in place after my d03ebd411c6 (rebase: remove the
rebase.useBuiltin setting, 2019-03-18) to help anyone who'd used the
experimental flag and wanted to know that it was the default, or that
they should transition their test environment to use the builtin
rebase unconditionally.

It's been more than long enough for those users to get a headsup about
this. So remove all the scaffolding that was left inplace after
d03ebd411c6. I'm also removing the documentation entry, if anyone
still has this left in their configuration they can do some source
archaeology to figure out what it used to do, which makes more sense
than exposing every git user reading the documentation to this legacy
configuration switch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/rebase.txt |  7 -------
 builtin/rebase.c                | 11 -----------
 t/t3400-rebase.sh               | 16 ----------------
 3 files changed, 34 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 214f31b451f..8c979cb20f2 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -1,10 +1,3 @@
-rebase.useBuiltin::
-	Unused configuration variable. Used in Git versions 2.20 and
-	2.21 as an escape hatch to enable the legacy shellscript
-	implementation of rebase. Now the built-in rewrite of it in C
-	is always used. Setting this will emit a warning, to alert any
-	remaining users that setting this now does nothing.
-
 rebase.backend::
 	Default backend to use for rebasing.  Possible choices are
 	'apply' or 'merge'.  In the future, if the merge backend gains
diff --git a/builtin/rebase.c b/builtin/rebase.c
index de400f9a197..783b526f6e7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -100,7 +100,6 @@ struct rebase_options {
 	char *strategy, *strategy_opts;
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
-	int use_legacy_rebase;
 	int reapply_cherry_picks;
 	int fork_point;
 };
@@ -1102,11 +1101,6 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
-	if (!strcmp(var, "rebase.usebuiltin")) {
-		opts->use_legacy_rebase = !git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "rebase.backend")) {
 		return git_config_string(&opts->default_backend, var, value);
 	}
@@ -1441,11 +1435,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	gpg_sign = options.gpg_sign_opt ? "" : NULL;
 	FREE_AND_NULL(options.gpg_sign_opt);
 
-	if (options.use_legacy_rebase ||
-	    !git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1))
-		warning(_("the rebase.useBuiltin support has been removed!\n"
-			  "See its entry in 'git help config' for details."));
-
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "%s/applying", apply_dir());
 	if(file_exists(buf.buf))
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 587b408063a..0bb88aa982b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -388,22 +388,6 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
 	)
 '
 
-test_expect_success 'rebase -c rebase.useBuiltin=false warning' '
-	expected="rebase.useBuiltin support has been removed" &&
-
-	# Only warn when the legacy rebase is requested...
-	test_must_fail git -c rebase.useBuiltin=false rebase 2>err &&
-	test_i18ngrep "$expected" err &&
-	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=false git rebase 2>err &&
-	test_i18ngrep "$expected" err &&
-
-	# ...not when we would have used the built-in anyway
-	test_must_fail git -c rebase.useBuiltin=true rebase 2>err &&
-	test_must_be_empty err &&
-	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true git rebase 2>err &&
-	test_must_be_empty err
-'
-
 test_expect_success 'switch to branch checked out here' '
 	git checkout main &&
 	git rebase main main
-- 
2.31.0.366.g75c23356abd

