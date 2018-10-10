Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B8C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeJKGt1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:49:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46383 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJKGt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:49:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id k1-v6so6320908pfg.13
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xWt+MRzk8eUqUcTthevWZYYF0Qp5MaeBdnJu0m9/RH8=;
        b=SDSwSyQs2DGwl9oS2TCg9zkAA4RyQ0Vf1pfabYw2DVLKcmNVaa9XhcitNjjqoX+5ME
         EYLPXdUxPljadvfLmbpqXQ4CMWqaN++wnhrJrgNlxRQs6ArRVSJPE0nqlC9cGVqOtYdg
         /mZJwzY3Vrsm7itov3saBW4N0vQYxw6auSnE3CfAb2YdL4qoevnSJBsGOUdbSL5qd1Aa
         Z8yJwbiHUusfdIm5nGZXlmjhGgOFukepZc9YKqnQ1ez1SVi7EQC1AKJr2+VeAzsQ7BLv
         TKfKNIa+BPl6Umu81BI8ESHrxxe6s1NsfBwE4evGNSqVbv0i0YfzHB7ci6V/dr0CRQbf
         n7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xWt+MRzk8eUqUcTthevWZYYF0Qp5MaeBdnJu0m9/RH8=;
        b=cpbg6AQVyeYEwVdgdrA6rA1cJ4hDb1WHFkCf8WFc5+M+pfaA7UDNgfbQ2cbT7SZbFJ
         65iwne5XZ6DdDKUYYqIIk0ZRl6kEo1V/1O6SMNXO1qpAz/sYv9ibIXbmNBw6V7Z3C3zK
         81vJrPK43zsDGm7AvR015km1Jm7CTUFd9km6bOZyu5IXTT0nX55xPIi1vdFOM/t8a1qG
         LNxhWRITO+5YVoJ+/54uozttJmkJgDSTz0pOu6NFh93lPtdOeVVuZFMMesiWVdVi0IAg
         t3cAKaR1JDLtV2yfoRjHVN7r9NeuvPjkPerjiM5viib12IXcUBv8O+XnyoL56+pbTanG
         cVgA==
X-Gm-Message-State: ABuFfoj3FpzSjnexbICmMk3Pek+lbV1eDXmVeRrbe8/0bk72Hzh0FHWl
        Q5A6GlWkJLh07KP0rXDYC55RvJabMm8uNTpxfQPlKZ69XgKrGPuna4udkLfnlDYIqtNLi5DAPL1
        4lkIF5f+A7NBr8QFYWo47yusTyN1/NtynOWEDLtUfpe/L2YyqYKR3gIuXL0x0
X-Google-Smtp-Source: ACcGV62GMMhzfMlFn1HiheUlMt93ZXTdf5N741NUhylOhS9N5/kdYc+JkDpJQVpffEMz5P4uBWMFQNTICkon
X-Received: by 2002:a62:4b18:: with SMTP id y24-v6mr16136938pfa.64.1539213902917;
 Wed, 10 Oct 2018 16:25:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:24:59 -0700
Message-Id: <20181010232459.251289-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] diff.c: pass sign_index to emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing the sign directly to emit_line_ws_markup, pass only the
index to lookup the sign in diff_options->output_indicators.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I still have this patch laying around, it simplifies the diff code
a tiny bit.

Stefan

 diff.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index f0c7557b40..9e895f2191 100644
--- a/diff.c
+++ b/diff.c
@@ -1202,10 +1202,11 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set_sign, const char *set,
 				const char *reset,
-				char sign, const char *line, int len,
+				int sign_index, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
+	int sign = o->output_indicators[sign_index];
 
 	if (o->ws_error_highlight & ws_rule) {
 		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
@@ -1285,8 +1286,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
-				    line, len,
+				    OUTPUT_INDICATOR_CONTEXT, line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1330,8 +1330,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_NEW],
-				    line, len,
+				    OUTPUT_INDICATOR_NEW, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1375,8 +1374,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_OLD],
-				    line, len,
+				    OUTPUT_INDICATOR_OLD, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.19.0

