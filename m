Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E061F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbeF0NZM (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35429 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbeF0NZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id z6-v6so1584035qti.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRrRTur7HtG+IrMmOxntj5n+/Sa4tAmjEt4BIaF03mA=;
        b=jz3qV/8z/bNtQSulSMFpNqXvPoJl81iy2NFGMbuENRePNLaLCm1FfUeNObvAz4r5Xe
         uoLcg2zK8hOb4apqOJ2wCmA0LaG8Gexz33UpamMxFZ6uD5o+n2Om9+gPfrlJYRSC1zNr
         t67jdiv2VaRlMxTRcdkgOZmsS+JsG2yXoakGNhbSHyo0SaXbQGVl9yMZhvsiIeo1S+ZY
         r88xLehnu8Bxhzta5lkC2gP/Re9A80MJZ/5GsMzAHv0c0wii3ncaG2IWPBV5VGhZjECu
         NhjGxlwNa9n3pVgszzHoX+POTdtdgkmBbVmozo5e65MlG67nr+pldUiznV0U7Jjsm9rQ
         lc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRrRTur7HtG+IrMmOxntj5n+/Sa4tAmjEt4BIaF03mA=;
        b=lid5OZjEHXCi6+DivmpuPhynAkk5uYsehIaozNIje7Z2E4QPWxUHz8PjhUQK5XUyz6
         9FTMLm29x4snWBNaoAdA9oPdE0OKZUNml9Pmi/VL/XTWBkET1O32Y1V0ZyUi0XPXF+6y
         9v8PgaBSX5ktv/M/cEnQ9I+EEIe+4FSZHyScsdJZcptqipDq5GtNM1eY6JfD/wldJgJP
         OamWenHZzRKTm5bDVbjvEM67GkvJY/JfjUug01BS6PerjSqR1FZMYd5wi23mcnYhE4Th
         Fk5W4r/QwymwMbMmxLk8dB0tdPYOYQErkQlM9hftxJA5KAHgt0KZkqIEfUTQGbJJMew8
         DESA==
X-Gm-Message-State: APt69E2cEws1ftAJ/hhV1PlRSbfz2CkoIcwnv1uUT8VofBHod3583/Pk
        XRn898wgHQYLGM7Ex3Tu7v+8kcG97Q0=
X-Google-Smtp-Source: AAOMgpe9UedTGn+l6qaqzvSjI4SL+FOX98f7R33NLN3sLNTe0G3JV9ohPXlI3OkbjuRmntVARV5SHA==
X-Received: by 2002:ac8:5354:: with SMTP id d20-v6mr5404307qto.141.1530105908115;
        Wed, 27 Jun 2018 06:25:08 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:07 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 06/22] commit-graph: load a root tree from specific graph
Date:   Wed, 27 Jun 2018 09:24:31 -0400
Message-Id: <20180627132447.142473-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When lazy-loading a tree for a commit, it will be important to select
the tree from a specific struct commit_graph. Create a new method that
specifies the commit-graph file and use that in
get_commit_tree_in_graph().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e77b19971d..9e228d3bb5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -362,14 +362,20 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
 	return c->maybe_tree;
 }
 
-struct tree *get_commit_tree_in_graph(const struct commit *c)
+static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
+						 const struct commit *c)
 {
 	if (c->maybe_tree)
 		return c->maybe_tree;
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
-		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
+		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
+
+	return load_tree_for_commit(g, (struct commit *)c);
+}
 
-	return load_tree_for_commit(commit_graph, (struct commit *)c);
+struct tree *get_commit_tree_in_graph(const struct commit *c)
+{
+	return get_commit_tree_in_graph_one(commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
-- 
2.18.0.24.g1b579a2ee9

