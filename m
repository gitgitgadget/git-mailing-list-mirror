Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F591F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeGRULk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:40 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:53934 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:40 -0400
Received: by mail-io0-f202.google.com with SMTP id o24-v6so4131158iob.20
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p6XPzVnllf9Qi/ogZt05DRLvrwU1b6rMDeMZ7p23VWM=;
        b=eFEoj4Gw9IOrY0XGAeHad98VZKf3zFWqP9js2szZnFMihaVSQJ5uccNGL0G6UnSNTm
         yAIuc7mDpze62Xwj+KESMCNGYNuKzQKQqTiZ/gYIwpj9svAlyMRl1wMxsMWMWL/tNHTH
         b6CgI2J6PxSKyNR+TpWsdAAZTUCLKjtkxHPUfcx4Yj1zKATJlj4g4KbWn9PILxUOgW9W
         aCuhNmrKUw5TD0GBQGG1ueloJ6kLAhXtOJyJ2kxnN7jBGU4HE12c31ZWozmqlXxnVS+9
         XSxapE1bOffnl9PK5eRARrwJykzP+CEsTtngL38j6OJPSeozWoneFUZlGfIFu1MvWngW
         t+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p6XPzVnllf9Qi/ogZt05DRLvrwU1b6rMDeMZ7p23VWM=;
        b=tVdy8GEGrpxeZtGq3Q3GricjKqkGm4F2Yz7Or0fWFBP7o/aNpN82D8MVLQ8MuIEUWA
         kOgsN42OSGacLNHMkdW1Qz+q6axvladM0vgteBMJm8zovAAaUY1Zb09OWq9zITo6vGjt
         ynHqXnaolvELMBicloTXCWWFyucRv6g6P52+CSozrK+VNPiA30aaEOf4JyI3IXhbdlOS
         0+ajQKbLFQxSwo2tINeRMcg77zhaYrSBdP0X+pG2SWiEz2Zejd1Z8XX/wgKEiZh36Goq
         84pQbtshSSo8Shg2/pWJbQF7WtmRG4YukXaAuLBSbiNXpFUwF0XgOT7pyXi4UOj8DYNO
         kr/g==
X-Gm-Message-State: AOUpUlFafWe0v504/1/K2Orc+jjJ+GJBIG3bOQV7ltw0w2c0F82TeWf/
        dNRzDXnQX7FWmsW++ikjmgvc9+uuD4Ia9lJANj0p9I93duzakuWiIJzYLF+KXIIo8jN3NunhBsr
        LLLuNDH5yh+iTXQgvV20t0CkvMPoS46nyD58iUrK/LaphU0iWWoZBoyN3X+b1
X-Google-Smtp-Source: AAOMgpeTEOW7doqVepIUbk0W8PpM+RIQD7Iqh+Zf6zZseu3u/P25pnzvjtaKpAcKShelZoiPXFWYHF8gn/jG
MIME-Version: 1.0
X-Received: by 2002:a24:324d:: with SMTP id j74-v6mr1621902ita.26.1531942340153;
 Wed, 18 Jul 2018 12:32:20 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:53 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-8-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 07/10] diff.c: decouple white space treatment from move
 detection algorithm
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original implementation of the move detection logic the choice for
ignoring white space changes is the same for the move detection as it is
for the regular diff.  Some cases came up where different treatment would
have been nice.

Allow the user to specify that white space should be ignored differently
during detection of moved lines than during generation of added and removed
lines. This is done by providing analogs to the --ignore-space-at-eol,
-b, and -w options by introducing the option --color-moved-ws=<modes>
with the modes named "ignore-space-at-eol", "ignore-space-change" and
"ignore-all-space", which is used only during the move detection phase.

As we change the default, we'll adjust the tests.

For now we do not infer any options to treat white spaces in the move
detection from the generic white space options given to diff.
This can be tuned later to reasonable default.

As we plan on adding more white space related options in a later patch,
that interferes with the current white space options, use a flag field
and clamp it down to  XDF_WHITESPACE_FLAGS, as that (a) allows to easily
check at parse time if we give invalid combinations and (b) can reuse
parts of this patch.

By having the white space treatment in its own option, we'll also
make it easier for a later patch to have an config option for
spaces in the move detection.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 17 ++++++++++
 diff.c                         | 39 +++++++++++++++++++--
 diff.h                         |  1 +
 t/t4015-diff-whitespace.sh     | 62 +++++++++++++++++++++++++++++++---
 4 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ba56169de31..80e29e39854 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -292,6 +292,23 @@ dimmed_zebra::
 	blocks are considered interesting, the rest is uninteresting.
 --
 
+--color-moved-ws=<modes>::
+	This configures how white spaces are ignored when performing the
+	move detection for `--color-moved`. These modes can be given
+	as a comma separated list:
++
+--
+ignore-space-at-eol::
+	Ignore changes in whitespace at EOL.
+ignore-space-change::
+	Ignore changes in amount of whitespace.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
+ignore-all-space::
+	Ignore whitespace when comparing lines. This ignores differences
+	even if one line has whitespace where the other line has none.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/diff.c b/diff.c
index 95c51c0b7df..70eeb40c5fd 100644
--- a/diff.c
+++ b/diff.c
@@ -283,6 +283,36 @@ static int parse_color_moved(const char *arg)
 		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed_zebra', 'plain'"));
 }
 
+static int parse_color_moved_ws(const char *arg)
+{
+	int ret = 0;
+	struct string_list l = STRING_LIST_INIT_DUP;
+	struct string_list_item *i;
+
+	string_list_split(&l, arg, ',', -1);
+
+	for_each_string_list_item(i, &l) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, i->string);
+		strbuf_trim(&sb);
+
+		if (!strcmp(sb.buf, "ignore-space-change"))
+			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
+		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
+			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		else if (!strcmp(sb.buf, "ignore-all-space"))
+			ret |= XDF_IGNORE_WHITESPACE;
+		else
+			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
+
+		strbuf_release(&sb);
+	}
+
+	string_list_clear(&l, 0);
+
+	return ret;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -717,10 +747,12 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
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
@@ -728,8 +760,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 {
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
 
@@ -4710,6 +4743,8 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
+	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
+		options->color_moved_ws_handling = parse_color_moved_ws(arg);
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
diff --git a/diff.h b/diff.h
index 7bd4f182c33..de5dc680051 100644
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
index e54529f026d..000c3a2b7de 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1460,7 +1460,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-all-space >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1522,7 +1523,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-space-change >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1587,7 +1589,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-space-at-eol >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1757,7 +1760,58 @@ test_expect_success 'move detection with submodules' '
 
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
+	git diff --color --color-moved -w >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
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
+		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
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
2.18.0.233.g985f88cf7e-goog

