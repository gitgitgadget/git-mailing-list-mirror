Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AF31F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDVUrc (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34366 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeDVUra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id p10so6920867pgn.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJvWHtLKSFvTGIpMq/DpICNlZq6OmV94JHAT/RbvCxo=;
        b=1yx7kQTmtwhcYCL3Ia9wdfx1rOG6/WwnaGNjRqlm8UdUiI9SH5j2HRLjh7r+bNoodA
         2Qq7YvjVDp9ITWCaswMUK+lHSNYZuEF4MJjQd8m0l6lHxyFYtkZzSaD43heqmOYGGQSe
         75FsQrYQMvWlgvm4V3aPTXolIRyFZj7J3F3qp3ScSkwXvkRtC8m1A5wXzz2+ynQB5HI6
         6Aq69EMMR0ZDf+ZHtIOoe97sbaaCAtuCpPnGA22jUdO3eA8bMSYeVTIQnEEqTjt9vpll
         jVMmUjj7H+tvAbpp8dTOG0okB4czctfb8FAse6vWGSl8ndOJZ/QhbEdmd9429P82aFpc
         nNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJvWHtLKSFvTGIpMq/DpICNlZq6OmV94JHAT/RbvCxo=;
        b=sBocc/ek8dECKvZfz0odJCNbyIppRQ2KHyBTMak6SDxpSO/KFx8MJpdUzZBkedfkax
         +7gOmUPoL6pkG29ieZg7kBApaZYa2skRADWwme95N9CVTYLrCzNlt1afZtKfO/wUkzL1
         pZ/mj3NLy5gYTlSp+82lBVLIdJAcXix91WZjtqkDYMtF8p7G95Y59qfjrGSzhMVbzGFS
         AYaV9ZHq7kDP1NCn4hsKDzaluQcN+s23efCOQvVEgdPm+41BpazFlk1BpwNfdp+mpU5W
         KJQS19w9rJB6AaBceqEo96YfOaSRwWAqUttLfPDuObrgkCf6EmnIVJn2Uv8/kWUPZ9vI
         d8lg==
X-Gm-Message-State: ALQs6tCJcdF9ZUhnIO8leqV5s8QhU7lOYPhq9E7T4hP0alE/qtDvzYfe
        9E8OcAp7rXm5CrHu9eOKBWsUqvM52NM=
X-Google-Smtp-Source: AIpwx49Uf9puL4Lk1/1SQeJ8uPK71GTYZaDojrMDmQmkY2ULcavFz5wUFp9rf5Mle7Z0mBbeW6fPkA==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr18178512pld.27.1524430049585;
        Sun, 22 Apr 2018 13:47:29 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id y7sm14026650pgr.26.2018.04.22.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:28 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:27 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
Message-ID: <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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

