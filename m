Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD931C77B6F
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDJJJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDJJI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:08:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AA4C3C
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m8so16188322wmq.5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117733;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RGNCDF90CYXoFbQ0XYjyVM2kfwvaB/2o7euwLACg2ZQ=;
        b=hhij9ApUztnk7YK/U3aWKymi/PHd8eqTzlUtIND2FIT3rS9SI9q5w2gZ17WuIqeIZo
         YpNnm8yQws5+ijvGWNVk0nhAGXPoVVFS5qlfQ642aYB8XwJMQuZ0iuyfDvgHnW1OmsMn
         EuG5BpecvfRsGZNy1PtbuSUjbnXlqCckNKZvQSFfHwVARXOMZM1UFjjUQMmPDKCYWT7j
         4lNGoweCb83oDsDH4ckUeYhXoZlrZX1UxoMOyCvZrwUmM5TBP0nCfcAN8l/iP+5HvRtD
         1nRXGtBnWnEA93SilkCybYup36xEFKQ63bn++rA/BWQokN84uxCMkDwVmXhkzl7+vjWD
         gV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117733;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGNCDF90CYXoFbQ0XYjyVM2kfwvaB/2o7euwLACg2ZQ=;
        b=V/begmq+UQgMBa4Kl5NLDyOdJ0T07cQ4Cd4gbekdWsz4BKJGfNGWywuSO1t8pOf5IM
         ghywX9xsaJGwd/MZfdHe1Ua8pr8/3JKoMEtqFn0s1FqcqZTyGf26U6pnoh6H9rl6ZsXq
         ZFyuAd0U99BJUVsL4yoWkgzmCIf1+X8zsNIisieRSd419dnXHg3kXyMJ+QrgrMNxDDbx
         2larGf4ET/uJYOWporfhJOcvQzmysNngK3exlKen2vt/0tahONR7zfYZEo+WJhC7VTrh
         +m99kX9XRhBPfix1JFToy69sb5AOrOl4fJKX1bo27R9vZQux7h1bQMdTAlI4fWYt/VRI
         9GQA==
X-Gm-Message-State: AAQBX9fu46hWOJnP5eG8VCge3bvd+Ec++LekcZvB+YLawofaR0Y98h6R
        GFeDsBOOO5Ug5n/LMYZTh7MZDlepMBs=
X-Google-Smtp-Source: AKy350Zxn1sov76QhrgeZINUAisrYZqm9xKz7lGB8+muBkGf5vy8NT6sTs7P8/8MkvrG+dng7bR4ow==
X-Received: by 2002:a7b:c406:0:b0:3ee:42fd:7768 with SMTP id k6-20020a7bc406000000b003ee42fd7768mr7094485wmi.1.1681117733036;
        Mon, 10 Apr 2023 02:08:53 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:52 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 4/5] rebase -m: fix serialization of strategy options
Date:   Mon, 10 Apr 2023 10:08:30 +0100
Message-Id: <671ee03503dd1642a8d38b9d86b913ec39b57ba3.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

To store the strategy options rebase prepends " --" to each one and
writes them to a file. To load them it reads the file and passes the
contents to split_cmdline(). This roughly mimics the behavior of the
scripted rebase but has a couple of limitations, (1) options containing
whitespace are not properly preserved (this is true of the scripted
rebase as well) and (2) options containing '"' or '\' are incorrectly
parsed and may cause the parser to return an error.

Fix these limitations by quoting each option when they are stored so
that they can be parsed correctly. Now that "--preserve-merges" no
longer exist this change also stops prepending "--" to the options when
they are stored as that was an artifact of the scripted rebase.

These changes are backwards compatible so the files written by an older
version of git can still be read. They are also forwards compatible,
the file can still be parsed by recent versions of git as they treat the
"--" prefix as optional.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 alias.c                        | 18 +++++++++++++++++
 alias.h                        |  3 +++
 sequencer.c                    | 11 ++++++-----
 t/t3418-rebase-continue.sh     | 36 ++++++++++++++++++++++------------
 t/t3436-rebase-more-options.sh | 24 -----------------------
 5 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/alias.c b/alias.c
index e814948ced..54a1a23d2c 100644
--- a/alias.c
+++ b/alias.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "gettext.h"
+#include "strbuf.h"
 #include "string-list.h"
 
 struct config_alias_data {
@@ -46,6 +47,23 @@ void list_aliases(struct string_list *list)
 	read_early_config(config_alias_cb, &data);
 }
 
