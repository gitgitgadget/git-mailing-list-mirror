Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E998F1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeDXVDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:46 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43456 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeDXVDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id f132so11734768pgc.10
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3I3pKpWBVMCMVqiVCZp18PBDcScq+SBqTQFXm6JLGtE=;
        b=Niaka7YdQ/p6RGm9EYgwE5d+BwKZU+3CYqVYA2+ujZsLgA1NT9bfdXsl890sl+Kpsc
         tvzdm91/sgeXKgyvHYvaErBW42KggQlpETGz04cNizRkNQIu+m/5vEuD9u4LdFAKOise
         ibrsHKovz2hoZkQ2Se6ZgpkWdtEafiMu2JgAVJDuYHVmnvnBcstFfHha+xCD0iPzZglV
         hrDIEYxqP0dGLcusDiIWGirBmcx+uN4YaL23M6KoCeLMhOjInx0zNS0RqnRDUmBC3Tzu
         6enKO5cwOVpaqlbLb22jVunrgS8G3mIw8hgRGrOdFC1w+jVopn2VW76W+SpW3LObO4gF
         7vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3I3pKpWBVMCMVqiVCZp18PBDcScq+SBqTQFXm6JLGtE=;
        b=BOYL0LkInS3r/vMmGLtFSABW+pbnTtSHGxVYSr9VMxyH2/wzhroiLcgCbO/wHjF/dd
         99vI8qDEvr0QTQzhYUfvmD9xRx31LjFWfdbngkSZfFwOHfuM2nNLpPnSUIXU8NBmx0Ie
         MqEHdtBXfV+U1HhSkkrs6S5PQRctke69A3wvxmkGmaDmmlwH8K3GB58NEsBWsC5vTaIf
         NDxa579rUvncJTs7tglHDjzVz/K60KCeum0pxZ98ZQ5OhGpv4ZqnlsQz3MxovXaADa12
         hEdRP44L7Ah7XAumyNrocGhq/f5R4HDp8Ta0LhjOMAS6okuc7ZNLZBWlX++rhUYmpsx6
         QFDw==
X-Gm-Message-State: ALQs6tC1HFOc5x4uJ8ep300R4vfcB70jntf5rTjHRV3B6g5F4m5UsYOg
        YKnLBYa1MUQjn/AKliZhRxe7yZpAjQY=
X-Google-Smtp-Source: AIpwx4+NgcoW5xYXSAm2xp9QQMbRTgEsVXayh3kudIgGhjkEUMu1l0GYTAYk7Ne267AdYK5Z8RBdow==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr26030884plk.216.1524603821589;
        Tue, 24 Apr 2018 14:03:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e83sm40782893pfd.175.2018.04.24.14.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] diff.c: decouple white space treatment from move detection algorithm
Date:   Tue, 24 Apr 2018 14:03:29 -0700
Message-Id: <20180424210330.87861-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original implementation of the move detection logic the choice for
ignoring white space changes is the same for the move detection as it is
for the regular diff.  Some cases came up where different treatment would
have been nice.

Allow the user to specify that whitespace should be ignored differently
during detection of moved lines than during generation of added and removed
lines. This is done by providing analogs to the --ignore-space-at-eol,
-b, and -w options (namely,
  --color-moved-[no-]ignore-space-at-eol
  --color-moved-[no-]ignore-space-change
  --color-moved-[no-]ignore-all-space) that affect only the color of the
output, and making the existing --ignore-space-at-eol, -b, and -w options
no longer affect the color of the output.

As we change the default, we'll adjust the tests.

For now we do not infer any options to treat whitespaces in the move
detection from the generic white space options given to diff.
This can be tuned later to reasonable default.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 13 +++++
 diff.c                         | 19 ++++++-
 diff.h                         |  1 +
 t/t4015-diff-whitespace.sh     | 90 +++++++++++++++++++++++++++++++---
 4 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bb9f1b7cd8..7b2527b9a1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -292,6 +292,19 @@ dimmed_zebra::
 	blocks are considered interesting, the rest is uninteresting.
 --
 
+--color-moved-[no-]ignore-space-at-eol::
+	Ignore changes in whitespace at EOL when performing the move
+	detection for --color-moved.
+--color-moved-[no-]ignore-space-change::
+	Ignore changes in amount of whitespace when performing the move
+	detection for --color-moved.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
+--color-moved-[no-]ignore-all-space::
+	Ignore whitespace when comparing lines when performing the move
+	detection for --color-moved.  This ignores differences even if
+	one line has whitespace where the other line has none.
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/diff.c b/diff.c
index 95c51c0b7d..b5819dd538 100644
--- a/diff.c
+++ b/diff.c
@@ -717,10 +717,12 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct moved_entry *a = entry;
 	const struct moved_entry *b = entry_or_key;
+	unsigned flags = diffopt->color_moved_ws_handling
+			 & XDF_WHITESPACE_FLAGS;
 
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
-				    diffopt->xdl_opts);
+				    flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -728,8 +730,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 {
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
 
@@ -4638,6 +4641,18 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--color-moved-no-ignore-all-space"))
+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-change"))
+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
diff --git a/diff.h b/diff.h
index 7bd4f182c3..de5dc68005 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,7 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+	int color_moved_ws_handling;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 45091abb19..751fc478dd 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1441,7 +1441,10 @@ test_expect_success 'move detection ignoring whitespace ' '
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
@@ -1465,7 +1468,10 @@ test_expect_success 'move detection ignoring whitespace ' '
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
@@ -1505,7 +1511,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
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
@@ -1529,7 +1538,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
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
@@ -1572,7 +1584,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
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
@@ -1596,7 +1611,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
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
@@ -1768,7 +1786,65 @@ test_expect_success 'move detection with submodules' '
 
 	# nor did we mess with it another way
 	git diff --submodule=diff --color | test_decode_color >expect &&
-	test_cmp expect decoded_actual
+	test_cmp expect decoded_actual &&
+	rm -rf bananas &&
+	git submodule deinit bananas
+'
+
+test_expect_success 'only move detection ignores white spaces' '
+	git reset --hard &&
+	q_to_tab <<-\EOF >text.txt &&
+		a long line to exceed per-line minimum
+		another long line to exceed per-line minimum
+		original file
+	EOF
+	git add text.txt &&
+	git commit -m "add text" &&
+	q_to_tab <<-\EOF >text.txt &&
+		Qa long line to exceed per-line minimum
+		Qanother long line to exceed per-line minimum
+		new file
+	EOF
+
+	# Make sure we get a different diff using -w
+	git diff --color --color-moved -w \
+		--color-moved-no-ignore-all-space \
+		--color-moved-no-ignore-space-change \
+		--color-moved-no-ignore-space-at-eol |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,3 +1,3 @@<RESET>
+	 Qa long line to exceed per-line minimum<RESET>
+	 Qanother long line to exceed per-line minimum<RESET>
+	<RED>-original file<RESET>
+	<GREEN>+<RESET><GREEN>new file<RESET>
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
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,3 +1,3 @@<RESET>
+	<BOLD;MAGENTA>-a long line to exceed per-line minimum<RESET>
+	<BOLD;MAGENTA>-another long line to exceed per-line minimum<RESET>
+	<RED>-original file<RESET>
+	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>a long line to exceed per-line minimum<RESET>
+	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>another long line to exceed per-line minimum<RESET>
+	<GREEN>+<RESET><GREEN>new file<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_done
-- 
2.17.0.441.gb46fe60e1d-goog

