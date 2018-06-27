Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DBA1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965397AbeF0NZI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:08 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41357 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934246AbeF0NZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:05 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so989044qkc.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LpvWA3HprX313IZBw6t64E1D6B/VULWRYY6wnOAsfGY=;
        b=kV19rAaaVz1CxBainmQQYzPpo+1y30rXEF5lYKBv8x/ageW0O6TGjpRD1tAdNjeTkA
         tLN5YXil02NxDREp2uMsJs5n9ejKIXWsE1MczaDzWn2ziJ4YX1Af3D2h4usECPz6FoPF
         87a9zm02SsZ5I2BTpVUO31iXR1kvO8wv1CN/mZ9kyLLPVCGI4CuzAUppZSDFSdv7DD/0
         PtD9eaTTVnuZomDp7bkDmkp815zZCjdTSVQZ9a+fVHtbE8hYNtAvJs1RS/tMUcsd+Aon
         mbN5bKJAFZxEoFPHjnHAKCOfklfu/LH4mBa7YqotAfN01sCydjReE/2nHwBGJdL8LvOa
         px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LpvWA3HprX313IZBw6t64E1D6B/VULWRYY6wnOAsfGY=;
        b=BfWSpyl6/OgZxFMVBK6Hj25tbo9lMR4qaXqhpxUJ09TDYxuMNoKm1ly6yBcNqHQeBP
         aoZM7ouPk6aCEso3vRul9ZCqaCDomaPJAxs0r/dXyn7Wwxoquz2C7evDP4ex91AquzHZ
         W9ZwP/lpNDPGWx8Hx92aF9bHoziMURcMTLlCfhNAyAp3NXr4IUwFtHzBVlF7qaYYZyga
         ViLe5EjCjg2MeOkFtX5+sQx1BCPFVupd6lgpGezrrLVpSCK/G9sw8IkVvQk9OXqbX98c
         0fSmy18aN+FuO73sEb+1Zi1GulUTRin+/K4SjjxiZYZIcQ9t5t4ceFtqu7x2AQWiDCWj
         9bvQ==
X-Gm-Message-State: APt69E38H2jSUFz+bLPwG+zm7PIqtoosk5xZkQLGDqfAt0tkeGZhxMoI
        fIzzPJscOTF+3ws7D4rQnonx/5dQNjI=
X-Google-Smtp-Source: AAOMgpe0wPsC2XMK0boLkSplrhHN2pZ8MbGwMgHNcSjcyRGSfBvdMasvYeU5YyMwJj8Q/EI1cacbdA==
X-Received: by 2002:a37:b3c6:: with SMTP id c189-v6mr4919576qkf.276.1530105904420;
        Wed, 27 Jun 2018 06:25:04 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:03 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 04/22] commit-graph: parse commit from chosen graph
Date:   Wed, 27 Jun 2018 09:24:29 -0400
Message-Id: <20180627132447.142473-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before verifying a commit-graph file against the object database, we
need to parse all commits from the given commit-graph file. Create
parse_commit_in_graph_one() to target a given struct commit_graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f83f6d2373..e77b19971d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -314,7 +314,7 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-int parse_commit_in_graph(struct commit *item)
+static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
 {
 	uint32_t pos;
 
@@ -322,9 +322,21 @@ int parse_commit_in_graph(struct commit *item)
 		return 0;
 	if (item->object.parsed)
 		return 1;
+
+	if (find_commit_in_graph(item, g, &pos))
+		return fill_commit_in_graph(item, g, pos);
+
+	return 0;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
+	if (!core_commit_graph)
+		return 0;
+
 	prepare_commit_graph();
-	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
-		return fill_commit_in_graph(item, commit_graph, pos);
+	if (commit_graph)
+		return parse_commit_in_graph_one(commit_graph, item);
 	return 0;
 }
 
-- 
2.18.0.24.g1b579a2ee9

