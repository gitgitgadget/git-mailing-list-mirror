Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF6F1F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQTr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36506 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQTrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id v24-v6so3151406plo.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1tQhBkCDBIyNYHput0bGsJ2DL+w7Xg6oa+qvdXYuEc=;
        b=ATTagjxWNI0hjw4ejwVP85WEXONUnUAMhKAGxxxT3KYLgwaijX4oQ5cJ7n1F57ak7J
         3QVz1MV5k8hnHAq2+3BkNnksrLhlZ5CBv9zam4iMQO3mVCjlpxyuRKK84z4l6HiUVHGp
         uigZFBFj5EgLRE/6C5GK2d6HgHDELP+r6uyQ+x1jTiTOYDsQ+0P7uLjKqlIl8oKIEzvj
         fQIAtMo4fUPdCiBqvJqjfH3uW1DC6O+VaLRDONtKI6guwvNPkxMTZ1/b+uilozPzekD/
         f8j+U0QnOGVXsOWhN5eF6vI46cMFYji7dSPwyDtWmszbrKR64SE/IN3jwqBj76VpEFHt
         dI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1tQhBkCDBIyNYHput0bGsJ2DL+w7Xg6oa+qvdXYuEc=;
        b=a+rRgyRC1d5ryQ8yCJfhuPpB0aTWoFI+pDNF1kQUjmF7iI3mzNiBAkyG1CYP0OZoFc
         gQQZ6MyLq6TG7dyhf5ax8ifrvRSa8pzcareYn6ZgqpbiUK52phXJxMpOGeXVANh/rbpQ
         G4x3KIf+0gUDgxDqkWyLofYI0LCsw6rNXkGbSV3Ol3imB47M0pOdisKSA2zBtqNcXRq5
         3IupE69E3lQ7kvE3EVAEq9s9uNZCu7MccMjUyVXwYquHfgHde29yV63CiWe+P3mJR/kc
         UyfIBRsY+pZ8rKL3zArpmfV16Fc45JhcqeCAYh/XpMN0e6crwx77NeKxztI3nbwnJRBQ
         sXdw==
X-Gm-Message-State: ALKqPwdSyhDGQBms5j8jHRLPIHiUGZ4sXPJJ7DE0U0LUK2oz/WtLi3rY
        9TPj6VgsTRKFvv66H7Iz7mK7tA==
X-Google-Smtp-Source: AB8JxZqyf4MajwOR+fmgKIsqHpciyOnrEAOK1DP1mbuBE8SwTmFu3xb1neZ7b84+5gP3PyBxT+F0sw==
X-Received: by 2002:a17:902:a718:: with SMTP id w24-v6mr6597088plq.45.1526586432051;
        Thu, 17 May 2018 12:47:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b3-v6sm9919942pff.132.2018.05.17.12.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 6/8] diff.c: decouple white space treatment from move detection algorithm
Date:   Thu, 17 May 2018 12:46:51 -0700
Message-Id: <20180517194653.48928-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 13 +++++
 diff.c                         | 19 ++++++-
 diff.h                         |  1 +
 t/t4015-diff-whitespace.sh     | 90 +++++++++++++++++++++++++++++++---
 4 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bb9f1b7cd82..7b2527b9a19 100644
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
index 95c51c0b7df..b5819dd538f 100644
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
index 45091abb192..751fc478dde 100755
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
2.17.0.582.gccdcbd54c44.dirty

