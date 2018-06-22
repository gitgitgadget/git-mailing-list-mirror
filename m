Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5839D1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeFVPto (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:44 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33416 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:42 -0400
Received: by mail-ot0-f179.google.com with SMTP id h6-v6so8011594otj.0
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fhfbchgy/rP49l+30wAT+72SRib17F3dc1QZwHQfRkA=;
        b=jwYJSkah2QDzqxJN7XmKTWjFXO4anqS0zVZRQzQ+5CnPskRadwj8aeZ+RJUzaQSmFu
         kg/fGOIO5YKCU8Z0W+qLnDT34UWy8U3MXIX7oD8aCqAxVzIwGZYccwqF3oUvthVluTNG
         tgEnZPA9HlFhyvIKNcRl858A7ssxzMXVWeVwgIh1pPWEhfBUytNSudd0wrWbm88KXYYc
         vgK/u2MFe/ZIbTU5C/nKE77TejM7/HzkSTOZ8i65szGPxZ2W1iM1K+z4N58/UoI5ze+I
         /ZAw/KiVKkOCMyT39jcfC4wiFdc/L9G4rxb+OLoznmshyg91vBXqJ8fHiPs13Wt7yqq0
         /Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fhfbchgy/rP49l+30wAT+72SRib17F3dc1QZwHQfRkA=;
        b=S662OHLrsHX1OzOl/pt1tupE+wpQbMGvvW88QzzPCwXil7NXhyvillrKEuifoDYtol
         r2anyEreUO6LERAJtnHpkIzmvHpbxB/WUZBZcQLH9+8bMB2yRTBnBj6j1Iha9KS4BmQb
         3EHOwHpj6A0ASnVayoAtU6PT708mmRbRA7QnkjcQJGPezToiKv2Eaa9dO5nuWi4/3c/o
         9ymBH/VQMNRkPNVCDQ54eE9Z66rq9UbTtqTl1hYehGE7z3OHG8psAIGqNhOTztTEDta3
         WjsGAJ/BZTU/NiEBkLm9JGN7YToMzVUgQ5tgGVnr7Vj/Qz8tUx3e9NRibeDT830AnMex
         B9vA==
X-Gm-Message-State: APt69E0tmgtgm+ibvQhUsPIOxbQZSHCeWS4hoC3kEQ6PGM7zFRgbtNbX
        LYCS1yxp8ybzsbZxhJArqWbzFSpTXoQ=
X-Google-Smtp-Source: ADUXVKJ0tt8veX2gU9kOsQxGossnb2id08PMp4pTCjr7N6BWR83sxehfXt+3jO9Q+5VZogCRfSAGxA==
X-Received: by 2002:a9d:3163:: with SMTP id v32-v6mr1335137otd.363.1529682581482;
        Fri, 22 Jun 2018 08:49:41 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id x194-v6sm3655186oix.38.2018.06.22.08.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:40 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <a3971a1a44bfbac599e74a9b177b21ccd2bb9a95.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support showing the matched column when calling 'git-grep(1)', teach
'grep_opt' the normal set of options to configure the default behavior
and colorization of this feature.

Now that we have opt->columnnum, use it to disable short-circuiting over
ORs and ANDs so that col and icol are always filled with the earliest
matches on each line. In addition, don't return the first match from
match_line(), for the same reason.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 47 +++++++++++++++++++++++++++++++++++++----------
 grep.h |  2 ++
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/grep.c b/grep.c
index dedfe17f93..c885101017 100644
--- a/grep.c
+++ b/grep.c
@@ -46,6 +46,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
 	color_set(opt->color_lineno, "");
+	color_set(opt->color_columnno, "");
 	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_selected, "");
@@ -155,6 +156,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->extended_regexp_option = def->extended_regexp_option;
 	opt->pattern_type_option = def->pattern_type_option;
 	opt->linenum = def->linenum;
+	opt->columnnum = def->columnnum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
 	opt->relative = def->relative;
@@ -164,6 +166,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	color_set(opt->color_filename, def->color_filename);
 	color_set(opt->color_function, def->color_function);
 	color_set(opt->color_lineno, def->color_lineno);
+	color_set(opt->color_columnno, def->color_columnno);
 	color_set(opt->color_match_context, def->color_match_context);
 	color_set(opt->color_match_selected, def->color_match_selected);
 	color_set(opt->color_selected, def->color_selected);
@@ -1277,23 +1280,36 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
 				     0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
-				     icol, 0))
-			return 0;
-		h = match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
+		if (h || opt->columnnum) {
+			/*
+			 * Don't short-circuit AND when given --column, since a
+			 * NOT earlier in the tree may turn this into an OR. In
+			 * this case, see the below comment.
+			 */
+			h &= match_expr_eval(opt, x->u.binary.right, bol, eol,
+					     ctx, col, icol, 0);
+		}
 		break;
 	case GREP_NODE_OR:
-		if (!collect_hits)
+		if (!(collect_hits || opt->columnnum)) {
+			/*
+			 * Don't short-circuit OR when given --column (or
+			 * collecting hits) to ensure we don't skip a later
+			 * child that would produce an earlier match.
+			 */
 			return (match_expr_eval(opt, x->u.binary.left, bol, eol,
 						ctx, col, icol, 0) ||
 				match_expr_eval(opt, x->u.binary.right, bol,
 						eol, ctx, col, icol, 0));
+		}
 		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
-		x->u.binary.left->hit |= h;
+		if (collect_hits)
+			x->u.binary.left->hit |= h;
 		h |= match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
-				     icol, 1);
+				     icol, collect_hits);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -1316,6 +1332,7 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
+	int hit = 0;
 
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, col, icol,
@@ -1325,11 +1342,21 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	for (p = opt->pattern_list; p; p = p->next) {
 		regmatch_t tmp;
 		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
-			*col = tmp.rm_so;
-			return 1;
+			hit |= 1;
+			if (!opt->columnnum) {
+				/*
+				 * Without --column, any single match on a line
+				 * is enough to know that it needs to be
+				 * printed. With --column, scan _all_ patterns
+				 * to find the earliest.
+				 */
+				break;
+			}
+			if (*col < 0 || tmp.rm_so < *col)
+				*col = tmp.rm_so;
 		}
 	}
-	return 0;
+	return hit;
 }
 
 static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
diff --git a/grep.h b/grep.h
index 399381c908..08a0b391c5 100644
--- a/grep.h
+++ b/grep.h
@@ -127,6 +127,7 @@ struct grep_opt {
 	int prefix_length;
 	regex_t regexp;
 	int linenum;
+	int columnnum;
 	int invert;
 	int ignore_case;
 	int status_only;
@@ -159,6 +160,7 @@ struct grep_opt {
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
+	char color_columnno[COLOR_MAXLEN];
 	char color_match_context[COLOR_MAXLEN];
 	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
-- 
2.18.0

