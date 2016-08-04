Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE66020193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbcHDTwQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:16 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33911 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965175AbcHDTwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:14 -0400
Received: by mail-pf0-f180.google.com with SMTP id p64so89617030pfb.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JuBYTNoCDbbkjLyYPGU6CIIGpXHqllBijXL+RPRkGoY=;
        b=FUGteuIgpdUJ8u5Z9zcYR5pW9XlFysdko7XyRV86xg4svC2RflgMZuogVKK0g9ecX/
         tU750BK1ZAgkqIQZJ6FEzmtg3lNyT5TY6rni4p77v94kHkb/4g6MvS4923+uiJ5yc7wM
         8iE5MpJkgAuuG5IQ4H2iFd36patZCIfqSyS52eEJ0n/+uJwwN2hiZOP3FpTYvJlHDmlQ
         xPOnpcYO1vUOGyPhOtAoOr62+zJpds0IBthRfNZ1j2gAvJ0fiNyREXO0iRmWVgKtbuiA
         HQsoLOqsC8I3lfQbA69RaX9gCI3yyhc2X/equa498iK/QAzGv5E5FSQ1Ue+Sv0Ios1mK
         IETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JuBYTNoCDbbkjLyYPGU6CIIGpXHqllBijXL+RPRkGoY=;
        b=JvddakwhRZ2Fy7SQq86e7W8vF1d9znP8ONk7Me/j3wSNv+yUIL46IyJTEhqqeXHn9u
         gfzK/I/f/5pSl7+QYeUqFQf+n1CjGkGH4uLrLiQH5WgP39vRbwVUW2sH1Ea8ys3NIGUq
         4YyS1EfN+XztOwoPuu7zFZfsdOBhjU+gFB9siF78CCVCPMSSmU5pBIbJEOwK3z86nxPo
         DggXUrXdz8tCOFb15dItbz03Vpc67KNE3Xq3jJ7dPJVX9Va8TKzYZq9N/AXgeqbe8hz1
         dm8Fr1bpYkPr34PJsY9Cb7qO29t5Y6CEbNKoW9FanUcQjXt/GS/WV6DGexttKf5hfdvV
         aU3A==
X-Gm-Message-State: AEkoouvTBJJtJHRC1dk24zIev2R9JMQdhsRr94LxURJTiyHcWK3vsaUrMFNwusrRIg9dsQye
X-Received: by 10.98.86.85 with SMTP id k82mr130341885pfb.82.1470340333476;
        Thu, 04 Aug 2016 12:52:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id v26sm22300972pfi.41.2016.08.04.12.52.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:12 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] submodule--helper update-clone: allow multiple references
Date:	Thu,  4 Aug 2016 12:51:57 -0700
Message-Id: <20160804195159.7788-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow the user to pass in multiple references to update_clone.
Currently this is only internal API, but once the shell script is
replaced by a C version, this is needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 git-submodule.sh            |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 896a3ec..b6f297b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -583,7 +583,7 @@ struct submodule_update_clone {
 	/* configuration parameters which are passed on to the children */
 	int quiet;
 	int recommend_shallow;
-	const char *reference;
+	struct string_list references;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -599,7 +599,8 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
+	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
@@ -709,8 +710,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", url, NULL);
-	if (suc->reference)
-		argv_array_push(&child->args, suc->reference);
+	if (suc->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &suc->references)
+			argv_array_pushl(&child->args, "--reference", item->string, NULL);
+	}
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -829,7 +833,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "reference", &suc.reference, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
diff --git a/git-submodule.sh b/git-submodule.sh
index 2b23ce6..526ea5d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -575,7 +575,7 @@ cmd_update()
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-		${reference:+--reference "$reference"} \
+		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-- 
2.9.2.572.g9d9644e.dirty

