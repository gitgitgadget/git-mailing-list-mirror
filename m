Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03DB1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcFYFYU (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35367 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFYFYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id w130so23688152lfd.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SB+4pxja0dRZCIvGXupOxtfwUfQgloc4kABJJyVsFI=;
        b=qP0kSrkDTpokS/slpAIzz+QXj2BzfartvYb+/jFvulA+RtJzmn7J5cVZRzGp4gefw8
         h9+m9Wp3QykyG2o4zERjC7ql/GFPmfd8WZSgqQ2f47IPO/SgvreKe3fqXe8znmgYqgF2
         x9xq6ZlJ1PjZWL9Ws5jZWxlsZFifX+dsCwyL5w91j+2HNFU/4QnFCUSQ1v0/s6P0EVwf
         fUQgTrnB+MGBSzs3d4A/9eNiqGDA71wNbFeB3IZ2Ms/dH7iGCY2WtRJ5abi3EjJPK3PX
         8sv/ogrnDxQYTK3DLDdVHBBScquAFF2q47kWiT4igcnw57nDGbsARkIddX3ArLCX9qAX
         3u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SB+4pxja0dRZCIvGXupOxtfwUfQgloc4kABJJyVsFI=;
        b=PW7C66u3iTH5RTI250Q73WF5TBWbVLxLczf1zPs/4/IlU4y1qDjDr9RdaHWlukt6LM
         XXmrVrdKnX7F1Aa+sc7F8McnQFGV6qsrOS4KEcZBImRnA5rN6HuUr/evPm68WS/JiLJ8
         mUUQAQyOfoOGG+woAmYlEz8pvotmrF3cN8ClkC2LNaWsWv15Q6gNdPrUNVDU5XcB7nOB
         /1B8Ru3+adFgr4ky6Up0sSPA+0sHf2pXZxH7fPd1jXOGkcBtobK5+Yvp9iWAJ5bQ9Gf/
         EuCvIuqndFSgzTP41KBQuSin8sckG7M1A/GoUvETauLNQ9WvR4FhW/NHnB84vqYAReOl
         Tv7w==
X-Gm-Message-State: ALyK8tIBzni+L85A1iGHYVM0wv2LEDznjOHp2gfWXdkwOvkCy24aNu/KPjU95RCXqKUtJA==
X-Received: by 10.25.8.7 with SMTP id 7mr2437275lfi.205.1466832250323;
        Fri, 24 Jun 2016 22:24:10 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:09 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/12] grep: rewrite an if/else condition to avoid duplicate expression
Date:	Sat, 25 Jun 2016 07:22:32 +0200
Message-Id: <20160625052238.13615-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"!icase || ascii_only" is repeated twice in this if/else chain as this
series evolves. Rewrite it (and basically revert the first if
condition back to before the "grep: break down an "if" stmt..." commit).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 5a8c52a..4b6b7bc 100644
--- a/grep.c
+++ b/grep.c
@@ -426,11 +426,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
-	if (opt->fixed)
+	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
-	else if ((!icase || ascii_only) &&
-		 is_fixed(p->pattern, p->patternlen))
-		p->fixed = 1;
 	else
 		p->fixed = 0;
 
-- 
2.8.2.526.g02eed6d

