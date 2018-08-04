Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ECE208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeHDDw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:27 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:39929 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbeHDDw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:27 -0400
Received: by mail-it0-f74.google.com with SMTP id w196-v6so7252969itb.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nW6rKFAplGO4cR2N5hHZ5yJf/scurRl3D1le+/Q0fKw=;
        b=GQOdgwe2K6Dq+n4egD+/SeEJlmPMMWqONffSx4xbGGMOzJJnIinHh8D8v85UMYPP4B
         /0aXywfGkMIS7Ut7sgtyjBo/RCWJDi63ie3lSzogG0ZUHRGKS2oO3ZtY5vIpv38sCPSI
         V+v03UulrcvpGayuGE/SrmfzSA6B52PfFKp0geQB6gCoNI9vTZWexvD1LyVA2luIIIs9
         4vy7GfQtCM9sclTLddm+lrGacqDa1rNOawoYrFJJb6fcTlSKEIJBiHblzGeVGYzYySxD
         ftIg2Z5Xwe6P8Zc2911Zj9wrfVqAzfN937e/AfwbWH745gzW00ATFQrJPdN9HbS4KjWK
         uroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nW6rKFAplGO4cR2N5hHZ5yJf/scurRl3D1le+/Q0fKw=;
        b=Le/YNiOVHazEEzB38GoCUP1Amq07LcV4HozFWgPq3aPQPsU/psnCH1mFwNvvSntei9
         nZ/0SrGeBvdWuOEvDs8tED8aeUtAhJj9qF+xAxSwgpEwthg2PFzQ1DLz+3g1K4poOK7U
         oUbtVmaXG62aVBFaAfMDR4Y9YLZGKiYfCAZaLcuYaJhnEkS/o9dAufwapRmXByN0Wws7
         Bv7fqOBmdirnssqzd9kxETyaMGrw51CYHRWeA+LH5bNP7q3LF4lMC5IJ+hr0IvePLOY7
         PEBeWBRTO+heDCGOwjdT4IYZNQVjf7DZa4/yJiAb91vD4NSc89VDHjKg22t+MtiHQvza
         bDeg==
X-Gm-Message-State: AOUpUlFfEIrnz1zvdt8WBfow4Tpp8FBquSzUclHTCNMocnvZsjGzNiUq
        aps48nMG9TJ5CSil9HR014m+G7h9BchmXAaBRMA/OCkbOyIyd5rIawMChznuKWPhDYgSqQseQgc
        47FBAyqXu0nNto6XXrI3hO6xRo1xSBDrlv9bDTILY0SUIOWLS7o2imQG5AMW/
X-Google-Smtp-Source: AAOMgpdDaj+hYExobHz6ighcUaQswMqb4bBFwT+2ao2g2Gn4j31HMz2X62rLD02N+jaFnBBf4xduXqkjsHLM
X-Received: by 2002:a5e:8c17:: with SMTP id n23-v6mr3754721ioj.132.1533347618051;
 Fri, 03 Aug 2018 18:53:38 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:17 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC PATCH 7/7] diff/am: enhance diff format to use */~ for moved lines
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try it out via
    ./git-format-patch --mark-moved 15ef69314d^..15ef69314d
to see if you like it.

This separates the coloring decision from the detection of moved lines.
When giving --mark-moved, move detection is still performed and the output
markers are adjusted to */~ for new and old code.

git-apply and git-am will also accept these patches by rewriting those
signs back to +/-.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c | 12 ++++++++++++
 diff.c  | 21 +++++++++++++++++++++
 diff.h  |  5 ++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 23a0f25ded8..cc42a4fa02a 100644
--- a/apply.c
+++ b/apply.c
@@ -2900,6 +2900,12 @@ static int apply_one_fragment(struct apply_state *state,
 			    ws_blank_line(patch + 1, plen, ws_rule))
 				is_blank_context = 1;
 			/* fallthrough */
