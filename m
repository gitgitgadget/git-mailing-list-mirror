Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B071F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeFTUFm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36896 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932936AbeFTUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id l22-v6so759490oib.4
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6C9cB/ALcvw7VN/qyID/yNz80FMwr8wPvWyHFmnFu3M=;
        b=DLwiFRqaYI72JRl2+2OSyuM0M8XsK0bsPbyyi15QvY48HmAMKs55mfXNsdNk4x/NUJ
         i2ReWQDnIiIbTuSrPHS4cfSLbG2S+oXUdITNhLXiTWcNZQEvvUGmEPd6n0n9TdiS7GTv
         hZeunUN3hX2kASpWB1HV4gVfkdx+LHET4TJ8lCt1qNGWDTkPa1rNyaLSyKMoSCA7KkSR
         RgwdgnbsFXblok1gRglKPF9pe+En+drwJG9n76Dxgh9geLL/bNDUnrPy6A5MzaDOYOdE
         EyJ/amLaptoJ89EKN8NNHLrq+UTAPnbHobX+bi5bi+lJCWjlD8v35IpunA61WRUtrpF9
         oEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6C9cB/ALcvw7VN/qyID/yNz80FMwr8wPvWyHFmnFu3M=;
        b=FneVIFOzwk58YnTrmv83E7Pgy9gi5dq959wwb9BV2dJ5hcy/euyIE43gMAQjA6KuuZ
         9xDkcYq1dxB2tGWgq3sXKpNlBN6v5MaoIBJIkt6Xg+zdiC/0XK8oyDxt1ikUfbkfJNay
         VfVgSkNYBpXzjW5QjkZ6UVKYhH4ijnRgskZjis8s+8WyRqaJLHhZ65f/Shub7VWKrJPn
         iDznMSQFyv57NLM/hosLN/s/QtGeZaGSFNQju7lGwg7eJAU0Wkqb7+3SLav1fWMimVrH
         kF6qc4e/VAhg5FfoUqo82BiK+Cn4FRuOxx2/h7hUsZOHGoB55mhqOHUmK0b9THWlUrLj
         LWPQ==
X-Gm-Message-State: APt69E1I++quBD01AAwTUmYskwy5InVg61jA76bkn1x4vbG8HryXrnOw
        D5mN8KPzTkDhMjGeB6KsL4wQnbZJ6eI=
X-Google-Smtp-Source: ADUXVKITiZMa1CMtZwtPl+cSlY3KUggyJNWmWPYyWDKtD7GuqEfMOlMWDlmYBSqgMrJ998aiMh/3lA==
X-Received: by 2002:aca:1c3:: with SMTP id 186-v6mr13160357oib.174.1529525138815;
        Wed, 20 Jun 2018 13:05:38 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id j40-v6sm1584927ota.29.2018.06.20.13.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 2/7] grep.c: expose {,inverted} match column in
 match_line()
Message-ID: <047550bcfd35941476dd9c8cb86351ef1ab37482.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling match_line(), callers presently cannot determine the
relative offset of the match because match_line() discards the
'regmatch_t' that contains this information.

Instead, teach match_line() to take in two 'ssize_t's. Fill the first
with the offset of the match produced by the given expression. If
extended, fill the later with the offset of the match produced as if
--invert were given.

For instance, matching "--not -e x" on this line produces a columnar
offset of 0, (i.e., the whole line does not contain an x), but "--invert
--not -e -x" will fill the later ssize_t of the column containing an
"x", because this expression is semantically equivalent to "-e x".

To determine the column for the inverted and non-inverted case, do the
following:

  - If matching an atom, the non-inverted column is as given from
    match_one_pattern(), and the inverted column is unset.

  - If matching a --not, the inverted column and non-inverted column
    swap.

  - If matching an --and, or --or, the non-inverted column is the
    minimum of the two children, with the exception that --or is
    short-circuiting. For instance, if we match "-e a --or -e b" on a
    line that contains both "a" and "b" (and "b" comes first), the match
    column will hold "a", since we inspected the left child first, and
    short-circuited over the right child.

