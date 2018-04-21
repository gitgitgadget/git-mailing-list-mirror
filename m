Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA2A1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDUDph (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47043 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id t12so4769995pgp.13
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJvWHtLKSFvTGIpMq/DpICNlZq6OmV94JHAT/RbvCxo=;
        b=08UuGI+yg+HcTVYYoRV+ZS0qq5iL7zSKR2gYkPIcejL/1V5oYVhaEucq1v1b4HgXiK
         IZ6VWsTYDAVBsiGatIgXSf2RN12naD4p9I04KOajk5Pqglrin8xz7LIjGRhVn/EhoSiu
         MIZBv/LOewlAAbwE1DWxeKU7LJFsHvXBR0uPR7I7bNsmkZRzBmhmW+v9K6kqrAHN3gTY
         AvdmzkQ/zQYrifU6okacG5UNLRgSgZVJeHW9pcMkjRbubiImWZ2gN/bEZlznu8m4DuEF
         UpSV3DfFe+e7a6pgYC307SsXkEmTUighx2IaCn2IOrKzjfTPn79235QYLXWg+vrLY4SM
         67Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJvWHtLKSFvTGIpMq/DpICNlZq6OmV94JHAT/RbvCxo=;
        b=lQQbOWvf/rBTpFfoQy71oQ+gv38f5KqoDV0gNFlTvCLWoxYp8Ldc8J+SmSOeNlMH6q
         5A+S8azlt7QXInV2Lc0efDdYQ1jFBQfmgA6KJO1GZrL8tv16+LR1KCqYLCQIR0vAsE8s
         tTy2zaZzS4ejRXVzfD4L+5Dcy2dN4qngiU6XpcJjWD2Z+vk4cfJhUZUL4DUbAdPRX4GY
         O3/f4P6TJIjD8MGjtvZqpAxB7fdGris9SzbGa/gg64aou5ViD0qI4i8f4ocfkK0m85A6
         oGTpOELePR65WbcvzPbGsd0CxjfSVmzFUo+BUZ6s2kmAWrCqfu2H7UB5c8tJUeI4yNzL
         Ox2Q==
X-Gm-Message-State: ALQs6tAsHcNwrRGpC+z/iKobXPPDJmXzez/2GNOcFzD9lGpfoZmJGgwa
        /8rFgOcKygUTdMLZi6rPZyFPJieHyF0=
X-Google-Smtp-Source: AIpwx4+XCPr3AIYtXZ5eeG1e/hHt6weTOFNEl9EAgRViaZgNmepAm8opwklaTYdLNx8xA1KyHd+BvQ==
X-Received: by 10.98.63.78 with SMTP id m75mr11686004pfa.176.1524282334569;
        Fri, 20 Apr 2018 20:45:34 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id d23sm11611683pfn.22.2018.04.20.20.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:33 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:32 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 2/6] grep.c: take column number as argument to show_line()
Message-ID: <20180421034532.GC24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524281843.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show_line() currently receives the line number within the
'grep_opt->buf' in order to determine which line number to display. In
order to display information about the matching column number--if
requested--we must additionally take in that information.

To do so, we extend the signature of show_line() to take in an
additional unsigned "cno". "cno" is either:

  * A 1-indexed column number of the first match on the given line, or
  * 0, if the column number is irrelevant (when displaying a function
    name, context lines, etc).

We additionally modify all calls to show_line() in order to pass the new
required argument.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 1c25782355..29bc799ecf 100644
--- a/grep.c
+++ b/grep.c
@@ -1361,7 +1361,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, char sign)
+		      const char *name, unsigned lno, unsigned cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1501,7 +1501,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			show_line(opt, bol, eol, gs->name, lno, 0, '=');
 			break;
 		}
 	}
@@ -1566,7 +1566,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, gs->name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, 0, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -1830,7 +1830,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_pre_context(opt, gs, bol, eol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, gs, bol, lno);
-			show_line(opt, bol, eol, gs->name, lno, ':');
+			show_line(opt, bol, eol, gs->name, lno, match.rm_so+1, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
@@ -1859,7 +1859,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, gs->name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, match.rm_so+1, '-');
 		}
 
 	next_line:
-- 
2.17.0

