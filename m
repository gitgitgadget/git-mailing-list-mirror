Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE6DC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJQMKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJQMJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3C1A20B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l32so8520950wms.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r37l8qjjqylHuf8OFZAvBm3VQ6GMlQDnnLyNl/cAid8=;
        b=Y77h0B23nJmii63oWoe68sDh6yjHJaC5wuVzNETskYMxG2txQqSPNY+7OD4xsg76kw
         2zuD34chC3vUwLjr0Gk8uOE72EUtvYjWDFhDkcjE0+DaXtMit5nsyyrAaxpK+McVWulr
         6A6s1CDowLfjFmAlFkPL8Uyy85S8zf0448y43aORyPfqvlnS9Ax+M3jOs3W6uAa9ofSy
         3myWVrpWYa+729rVAXAGjYqbSGdSc2Xm0LQY0Rw2L9nyuvKVypwT4z3NVGY2xb2M7xaQ
         6zw6Z7+KQxrSe9QIXRzQHGlCTE4GQh2uXEv64I7N5uBAkwQdA0UEh+NbCZ5MQ8Px73rj
         4+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r37l8qjjqylHuf8OFZAvBm3VQ6GMlQDnnLyNl/cAid8=;
        b=jPvQEySag/D4+rbCAMghAHjn+HsSOmP3Tu8XCM8VCNMtNULM7fIgVsHWe0Z4FJ1fkY
         JKYCFtlyv8WEx9TTJw30FquwbMYVFtDPvlHMj8x+ya2zNLNfoRw31xC6bifbQGILxC0s
         ULA6CLHzS6tALyx95XkBQ3WklBv8xHGd4vl64wnA/l7xVq0J3iX+bqvMlNG2psSgLA/O
         2fFGn8EJo/fwwVbbixfcrAt7rLb46zCfFUf44PQN12B5MJ0B3nV2pLxoG/RlF2kDzTGl
         +FoZlBxKIY7gJiPMK6kxyAN1VuBHF0E0nllsEnLO+8z0TXRIS1gp+zDdm2kZbMFt/xXz
         vM7Q==
X-Gm-Message-State: ACrzQf3e/6aCj0jFhmBg6YT2r+u0ueTOYNqLS2f4Mnxj9vvxyjesAZhD
        U/brLZFJ85Vy/fIcCKlVGv+ZrRuqHqdooA==
X-Google-Smtp-Source: AMsMyM6E0kH6BtWmLNT+gOEntKW//QVF7tH7D6GurpSBtx8AvgsVi1CQm8LTAzwdkjaeK5eJKxHyDA==
X-Received: by 2002:a05:600c:4fce:b0:3b4:935f:b952 with SMTP id o14-20020a05600c4fce00b003b4935fb952mr19123902wmq.197.1666008579099;
        Mon, 17 Oct 2022 05:09:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] submodule: support "--" with no other arguments
Date:   Mon, 17 Oct 2022 14:09:23 +0200
Message-Id: <patch-08.10-8dbb81e2fa5-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address an edge case that "git-submodule.sh" has had all along, but
which became painfully obvious in the *.sh to *.c migration in the
preceding commit.

We didn't support the "--" delimiter in the argument-less
invocation. Let's not bend over backwards to behave unusually in this
scenario, simply accepting "--" is harmless.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-submodule.txt |  2 +-
 builtin/submodule.c             | 12 ++----------
 t/t7400-submodule-basic.sh      |  4 ++--
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f92..345ebcafb9c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] [--cached]
+'git submodule' [--quiet] [--cached] [--]
 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
diff --git a/builtin/submodule.c b/builtin/submodule.c
index 7e3499f3376..1d77f2d0964 100644
--- a/builtin/submodule.c
+++ b/builtin/submodule.c
@@ -8,7 +8,7 @@
 #include "strvec.h"
 
 #define BUILTIN_SUBMODULE_USAGE \
-	"git submodule [--quiet] [--cached]"
+	"git submodule [--quiet] [--cached] [--]"
 
 #define BUILTIN_SUBMODULE_ADD_USAGE \
 	N_("git submodule [--quiet] add [-b <branch>] [-f | --force] [--name <name>]\n" \
@@ -91,14 +91,6 @@ static void setup_helper_args(int argc, const char **argv, const char *prefix,
 	argv++;
 	argc--;
 
-	/*
-	  * This is stupid, but don't support "[--]" to
-	 * subcommand-less "git-submodule" for now.
-	 */
-	if (!strcmp(cmd, "--") || !strcmp(cmd, "--end-of-options"))
-		usage_msg_optf(_("need explicit sub-command name to delimit with '%s'"),
-			       git_submodule_usage, options, cmd);
-
 	/* Options that need to go before user-supplied options */
 	if (!strcmp(cmd, "absorbgitdirs"))
 		do_quiet_cache = 0;
@@ -133,7 +125,7 @@ int cmd_submodule(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	/*
 	 * Tell the rest of git that any URLs we get don't come
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 19df3407ef1..c524398e805 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -25,8 +25,8 @@ test_expect_success 'submodule usage: --recursive' '
 '
 
 test_expect_success 'submodule usage: status --' '
-	test_expect_code 129 git submodule -- &&
-	test_expect_code 129 git submodule --end-of-options
+	git submodule -- &&
+	git submodule --end-of-options
 '
 
 for opt in '--quiet'
-- 
2.38.0.1091.gf9d18265e59

