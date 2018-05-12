Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7B21F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeELDLI (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43362 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id a39-v6so4263569pla.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=mMXmrJqsDqPD0nI1f93sHAtMIHLr6sTP7pi5JnHoB92V6ruYaRtyTKmIrqx0TsB7+y
         fDNa9Lbq8jcqu2gArmR2jjcAZxhr3B0aZjzTpiDgRcHDWN/vtdTjitKyUHZA7j+WeEUa
         0mxZX+4QCT6MDM1ScTd9MqlMPzylZFdHj16E8pmziCV24+9EEn5eq5V3RfFjuES3y3XF
         aWBWWk4Q+lilLvWWlANC94jeLqngEXA24T7tKpLOEyyT1xPmUz+h3KuwzGqvWLXwtyp2
         MHwo/uV6UxGT4WTDaJr4qZ+/JlCX1t7CZyLNU4WGS7IKcn30MiM+KIpzLVC4K7Sm4619
         Yl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=Hk2Ke7ZdEOFNjUtSDYwAs7ZbokoUkQRnFshg/sYEnqpwFXVFRps5mCC/QGtfF1EHFQ
         LpSyMVAarAz2s1cpNbLWnwXvwgKGXyNL/hCP23sM4O5nNxXrjbBloNAoVGokFEiZrN6Q
         HY8pcYe9zfULqXfpw0tDSoZggJ9lF8NMF/A3E1LWuUfMNjqg8ajYzjmVYrRIgphs4p3i
         wAd+ka74pNQa2AzpfmGCKpX8ET5yMnqmfczI5PH74N+HF/3axMejAVfa8zlFZZrHJajJ
         IccHwz5In8meIRyYH3cqrf855rex0zIo1QFOiq/fMNQONMwvT4Jw6O8yIuLeXQ2pVDo5
         Dh2w==
X-Gm-Message-State: ALKqPwcZqLHGBIZxq9Jz63jUyFjNeZjPx5do6EumuwGnyxJ8c0Lsb0LN
        RBT1L18DQFQwrgqt6lsnPGIRQApOICw=
X-Google-Smtp-Source: AB8JxZrUpOBP0lepSb+okG4RR3kmVMIZLajbxYmTalF4gQ37/xUHVOyNybPUpJpqH4VNHcnp80yD9Q==
X-Received: by 2002:a17:902:2804:: with SMTP id e4-v6mr705220plb.153.1526094665949;
        Fri, 11 May 2018 20:11:05 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id w184-v6sm6823745pgb.20.2018.05.11.20.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:04 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:03 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 2/7] grep.c: expose matched column in match_line()
Message-ID: <5281d6bdc1f6614b9330315cd9931ec9b2232445.1526094383.git.me@ttaylorr.com>
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

When calling match_line(), callers presently cannot determine the
relative offset of the match because match_line() discards the
'regmatch_t' that contains this information.

Instead, teach match_line() to take in a 'regmatch_t *' so that callers
can inspect the match's starting and ending offset from the beginning of
the line. This additional argument has no effect when opt->extended is
non-zero.

We will later pass the starting offset from 'regmatch_t *' to
show_line() in order to display the column number of the first match.

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

