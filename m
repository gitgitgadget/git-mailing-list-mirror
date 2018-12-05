Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FCE211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeLEWdA (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:33:00 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39363 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:33:00 -0500
Received: by mail-qt1-f201.google.com with SMTP id u20so22188632qtk.6
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=mTIKFfcW5LJ4Ek7rhxlxsP5P/TLR1OL2OWgCGOJoOKk=;
        b=kEIox6TvEgfmcyjr/fBCEtTP93KEtqpjsYRaRr92Zhoe1REsJ99sxFT3uAbLRrClwi
         S3vBLprXGz0xVMwIrrv0oINyawRDUYBd8qg/yxu/Hzaua856eP3wY/680r/DWK2wz+TI
         ia+f+AwfqMZZLC/OejzcuMFBJ90TwXmAqXZKR2qz92D6vHGdz6bQ9T+VEMKM1oO0VqNy
         Lx9auJYdmDIPo06TLt1294Y7FWFoAc6QfaZhdceyPQbRajHhe1VCbceNyf4iX5NrN0Rz
         jivq3b5xIvCPXceotWBBEWc5tExgkWy3hk12faF33uTgGo4HaUieyQ6Q1Zs1JzoE4sHL
         JuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=mTIKFfcW5LJ4Ek7rhxlxsP5P/TLR1OL2OWgCGOJoOKk=;
        b=Zd37r8IHbFZzuHaV2pDk+fC8rRjnj6/DCOIVIonct4J88TsrK26JUcMpXOiDeRJIFh
         vQLyMi4u/vyKn9oAR4csAsWDa/JyHKHvOz8SOlGuKpHt5UZjF06D57BlYaeVLGFyV7HD
         GCjIX4YTqMNCNG2Tz+1RjnFW7ShNlKjquHko3b6mrDMxtYzzKA40Cw4PFQSlQQJpZDIe
         mjEf/MM5aV2iRoBDY/JYg9Dts7oIyI4MbBt8MPf+AofvGDqORGQnnamBQSplnl3HlJse
         v1wUZxkhVG2cikmjaNLwm28k2AlA19GuEoRQhJqjkhiIDSz9U6SvXyP1amEytnNV9bK2
         L+mQ==
X-Gm-Message-State: AA+aEWYnIWKQzjNHS9n34TDv/ANi2aBMUR8wGnbI2oq7PSYoZE/LcAH6
        npYgTFfqRDLO6rBk/3TAWGFYksksO6ejIUk899Gpc92JlGdWV0uHRf3TpZCgTM/AJ9Dh5HMRkDp
        eK3opuAw+ZDms+jyQmb5d4ngMIMKezf6iAjhJkwFz0wliyAHH4Iaf4ECmNczb+gg=
X-Google-Smtp-Source: AFSGD/Xb6dekCd19Q0dOqaFwpMGfey+s3dAlVpbL6jEcLGlLVkK8G/tMgjxxMCt1AexjJ8AM0esFqUT4FQiExw==
X-Received: by 2002:a0c:9dd5:: with SMTP id p21mr20435529qvf.31.1544049179417;
 Wed, 05 Dec 2018 14:32:59 -0800 (PST)
Date:   Wed,  5 Dec 2018 14:32:51 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <ad2e761f4438ac80e947be0f6831fb6467eb4396.1544048946.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 2/2] commit-graph: fix buffer read-overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fuzz-commit-graph identified a case where Git will read past the end of
a buffer containing a commit graph if the graph's header has an
incorrect chunk count. A simple bounds check in parse_commit_graph()
prevents this.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
---
 commit-graph.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0755359b1a..fee171a5f3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -175,10 +175,19 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
 	for (i = 0; i < graph->num_chunks; i++) {
-		uint32_t chunk_id = get_be32(chunk_lookup + 0);
-		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
+		uint32_t chunk_id;
+		uint64_t chunk_offset;
 		int chunk_repeated = 0;
 
+		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH > data + graph_size) {
+			error(_("chunk lookup table entry missing; graph file may be incomplete"));
+			free(graph);
+			return NULL;
+		}
+
+		chunk_id = get_be32(chunk_lookup + 0);
+		chunk_offset = get_be64(chunk_lookup + 4);
+
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
-- 
2.20.0.rc2.403.gdbc3b29805-goog

