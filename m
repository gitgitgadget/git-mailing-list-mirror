Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721F11F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbeFVPtr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35916 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPtq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id 14-v6so6539802oie.3
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J2hafhNGGCVWlcQX0iubKMnV/I0axL89h9GzwN3Q8iA=;
        b=L+GlgdLxJyoRHlsV3OgwQtbrxszXlkotHFkA80Vyx6VyRaKwjGqyNjGyYZbndKBDa0
         sz1R/z3XdiFVbqyfqlosU3WxP8RRvBAuG64sTw4M6O0SwwcmObF1KP7blL5Bn6f3hHB4
         S+r/cRE8AjwxbnDxuoJMvh/isJ9/GrjhICg8VvV7UztsDlC8qGKAOVoBBJU+fJYGUMhq
         mu3DMGrh+fz6qA/OMHBHACAnFYA9gvoqNAGhleOCsFBJMgPtTW0y429z7sTGLEnr3nTC
         JlYTpUMiFHonsdqc9t9VbdzIwL7l2ICkD6gESV6GvCzdu5gO12ywVUNJ15z9Txko2D2B
         MRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J2hafhNGGCVWlcQX0iubKMnV/I0axL89h9GzwN3Q8iA=;
        b=tTvGCgOUYoxz2r/9+lgCxfHxq7HvnvRWomh8CPkbDsMrRhCx/vt5l9SNp4SLwo0HsG
         JMfJbUEpMoBWPRr3pypaFc8LSvwm/n9o8r0R11MgSYm9zsJdNmHnZ0MBeycbvBqdEYxv
         phkcfSssTdZTuypfUrbZcfzXvFA8kovwOvFY4at3S8ncKMwpMsduf0FVrAd3oyXEf58r
         FCYy09CGq3agIXKxCBFxPacaTBGf3C0KgYGBT78goHNeOJtDBDEa6dV7u9kmDygM67AE
         epANKeCGGkweEXAfj0pUDdeylZbDL3BS7xNwXWW67BzcuexLvZZ9BttMrTcLjWKKhuNn
         FW7w==
X-Gm-Message-State: APt69E23Odszt4nZScOSsrLfya69rQ2MP6H8y/0w9RjkamQTU18C9Eh8
        QjVqV0Es9Tfa3qM8wGh9VASq49H/lu4=
X-Google-Smtp-Source: AAOMgpcqHffXb4dPJKI3g0OEEFYoTiWHwPkL1/62eUMiN4gQjwyEYTOqotbHhMjkQUzlp9IAlaHlMw==
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr1206311oii.198.1529682584826;
        Fri, 22 Jun 2018 08:49:44 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id r23-v6sm3833499oie.5.2018.06.22.08.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:43 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 4/7] grep.c: display column number of first match
Message-ID: <4256d38228a9122f6962d40372c88dfc199507b9.1529682173.git.me@ttaylorr.com>
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

To prepare for 'git grep' learning '--column', teach grep.c's
show_line() how to show the column of the first match on non-context
lines.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index c885101017..83fe32a6a0 100644
--- a/grep.c
+++ b/grep.c
@@ -1405,7 +1405,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, char sign)
+		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1440,6 +1440,17 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
+	/*
+	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
+	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
+	 * being called with a context line.
+	 */
+	if (opt->columnnum && cno) {
+		char buf[32];
+		xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);
+		output_color(opt, buf, strlen(buf), opt->color_columnno);
+		output_sep(opt, sign);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -1545,7 +1556,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			show_line(opt, bol, eol, gs->name, lno, 0, '=');
 			break;
 		}
 	}
@@ -1610,7 +1621,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, gs->name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, 0, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -1809,6 +1820,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	while (left) {
 		char *eol, ch;
 		int hit;
+		ssize_t cno;
 		ssize_t col = -1, icol = -1;
 
 		/*
@@ -1874,7 +1886,18 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_pre_context(opt, gs, bol, eol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, gs, bol, lno);
-			show_line(opt, bol, eol, gs->name, lno, ':');
+			cno = opt->invert ? icol : col;
+			if (cno < 0) {
+				/*
+				 * A negative cno indicates that there was no
+				 * match on the line. We are thus inverted and
+				 * being asked to show all lines that _don't_
+				 * match a given expression. Therefore, set cno
+				 * to 0 to suggest the whole line matches.
+				 */
+				cno = 0;
+			}
+			show_line(opt, bol, eol, gs->name, lno, cno + 1, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
@@ -1903,7 +1926,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, gs->name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, col + 1, '-');
 		}
 
 	next_line:
-- 
2.18.0

