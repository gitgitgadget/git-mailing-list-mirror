Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631881F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCWZo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:25:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42063 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:25:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id y71-v6so5538405lje.9
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4p5x2geL/GLeSfknLVaIJCGegABo7aQf/tABNhnxc3g=;
        b=oNeElJj5OqeiVMpsvdP1KkTUTJDmMiqmvE2VOA885mqzxGyeb6zIuyYjpgQ9kgQsUL
         ERRz3+w9UQkUvrW0ncyipjno4wOS4e0tnLmFWN6nWzsIPrkCpctlR1B77i2KhwUyNQly
         GVOPgkZ5TVa6C1gY6PiKn3CKCOvPkxub6g+A2RGSxJXhWIF7fp6wp+yyMmVKTfqJqoNM
         d9gG0Nxvd8i/YvSNVRDUwTeeBFJy7RqY49Pzk2VeaUXsaARayNJGlgXjQSgkoaSfxwxp
         toMGlUYoCZ0wnT6IhhvKyxJIx7M8hgu21FrcT02agcKmv32gtBdAxjvhKOp0SRSncoE6
         xywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4p5x2geL/GLeSfknLVaIJCGegABo7aQf/tABNhnxc3g=;
        b=iGTD6edRg0Xxci1RA1Sbt8s2dGI4hnYJVcj7BKQ2099JNrd8spGry3IzDxe+N7fGP7
         Xjgk//iif16Rkv81G7HnJDESYffGxzJSuFWarxKMpdj2JIlAzhRFb77xSAFyi99m5imW
         hYPpx/aVuejQk0dsaxyXmAi2BE6YSb9Aa/Qr4OJxqS4v/Z2AATmXd42/3MsG0kJ2Ite/
         oqYVD7ZNKane6pwhcPFb0TNPi50QBgeMawSew8+GwI5wQgrpFiE/jTscH0e5kboVzY0a
         YbrmMlC7cv24dii0AXpLYU6ATNEnVfJzzq3BJfdfN+lbc/RF7gp4mAIU/dujrSpoaU3y
         tIvQ==
X-Gm-Message-State: ABuFfohcsWBW1dliAtIpKttJSRY55RvJNTifocmDTVQ8Z2Cb/zPLCH+R
        P6KQAOqkiSM8gRIkGU89qQ0=
X-Google-Smtp-Source: ACcGV61eGTpmVL8BTDEbrjnPdipbXJq6KklMpmKgvgr6ExKpba/2sWf1uDOMorrrOjtr3lxVR+vzSA==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr1508349lji.29.1538581009119;
        Wed, 03 Oct 2018 08:36:49 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u196-v6sm471838lja.42.2018.10.03.08.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 08:36:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/2] builtin/commit-graph.c: UNLEAK variables
Date:   Wed,  3 Oct 2018 17:36:23 +0200
Message-Id: <5d260588675f6446079efc05b00492f2c99948a3.1538579441.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.329.g76f2f5c1e3
In-Reply-To: <cover.1538579441.git.martin.agren@gmail.com>
References: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com> <cover.1538579441.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`graph_verify()`, `graph_read()` and `graph_write()` do the hard work of
`cmd_commit_graph()`. As soon as these return, so does
`cmd_commit_graph()`.

`strbuf_getline()` may allocate memory in the strbuf, yet return EOF.
We need to release the strbuf or UNLEAK it. Go for the latter since we
are close to returning from `graph_write()`.

`graph_write()` also fails to free the strings in the string list. They
have been added to the list with `strdup_strings` set to 0. We could
flip `strdup_strings` before clearing the list, which is our usual hack
in situations like this. But since we are about to exit, let's just
UNLEAK the whole string list instead.

UNLEAK `graph` in `graph_verify`. While at it, and for consistency,
UNLEAK in `graph_read()` as well, and remove an unnecessary UNLEAK just
before dying.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/commit-graph.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bc0fa9ba52..66f12eb009 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -64,6 +64,7 @@ static int graph_verify(int argc, const char **argv)
 	if (!graph)
 		return 0;
 
+	UNLEAK(graph);
 	return verify_commit_graph(the_repository, graph);
 }
 
@@ -89,10 +90,8 @@ static int graph_read(int argc, const char **argv)
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	graph = load_commit_graph_one(graph_name);
 
-	if (!graph) {
-		UNLEAK(graph_name);
+	if (!graph)
 		die("graph file %s does not exist", graph_name);
-	}
 
 	FREE_AND_NULL(graph_name);
 
@@ -115,7 +114,7 @@ static int graph_read(int argc, const char **argv)
 		printf(" large_edges");
 	printf("\n");
 
-	free_commit_graph(graph);
+	UNLEAK(graph);
 
 	return 0;
 }
@@ -166,6 +165,8 @@ static int graph_write(int argc, const char **argv)
 			pack_indexes = &lines;
 		if (opts.stdin_commits)
 			commit_hex = &lines;
+
+		UNLEAK(buf);
 	}
 
 	write_commit_graph(opts.obj_dir,
@@ -174,7 +175,7 @@ static int graph_write(int argc, const char **argv)
 			   opts.append,
 			   1);
 
-	string_list_clear(&lines, 0);
+	UNLEAK(lines);
 	return 0;
 }
 
-- 
2.19.0.329.g76f2f5c1e3

