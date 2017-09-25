Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA4A2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 04:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbdIYEIN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 00:08:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35635 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdIYEIM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 00:08:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id r20so2967308oie.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 21:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lBHsUmj0FHZJLdsdUAVJYA72fdJWUTqtP000ToSRv1I=;
        b=s6VsobMTsVdaxuTJT4ZZ6uHiwT+XjzuVTJWO8mktlHOHBaKbm1FqFgBF9CrNyRbHUN
         diF5DBhWNy6jaxzP8oOgcYOgdSf7RzwVf4FZzXZ/ioRSIFdV9emo6BXZNOy9bc+9ZKZo
         wQMSIMYCnqztPWrLEvjMkUfdZ3vGo9/wXvh63fda5eVM4FTPWqvxxBVxJZA8ugZ5GuQw
         92QuI7H1f6Mx3W503SUwg949ostbtYohIUgGxKpgono/vFrbCFNLgZ3MO3wOPUqSDgTe
         dSMOyydEMZiLkUpnPRliN7yDLPXQtq7wBYQJ3hk+mCV3sdQl3ymEWLTtAHvFpdSlU6Xg
         9v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lBHsUmj0FHZJLdsdUAVJYA72fdJWUTqtP000ToSRv1I=;
        b=XO1jkpW+ba8DN6Df4vYPNhX39C+cSE+RwGo7IrZJxcZHiaPxIcYO7BJfz3hMc+4Jjz
         JkZ5oU3C36NSX6EApTrLc8P4RjLH+pH256xS++L0Oib2q7PL2uzzQA5aN6dXlk9wrF1w
         NH5FMw7j7KK6MJATj7Fh6x/JYWbZE2bGyaFMer1k/qcpDJx1XggeAuo1vECViadsjFQL
         qynPJZ4ZFv1AYE6OBWqqSqHmWzE6+CLexRniLC4u/v2JvwwDAqu8AOx0nnkybJup9VTX
         EGXBD5yuhGM3aZRLDw1ElF9Vq2XuELdIqVWEr8TSAzOXIXSL9YlX0cJEX4KnnKQ6pf45
         nEqA==
X-Gm-Message-State: AHPjjUjgo1OLqmiemBFkeRFOFktvfUSsz2UoFbhFeIqbTEefQljz1zzd
        HZnP8ppMiPdIepL4ISfXcQKrmj0k
X-Google-Smtp-Source: AOwi7QC56qEojHgbHBYc9S6l4WN8aG3VRA5TZmjmsxNJyhX5uV290/6eY5nIMF7QabgIP9XkoWCxhg==
X-Received: by 10.202.107.10 with SMTP id g10mr3457296oic.98.1506312491405;
        Sun, 24 Sep 2017 21:08:11 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id x206sm6514571oig.55.2017.09.24.21.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Sep 2017 21:08:10 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/3] t0040,t1502: Demonstrate parse_options bugs
Date:   Sun, 24 Sep 2017 21:08:03 -0700
Message-Id: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the option spec contains no switches or only hidden switches,
parse_options will emit an extra blank line at the end of help output so
that the help text will end in two blank lines instead of one.

When parse_options produces internal help output after an error has
occurred it will emit blank lines within the usage string to stdout
instead of stderr.

Update t/helper/test-parse-options.c to have a description body in the
usage string to exercise this second bug and mark tests as failing in
t0040.

