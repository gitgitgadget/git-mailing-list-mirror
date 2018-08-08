Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304DA208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeHHRnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37514 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so1459908eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G83GlZ8T7pGkL4IwWhZqihUUFNEwvtEPcRcdq+J37SI=;
        b=m5F/Zd9733DmhRfEjtmUZqDhEhSav5qmEceIh/BgVhtcCt4DGWHrqqNqOVqe5AMGSP
         tLXhCweLZZUbz04zlR+ApYK95W6wSYoIpX2X4g8jt1d73U9c8md0oB2xKxtJLZoh/Wt/
         JECAhgoMrwkg+nODei6HjAXDYOruTL32RekRJuhoDGPFdhBpqFJGN7URC8vCo5gxAdbW
         UDC327HeidozCDH0m3MSluxurlLEUCL+vinNchVZwqaH7Mo3cYG9FVkZ2z0zaHGBJzMS
         lo5aAFyZs1eZx4Ywh1wfKVU4L9YNLxPV/QIjyhdtBONdnH5kmyg0MQLwF32szLaxrejq
         PvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G83GlZ8T7pGkL4IwWhZqihUUFNEwvtEPcRcdq+J37SI=;
        b=BkRh1dN41ZfH8Gemglp6t9Zm9CcSvwSFZcSISYDIiwWuq3ds/Tf1eLFtO3wZNAgttR
         +PYKtanOUcO6vMqzdV0ahwcqeGf8rPa6hDujcS5FyfSizNJGbcWklWBrXqjj+Q2vv0Gr
         ky5ebZJOvxLdst9i0mlu3TnpQVQUDqj77v2HrPtJVJEDz6y5d9sma6r+mZFGwvKEvQOP
         3zvFZE/24DvBY6CL87tFL4X/T9ce+MLNbF2e7zB7hYdkTue1qhg+c1hHC80ScRIryI9j
         MBsyG6RTt9zE/vKVnguqUHOyS4nayGoiEinRCPucJdim49PLrBIsZgDr/OT3nSZs6B7S
         P3ww==
X-Gm-Message-State: AOUpUlGQDf7+Fp8tuPgHhqc7py4ovdFgqeNuotU1rtZhV3dXi6f5GXo0
        1j8AI6nKlHi9Ge0ZIjoSmjael38K
X-Google-Smtp-Source: AA+uWPzya5ZZ44c59mcm6yz8vmWEC//LMXCpKj65pbaUu8jtX9M4LF/tFPzTd6MDy9id1iXH8ExRTA==
X-Received: by 2002:a50:9182:: with SMTP id g2-v6mr3808309eda.24.1533741816729;
        Wed, 08 Aug 2018 08:23:36 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:36 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 16/18] builtin rebase: support `fork-point` option
Date:   Wed,  8 Aug 2018 21:06:38 +0545
Message-Id: <20180808152140.14585-17-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for `--fork-point` and `--no-fork-point`.
This is converted as-is from `git-legacy-rebase.sh`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0b94d2daaa..72e64868b2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -632,6 +632,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
+	int fork_point = -1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -714,6 +715,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+		OPT_BOOL(0, "fork-point", &fork_point,
+			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_END(),
 	};
 
@@ -1062,6 +1065,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
+	if (fork_point > 0) {
+		struct commit *head =
+			lookup_commit_reference(the_repository,
+						&options.orig_head);
+		options.restrict_revision =
+			get_fork_point(options.upstream_name, head);
+	}
+
 	if (read_index(the_repository->index) < 0)
 		die(_("could not read index"));
 
-- 
2.18.0

