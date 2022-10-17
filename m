Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244AC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQMKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJQMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F271A21F
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t4so8492078wmj.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOdtniLp5VSsE3DbQ7Z3B+oO8L/2JwdWe6JaS7fSlmQ=;
        b=fT6zgU7rULs+7AqjsM6HlR238IIfobrHC/zZFZoh67wIsN3MqOzmnx69wlcA/gtCFB
         6DuSVyn0Uazf2V6GtiMMaSmhgJr/oKdcDClr/Kw0yR8qL2PX4FRz7u6vtGi96qZRXgba
         fpI+0DNWbIBZm4uHFFp9NPUuxmbwDNwlE9rK0DlPgYk3DhvHSYkLt/vwro+H3Vqe7x7m
         SbDFYphIidNSIXY9EpMR9FeDPvYtVAnD3WQ01q4aX5C9V39pkoLQNT/k0auBvALKrLFS
         B3eXi/YmKN/Pgkpq/xhJNzv7td+g/4Lxz6+je6h2yLtvM7UzbP6n5rdaEjQnxJn9xqRc
         HAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOdtniLp5VSsE3DbQ7Z3B+oO8L/2JwdWe6JaS7fSlmQ=;
        b=NuFduGEU6K7/ynk9wQxIk51WT0G2X94HeR3igLNejcL098d9ZK/1Dm/WQs66PJrvWP
         AzaLuaACX1YZIzZ5JBtJzOVOzEdaJcCjBB3aJTfXigi9pY179H7cXWthslocfRygzUqQ
         WwiCNitIZyP+4oluD09KqTQD10K3EvnCBAdZgDhXWDCDVoZLe7He9ydmgUXacxosokXA
         3CiO4s6Yuz83WeTOOn+5Gj1hWqaAfxIWn6k9WDsmx3a+j/6+gWG1B+WMG7xo8ROKx+Vc
         eEcQjTnvxyicWHqBIpCyKIdHnOH7sxmjoU1NTHeKy1iSL1ziRGM/4u+cDRiQY8XAVNhL
         sOrg==
X-Gm-Message-State: ACrzQf3P9KqydePeByGo9gHv2elNL3qzNTDJbJz0bQgAhbfEBGafmDk7
        8RpC1KejU+3doOUoz5VnU8q05BP7NOJ53A==
X-Google-Smtp-Source: AMsMyM4W9lnhiBMlmh816lqZV6H3ViiGGhp/fhE5N0Q7jeTKiOahVmzI0TrDLL8bYqWom+8wcv5dOg==
X-Received: by 2002:a05:600c:a45:b0:3bc:c676:a573 with SMTP id c5-20020a05600c0a4500b003bcc676a573mr19397434wmq.118.1666008580073;
        Mon, 17 Oct 2022 05:09:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] submodule: support sub-command-less "--recursive" option
Date:   Mon, 17 Oct 2022 14:09:24 +0200
Message-Id: <patch-09.10-7f232c5e503-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The inability to specify "--recursive" when we're not providing a
sub-command name appears to have been an omission in 15fc56a8536 (git
submodule foreach: Add --recursive to recurse into nested submodules,
2009-08-19). Let's support it along with the other "status" options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-submodule.txt |  2 +-
 builtin/submodule.c             | 16 +++++++++++++---
 t/t7400-submodule-basic.sh      |  6 +-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 345ebcafb9c..0c918390f2f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] [--cached] [--]
+'git submodule' [--quiet] [--cached] [--recursive] [--]
 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
diff --git a/builtin/submodule.c b/builtin/submodule.c
index 1d77f2d0964..ca8e273b6e9 100644
--- a/builtin/submodule.c
+++ b/builtin/submodule.c
@@ -64,7 +64,8 @@ static const char * const git_submodule_usage[] = {
 };
 
 static void setup_helper_args(int argc, const char **argv, const char *prefix,
-			      int quiet, int cached, struct strvec *args,
+			      int quiet, int cached, int recursive,
+			      struct strvec *args,
 			      const struct option *options)
 {
 	const char *cmd;
@@ -79,10 +80,13 @@ static void setup_helper_args(int argc, const char **argv, const char *prefix,
 		return;
 	}
 
-	/* Did we get --cached with a command? */
+	/* Did we get a forbidden top-level option with a command? */
 	if (cached)
 		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
 			       git_submodule_usage, options, "--cached");
+	if (recursive)
+		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
+			       git_submodule_usage, options, "--recursive");
 
 
 	/* Either a valid command, or submodule--helper will barf! */
@@ -92,6 +96,9 @@ static void setup_helper_args(int argc, const char **argv, const char *prefix,
 	argc--;
 
 	/* Options that need to go before user-supplied options */
+	if (!strcmp(cmd, "status") && recursive)
+		strvec_push(args, "--recursive");
+
 	if (!strcmp(cmd, "absorbgitdirs"))
 		do_quiet_cache = 0;
 	else if (!strcmp(cmd, "update"))
@@ -116,11 +123,14 @@ int cmd_submodule(int argc, const char **argv, const char *prefix)
 {
 	int opt_quiet = 0;
 	int opt_cached = 0;
+	int opt_recursive = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct option options[] = {
 		OPT__QUIET(&opt_quiet, N_("be quiet")),
 		OPT_BOOL(0, "cached", &opt_cached,
 			 N_("print the OID of submodules")),
+		OPT_BOOL(0, "recursive", &opt_recursive,
+			 N_("recurse into nested submodules")),
 		OPT_END()
 	};
 
@@ -133,7 +143,7 @@ int cmd_submodule(int argc, const char **argv, const char *prefix)
 	 */
 	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
 	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
-			  &cp.args, options);
+			  opt_recursive, &cp.args, options);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 0; /* for git submodule foreach */
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c524398e805..7cafc2e1102 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -20,10 +20,6 @@ test_expect_success 'submodule usage: -h' '
 	test_must_be_empty err
 '
 
-test_expect_success 'submodule usage: --recursive' '
-	test_expect_code 129 git submodule --recursive
-'
-
 test_expect_success 'submodule usage: status --' '
 	git submodule -- &&
 	git submodule --end-of-options
@@ -38,7 +34,7 @@ do
 	'
 done
 
-for opt in '--cached'
+for opt in '--cached' '--recursive'
 do
 	test_expect_success "submodule usage: status $opt" '
 		git submodule $opt &&
-- 
2.38.0.1091.gf9d18265e59

