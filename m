Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB67B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeF0NZD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:03 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:43675 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeF0NZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:01 -0400
Received: by mail-qt0-f176.google.com with SMTP id c8-v6so1565441qtp.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MpL6pQM5PvcfrPPYOhMWOUpFGRaeGBzih4xE2kWaOw=;
        b=BAEJOhjWoFrL+ncI7N+qrpiUxq8J4PZYG/k1BKniqhuRxSBYbknUku78GR97oQTq7o
         miTtKP1wPc7X1OaVKYK5oROwzO0hY1nydo60P9tA6aQwqXbSPRMkuNEsApN/HMRe7pzb
         UuV3tWNWefB+LAMTkGFFgyzPXdk0im99+Ew2K8Ia3c/X8ABrCsPBK34VykN1QPdl/Bc/
         mYGREuBbx9dHiSY/aS1oYh1PpWw8p5HFFwIH5OP/NIvPdC9nxXdWSwx8VoDf4KC6IB1T
         I750kphUM1zw3TM1e+ttyugzvaPu/LPQ6W3KjU9ldRKcdNDtNXSquxSIG0t0kj+vF50j
         sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MpL6pQM5PvcfrPPYOhMWOUpFGRaeGBzih4xE2kWaOw=;
        b=iyeW4YuPV+id06+IjTVrM/tKGret8PhekLHzD1Y0DPm/NHR3rH7ocrWPjKSNl8DMsc
         Cdr4NVQ6chHHuTGAtYfg4wYOSgJAoEd1EKZP3NiLMu2gsXhrGpTrZ6a2FZwQjPwAMyVp
         w9fvXzSpT78v/O/Ni9WATCLJhSSlsDBGB/uXdLyN/XKCezTALRYA13WF3HOMwttfNC8/
         kOsfeWs313n7swR5h+tf/Wbpc9DAxOdc4Ir21HC2SSP5MgogsGY/Mn6QbPJxExuMwC/u
         pc5iqPCJ/GXk9IlZvr0o6rXb+Oqel6MaHW6xjmZnezPjkg1rKvK+rJGMZ/wpqleTFjZx
         wATQ==
X-Gm-Message-State: APt69E0jSXb//t7kNUB1L11Z3t5Y6Nq7aSHQcnSW0sVLChRFdXOL3UGX
        J+4p9yD3Y5aLmnUWJqSIz5n7nCJXs9Y=
X-Google-Smtp-Source: AAOMgpev7jfyg9zgvhyyiaA50jKTlxFMn7fsMbc6JFuVYSSFv61FIds1k3kChVYGGjOiCxhIg2Fleg==
X-Received: by 2002:aed:3fc8:: with SMTP id w8-v6mr5329206qth.262.1530105901014;
        Wed, 27 Jun 2018 06:25:01 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:00 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 02/22] commit-graph: UNLEAK before die()
Date:   Wed, 27 Jun 2018 09:24:27 -0400
Message-Id: <20180627132447.142473-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 37420ae0fd..f0875b8bf3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -51,8 +51,11 @@ static int graph_read(int argc, const char **argv)
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	graph = load_commit_graph_one(graph_name);
 
-	if (!graph)
+	if (!graph) {
+		UNLEAK(graph_name);
 		die("graph file %s does not exist", graph_name);
+	}
+
 	FREE_AND_NULL(graph_name);
 
 	printf("header: %08x %d %d %d %d\n",
-- 
2.18.0.24.g1b579a2ee9