This patch will become useful when we later pick between the two new
results in order to display the column number of the first match on a
line with --column.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 58 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/grep.c b/grep.c
index 45ec7e636c..dedfe17f93 100644
--- a/grep.c
+++ b/grep.c
@@ -1248,11 +1248,11 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	return hit;
 }
 
-static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
-			   enum grep_context ctx, int collect_hits)
+static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
+			   char *eol, enum grep_context ctx, ssize_t *col,
+			   ssize_t *icol, int collect_hits)
 {
 	int h = 0;
-	regmatch_t match;
 
 	if (!x)
 		die("Not a valid grep expression");
@@ -1261,25 +1261,39 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 		h = 1;
 		break;
 	case GREP_NODE_ATOM:
-		h = match_one_pattern(x->u.atom, bol, eol, ctx, &match, 0);
+		{
+			regmatch_t tmp;
+			h = match_one_pattern(x->u.atom, bol, eol, ctx,
+					      &tmp, 0);
+			if (h && (*col < 0 || tmp.rm_so < *col))
+				*col = tmp.rm_so;
+		}
 		break;
 	case GREP_NODE_NOT:
-		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
+		/*
+		 * Upon visiting a GREP_NODE_NOT, col and icol become swapped.
+		 */
+		h = !match_expr_eval(opt, x->u.unary, bol, eol, ctx, icol, col,
+				     0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, 0))
+		if (!match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
+				     icol, 0))
 			return 0;
-		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, 0);
+		h = match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+				    icol, 0);
 		break;
 	case GREP_NODE_OR:
 		if (!collect_hits)
-			return (match_expr_eval(x->u.binary.left,
-						bol, eol, ctx, 0) ||
-				match_expr_eval(x->u.binary.right,
-						bol, eol, ctx, 0));
-		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, 0);
+			return (match_expr_eval(opt, x->u.binary.left, bol, eol,
+						ctx, col, icol, 0) ||
+				match_expr_eval(opt, x->u.binary.right, bol,
+						eol, ctx, col, icol, 0));
+		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
+				    icol, 0);
 		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, 1);
+		h |= match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+				     icol, 1);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -1290,25 +1304,30 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 }
 
 static int match_expr(struct grep_opt *opt, char *bol, char *eol,
-		      enum grep_context ctx, int collect_hits)
+		      enum grep_context ctx, ssize_t *col,
+		      ssize_t *icol, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(x, bol, eol, ctx, collect_hits);
+	return match_expr_eval(opt, x, bol, eol, ctx, col, icol, collect_hits);
 }
 
 static int match_line(struct grep_opt *opt, char *bol, char *eol,
+		      ssize_t *col, ssize_t *icol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
-	regmatch_t match;
 
 	if (opt->extended)
-		return match_expr(opt, bol, eol, ctx, collect_hits);
+		return match_expr(opt, bol, eol, ctx, col, icol,
+				  collect_hits);
 
 	/* we do not call with collect_hits without being extended */
 	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(p, bol, eol, ctx, &match, 0))
+		regmatch_t tmp;
+		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
+			*col = tmp.rm_so;
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -1763,6 +1782,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	while (left) {
 		char *eol, ch;
 		int hit;
+		ssize_t col = -1, icol = -1;
 
 		/*
 		 * look_ahead() skips quickly to the line that possibly
@@ -1786,7 +1806,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		if ((ctx == GREP_CONTEXT_HEAD) && (eol == bol))
 			ctx = GREP_CONTEXT_BODY;
 
-		hit = match_line(opt, bol, eol, ctx, collect_hits);
+		hit = match_line(opt, bol, eol, &col, &icol, ctx, collect_hits);
 		*eol = ch;
 
 		if (collect_hits)
-- 
2.17.0.582.gccdcbd54c

