Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825F520248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDNVJq (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:09:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33406 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:09:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so4727130wmi.0
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBAX/LtcznBiuvlrWM8YLKJgV2DNxPC1sKcO7uQ0nRo=;
        b=amTi0ZrhTrHt/pVLC1iXciZRcFOEnYa53hYrNF7qTSHDKJnbwQ5IttymSQSEHNS1aF
         cmGhvT2IjUaYtrPK49cLzJL1IJgYL/bogMIBLMS1HdYj/YTihzXsJsERIakWdmtVynzM
         Eu6BdaE9Qxl9IfF2ANTsh8ESUodxTdTAQDUeLP1gmfi3PocUWZJwmCyIPXDLpbro7YFe
         U5qStoziyeQz3wWaWSz3/zOMpFcXfX3Jseah2dJJvOs6Xq269fi2raxrQSz74Ybg8IHj
         XloT7VLTwxZsDSoq6xwbAxjprxKMN8FQeq51doCkGlKFrkhhlfI2rSfI3OsH/oosqpZ7
         RrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBAX/LtcznBiuvlrWM8YLKJgV2DNxPC1sKcO7uQ0nRo=;
        b=EaI1sSvqqTBbF51PDMwDqUkuLfZlr5pol0XMQ2o2QmFt5fS5aq5hlSSrH5vKzvhG7t
         z4hsOiwmFxER81ZVzy02NLZUBJihdliuZdv26JhpmlDGN4Z0usESmflvY1ASvjdoVZo3
         x9w9tOBpG5y20VUgBQFJ/jFPsDHyYwmkH4GyZBf8/EV6zHxdvFywNdaLpdiPH1wsmzkK
         +p3f9IAy7Em44CEU5FBZ5JSsZEzmKYugxArhTe3wa9GVp+eDwb7lPbt6DgpbbmV95ZgJ
         sMNt0icWF2P5SmFtHk6XqKzKEdWYaFTMoRlN0byFRGzwHF+rfwoiYoZqCPx8s5KjHq+t
         tD6Q==
X-Gm-Message-State: APjAAAU+/hH2nJELQ/ARIUoW5Hv47NebgsrCxjoewTYECV+SvydJLwU3
        cRCPDQDfcXBS2A9wuEIZlZtH0RmF
X-Google-Smtp-Source: APXvYqw7PYqbX8E/lSGa5ZXG0o7tJ+4NZgSOs3A0fjmuJBniUchpvpROiRAwKrbiswZ6FmWHpJ/B7w==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr19378341wmf.77.1555276184412;
        Sun, 14 Apr 2019 14:09:44 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id h12sm46247415wrq.95.2019.04.14.14.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:09:43 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 2/4] range-diff: don't remove funcname from inner diff
Date:   Sun, 14 Apr 2019 22:09:31 +0100
Message-Id: <20190414210933.20875-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When postprocessing the inner diff in range-diff, we currently replace
the whole hunk header line with just "@@".  This matches how 'git
tbdiff' used to handle hunk headers as well.

Most likely this is being done because line numbers in the hunk header
are not relevant without other changes.  They can for example easily
change if a range is rebased, and lines are added/removed before a
change that we actually care about in our ranges.

However it can still be useful to have the function name that 'git
diff' extracts as additional context for the change.

Note that it is not guaranteed that the hunk header actually shows up
in the range-diff, and this change only aims to improve the case where
a hunk header would already be included in the final output.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 9242b8975f..f365141ade 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -102,9 +102,12 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addch(&buf, '\n');
 			}
 			continue;
-		} else if (starts_with(line.buf, "@@ "))
-			strbuf_addstr(&buf, "@@");
-		else if (!line.buf[0] || starts_with(line.buf, "index "))
+		} else if (starts_with(line.buf, "@@ ")) {
+			char *skip_lineno = strstr(line.buf + 3, "@@");
+			strbuf_remove(&line, 0, skip_lineno - line.buf);
+			strbuf_addch(&buf, ' ');
+			strbuf_addbuf(&buf, &line);
+		} else if (!line.buf[0] || starts_with(line.buf, "index "))
 			/*
 			 * A completely blank (not ' \n', which is context)
 			 * line is not valid in a diff.  We skip it
-- 
2.21.0.593.g511ec345e1

