Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A956B1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754763AbeDBWtT (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:19 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:40350 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbeDBWtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:14 -0400
Received: by mail-pl0-f48.google.com with SMTP id x4-v6so6119541pln.7
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CD6hfAcuikMh2lRaaImOR+d7GWa+qQRHsiCD1/GQetg=;
        b=soZHwPVTqeh8beUtEH2OcHlYaHII3Wj+DtmuPdPf1PFPGya9zqWumRgeaJwy2bIRau
         DKMu9i4cLyerwYb15239QtokQQFMC27RoH3gkvWYKdUwKs41UTzilIdU71llVqS1nqis
         UiymtX+u/icgVuYWppeA759IXbwqDAxuur/XQ6JIzvEfUud5VF+Y9LRD+jSFTNSbpNyl
         8fZvWQekpCh4qm5UH/0Q8Ewkxb6EDX4iwxbMRDV1ETY0sOr48gXL5K/+/HCT8PoB1Prc
         YibaCcQ6YLKd/LGu/xxioqErrj6pKuurdQg+i3cYNnYXwMXbDsr8j+v+ZakEDAq3Hlj6
         47fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CD6hfAcuikMh2lRaaImOR+d7GWa+qQRHsiCD1/GQetg=;
        b=uGlNH98/k1kpqo+HCTJAaO/Eu4csQcR9m4UldzHZw+k2d0z7sf4R7YIRdfBCo0fqUZ
         c8S+jn2cxCywlmxCN4iPa9W8GppDczpmSmNXVkGmE1GXxBeNUziEZoVz+3BvVzXWieYu
         dBo/uitefYDW5UBEpGQHrUfa8TuffiYxhJnU1dyM7a5XSYYE9QYk5QUxG6VJDgl/y3uY
         T6SUbkTpqNSEHpCvHs09/J9MFscDXWeGZnMQeOJUCUC23wjuRh2WiE11ScUzH8h9dz0B
         dWe51UCyZx6sta52LfcCNtcwWCBN/8r5R7yvUBl9l4ArS7OgqzWpp544hCCkUVaydTGY
         9ktA==
X-Gm-Message-State: AElRT7HZWOZZMs8UP363KA+aUG1mVhejDLxy9LLBDk4kj98GW2KTSLS8
        vYir+1uhfMnA9lYbi8zp47ac/Q==
X-Google-Smtp-Source: AIpwx4+3usiWWewimzdTUKhH92s+QSOI6Z1Yh7s5eXHPj6OTtcUYTyAI09iCeICvt8EVlxWAj14ZIw==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr6471780plz.190.1522709353630;
        Mon, 02 Apr 2018 15:49:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t64sm2292574pfi.34.2018.04.02.15.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] diff.c: decouple white space treatment for move detection from generic option
Date:   Mon,  2 Apr 2018 15:48:53 -0700
Message-Id: <20180402224854.86922-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original implementation of the move detection logic we assumed that
the choice for ignoring white space changes is the same for the move
detection as it is for the generic diff.  It turns out this is wrong.

There are a couple of things where the user wants to input their
decision into the diff machinery:

* Whether or not to ignore white space for the general diff detection.
  This is covered with the -w, -b options already.
* Whether the move detection ought to pay attention to white spaces
  in general. And if so, how are white spaces handled for the block
  detection.

One example would be reviewing a current patch under discussion, that moves
code around.  In that case, you may want to have the general diff machinery
not ignore the white spaces (i.e. exact matching), as that will show you
the diff as the patch sent. The code moved however may have another
indentation level, such that you want to ignore white spaces for the move
detection. The code may be in python, such that spaces matter for program
flow, though. That is why you'd want each block to have the same change
in white space.

This patch decouples white space treatment in the general diff machinery
from the white space treatment in the move detection.

This adds all the the options for ignoring white space that the regular
diff machinery has to the move detection, such that we can cover all the
cases that were introduced in 7a55427094 (Merge branch
'jk/diff-color-moved-fix', 2017-11-06).

The example from above (different lines in the diff with -w for the regular
diff) is covered in a test. Convert the existing tests to be more explicit
on their choice of white space behavior in the move detection as the tests
should not fail if the default is changed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  13 +++
 diff.c                         |  17 +++-
 t/t4015-diff-whitespace.sh     | 150 +++++++++++++++++++++++++++++++--
 3 files changed, 171 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e3a44f03cd..4ca09c1977 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -288,6 +288,19 @@ dimmed_zebra::
 	blocks are considered interesting, the rest is uninteresting.
 --
 