Add tests to t1502 to demonstrate both of these problems.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Notes:
    FYI: this is built on top of bc/rev-parse-parseopt-fix (697bc88) merged
    into next.

 t/helper/test-parse-options.c |   2 +
 t/t0040-parse-options.sh      |   8 ++--
 t/t1502-rev-parse-parseopt.sh | 100 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 75fe883..630c76d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -99,6 +99,8 @@ int cmd_main(int argc, const char **argv)
 	const char *prefix = "prefix/";
 	const char *usage[] = {
 		"test-parse-options <options>",
+		"",
+		"A helper function for the parse-options API.",
 		NULL
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 74d2cd7..a36434b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -10,6 +10,8 @@ test_description='our own option parser'
 cat >expect <<\EOF
 usage: test-parse-options <options>
 
+    A helper function for the parse-options API.
+
     --yes                 get a boolean
     -D, --no-doubt        begins with 'no-'
     -B, --no-fear         be brave
@@ -90,8 +92,8 @@ test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
 test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
 
-test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
-test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
+test_expect_failure 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
+test_expect_failure 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
 
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
@@ -286,7 +288,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 
 >expect
 
-test_expect_success 'OPT_CALLBACK() and callback errors work' '
+test_expect_failure 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
 	test_i18ncmp expect.err output.err
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 6e1b45f..1bfa80f 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -38,6 +38,25 @@ test_expect_success 'setup optionspec' '
 EOF
 '
 
+test_expect_success 'setup optionspec-no-switches' '
+	sed -e "s/^|//" >optionspec_no_switches <<\EOF
+|some-command [options] <args>...
+|
+|some-command does foo and bar!
+|--
+EOF
+'
+
+test_expect_success 'setup optionspec-only-hidden-switches' '
+	sed -e "s/^|//" >optionspec_only_hidden_switches <<\EOF
+|some-command [options] <args>...
+|
+|some-command does foo and bar!
+|--
+|hidden1* A hidden switch
+EOF
+'
+
 test_expect_success 'test --parseopt help output' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
@@ -79,6 +98,87 @@ END_EXPECT
 	test_i18ncmp expect output
 '
 
+test_expect_failure 'test --parseopt help output no switches' '
+	sed -e "s/^|//" >expect <<\END_EXPECT &&
+|cat <<\EOF
+|usage: some-command [options] <args>...
+|
+|    some-command does foo and bar!
+|
+|EOF
+END_EXPECT
+	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
+	test_i18ncmp expect output
+'
+
+test_expect_failure 'test --parseopt help output hidden switches' '
+	sed -e "s/^|//" >expect <<\END_EXPECT &&
+|cat <<\EOF
+|usage: some-command [options] <args>...
+|
+|    some-command does foo and bar!
+|
+|EOF
+END_EXPECT
+	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'test --parseopt help-all output hidden switches' '
+	sed -e "s/^|//" >expect <<\END_EXPECT &&
+|cat <<\EOF
+|usage: some-command [options] <args>...
+|
+|    some-command does foo and bar!
+|
+|    --hidden1             A hidden switch
+|
+|EOF
+END_EXPECT
+	test_expect_code 129 git rev-parse --parseopt -- --help-all > output < optionspec_only_hidden_switches &&
+	test_i18ncmp expect output
+'
+
+test_expect_failure 'test --parseopt invalid switch help output' '
+	sed -e "s/^|//" >expect <<\END_EXPECT &&
+|error: unknown option `does-not-exist'\''
+|usage: some-command [options] <args>...
+|
+|    some-command does foo and bar!
+|
+|    -h, --help            show the help
+|    --foo                 some nifty option --foo
+|    --bar ...             some cool option --bar with an argument
+|    -b, --baz             a short and long option
+|
+|An option group Header
+|    -C[...]               option C with an optional argument
+|    -d, --data[=...]      short and long option with an optional argument
+|
+|Argument hints
+|    -B <arg>              short option required argument
+|    --bar2 <arg>          long option required argument
+|    -e, --fuz <with-space>
+|                          short and long option required argument
+|    -s[<some>]            short option optional argument
+|    --long[=<data>]       long option optional argument
+|    -g, --fluf[=<path>]   short and long option optional argument
+|    --longest <very-long-argument-hint>
+|                          a very long argument hint
+|    --pair <key=value>    with an equals sign in the hint
+|    --aswitch             help te=t contains? fl*g characters!`
+|    --bswitch <hint>      hint has trailing tab character
+|    --cswitch             switch has trailing tab character
+|    --short-hint <a>      with a one symbol hint
+|
+|Extras
+|    --extra1              line above used to cause a segfault but no longer does
+|
+END_EXPECT
+	test_expect_code 129 git rev-parse --parseopt -- --does-not-exist 1>/dev/null 2>output < optionspec &&
+	test_i18ncmp expect output
+'
+
 test_expect_success 'setup expect.1' "
 	cat > expect <<EOF
 set -- --foo --bar 'ham' -b --aswitch -- 'arg'
-- 
2.2.0.rc3

