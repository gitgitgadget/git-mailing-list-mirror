Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F812055E
	for <e@80x24.org>; Wed, 25 Oct 2017 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJYWqf (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 18:46:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:48093 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdJYWqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 18:46:32 -0400
Received: by mail-it0-f65.google.com with SMTP id p138so3026789itp.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCMqmJB54PPHXYcfFcWNNsRfQGF40vZOqgnaUax/nVA=;
        b=ca7GQPRaPK45qzn2DUEgp0YHRlPLVHHTSFIX6FaZZxyep/aOK2c5fgAWMXmKNiyEt9
         qEbUusgjRGgEXCIR9QMhl8VWyteBnHFRXLnm5J6wijF9kZq1MyI3/dJugFROLsdIhoCs
         RZqROOK/Eu+r7lDynzjOYxdFes0Kx0F7T3VNZSP7PRdC+mTZBayGYH51hLRgiiV9BXOf
         F1kI9RqN0FJnp9KNTR4tzntRJ83Re+U2usbQjK1y3V3SO5fycuRX5zvClzev5IufSB4i
         OmRJABHViZgzzFfZnH4qLyVGJK6/ld7QTC+mv7oJH11yAllZt08aurbDq4lEP0QCUqF+
         6HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCMqmJB54PPHXYcfFcWNNsRfQGF40vZOqgnaUax/nVA=;
        b=mqFAIJ4GLqbAOH44aeTGjRpULJAPdXudApN+LJzVtAvRIsHC8vME52NeWFO8tOBWwj
         HH0YfgJRymQ1sTwptLzSCJI/854JsE5k4LglZYC7HiqNeacoCYGMP9T9ckGrVSCeOMat
         4xNqVWrP8/wTZFkpgrVlN3pjdNWgbSPjcNU/TpCHW0pyUoP0tAg77P5ettFCt659+YBc
         wXoQWW8Tx83E1R6fuR1D/e0Ou6RW7Uw+NwHhaw/c3gur5hVHyS6YxXPayrh6X4Rb1zJU
         Km0VZwK8pfxozhdT7ShlfmEqLCAr9kFbJAhltqoOhsGijI2eZO5QxtB9TIz8FmlN1msu
         vR9Q==
X-Gm-Message-State: AMCzsaVYYKC5M+4KG7LQI/FaGgmFi8eCwzJIUPUa4U33WLEJJKY41q8t
        uI/bUp9ROywGuIzoGd+HNwZSj3K0sfg=
X-Google-Smtp-Source: ABhQp+Qt+VeE0aQyRRd7w0Yh8Jvb84BgvbpypQdPB1BAWKjlzsEyOh2MvEXVC8Jyp0aPreg8jDqPNA==
X-Received: by 10.36.112.147 with SMTP id f141mr4273327itc.59.1508971590855;
        Wed, 25 Oct 2017 15:46:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id p136sm1804284itg.14.2017.10.25.15.46.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 15:46:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] diff: decouple white space treatment for move detection from generic option
Date:   Wed, 25 Oct 2017 15:46:19 -0700
Message-Id: <20171025224620.27657-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171025224620.27657-1-sbeller@google.com>
References: <20171025224620.27657-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original implementation of the move dection logic we assumed that
the choice for ignoring white space changes is the same for the move
detection as it is for the generic diff.

It turns out, users want to have different choices regarding white spaces
for the move detection and the generic diff.  For example when reviewing
a patch that is sent to the mailing list (which doesn't ignore white space
changes at all; it is an exact patch) refactors some nested code out
into a separate function, we want to have the move detection kick in
despite different indentation levels of the old and new code.

This patch enables the user to have a different choice for ignoring
white spaces in the move detection.

The example given is covered in a test. Convert the existing tests
to be more explicit on their choice of white space behavior in the
move detection as we'll change the default shortly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  13 ++++
 diff.c                         |  17 ++++-
 diff.h                         |   1 +
 t/t4015-diff-whitespace.sh     | 150 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index a88c76741e..1000b53b84 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -265,6 +265,19 @@ dimmed_zebra::
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
index e6814b9e9c..2580315ab9 100644
--- a/diff.c
+++ b/diff.c
@@ -714,7 +714,7 @@ static int moved_entry_cmp(const struct diff_options *diffopt,
 {
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
-				    diffopt->xdl_opts);
+				    diffopt->color_moved_ignore_space);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -723,7 +723,8 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len,
+					  o->color_moved_ignore_space);
 	ret->es = l;
 	ret->next_line = NULL;
 
@@ -4592,6 +4593,18 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--color-moved-no-ignore-all-space"))
+		options->color_moved_ignore_space &= ~XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-change"))
+		options->color_moved_ignore_space &= ~XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
+		options->color_moved_ignore_space &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
+		options->color_moved_ignore_space |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
+		options->color_moved_ignore_space |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
+		options->color_moved_ignore_space |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
diff --git a/diff.h b/diff.h
index aca150ba2e..6ba3f53bbd 100644
--- a/diff.h
+++ b/diff.h
@@ -196,6 +196,7 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+	int color_moved_ignore_space;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6c9a93b734..4ef4d6934a 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1350,7 +1350,10 @@ test_expect_success 'move detection ignoring whitespace ' '
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
@@ -1374,7 +1377,10 @@ test_expect_success 'move detection ignoring whitespace ' '
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
@@ -1414,7 +1420,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
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
@@ -1438,7 +1447,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
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
@@ -1481,7 +1493,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
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
@@ -1505,7 +1520,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
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
@@ -1677,7 +1695,125 @@ test_expect_success 'move detection with submodules' '
 
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
+	<RED>-int func()<RESET>
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
+	<GREEN>+<RESET><GREEN>int func()<RESET>
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
2.15.0.rc2.6.g953226eb5f

