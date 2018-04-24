Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B391F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755720AbeDXFHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43052 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755603AbeDXFHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id j11so11234662pff.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=ZWpTsMd5Kb3L6/ymgEqa2ikkQlSF2T7Xr120GrsC8iOF7l9qDIiVEgbfpkYlJCPm3p
         Pbu8Cw48PnEFahgTD6itD1RQpv/rdYQKKhLlKGdjpyfi/WmVH5kkYeVmuL4z1N0krU5y
         AiCPOPrvbIq3wLiApx6LsvaFutTWIA4+VlGOMNVwefqLzHBiRNhbx79Hay6wHGYvsaHE
         /c9XsZrO1691EZo+aXQ0TPeqIpo7ukqE4SLfnGWoduyRb+nwbvvQr2s7chnJ3RnWjTri
         DAYKOdVuJu/s/TMjbpEsZ/DNvCWHSSvvwQ6ovdx/Qe0wUAY7lGMI7w1vFDBX8hm9QK/l
         N3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=OezbqhFsCLK4/hvHRmUpKdC0CHTwBAcWYBBJANJSstgAnEpZ2MtdqAA8QtLi7bG0qO
         NvfT8vvqZfW97J85rUaIQ8asNFlGoJIl/U2AL15XvH1LHvUheTlBf/5a/g6s99M4FFcj
         QtA40vz7rgVHZqQbJCH7fCEGIS7G//QsVmO4Vfo6q/SEdG49Gyq2cc34Zs0gT+hoOQzk
         D1707d8mbrNv0Njv1dh6Kh9BSwatLhj4nyQC5w2DW8f4+C8vvotHEIl+F8aSqVh5D9bF
         pz5u7TDPcHHTV7dlA/J8XB7iSOLsVx49JnZDQDTPeJArGJPhGQykG/1E55Vpj/uYBkUy
         Mxyg==
X-Gm-Message-State: ALQs6tAJf1FS9mOrveQJgTn2FBttVJap9cgcr1+P2I+uN8XcGKd7Q+Lk
        zjA2y/PyFNhqKN3fUwkV18OTH6i6zxTkOg==
X-Google-Smtp-Source: AIpwx4+jpe+l6kYFb0HOsmn+UlZa4a52RZkriSdfe9RP39erxnmBHI2BrXVx4fc0/9swP8lzzdTM7w==
X-Received: by 10.99.125.86 with SMTP id m22mr19715277pgn.257.1524546460981;
        Mon, 23 Apr 2018 22:07:40 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id z78sm33860933pfd.23.2018.04.23.22.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:39 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:39 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 2/7] grep.c: expose matched column in match_line()
Message-ID: <c9fcd2a1eef70aaeb4e030b23558f2829f66ddc4.1524545768.git.me@ttaylorr.com>
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

