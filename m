Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03991F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeHKBVa (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:21:30 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:48127 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKBVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:21:30 -0400
Received: by mail-io0-f202.google.com with SMTP id l25-v6so8171784iog.14
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i5zEj9sxTpkGY7sLwcJncPSf0aQQIw6T9BwOTzDGusc=;
        b=RkM6KpojBdSnFVvgzJZPC+dFz+2ZnBoK4FwNPNQw6Pd0cgYK2wEcz4/Ta7DIi/r7Mj
         ay6jA3A5g7H2Tmj7NksSdvrbbN9SU+Ktwcpiqpc8t4Hpc56ajzJtpIP3a07UbvxMQve6
         9BkjPUOEx5eExJhHyB0lVlQSqoAro7+ruXt8ifDSlMqZ2/zizwfiN6xCRa+4ERy8GMMt
         tiZz2eJZ3N4+KZFljDeGJ/KBrqClZ4tnvV0N1XgudtdImxiLLZw6pAXitovuD46j4NgK
         3NwfhyieNDJWrmMhmVvkPcNp6mmMNfzCHos/KecS4I7IJT5VHGhkBbVCvg7IzwUGtRgA
         ILIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i5zEj9sxTpkGY7sLwcJncPSf0aQQIw6T9BwOTzDGusc=;
        b=OTDVEUdJxOJHwtxcJDjWxiH6ySJaRsystf8DXRw26DKMaEpuMWppE4jKqueEFvqVjX
         8lyJ3KQOsMV4sTpjnjFc1LMU5z7ZMveIOaUhB0jUN9c4W/dRLxTdsFOmpz+5EgmK+ymL
         fKvFil+v/t/uBxbk17cUtSjnYdLFxNr2EpYemNyCIG3qmuqdMa+lgjVrIrS2TumyTUod
         J1loQhrGBwdmDVdQ9b4Bm+LHHi/046tQJRE93gXZJa7deRxn5+QvQiGAC4NiWGluTPvU
         30/IhbN1OPwX9Z3HbHVEfREOpOMQmgPtaZNH8Vb0qVF2QewhGC3G12QfFZvP7B0f9vdR
         P7vw==
X-Gm-Message-State: AOUpUlHH12SUDytyoD4vr5TpG2xWWeorNFj8j4RKVXC1R3hoFigfBiFr
        2QFe23PKux0Iesc2yhPTTKGr8sALd/RP
X-Google-Smtp-Source: AA+uWPw2Rm5X+B7JEJ6RzjBgZh8tfJellb0qmuiH3oqX2DbuRI5hyKpNQJccqSKt40aQNpU38NVMeOYIEgjr
X-Received: by 2002:a24:1182:: with SMTP id 124-v6mr2116512itf.8.1533941377368;
 Fri, 10 Aug 2018 15:49:37 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:49:20 -0700
In-Reply-To: <20180810224923.143625-1-sbeller@google.com>
Message-Id: <20180810224923.143625-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/4] diff.c: emit_line_0 to take string instead of first sign
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By providing a string as the first part of the emission we can extend
it later more easily.

While at it, document emit_line_0.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index af9316c8f91..b3cb73eb69a 100644
--- a/diff.c
+++ b/diff.c
@@ -621,9 +621,15 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
+/*
+ * Emits
+ * <set_sign> <first> <reset> <set> <second> <reset> LF
+ * if they are present. 'first' is a NULL terminated string,
+ * 'second' is a buffer of length 'len'.
+ */
 static void emit_line_0(struct diff_options *o,
 			const char *set_sign, const char *set, const char *reset,
-			int first, const char *line, int len)
+			const char *first, const char *second, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int reverse = !!set && !!set_sign;
@@ -633,11 +639,11 @@ static void emit_line_0(struct diff_options *o,
 
 	fputs(diff_line_prefix(o), file);
 
-	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	has_trailing_newline = (len > 0 && second[len-1] == '\n');
 	if (has_trailing_newline)
 		len--;
 
-	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	has_trailing_carriage_return = (len > 0 && second[len-1] == '\r');
 	if (has_trailing_carriage_return)
 		len--;
 
@@ -655,7 +661,7 @@ static void emit_line_0(struct diff_options *o,
 	}
 
 	if (first)
-		fputc(first, file);
+		fputs(first, file);
 
 	if (!len)
 		goto end_of_line;
@@ -666,7 +672,7 @@ static void emit_line_0(struct diff_options *o,
 		fputs(set, file);
 		needs_reset = 1;
 	}
-	fwrite(line, len, 1, file);
+	fwrite(second, len, 1, file);
 	needs_reset |= len > 0;
 
 end_of_line:
@@ -681,7 +687,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, 0, line, len);
+	emit_line_0(o, set, NULL, reset, NULL, line, len);
 }
 
 enum diff_symbol {
@@ -1201,7 +1207,7 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set_sign, const char *set,
 				const char *reset,
-				char sign, const char *line, int len,
+				const char *sign, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -1244,7 +1250,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, reset, '\\',
+		emit_line_0(o, context, NULL, reset, "\\",
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
@@ -1282,7 +1288,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1325,7 +1331,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1368,7 +1374,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.865.gffc8e1a3cd6-goog