+--color-moved-[no-]ignore-all-space::
+	Ignore whitespace when comparing lines when performing the move
+	detection for --color-moved.  This ignores differences even if
+	one line has whitespace where the other line has none.
+--color-moved-[no-]ignore-space-change::
+	Ignore changes in amount of whitespace when performing the move
+	detection for --color-moved.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
+--color-moved-[no-]ignore-space-at-eol::
+	Ignore changes in whitespace at EOL when performing the move
+	detection for --color-moved.
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/diff.c b/diff.c
index 2052a43f7a..5fe2930dca 100644
--- a/diff.c
+++ b/diff.c
@@ -720,7 +720,7 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
-				    diffopt->xdl_opts);
+				    diffopt->color_moved & XDF_WHITESPACE_FLAGS);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -728,8 +728,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 {
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+	unsigned flags = o->color_moved & XDF_WHITESPACE_FLAGS;
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
 
@@ -4638,6 +4639,18 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--color-moved-no-ignore-all-space"))
+		options->color_moved &= ~XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-change"))
+		options->color_moved &= ~XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
+		options->color_moved &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
+		options->color_moved |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
+		options->color_moved |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
+		options->color_moved |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3a..38aaf4c46c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1395,7 +1395,10 @@ test_expect_success 'move detection ignoring whitespace ' '
 	line 4
 	line 5
 	EOF
-	git diff HEAD --no-renames --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1419,7 +1422,10 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1459,7 +1465,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	line 5
 	EOF
 
-	git diff HEAD --no-renames --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1483,7 +1492,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-at-eol \
+		--color-moved-ignore-space-change |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1526,7 +1538,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	# avoid cluttering the output with complaints about our eol whitespace
 	test_config core.whitespace -blank-at-eol &&
 
-	git diff HEAD --no-renames --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1550,7 +1565,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-ignore-space-at-eol |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1722,7 +1740,125 @@ test_expect_success 'move detection with submodules' '
 
 	# nor did we mess with it another way
 	git diff --submodule=diff --color | test_decode_color >expect &&
-	test_cmp expect decoded_actual
+	test_cmp expect decoded_actual &&
+	rm -rf bananas &&
+	git submodule deinit bananas
+'
+
+test_expect_success 'move detection only ignores white spaces' '
+	git reset --hard &&
+	q_to_tab <<-\EOF >function.c &&
+	int func()
+	{
+	Qif (foo) {
+	QQ// this part of the function
+	QQ// function will be very long
+	QQ// indeed. We must exceed both
+	QQ// per-line and number of line
+	QQ// minimums
+	QQ;
+	Q}
+	Qbaz();
+	Qbar();
+	Q// more unrelated stuff
+	}
+	EOF
+	git add function.c &&
+	git commit -m "add function.c" &&
+	q_to_tab <<-\EOF >function.c &&
+	int do_foo()
+	{
+	Q// this part of the function
+	Q// function will be very long
+	Q// indeed. We must exceed both
+	Q// per-line and number of line
+	Q// minimums
+	Q;
+	}
+
+	int func()
+	{
+	Qif (foo)
+	QQdo_foo();
+	Qbaz();
+	Qbar();
+	Q// more unrelated stuff
+	}
+	EOF
+
+	# Make sure we get a different diff using -w ("moved function header")
+	git diff --color --color-moved -w \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/function.c b/function.c<RESET>
+	<BOLD>--- a/function.c<RESET>
+	<BOLD>+++ b/function.c<RESET>
+	<CYAN>@@ -1,6 +1,5 @@<RESET>
+	<BOLD;MAGENTA>-int func()<RESET>
+	<GREEN>+<RESET><GREEN>int do_foo()<RESET>
+	 {<RESET>
+	<RED>-	if (foo) {<RESET>
+	 Q// this part of the function<RESET>
+	 Q// function will be very long<RESET>
+	 Q// indeed. We must exceed both<RESET>
+	<CYAN>@@ -8,6 +7,11 @@<RESET> <RESET>int func()<RESET>
+	 Q// minimums<RESET>
+	 Q;<RESET>
+	 }<RESET>
+	<GREEN>+<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>int func()<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<GREEN>+<RESET>Q<GREEN>if (foo)<RESET>
+	<GREEN>+<RESET>QQ<GREEN>do_foo();<RESET>
+	 Qbaz();<RESET>
+	 Qbar();<RESET>
+	 Q// more unrelated stuff<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	# And now ignoring white space only in the move detection
+	git diff --color --color-moved \
+		--color-moved-ignore-all-space \
+		--color-moved-ignore-space-change \
+		--color-moved-ignore-space-at-eol |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/function.c b/function.c<RESET>
+	<BOLD>--- a/function.c<RESET>
+	<BOLD>+++ b/function.c<RESET>
+	<CYAN>@@ -1,13 +1,17 @@<RESET>
+	<GREEN>+<RESET><GREEN>int do_foo()<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// this part of the function<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// function will be very long<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// indeed. We must exceed both<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// per-line and number of line<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>// minimums<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>;<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>}<RESET>
+	<GREEN>+<RESET>
+	 int func()<RESET>
+	 {<RESET>
+	<RED>-Qif (foo) {<RESET>
+	<BOLD;MAGENTA>-QQ// this part of the function<RESET>
+	<BOLD;MAGENTA>-QQ// function will be very long<RESET>
+	<BOLD;MAGENTA>-QQ// indeed. We must exceed both<RESET>
+	<BOLD;MAGENTA>-QQ// per-line and number of line<RESET>
+	<BOLD;MAGENTA>-QQ// minimums<RESET>
+	<BOLD;MAGENTA>-QQ;<RESET>
+	<BOLD;MAGENTA>-Q}<RESET>
+	<GREEN>+<RESET>Q<GREEN>if (foo)<RESET>
+	<GREEN>+<RESET>QQ<GREEN>do_foo();<RESET>
+	 Qbaz();<RESET>
+	 Qbar();<RESET>
+	 Q// more unrelated stuff<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_done
-- 
2.17.0.484.g0c8726318c-goog

