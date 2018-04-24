Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B628E1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755774AbeDXFHv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42171 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755706AbeDXFHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id o16so11231555pfk.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uo2ED+bPZfqGpRUQMaNDrRyoo9c2p7c4b+36YgkXDbE=;
        b=njfFkdc/Wgi0G/shuvras9tBcZRuyrcxKAM08iQKcVZpH4EitvPzYFhV8JNYVDcMaU
         ITW0J10cp6jpK6oGU1GBgn/nsKMR8qsLMBpBscNLQrD9H/07t9GqU7HIV568sGgHCLy0
         De9Z94+zImNqnz7Gz2mArFfFz4PD4JenSZ/Bue13GWlhpwq2RxlTfQKbxRWwnuCzoddh
         R56OQo5gBkCQrfT5i1+Z1I3raTey5VntmktUdjAHdQIDPPDQTtAeXPWuC1R8hVrvC2D+
         Wk2sd1mTc7ilEpAIfc60cASQXHJyews7AjTqnUvY53flJ0uaEDEXI/a+5ZJS2xBat4i+
         PXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uo2ED+bPZfqGpRUQMaNDrRyoo9c2p7c4b+36YgkXDbE=;
        b=k5izLhI1PnBRfUC95meaBo5M/WjeclXd4kQi1NnDlEpVmFMwVokwUjZ+ZAdQ09YbTA
         kjgQOLVP0euFNw/J0mrh/E6h6FqfhGyTiZaeJbnm+kllmKzcUwrcGfLtxLRW23trpTXe
         K0lB99E7yLcXBftCwM9jMhiQI607xVjwUt1Xe5t5FVgLpUORUrNzShFRAqUMLz0PUOYQ
         h3w1i9MGvu7KIIHtoOrnSYW+1GrkKaV89ixftxyNwnbxeqCPtbGT2JxFEo1/JbSBtEIC
         1aOEDvuzn/B2e+U+4zWwUVrWzZqaBGPlPsXIGx+HZ0uytJZRLv69oxbaKDCk7vtn0dwU
         xlYQ==
X-Gm-Message-State: ALQs6tAhuqayFr7JkIiuO4FLMvJkVT89+ojyujgBxjXp0GCcDqxxCIHu
        TPpMkdUKWHDN+oB3dP+q3KOE1badMq/oNQ==
X-Google-Smtp-Source: AIpwx49cO2Te82Dq6LuUqTCHwijEJ8q3KBf3UspO4vc/vd04kZPYrT/fXltaaJnFDo+Pr74TNPJ+LA==
X-Received: by 10.98.5.196 with SMTP id 187mr22355078pff.151.1524546465946;
        Mon, 23 Apr 2018 22:07:45 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id c201sm25171982pfb.30.2018.04.23.22.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:44 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:44 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 4/7] grep.c: display column number of first match
Message-ID: <f6f74e43eec63e9e7a9037a2a40075feb5fa0ac4.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for 'git grep' learning '--column-number', teach grep.c's
show_line() how to show the column of the first match on non-context
line.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index fb0fa23231..d58d940afb 100644
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
+	/**
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