+		case '~':
+			/*
+			 * For now ignore moved line indicators and apply
+			 * as a regular old line
+			 */
+			/* fallthrough */
 		case '-':
 			memcpy(old, patch + 1, plen);
 			add_line_info(&preimage, old, plen,
@@ -2908,6 +2914,12 @@ static int apply_one_fragment(struct apply_state *state,
 			if (first == '-')
 				break;
 			/* fallthrough */
+		case '*':
+			/*
+			 * For now ignore moved line indicators and apply
+			 * as a regular new line
+			 */
+			/* fallthrough */
 		case '+':
 			/* --no-add does not add new lines */
 			if (first == '+' && state->no_add)
diff --git a/diff.c b/diff.c
index 56bab011df7..8e39e77229f 100644
--- a/diff.c
+++ b/diff.c
@@ -1043,6 +1043,9 @@ static const char *determine_line_color(struct diff_options *o,
 	const int off = (eds->s == DIFF_SYMBOL_PLUS) ?
 		DIFF_FILE_NEW_MOVED - DIFF_FILE_OLD_MOVED : 0;
 
+	if (!o->color_moved)
+		goto default_color;
+
 	switch (flags & (DIFF_SYMBOL_MOVED_LINE |
 			 DIFF_SYMBOL_MOVED_LINE_ALT |
 			 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
@@ -1063,6 +1066,7 @@ static const char *determine_line_color(struct diff_options *o,
 		set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + off);
 		break;
 	default:
+default_color:
 		set = (eds->s == DIFF_SYMBOL_PLUS) ?
 			diff_get_color_opt(o, DIFF_FILE_NEW):
 			diff_get_color_opt(o, DIFF_FILE_OLD);
@@ -1152,6 +1156,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 
 		first = o->output_indicators[OI_NEW] ?
 			o->output_indicators[OI_NEW] : "+";
+		if (o->output_indicators[OI_MOVED_NEW] &&
+		   (flags & DIFF_SYMBOL_MOVED_LINE))
+			first = "*";
 		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
@@ -1176,6 +1183,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		}
 		first = o->output_indicators[OI_OLD] ?
 			o->output_indicators[OI_OLD] : "-";
+		if (o->output_indicators[OI_MOVED_NEW] &&
+		   (flags & DIFF_SYMBOL_MOVED_LINE))
+			first = "~";
 		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
@@ -4795,6 +4805,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
 	else if (!strcmp(arg, "--color-moved")) {
+		options->color_moved = 1;
 		if (diff_color_moved_default)
 			options->markup_moved = diff_color_moved_default;
 		if (options->markup_moved == COLOR_MOVED_NO)
@@ -4806,6 +4817,16 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->markup_moved = cm;
+		options->color_moved = 1;
+	} else if (skip_prefix(arg, "--mark-moved", &arg)) {
+		/*
+		 * NEEDSWORK:
+		 * Once merged with 51da15eb230 (diff.c: add a blocks mode for
+		 * moved code detection, 2018-07-16), make it COLOR_MOVED_BLOCKS
+		 */
+		options->markup_moved = COLOR_MOVED_PLAIN;
+		options->output_indicators[OI_MOVED_NEW] = "*";
+		options->output_indicators[OI_MOVED_OLD] = "~";
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
diff --git a/diff.h b/diff.h
index 0dd1651dda4..0058602c849 100644
--- a/diff.h
+++ b/diff.h
@@ -197,7 +197,9 @@ struct diff_options {
 #define OI_NEW 0
 #define OI_OLD 1
 #define OI_CONTEXT 2
-	const char *output_indicators[3];
+#define OI_MOVED_NEW 3
+#define OI_MOVED_OLD 4
+	const char *output_indicators[5];
 
 	struct pathspec pathspec;
 	pathchange_fn_t pathchange;
@@ -211,6 +213,7 @@ struct diff_options {
 
 	int diff_path_counter;
 
+	unsigned color_moved : 1;
 	struct emitted_diff_symbols *emitted_symbols;
 	enum {
 		COLOR_MOVED_NO = 0,
-- 
2.18.0.597.ga71716f1ad-goog

