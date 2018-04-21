Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3441F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDUDpe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38747 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDpd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id c7-v6so6248107plr.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+OrLt1sUPE3WHgDPzu7gz09bzu4VQ9JvIR5k/2pItg=;
        b=JzSxbzvY7IXqQdQscWRy8p6b5inzF/6NVBZmImasUjZqBMuhmKVPIbfFYFIh+ZbjsA
         uKc/c4G5CaceyzAqg3buqXt693e2IAMj3CyrQNISXoA2SpERbctd/Yzqg1+L40uhGq7B
         YDNpABfk7lIQVZsqqW9hgSnpytWtdvfC+cj/KQUCay8dzlVgHyjAFDZtWIg8/+rz7vKb
         U8FLk70ma3VhdZ+8s65MLACbf2QWu7TgbvpquFtD22TloGU6WP9lFkAgGDb+XUajnUbR
         FUjFcll/F9zLufB1YPVuZ5uHQJrXB7YU1j3MaQ9z1zPC5ICV4CKGOnbpfHoTq46Tu9GZ
         rYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+OrLt1sUPE3WHgDPzu7gz09bzu4VQ9JvIR5k/2pItg=;
        b=PP4WxPSlu4/afKtbnfq4gpkj1F5M9aBEePx/V2QN+qpTHvRjNKe+6DiReKxOFErr3r
         +H7k2ja0YSgYhDOTDK/jGWox70wysQ4JV7fu+w3KwUBADCFXKTitkJITi9kgNhKp8f3z
         nPniGbOAwK3J/y/d1L8OKt1x51/nB+WsmvHE9a9ySw/n50ML2df+AsktbqEkOW/c07T0
         ppEaZd3COFInVIktQwV9kCSWdzlwIObrPrMah7sqJT1NCk3Qf6DTq8U12lInsTTXY6wY
         9LazjPv59NSkLg+VyeqsS4RO/dpdp2+OyqhzNFxeHt2j0FAGYPBOnZd1XEwpq+GfVh4u
         hfpQ==
X-Gm-Message-State: ALQs6tCtYPowN6ysx0jaxaS0bmeHWViVeKF+pLH1Fc7e6qh9ok7ZrWnE
        PAhdWJyCQF7HU/yg1c05ro1pVvYMr5g=
X-Google-Smtp-Source: AIpwx4+gsMP8HzsSUG4e5Mv5E1Kwx0Hp8ssmm1s4ZU2GPOcrflBWDoJjjteLVYJaAgPw5dnDaf24ig==
X-Received: by 2002:a17:902:6e08:: with SMTP id u8-v6mr12270466plk.96.1524282332005;
        Fri, 20 Apr 2018 20:45:32 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id k24sm9066547pff.147.2018.04.20.20.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:30 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:30 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 1/6] grep.c: take regmatch_t as argument in match_line()
Message-ID: <20180421034530.GB24606@syl.local>
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

