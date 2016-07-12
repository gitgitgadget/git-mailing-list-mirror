Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD6B20196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbcGLWjf (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:35 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32802 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcGLWja (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:30 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so1822526pap.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3L4PoUCTLwUTFGoyXMjx0FHBth/lWBOcgtc068ywzY=;
        b=ON9bm4Y1reDI94fOPVR0ID/sbirWRjaeS91Tp17EgUYqJdGVeSz3oK63edWZisotMq
         2EW72xzMHq398cOCFa8Cf8rwNpZ1f1v8qdiB0rLYIUKzI51GF3slKyiKr0eydr9mxTkx
         Nfr7zfNTIJAsbk6XZz/awF+Pw4t73scK/vfBy7bFyett4PNgoZafrQfEEr829go6uSQH
         ftBjk/A5sEueHZ6G7coU61d1mfDFpyUecwXJ24zIn1AWl2FG5UYEZtSiFot7H4l9wyIl
         Ei9dxDb2frBJsm4+gVVh5k2I1Lr3f/xfDyq++Z95OIIalWs+S4v4BO+0IU6j1iuRgVpk
         y4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3L4PoUCTLwUTFGoyXMjx0FHBth/lWBOcgtc068ywzY=;
        b=eDGqbGUuDP9NbOYzlXXmwAPpYS6NigUMyRoClg6Gf9+MnEG+0KFlIwPbsMqSYc0RbT
         dCMfTsNU4Qla0Qzs1sCofcAuIvhZMR9SnatqpSt1u8SCbgKo0Cvl0KyfeyXGkuJeQZLo
         TgVaD8tV+UZpJtalIdXVs50CWILM5QO0khkeTSuv40XIireWFV7i0DZK+JIZv3r9iOZt
         5omhwQkmRTRDH0YTkDsP39WbhFZxIRR+RRV0zG668ILwB7GgtGdLTyYr72HnQAslvsqK
         zmRW6+tHDibcPy/IZJw602L/5c7H9/xq8EnC0VTMSLkHnKO4MwATwVHQrOnmWRs5uc1I
         hfYA==
X-Gm-Message-State: ALyK8tJV2SH+Ot2+SDbZxEY6TEt0BHHkeB4fc2r33hPcYq0RLhmEE24M9z020RWxN+dCSQ==
X-Received: by 10.66.15.232 with SMTP id a8mr8244713pad.129.1468363144282;
        Tue, 12 Jul 2016 15:39:04 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:03 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 1/9] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date:	Wed, 13 Jul 2016 04:05:30 +0530
Message-Id: <20160712223538.28508-2-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..8111c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	enum { NEXT_ALL = 1 } cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &cmdmode,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (cmdmode) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", cmdmode);
+	}
+	return 0;
 }
-- 
2.9.0

