Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060F21F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937016AbeFRXnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:13 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43055 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:12 -0400
Received: by mail-ot0-f195.google.com with SMTP id i19-v6so20511624otk.10
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u7+dRBGtAdQeCJJolY0qDqkjtyE3ZqyiEGvoOULcQaw=;
        b=kBfV6UeeKkEqDFoAy86YHGhkFzk+fBaqG7MmwEk4puiEGvVi+oZwoLIb/SvEFq9JRe
         isyDORZUOhWE6kVAL1w1ZJ95vBTQfvSpRb0rU82o9sBnT2MI/FVyotnqeI7Lpw7XDZlc
         VKj6KAEwcQ9tJy/Njv7b+KEQpLdzvXA5DqLq8+KUAyxujPJfw8DBsX5Tz3C2mvi8NL5N
         SyWvFXXKGn8gGKFfPXYrg9ZKR8SeL6Ik5o2gJ6aTaNnsddNghO4Hv9QbAYs7HyNwNNr3
         ATOWIET1B6HuutUFm3PBo4cfDlam6H2+p36vnmIceO7R++jmMdAoV+todNY8cxORxy/s
         /jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7+dRBGtAdQeCJJolY0qDqkjtyE3ZqyiEGvoOULcQaw=;
        b=U5h6Tk68n5wt4dC+jAwBCUYCbtP6W677A7oKOmd8Ep0GaKf0rhNJkuItDBMMldUM3a
         c5wVToWiFxtIytEuGaSKkjET3y6cTYfhTIs+zHvwLjpYYOgS2HvJJlgPVSOdrKf//xFx
         LM1XWvWL9g+yEjoOwpx1caRwcYjGpC1m9T8UcDQNEIbxiHwdyl5iAAxxHmVAr1iyhqak
         oWL84oUve0UqCNxVlS2U2fl/+INWt0HYTPI2w9NgFCWlyWlOXLHSAhguR+hrCVI6jz9A
         rUbLajq6r5mCJzpczv8VIvc3nKFJUW6KiQRu1JfVSIa3/0fWA3Pl/uOXR3eq2tfmyO7g
         WLxg==
X-Gm-Message-State: APt69E0ZwxzpCWG2E6NksH+NY5KzfyMjez5BOHLOLZ3D//LLTvZbKsly
        FywdliVqPRdxcb3iavL22N7C+C6drFQ=
X-Google-Smtp-Source: ADUXVKKhuFP+07mYw0kkf3fCAnaeCM5LLR0qLIs8APUnjwmnDpt58N5vp10eFaJjR+Kt4g7voXLnDg==
X-Received: by 2002:a9d:11f4:: with SMTP id y49-v6mr9529364oty.141.1529365390868;
        Mon, 18 Jun 2018 16:43:10 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id a13-v6sm7356799otf.59.2018.06.18.16.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:09 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 2/7] grep.c: expose {,inverted} match column in match_line()
Message-ID: <d0a6b3ca2a8e67c6a5ed4d2c56c5121d4bc3554b.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
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

  - If matching a --not, the inverted column and non-inverted column swap.

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
 grep.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/grep.c b/grep.c
index 45ec7e636c..19c782aa9d 100644
--- a/grep.c
+++ b/grep.c
@@ -1249,10 +1249,10 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 }
 
 static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
-			   enum grep_context ctx, int collect_hits)
+			   enum grep_context ctx, ssize_t *col,
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
+		 * Upon visiting a GREP_NODE_NOT, imatch and match become
+		 * swapped.
+		 */
+		h = !match_expr_eval(x->u.unary, bol, eol, ctx, icol, col, 0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, 0))
+		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+				     icol, 0))
 			return 0;
-		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, 0);
+		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
+				    icol, 0);
 		break;
 	case GREP_NODE_OR:
 		if (!collect_hits)
-			return (match_expr_eval(x->u.binary.left,
-						bol, eol, ctx, 0) ||
-				match_expr_eval(x->u.binary.right,
-						bol, eol, ctx, 0));
-		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, 0);
+			return (match_expr_eval(x->u.binary.left, bol, eol, ctx,
+						col, icol, 0) ||
+				match_expr_eval(x->u.binary.right, bol, eol,
+						ctx, col, icol, 0));
+		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+				    icol, 0);
 		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, 1);
+		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
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
+	return match_expr_eval(x, bol, eol, ctx, col, icol, collect_hits);
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

