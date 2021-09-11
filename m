Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63363C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470E86108B
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhIKTLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhIKTLn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD73C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so3889833wmq.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgbq52nKtIjlI7AfAq29aPRtgmtqwNjH66dToxtx3yk=;
        b=VouKC0oWtwQXHEpflXkPz7ltCYL2IwKuNfae1on/5wM0RIAMz3+ybvLWJtXUxsQ3mO
         8aBW1qtgkjgQbe36afXR95HuR/VVjbNiORdQLZHRhMGgWxZofe/fZX/YBRQv13OioiJP
         k5PQ9pCZwADNuv3y4uWuGykr2Dv//gH4pqqGVZqg4i54G8Qn40sbOKvKMjlTpEqFppVM
         0uUGYF2P8LmQWNqlw8jdNReLJk1rReU9uL3Buoi9J8KRYUBQ58qUK9mTbpQDpDpU1izv
         mizSSJ6sV+AzsDZXpxmerki8dNgAwhK/88WWclZsrgZphY7REgh2/YhkUJYTKa0FxjW+
         sO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgbq52nKtIjlI7AfAq29aPRtgmtqwNjH66dToxtx3yk=;
        b=nZ3nFvKl2Icr0znGeYgCJcegVfLXi1Ns29nvaPQZAzmHGVoLvZBEUID1Dw1WgwIbvw
         IA9FXthJi733gLTSQziEjGEpw8hy3bU4UrOcTy/onOabivHD/rQkr3xzL7HCKlIwaEI3
         sKRiyJSnB8866VFKKa7eX7eVZucpkcFV2KZcimhrLrMWuUvwC55yaxt7plrTVSRK+sRi
         i6COJkiJxcfbbP7nr8akQG1kQbnUmFlDBEtuWku/4IGL7N+bU/2vd1cGR40Zw/L0NWWH
         RFQ/ArfJ+gdYyjncXwgwU+d3nwu3sA6DXo5BB0fRykodbmL26ZG5YMXBh9FpTtInCstU
         KM+A==
X-Gm-Message-State: AOAM533vu2/by7I9VKjaaIozET963k8GicquGmi8VN0FWM6IKqrhivux
        A8ieFLUkR0zc5Q/WCLFZcf2JFp9aKQiFMA==
X-Google-Smtp-Source: ABdhPJyE7yKuS358OLzSFxwqDDJkFYaf7e3DwCd48mJb89DHLSmeepDeUT6x5yCqiMNajCWQ/DamUA==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr3782177wmf.82.1631387428244;
        Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] parse-options: stop supporting "" in the usagestr array
Date:   Sat, 11 Sep 2021 21:09:02 +0200
Message-Id: <patch-v3-3.6-e23a8231f38-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
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

In the preceding commits we got rid of the two users of this
undocumented part of the API. Let's remove it in preparation for
improving the output emitted by usage_with_options_internal().

I think we might want to use this in the future, but in that case
we'll be much better off with an API that emulates the
non-parse_options() way that git.c does this.

That git.c code uses a separate "git_usage_string" and
"git_more_info_string". See b7d9681974e (Print info about "git help
COMMAND" on git's main usage pages, 2008-06-06). By splitting the two
up we can emit something in the middle, as indeed git.c does.

I'd like our "git <cmd> -h" info to be more helpful, and I'd also like
parse_options() to handle the "git" command itself, because of the
limitations of how this was done in usage_with_options_internal() we
couldn't migrate a caller like git.c to parse_options().

So let's just remove this for now, it has no users, and once we want
to do this again we can simply add another argument to the relevant
functions, or otherwise hook into things so that we can print
something at the end and/or middle.

It's possible that this change introduce breakage somewhere. We'd only
catch these cases at runtime, and the "git rev-parse --parseopt"
command is used by shellscripts, see bac199b7b17 (Update
git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt,
2007-11-04). I've grepped the codebase for "OPTIONS_SPEC",
"char.*\*.*usage\[\]" etc. I'm fairly sure there no outstanding users
of this functionality.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rev-parse.c           |  3 +++
 parse-options.c               |  8 +-------
 t/helper/test-parse-options.c |  2 --
 t/t0040-parse-options.sh      |  2 --
 t/t1502-rev-parse-parseopt.sh | 34 ++++++++++++++++++----------------
 5 files changed, 22 insertions(+), 27 deletions(-)

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
2.33.0.995.ga5ea46173a2

