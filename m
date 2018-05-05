Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665D2200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEECnA (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40086 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeEECm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:42:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id f189so18773797pfa.7
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=BeMV+IZlqHqYTxF3wngFHK4HxzL5+pxMZKXuPoRranAafAUM2l0On/SRlVSWU9sWff
         vQnYbdj3I16+0ekgE3/VKxwbMBmLGTvTLUlto9RTpSVtlT2O4TyCCLaL79H46dTJ5zyt
         4Vhui6q2G7mtV2VNdRJ+3eXSqF4x1NE4JeOuF6a2zOjz7rUpzb59A31WX8nkycMYzs4F
         g+VWHnwYoVSPLn24azTLYa+le7ETEvyWkrZh9C5l8EbvxncuBf+hlm5U3xoh7LRa8t/S
         6wMmlzfaZkYzylhYGDujPDXfn7bxSid/3Nq79855+k+34EyLkOpACBETTbuSLBuALVFn
         NkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ID+bGwKFWjEulgY/rLodtVv378O83+RJMv5qhq/h6wQ=;
        b=P9OqlZuWyDnAuyXK9aqUinQrzjHUZJ+U8mokytM8Rrq5N5XkkGh0XXzkMLdqiWpIqq
         sHjd33TLEg6nqhinbd+yxRj/WCfzjDQQm9tuC0lmLNYFBxHD5Vsw/32y3D5NAF6KAYKz
         cktdHHMqsryWaXG3LmVlL2R5+5NIDyDKFsohBSliJjElnhAPl/YwAglQ0RM0vH0D/cMj
         +bp7Yh/Fh9JIEnIo2Mx+1iGWJwdPk+tuHnsA7QKEoWD7NXJRtXHK71NnYzVyJhvBm7f3
         M8M6/dBGnVBManQSBIgKbWClfs49VOPpihD5J+JKTAlQyeiUmdtiWkoZgU0itG0cjfiF
         kOfg==
X-Gm-Message-State: ALQs6tD14R974IVMylPbneylXQRhEH6oB0qVq5kpM2Wlio+LFTp/a02R
        BlK0ij+qQoqhoFivV5N8VZhjqXv1q4AU5g==
X-Google-Smtp-Source: AB8JxZpP8kNPpkbtv9mM2ZhmRHTtBYmXaaw7wmI3Y2tmFeD8iDZZsksDsMrmxskvq7ErSDD0watz6A==
X-Received: by 2002:a63:6f0f:: with SMTP id k15-v6mr23794706pgc.91.1525488177256;
        Fri, 04 May 2018 19:42:57 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id 27sm36605766pfo.137.2018.05.04.19.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:42:56 -0700 (PDT)
Date:   Fri, 4 May 2018 19:42:55 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 2/7] grep.c: expose matched column in match_line()
Message-ID: <5281d6bdc1f6614b9330315cd9931ec9b2232445.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
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

