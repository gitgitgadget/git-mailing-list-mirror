Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCE81F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933567AbeEICNn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42711 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeEICNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so19061477pgc.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=QRjk69/bU9kdKOJNS5KN+/S6mqrb7cLT3vVZgEs6wYjEf4TklIy/0TKHZ0uJyoboHN
         pbsQs7scSSMz4KiOJoE2HUwu6+VMufQXr0QsWBS/KmJJKtEVMAMJKdDG0JVc8sO4x4f0
         XNE5OZo75UE3TF5iEuq2gwIDjAl4MXkohZ1NVU4gDrQmqVYuBhDkxkBgDJ0PFZ+qljnw
         /QBDOicRA8dSt3fhzSJclcF8FAX3aHLSSG3o/WAuHOmttIAgC7xAw5BbV9yepM7ehgJ+
         ar+DEjriev65x3KG59gBNxnq5LSuWFcQorM3c0BX3uP2b291QCrAT7Q6EdNp5lCG57D7
         wUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=axvham5JSKp5xUTpNk2pTJeh8dGXuBf4esj5mHL9XUs=;
        b=ELf0VN62qhhEmAmEvV1ZICq/TOVBnqKiXomvmsxWVXxWDnOIjP5GvaZugV/l+fhSSa
         jRWLFMtO/5z7GhO/mizunrEH2yENBzbkElep4M3tpvtPut0pGTkgtu6uYvyOX4R1ZRIW
         /mWU7JdFxwxeIB3LkTHGsyRKLGPj4DV4jko/wQOY3M62oqMu4lnhwL9Dw00+uNdhz9ho
         F0ZHXZUfcxU8A6iHw7vhkFi6hd0o8ge63e3S07tUNIypHz7W+ChzGulr4DwlAsMdFKQs
         mVdMSeKlGF87TMebb5awX1wdi8+F4vXzBG4gU5j+NHb8Ow0xf4QWbzKn+6DbHxKovtdW
         Yziw==
X-Gm-Message-State: ALKqPwc5N3DMCVLBrffDiPE1HDvvFJwKDxf9TA3eGCY7iU1bqj/NCMe6
        FyFPltXLMm7hD4792H0vXwcZ3XRfxjCfUg==
X-Google-Smtp-Source: AB8JxZqLE3pDbSMf9OjkgUb2CruJCJqaDXBdN6uaGUFxYcCZIx1EaAz6AqJFkspmKI5FoaU34SsNTQ==
X-Received: by 2002:a63:a909:: with SMTP id u9-v6mr1474912pge.8.1525832018216;
        Tue, 08 May 2018 19:13:38 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id 65sm54206324pft.74.2018.05.08.19.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:37 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 4/7] grep.c: display column number of first match
Message-ID: <defb078e349848793d120103676635d44e361f1e.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525831201.git.me@ttaylorr.com>
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

