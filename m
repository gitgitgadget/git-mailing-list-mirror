Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C071F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFTUFs (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:48 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46332 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbeFTUFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:45 -0400
Received: by mail-ot0-f196.google.com with SMTP id v24-v6so899545otk.13
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFsj7z7vg26fFQ3vkd13ZtuMH97ZPF5pLfjkj4RwgD8=;
        b=DkljHbmwKB1WE3XN84jHoL6qYbgMWF5MOj2EL2Hnbe2LC0dOleq42dm04bmImVrHFe
         vwlnnQhjmRqIX7BKSHpG4Y3A3diukAvebXAIqTMFkUUF5Net5LBQswlHbF1iAUXU/hEX
         f7akc3KFonh3cAb9epjxglmvBhSw+DQ6wFJZSHnbMYnD1gAEHzbeooFMrCLyTE7MSI7a
         iOYWi6oBXiaU9cf93gTzljcqMyuO3GLOXKfOf4vu9PylfPB+/Pnf3nVsUx15GRKa6to0
         ST6jbTUflGEOcMMNplmniX2g5qtkYjOwdWZRbmr3p/F5ucFDig1scw3yotjamRJpe5oG
         Qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFsj7z7vg26fFQ3vkd13ZtuMH97ZPF5pLfjkj4RwgD8=;
        b=RmA0Y2y1a7Cw7RhOqiHtgTunVhLLCdEj8ykzkdWgs9mXiPrTjQDSvtAZJsPKCXs++v
         SUmcxxI6KkVidDGebpavUJOQqwWNRjWC8tfIUUdTy1Puebyr6osrqlLKbaG49mbX3U6v
         bMIFxKwz7I1T6WmUnqy96npb+PymhggYuJba+ajlTGDVQgusrdZT/laNcWDopEsYxl/S
         dVHaRSR/Y5vgzEdy2XcNPS3nnyccADZrcQf9GmG5rKIbg/uBbtaaklngXJY1ndqNpL64
         M9+ZKeKulfcgoj0hIefX4W1ZTRRWBYbawOFdzA/TMfPrufeMoEhG/Id++PhOSqkz9yg4
         zTOA==
X-Gm-Message-State: APt69E2MWvbNOKQJb9vBhStBVsCnXtoJuxYZyWfagLW4G4P5CBqoUjzL
        Foet11EkHNVaLe8IUmmnWZ4Uiyw8DpE=
X-Google-Smtp-Source: ADUXVKLVtg9KSDoxIxaWC+70YyGDGzq9sniu6qJLKxEZQ7fKjhUP3B6Ie3R5fm2sJAXvl0GjYRsCkg==
X-Received: by 2002:a9d:2525:: with SMTP id k34-v6mr14829799otb.180.1529525144123;
        Wed, 20 Jun 2018 13:05:44 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id t204-v6sm1759009oig.24.2018.06.20.13.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:43 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 4/7] grep.c: display column number of first match
Message-ID: <91014cf1993a9b43983c9e7d2e19fbe442f0d89d.1529524852.git.me@ttaylorr.com>
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

To prepare for 'git grep' learning '--column', teach grep.c's
show_line() how to show the column of the first match on non-context
lines.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index d56d4a3a37..d353d5d976 100644
--- a/grep.c
+++ b/grep.c
@@ -1399,7 +1399,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, char sign)
+		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1434,6 +1434,17 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
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
+		xsnprintf(buf, sizeof(buf), "%zu", cno);
+		output_color(opt, buf, strlen(buf), opt->color_columnno);
+		output_sep(opt, sign);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -1539,7 +1550,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			show_line(opt, bol, eol, gs->name, lno, 0, '=');
 			break;
 		}
 	}
@@ -1604,7 +1615,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, gs->name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, 0, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -1803,6 +1814,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	while (left) {
 		char *eol, ch;
 		int hit;
+		ssize_t cno;
 		ssize_t col = -1, icol = -1;
 
 		/*
@@ -1868,7 +1880,18 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
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
@@ -1897,7 +1920,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, gs->name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, col + 1, '-');
 		}
 
 	next_line:
-- 
2.17.0.582.gccdcbd54c

