Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F87B1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbeDVUra (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35393 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753558AbeDVUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id j5so7509962pfh.2
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+OrLt1sUPE3WHgDPzu7gz09bzu4VQ9JvIR5k/2pItg=;
        b=a0twLUQoozVOGpKKfpDojtHhSKNEOEVoRMeKeuB025+90aWcGRVFXZRyuafZbrGcmS
         jELDLpq9ZTlBI4kxy50/x55FBJd+VOKlZ/GX0kMtEO8CfFvHnlIIOSbSnuIzJPIrnEio
         rkOtF1IX3PgQG00fPxDjX8T6mYtpTzkV5Wp/NZKQQ3aTpu3kYYOafi+/HIYauyN0SJ1v
         yzOG9oKv8OrgRcguh/U3/eD8rynVL11oPZJQjxJz8M0snZnKFWd307FPidiEFmTB7Sjf
         iuC+YvCz0E/lfo7M4rzV178mmjqXuBjH+5/D0s5Fy5VVrPqOGH3bfXSeR+vmrKcd9GL5
         BQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+OrLt1sUPE3WHgDPzu7gz09bzu4VQ9JvIR5k/2pItg=;
        b=pZOYJVnD0MQiNMzLYlzwiLRZJ7NPdikKKporjcEgA3dGfCmlXp48veSxGWz5gzAbmR
         84dOx+QiAPJgAQfNzMhiRjIOUAf1UjofKMyxhyciuK3xDrkZaM8jTQERuyYd/4Yz5tij
         SEU+lao+X3rGnNWk8MktsgFrWgEtf95z0PhTGItLcEgBzdP8RTMhcs0sv4ldYSLKYpbB
         LoNba2Sz4pH9CNfl9C30C+jSzyp4aMth/OabsWeu2m3DsSW73COKPXY3iW+Vcjewpx2r
         T+BSCcMu5VoM3+TQx7sKeQZmPrmiDhdyi/tQZ7KrdDcEV8+HHfRk9ED3kwidiu1EQIaI
         LdzQ==
X-Gm-Message-State: ALQs6tA25h8bkkHVKEW/Q2E+6qT7tR8IlAeZ1wEwQf3Cqc2PbRr3vune
        RRBVhPy9J9zgnLe8iq2z/bJNxNaLpz0=
X-Google-Smtp-Source: AIpwx4/CJM/om4PZOjYJ4S9HIArl4seAK9V4fj+F5pgUhSFiAVkMCSJ27kKKyFYLzsuuBGrKATVn4w==
X-Received: by 2002:a17:902:6709:: with SMTP id f9-v6mr18128386plk.159.1524430046837;
        Sun, 22 Apr 2018 13:47:26 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id d199sm20681953pfd.95.2018.04.22.13.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:25 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:24 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 1/6] grep.c: take regmatch_t as argument in match_line()
Message-ID: <73eb315b1f9daa518405c3ab1b28087c38f27ce5.1524429778.git.me@ttaylorr.com>
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

In a subsequent patch, we teach show_line() to optionally include the
column number of the first match on each matched line.

The regmatch_t involved in match_line() and match_one_pattern() both
contain this information (via regmatch_t->rm_so), but their current
implementation throws this stack variable away at the end of the call.

Instead, let's teach match_line() to take in a 'regmatch_t *' so that
callers can inspect the result of their calls. This will prove useful in
a subsequent commit when a caller will forward on information from the
regmatch_t into show_line (as described above).

The return condition remains unchanged, therefore the only change
required of callers is the addition of a single argument.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 65b90c10a3..1c25782355 100644
--- a/grep.c
+++ b/grep.c
@@ -1299,17 +1299,17 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static int match_line(struct grep_opt *opt, char *bol, char *eol,
-		      enum grep_context ctx, int collect_hits)
+		      regmatch_t *match, enum grep_context ctx,
+		      int collect_hits)
 {
 	struct grep_pat *p;
-	regmatch_t match;
 
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, collect_hits);
 
 	/* we do not call with collect_hits without being extended */
 	for (p = opt->pattern_list; p; p = p->next) {
-		if (match_one_pattern(p, bol, eol, ctx, &match, 0))
+		if (match_one_pattern(p, bol, eol, ctx, match, 0))
 			return 1;
 	}
 	return 0;
@@ -1699,6 +1699,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	int try_lookahead = 0;
 	int show_function = 0;
 	struct userdiff_driver *textconv = NULL;
+	regmatch_t match;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
@@ -1788,7 +1789,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		if ((ctx == GREP_CONTEXT_HEAD) && (eol == bol))
 			ctx = GREP_CONTEXT_BODY;
 
-		hit = match_line(opt, bol, eol, ctx, collect_hits);
+		hit = match_line(opt, bol, eol, &match, ctx, collect_hits);
 		*eol = ch;
 
 		if (collect_hits)
-- 
2.17.0

