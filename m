Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559551F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeHQXtB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:49:01 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:51783 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeHQXtB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:49:01 -0400
Received: by mail-ua1-f73.google.com with SMTP id 71-v6so3438613uas.18
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zC/yn0VPNk9RD8j7jtKwFKe8HgmZPkAKK5WgPsD1Bis=;
        b=h899EjnYNmisPws7q7FERmrWs0isFuoxESZY+pbCJshty6EOMWkAg03hNx/zh3KNmd
         RphWx70rFTqZ9EM/te0Lty4z1Oyx+tz2l2Oo/ugIRA8GlZdQkL7A0Pwv3hFvK9PAOo9f
         eOlK915U2jxrumNy8gr2CaPOfbw5/ZVliDc1OIF6bOm5znBzad2YxA/MowealtHeSUgd
         284IzYR+MLN+ji1O3wSpu4S6H7YcilLdBC9HFFjQzs1Xo8WCz4D13y9eGmmAJAYiIwJK
         JWof6x7qyJxqAJg3dmjkwkaqYk8VilAkTyj8PTj1ubq8AQsrBASBNOlXq7ejrCTkWxL2
         FvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zC/yn0VPNk9RD8j7jtKwFKe8HgmZPkAKK5WgPsD1Bis=;
        b=njdNlbwSgkWfC1z5qzY3Wyu9WV32AJb58Fd/VRZTH1kE+vq1yf8qqBAUh1hZSWEBKS
         62blN7HVBg0xnUiphKyAomU031rtky6XjTZH0LZWJkRJ6zh7o6IsxNTnz7DGDa5ajr4C
         3Q1TABmWiZyct0bfmda2XbU1QiTwkMeDRqqdj1cjl8k3mu4kQzyPHTw5ZwMHZZLxciEu
         oO1yPf6sqCUSIRXqi1IvB/KiC08JFWeqEiPJAikYlmySPoDh7SkkpL5lnwvYafsJNYyI
         Ws/+Dn8zmPIsE2yR0jx5+Ow0kaF9/TH+05xwoFxloAJOPa/eeE0HWxqfeyqoAtToNTIi
         D8lw==
X-Gm-Message-State: AOUpUlFCd/yqvr5xW/lMfKPWPrqZv83CZCd/SKQULzrQ11SRTWs/vnDz
        MV+priWp4eQvv35amQ4qFpB1JyJYX05G
X-Google-Smtp-Source: AA+uWPylDtqB43m9U17/jGs2QXkq/t249HOATLXwn1d/pjLqNbx9I7ZWH/IF8mO8a7TwZXHrDy/dNOcT1xB0
MIME-Version: 1.0
X-Received: by 2002:ab0:324f:: with SMTP id r15-v6mr17065792uan.67.1534538649218;
 Fri, 17 Aug 2018 13:44:09 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:43:52 -0700
In-Reply-To: <20180817204354.108625-1-sbeller@google.com>
Message-Id: <20180817204354.108625-2-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet> <20180817204354.108625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 1/3] diff.c: add --output-indicator-{new, old, context}
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will prove useful in range-diff in a later patch as we will be able to
differentiate between adding a new file (that line is starting with +++
and then the file name) and regular new lines.

It could also be useful for experimentation in new patch formats, i.e.
we could teach git to emit moved lines with lines other than +/-.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 21 ++++++++++++++++++---
 diff.h |  5 +++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index c5c7739ce34..03486c35b75 100644
--- a/diff.c
+++ b/diff.c
@@ -1281,7 +1281,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset,
+				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
+				    line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1324,7 +1326,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset,
+				    o->output_indicators[OUTPUT_INDICATOR_NEW],
+				    line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1367,7 +1371,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset,
+				    o->output_indicators[OUTPUT_INDICATOR_OLD],
+				    line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
@@ -4382,6 +4388,9 @@ void diff_setup(struct diff_options *options)
 
 	options->file = stdout;
 
+	options->output_indicators[OUTPUT_INDICATOR_NEW] = '+';
+	options->output_indicators[OUTPUT_INDICATOR_OLD] = '-';
+	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
 	options->break_opt = -1;
@@ -4869,6 +4878,12 @@ int diff_opt_parse(struct diff_options *options,
 		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--no-compact-summary"))
 		 options->flags.stat_with_summary = 0;
+	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
+	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
+		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
+	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
+		options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = arg[0];
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/diff.h b/diff.h
index e1e54256c18..d7edc64454a 100644
--- a/diff.h
+++ b/diff.h
@@ -194,6 +194,11 @@ struct diff_options {
 	FILE *file;
 	int close_file;
 
+#define OUTPUT_INDICATOR_NEW 0
+#define OUTPUT_INDICATOR_OLD 1
+#define OUTPUT_INDICATOR_CONTEXT 2
+	char output_indicators[3];
+
 	struct pathspec pathspec;
 	pathchange_fn_t pathchange;
 	change_fn_t change;
-- 
2.18.0.265.g16de1b435c9.dirty

