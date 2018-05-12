Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1C91F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeELDLO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:14 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36371 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id z70-v6so3180563pgz.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=CqKsCbWbS33E/gt+bTRMIy4gYh0Mzts2hvsxcihqOCOQHOMDatc2imqjQtbwNiy1X1
         MfmAR4l60qSqvvT4YZzTBBCTavFF7QzNqOgxMhHuoPZlBV2GGbAywoQL2TaUdCzdlNYd
         FZD0rjm6fNfJvZVMF8W89PEsUCNAg388qxkLGwqC/fT7SjlA06WeZXB+/SDoZhI5x7Dh
         pJapOZh7b7fcgEqaeSRyX19z7NzzvPYZ7FBejDvWdFgSP1vdqhk7BPFBc48hmh8GD8Vu
         WWsQ4WwKBmmvNsUuhG2Wik9O/6yORlBlLPN4CgRMTmWsXZLyrpGCyyRWSuYJNX57O9p8
         HQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=dqBb9lkIjzQNGooi//JPwkmEdliCjbG2BtRB5tNmrQdONQ1W4QqVf7rmFYM9mVxl8b
         spOs2WXddhLShTPxARuHQxQAtnis3Tyz70suqMw0Dn/A4C3Z6uvNSs42cOESSMO8S5Oa
         iI1jMEtubXF2QgpxJTMWPgSZCnaT/0VbrMQTW93HR7+JLmXJqaPHQCQbTzw8lpSfG+xV
         BTu4FCIoIXdtc85731xkJhG1N6X19lxMeCa0koGkAdbsWRoXzCd4i3PozbMJsRyRntCo
         SnAH9cPjhEGBFBdXWTcyFxSD0UBUAV/5WqaZLJshQRDN8Dm1IHAOd/XVxPrW3TVbeHx7
         zS/g==
X-Gm-Message-State: ALKqPwe6h9VOZ8By0DKmD8sM775NHmc/sLm87zhgwvUEMy045kFIWQgJ
        L31LFvaYcfqLiF3mCFltDEoiFAmOMmY=
X-Google-Smtp-Source: AB8JxZpL2e4KlD9j9IDvbRBJnIeNlHXA7hTaUoDr0B6kOQ2kfAna04dzrYzwlJ/ogUsu/fDoRylZ8g==
X-Received: by 2002:a62:c413:: with SMTP id y19-v6mr1388636pff.97.1526094672132;
        Fri, 11 May 2018 20:11:12 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id c87-v6sm11620940pfd.78.2018.05.11.20.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:11 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:09 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 4/7] grep.c: display column number of first match
Message-ID: <defb078e349848793d120103676635d44e361f1e.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
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

