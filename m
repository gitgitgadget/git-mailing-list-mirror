Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE3C200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEECnE (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46921 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEECnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:43:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id z4-v6so16588919pgu.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=Pdb4J5lMwimegh6gTi4SfljxgucbWhvHTimn58kweRiCp0yff8E2EnHO9Ib7wAujh5
         AwZ1YGSY9NBAsUNjPQ1Rw2yyjKylqueSjwrzer+9nIsbpjXzHtEadwqdn4D7ImBROBKC
         8uZ8YOT2PM21+yIg7antcVjVS100ahB7j0cqC1WZmCArIClu1OdP/UpkDnH0PzfQMs1Z
         lBAbmCkbKLP1dxwjYgmbX0sPLezHCLIVZwkttm22eeJnQcw0sN036KenssyLAew2klbn
         DVROCsgwiBkSPHhk1EYg/xuaDslGCI8EY1Gxgzqu3C3TtFLjknnlhjk85w/ezdBw0rZ7
         T5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=Eu4byJ7Jtv0kwIhTCQMkBzmhlBv3FK7AQv0VZCVPIpWGnxcdfuOFS9y9iLvltczyb8
         3A5R4jrV4UiDQucldPp9PofXmG+lUDWrNPagSj0Vif9k/EdlvYqQhN3qV+C+rQVlx+7B
         5FNYHBPmAm2j90vWIDmJYi21RouHPVdXXuBn4zZ1uymwB8MMaTPOlqssdH+sfmGuM0z7
         QkT93nOlD9w7/w4gRXsAvcmK1rutUXd+NIyn7m29DCGSZEZ/GCSSTrTZZqM6eDloOXjq
         dTIiMiLivUzHZySP1/JRoY1PCWa9c/TaB9FC37m79lwi9D+R5QIR97Ru2EgYh4egsrLv
         T07w==
X-Gm-Message-State: ALQs6tA3xT4jM0aBGwpe8ifVX+NNPnpiw4wHk5bSsYh9bEzCWhxeUCb3
        697Bluh0AZdNRbYCZ5Hi30LMkVR1c4BEfA==
X-Google-Smtp-Source: AB8JxZo13Ol92o1LCD7aVMsllxeFn5FoeADUDcqWTZjcc9ImfhZe4DT6JPqBHXnz+9KlpZkwNyRaPg==
X-Received: by 2002:a17:902:9883:: with SMTP id s3-v6mr25582617plp.179.1525488181967;
        Fri, 04 May 2018 19:43:01 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id r8-v6sm17586343pgn.2.2018.05.04.19.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:43:00 -0700 (PDT)
Date:   Fri, 4 May 2018 19:43:00 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 4/7] grep.c: display column number of first match
Message-ID: <defb078e349848793d120103676635d44e361f1e.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for 'git grep' learning '--column', teach grep.c's
show_line() how to show the column of the first match on non-context
line.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index fb0fa23231..f3fe416791 100644
--- a/grep.c
+++ b/grep.c
@@ -1364,7 +1364,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, char sign)
+		      const char *name, unsigned lno, unsigned cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1399,6 +1399,17 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
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
+		xsnprintf(buf, sizeof(buf), "%d", cno);
+		output_color(opt, buf, strlen(buf), opt->color_columnno);
+		output_sep(opt, sign);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -1504,7 +1515,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			show_line(opt, bol, eol, gs->name, lno, 0, '=');
 			break;
 		}
 	}
@@ -1569,7 +1580,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, gs->name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, 0, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -1833,7 +1844,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_pre_context(opt, gs, bol, eol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, gs, bol, lno);
-			show_line(opt, bol, eol, gs->name, lno, ':');
+			show_line(opt, bol, eol, gs->name, lno, match.rm_so+1, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
@@ -1862,7 +1873,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, gs->name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, match.rm_so+1, '-');
 		}
 
 	next_line:
-- 
2.17.0

