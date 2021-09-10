Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5105360295
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhIJPkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhIJPkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:40:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2BC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s24so1513803wmh.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqS7usYgHsZcfanoSrDwIY0ZZqrgvd2N/Aa7zSOkCZE=;
        b=KG5fn8JrtSR2bjhVMd2z1eSXv/JsVCxlZiNqlnPN1Nhl5w7nufxW8j9rb/cuhAXu3G
         KA/MoRE8Rna3trN5PLoVIxBoJ2ZRUR/hN1ysLyrvzUGJtVE7yhnJu6kTwk6cZobh1512
         pDqgTB2oY+aUvA2N8owAhbS766gqOlQOrF5tlB9MyKx3tsuwzOAiLQVUUAXiErTt2gsp
         loXGMXUiq1U+dHzSV7ZRLhx/fNw/ES+nSh+DGXrudAJXn9fgqVfz1jk9wDdd2C/JW4gC
         HxQavPRpEWELTWB6MEJ8eKRRc4VJeoWrhIrLYD4TEpxD9yiy8kNz6lHtHLqYSf86tquJ
         uzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqS7usYgHsZcfanoSrDwIY0ZZqrgvd2N/Aa7zSOkCZE=;
        b=3/wsKsJnI50tDoKysIedwELbqQ7VcwGXRFdRNP2amwXZu3bxLm6i6YIYRMEHB4Co95
         xTxzjJlWjLTLPJRZ2tx2PQeS8IMMIj9KnUuemkgNEO18xphffPRM439/QPjCtlG9tPuw
         2AR2GBcr4s6TLWEixlHmwHd2EpWsxqHScqGbUBDsLKZY6ZGJeeLHiufw0VyVTVpWE5Aa
         RU+v9wrhP9Qbc+1T1GrglBoqVGubvYbJA2paTB7ezG/iBhxzbepZmg5Gw06xD7mPG+Co
         REnnADRCZAW5GOxkSW61pzzT13WsFRAlA1ZMHxg4NOaPLgEQ7NsT4GCiEu5mTHPTRave
         Ch3Q==
X-Gm-Message-State: AOAM532IKqzun4EfUNbFIF7DkMPFW4ZCkiWoaa2Qk+PjMKq18HjOftt3
        XSMly98sx0weFlYyFXZ2fQG6h1xfA0sooA==
X-Google-Smtp-Source: ABdhPJyfzSYpEJ3VTSnQc5u5BIFJkPyZo76n1QKna/eiyXDDM4dvGglqvdbSB+Ii1ZLCy81LYWy/YA==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr8883039wmj.163.1631288327122;
        Fri, 10 Sep 2021 08:38:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] parse-options: stop supporting "" in the usagestr array
Date:   Fri, 10 Sep 2021 17:38:33 +0200
Message-Id: <patch-v2-3.6-11f4a119563-20210910T153147Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strings in the the "usagestr" array have special handling for the
empty string dating back to f389c808b67 (Rework make_usage to print
the usage message immediately, 2007-10-14).

We'll prefix all strings after the first one with "or: ". Then if we
encountered a "" we'll emit all strings after that point verbatim
without any "or: " prefixing.

This gets rid of that special case, which was added in
f389c808b67 (Rework make_usage to print the usage message immediately,
2007-10-14). It was only used "blame" (the "credential-cache*" use of
it was removed in the preceding commit). Before this change we'd emit:

    $ git blame -h
    usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>

        <rev-opts> are documented in git-rev-list(1)

This changes that output to simply use "[<git-rev-list args>]" instead
of "[<rev-opts>]". This accomplishes the same, is more consistent as
"git bundle" and "git blame" use the same way of referring to these
options now.

The use of this in "blame" dated back to 5817da01434 (git-blame:
migrate to incremental parse-option [1/2], 2008-07-08), and the use in
"bundle" to 2e0afafebd8 (Add git-bundle: move objects and
references by archive, 2007-02-22).

Once we get rid of this special case we can also use usage_msg_opt()
to emit the error message we'd get on an invalid "-L <range>"
argument, which means we can get rid of the old-style "blame_usage"
variable.

It's possible that this change introduce breakage somewhere. We'd only
catch these cases at runtime, and the "git rev-parse --parseopt"
command is used by shellscripts, see bac199b7b17 (Update
git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt,
2007-11-04). I've grepped the codebase for "OPTIONS_SPEC",
"char.*\*.*usage\[\]" etc. I'm fairly sure there no outstanding users
of this functionality.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c               |  9 +++------
 builtin/rev-parse.c           |  3 +++
 parse-options.c               |  8 +-------
 t/helper/test-parse-options.c |  2 --
 t/t0040-parse-options.sh      |  2 --
 t/t1502-rev-parse-parseopt.sh | 34 ++++++++++++++++++----------------
 6 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..45d9873a999 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -29,12 +29,8 @@
 #include "refs.h"
 #include "tag.h"
 
