Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337DE20248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfDEDhy (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46168 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfDEDhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so2462126pfj.13
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrdbbYJLYN1A9NpG7aHq8VQP3FpKbnoaDhrpoWW65iU=;
        b=YNnOX/gSLNTKl0WSu/XsWP+eeSzQUA6YFnUMVlXilOCCmZnxegJANQVPwHks1dNd0D
         k3tQ3CEMMCgNgkrwVOYcTQAta29FnaE78mbY5N0FYLWVPEopDEaLpoKDiMuGaPHnjspY
         Bj+wBHIVztCpLusBqUum+pLMCeFAvEKfVRjNW1DYhyM+/YAgdzaFvoaw1B8uMWwqSPYA
         CoANcI20evUxbY46Y//P8TNZr8eAd7pFGc/RAGImLsxsXDXexnrqSnN3rXQ7kKnzqBkZ
         pjsnyhe+5AvpGrdfSAeYKUKDvTkcZHAAPM3d/2j/wxGfCHq5tJwLtD4UgrG6UPpphrx4
         GxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrdbbYJLYN1A9NpG7aHq8VQP3FpKbnoaDhrpoWW65iU=;
        b=HH3eq59wjDBdznArwau6sEP46r2+3cjAvlVeQ/qn4iY0IhsuiUQpdD+khdH+9yS6Mb
         wznax74yC85x+PpqP1VYPTze1xQp8PtEOdxSk1UNReGkldpob23p2ufDkcYU2gq3MtIK
         5fZCsjwRiD4CFfAUAaSk/znL9B/bPyL19+7zoScHelvLiAoMV+jRTax94GYc8tr7+hAs
         0Wyh1eIs6E7j6Zg0Vsy6u2RJUu8PUrBUUBWEcCXTFSBbvPcuFctTdvTSiuDwnzaHROSn
         SmH/1cG5RKiaqrABGuiQzlnS+XSEiH8LPaeCv11XvLy/OgZwjGGkeoq6df0YxSiPZqZ3
         q34g==
X-Gm-Message-State: APjAAAVNMomBZDHWOHnDU3umoj2y7DAroPmOljM5NaI6mz6pc9lgpagY
        duMfFk/pEw0+2N90wiGSDSmRbK9UP/KUMw==
X-Google-Smtp-Source: APXvYqzE7VgiFOQ89st3pGqwxIsaRbaKbs9NZ1ET4M22ax2VuggnD+l7KSm42/ZYIaO4Sv5dOEXh1A==
X-Received: by 2002:a63:7152:: with SMTP id b18mr9567360pgn.186.1554435472845;
        Thu, 04 Apr 2019 20:37:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id c17sm29720117pfd.76.2019.04.04.20.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:52 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:50 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 5/7] get_commit_tree(): return NULL for broken tree
Message-ID: <a3975f74d4a5153d1275baa4b15e0afb9741541d.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Return NULL from 'get_commit_tree()' when a commit's root tree is
corrupt, doesn't exist, or points to an object which is not a tree.

In [1], this situation became a BUG(), but it can certainly occur in
cases which are not a bug in Git, for e.g., if a caller manually crafts
a commit whose tree is corrupt in any of the above ways.

Note that the expect_failure test in t6102 triggers this BUG(), but we
can't flip it to expect_success yet. Solving this problem actually
reveals a second bug.

[1]: 7b8a21dba1 (commit-graph: lazy-load trees for commits, 2018-04-06)

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..e2cde566a9 100644
--- a/commit.c
+++ b/commit.c
@@ -345,10 +345,10 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
 
-	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
-		BUG("commit has NULL tree, but was not loaded from commit-graph");
+	if (commit->graph_pos != COMMIT_NOT_FROM_GRAPH)
+		return get_commit_tree_in_graph(the_repository, commit);
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return NULL;
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
-- 
2.21.0.203.g358da99528

