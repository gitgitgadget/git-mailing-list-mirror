Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149B51F461
	for <e@80x24.org>; Wed, 21 Aug 2019 11:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfHULEi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 07:04:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfHULEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 07:04:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so1628552wrq.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DcreXoUKwUS5SAf23Pw64yyR1a59jwBmYjOBZ6iQg4=;
        b=QjIrQ60s79+yWhNK4SGQKoDBSE3I7ExeIQ5M2+nwS8+h+zP56xA0hL+vIcTbFN9hDg
         8uY/uyJWNzpcVBTitM9pZl00fc9Ro5XqVtvSYYPIruAaONvOWCDIltipmFqD/All2CrR
         pvz6C2uh6b+zS/zDzqOm1Wjp6RFRazCMzVOcEZUZGXLWCYf/BqCaA9BiZFoPTjjbgqfc
         SaS6WkhcKayMuQH8NlDKmq9NpsUdxa7KIHoqo7LEEq5KVrQeXWLpN6cF4yoWj6Czr280
         F7yq3dbJsc2vVptFxOIkdZd2PNbkgVc+IZHpnLxClaj1xlGsjUps+A6CcuJMM4IeMQle
         cJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DcreXoUKwUS5SAf23Pw64yyR1a59jwBmYjOBZ6iQg4=;
        b=luE05VXUrxNRFcUxc0KJJj13futgpUEBbSDQG5xJJ/CMYY9xiIIVDLtVB/WSvo1pQ5
         RV2t3Mih23ItYpSLXhE3MvObPy7U5rM0YMEHq9sWQgWErkRsrYV3C6VsrkC7lIRmNi3N
         +ZDdHUhROa1T5rnzZmToy+3VcTRux7jNSIZH39jFOR/VWEGYsxiqP0pW8KAKbvMwxy8y
         SINo1AQOPRqa2A2WtWmgAVlqYIf2ELNbKvJPoTaDzNE+6jyTiXw6Qy6rueEaRWaFMqPV
         lCmg5n7o/PENpBnuC8I1SjRhIC9N0LXHR1WH9I9PsP15FufTNMulVbUxsWFTWXwcw6BN
         nM1g==
X-Gm-Message-State: APjAAAXxCPyCA73p04/l+0+uMlFt82pL26TztBmWAsd0c861lE35agVM
        aGnqnZBIIVAytKS6NPNd2lSXCazC
X-Google-Smtp-Source: APXvYqzWqbBd3dYUdcGQj5YsMiqQDyn7uWrK+YOBFBBrqvhUwZEg5xW1XPgnliIeyNo/iZUBhUNO5w==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr31924353wrb.261.1566385475428;
        Wed, 21 Aug 2019 04:04:35 -0700 (PDT)
Received: from localhost.localdomain (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id c15sm61648441wrb.80.2019.08.21.04.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 04:04:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] line-log: extract pathspec parsing from line ranges into a helper function
Date:   Wed, 21 Aug 2019 13:04:23 +0200
Message-Id: <20190821110424.18184-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.352.gebb2b55eae
In-Reply-To: <20190821110424.18184-1-szeder.dev@gmail.com>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A helper function to parse the paths involved in the line ranges and
to turn them into a pathspec will be useful in the next patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/line-log.c b/line-log.c
index 3aff1849e7..fddd91f060 100644
--- a/line-log.c
+++ b/line-log.c
@@ -737,6 +737,22 @@ static struct line_log_data *lookup_line_range(struct rev_info *revs,
 	return ret;
 }
 
+static void parse_pathspec_from_ranges(struct pathspec *pathspec,
+				       struct line_log_data *range)
+{
+	struct line_log_data *r;
+	struct argv_array array = ARGV_ARRAY_INIT;
+	const char **paths;
+
+	for (r = range; r; r = r->next)
+		argv_array_push(&array, r->path);
+	paths = argv_array_detach(&array);
+
+	parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL, "", paths);
+	/* strings are now owned by pathspec */
+	free(paths);
+}
+
 void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args)
 {
 	struct commit *commit = NULL;
@@ -746,20 +762,8 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	range = parse_lines(rev->diffopt.repo, commit, prefix, args);
 	add_line_range(rev, commit, range);
 
-	if (!rev->diffopt.detect_rename) {
-		struct line_log_data *r;
-		struct argv_array array = ARGV_ARRAY_INIT;
-		const char **paths;
-
-		for (r = range; r; r = r->next)
-			argv_array_push(&array, r->path);
-		paths = argv_array_detach(&array);
-
-		parse_pathspec(&rev->diffopt.pathspec, 0,
-			       PATHSPEC_PREFER_FULL, "", paths);
-		/* strings are now owned by pathspec */
-		free(paths);
-	}
+	if (!rev->diffopt.detect_rename)
+		parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
 }
 
 static void move_diff_queue(struct diff_queue_struct *dst,
-- 
2.23.0.352.gebb2b55eae