-static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
-
 static const char *blame_opt_usage[] = {
-	blame_usage,
-	"",
-	N_("<rev-opts> are documented in git-rev-list(1)"),
+	N_("git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>"),
 	NULL
 };
 
@@ -1107,7 +1103,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage_msg_opt(_("Invalid -L <range> parameters"),
+				      blame_opt_usage, options);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 22c4e1a4ff0..aeebfd52805 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -436,7 +436,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	for (;;) {
 		if (strbuf_getline(&sb, stdin) == EOF)
 			die(_("premature end of input"));
+		if (!sb.len)
+			die(_("empty lines are not permitted before the `--' separator"));
 		ALLOC_GROW(usage, unb + 1, usz);
+
 		if (!strcmp("--", sb.buf)) {
 			if (unb < 1)
 				die(_("no usage string given before the `--' separator"));
diff --git a/parse-options.c b/parse-options.c
index 2abff136a17..950a8279beb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -924,18 +924,12 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		fprintf(outfile, "cat <<\\EOF\n");
 
 	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
-	while (*usagestr && **usagestr)
+	while (*usagestr) {
 		/*
 		 * TRANSLATORS: the colon here should align with the
 		 * one in "usage: %s" translation.
 		 */
 		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
-	while (*usagestr) {
-		if (**usagestr)
-			fprintf_ln(outfile, _("    %s"), _(*usagestr));
-		else
-			fputc('\n', outfile);
-		usagestr++;
 	}
 
 	need_newline = 1;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 2051ce57db7..e00aef073b0 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -102,8 +102,6 @@ int cmd__parse_options(int argc, const char **argv)
 	const char *prefix = "prefix/";
 	const char *usage[] = {
 		"test-tool parse-options <options>",
-		"",
-		"A helper function for the parse-options API.",
 		NULL
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ad4746d899a..2910874ece5 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -10,8 +10,6 @@ test_description='our own option parser'
 cat >expect <<\EOF
 usage: test-tool parse-options <options>
 
-    A helper function for the parse-options API.
-
     --yes                 get a boolean
     -D, --no-doubt        begins with 'no-'
     -B, --no-fear         be brave
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index b29563fc997..6badc650d64 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -6,8 +6,6 @@ test_description='test git rev-parse --parseopt'
 test_expect_success 'setup optionspec' '
 	sed -e "s/^|//" >optionspec <<\EOF
 |some-command [options] <args>...
-|
-|some-command does foo and bar!
 |--
 |h,help    show the help
 |
@@ -41,8 +39,6 @@ EOF
 test_expect_success 'setup optionspec-no-switches' '
 	sed -e "s/^|//" >optionspec_no_switches <<\EOF
 |some-command [options] <args>...
-|
-|some-command does foo and bar!
 |--
 EOF
 '
@@ -50,8 +46,6 @@ EOF
 test_expect_success 'setup optionspec-only-hidden-switches' '
 	sed -e "s/^|//" >optionspec_only_hidden_switches <<\EOF
 |some-command [options] <args>...
-|
-|some-command does foo and bar!
 |--
 |hidden1* A hidden switch
 EOF
@@ -62,8 +56,6 @@ test_expect_success 'test --parseopt help output' '
 |cat <<\EOF
 |usage: some-command [options] <args>...
 |
-|    some-command does foo and bar!
-|
 |    -h, --help            show the help
 |    --foo                 some nifty option --foo
 |    --bar ...             some cool option --bar with an argument
@@ -103,8 +95,6 @@ test_expect_success 'test --parseopt help output no switches' '
 |cat <<\EOF
 |usage: some-command [options] <args>...
 |
-|    some-command does foo and bar!
-|
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
@@ -116,8 +106,6 @@ test_expect_success 'test --parseopt help output hidden switches' '
 |cat <<\EOF
 |usage: some-command [options] <args>...
 |
-|    some-command does foo and bar!
-|
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
@@ -129,8 +117,6 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |cat <<\EOF
 |usage: some-command [options] <args>...
 |
-|    some-command does foo and bar!
-|
 |    --hidden1             A hidden switch
 |
 |EOF
@@ -144,8 +130,6 @@ test_expect_success 'test --parseopt invalid switch help output' '
 |error: unknown option `does-not-exist'\''
 |usage: some-command [options] <args>...
 |
-|    some-command does foo and bar!
-|
 |    -h, --help            show the help
 |    --foo                 some nifty option --foo
 |    --bar ...             some cool option --bar with an argument
@@ -282,4 +266,22 @@ test_expect_success 'test --parseopt --stuck-long and short option with unset op
 	test_cmp expect output
 '
 
+test_expect_success 'test --parseopt help output hidden switches' '
+	sed -e "s/^|//" >optionspec-trailing-line <<-\EOF &&
+	|some-command [options] <args>...
+	|
+	|
+	|--
+	|h,help    show the help
+	EOF
+
+	cat >expect <<-\EOF &&
+	fatal: empty lines are not permitted before the `--'"'"' separator
+	EOF
+
+	test_must_fail git rev-parse --parseopt -- -h >out < optionspec-trailing-line 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.876.g423ac861752