+void quote_cmdline(struct strbuf *buf, const char **argv)
+{
+	for (const char **argp = argv; *argp; argp++) {
+		if (argp != argv)
+			strbuf_addch(buf, ' ');
+		strbuf_addch(buf, '"');
+		for (const char *p = *argp; *p; p++) {
+			const char c = *p;
+
+			if (c == '"' || c =='\\')
+				strbuf_addch(buf, '\\');
+			strbuf_addch(buf, c);
+		}
+		strbuf_addch(buf, '"');
+	}
+}
+
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 #define SPLIT_CMDLINE_ARGC_OVERFLOW 3
diff --git a/alias.h b/alias.h
index aef4843bb7..43db736484 100644
--- a/alias.h
+++ b/alias.h
@@ -1,9 +1,12 @@
 #ifndef ALIAS_H
 #define ALIAS_H
 
+struct strbuf;
 struct string_list;
 
 char *alias_lookup(const char *alias);
+/* Quote argv so buf can be parsed by split_cmdline() */
+void quote_cmdline(struct strbuf *buf, const char **argv);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
diff --git a/sequencer.c b/sequencer.c
index 587a473d6e..fc6ea75895 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2925,7 +2925,7 @@ static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 
 	count = split_cmdline(strategy_opts_string, &argv);
 	if (count < 0)
-		die(_("could not split '%s': %s"), strategy_opts_string,
+		BUG("could not split '%s': %s", strategy_opts_string,
 			    split_cmdline_strerror(count));
 	for (i = 0; i < count; i++) {
 		const char *arg = argv[i];
@@ -3049,12 +3049,13 @@ static int read_populate_opts(struct replay_opts *opts)
 
 static void write_strategy_opts(struct replay_opts *opts)
 {
-	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (i = 0; i < opts->xopts.nr; ++i)
-		strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
-
+	/*
+	 * Quote strategy options so that they can be read correctly
+	 * by split_cmdline().
+	 */
+	quote_cmdline(&buf, opts->xopts.v);
 	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
 	strbuf_release(&buf);
 }
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 130e2f9b55..42c3954125 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -62,29 +62,39 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F2-on-topic-branch &&
 	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run" &&
+	test_when_finished "rm -fr test-bin" &&
 	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
+
+	write_script test-bin/git-merge-funny <<-\EOF &&
+	printf "[%s]\n" $# "$1" "$2" "$3" "$5" >actual
+	shift 3 &&
+	exec git merge-recursive "$@"
+	EOF
+
+	cat >expect <<-\EOF &&
+	[7]
+	[--option=arg with space]
+	[--op"tion\]
+	[--new
+	line ]
+	[--]
+	EOF
+
+	rm -f actual &&
 	(
 		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -s funny -Xopt main topic
+		test_must_fail git rebase -s funny -X"option=arg with space" \
+				-Xop\"tion\\ -X"new${LF}line " main topic
 	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
+	test_cmp expect actual &&
+	rm actual &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	(
 		PATH=./test-bin:$PATH &&
 		git rebase --continue
 	) &&
-	test -f funny.was.run
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -i --continue handles merge strategy and options' '
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 3adf42f47d..94671d3c46 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -40,30 +40,6 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
-	test_when_finished "test_might_fail git rebase --abort" &&
-	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': unclosed quote
-	EOF
-	GIT_SEQUENCE_EDITOR="echo break >" \
-		git rebase -i -X"bad argument\"" side main &&
-	test_expect_code 128 git rebase --continue >out 2>actual &&
-	test_must_be_empty out &&
-	test_cmp expect actual
-'
-
-test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
-	test_when_finished "test_might_fail git rebase --abort" &&
-	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': cmdline ends with \
-	EOF
-	GIT_SEQUENCE_EDITOR="echo break >" \
-		git rebase -i -X"bad escape \\" side main &&
-	test_expect_code 128 git rebase --continue >out 2>actual &&
-	test_must_be_empty out &&
-	test_cmp expect actual
-'
-
 test_expect_success '--ignore-whitespace works with apply backend' '
 	test_must_fail git rebase --apply main side &&
 	git rebase --abort &&
-- 
2.40.0.672.gbd2d2ac924

