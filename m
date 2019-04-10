Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD4A20248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfDJCNY (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39107 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id a96so382412pla.6
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrdbbYJLYN1A9NpG7aHq8VQP3FpKbnoaDhrpoWW65iU=;
        b=Un99nteXuGo+xHLrlm21CjfFNy79eiUTu1CBTsnVBod0ZaTrV3duVTJGyCzIymS8RB
         y8LxJe9CQhbRFWtgL6x1s6w5M+Lyl7HpymPtlBwJc9YkXlafZm9oSABjm0LirxUyjm28
         WaAt9HZEhZuriLyUZvfoAc8qQNzsPP7nwZt0ysz7QXQrYlKeHyHkg26ErMHmqehK508V
         AawxFbByd0upRZvSym5/IcsRLM2DkSXTwl8HXZvtyxMP8LHHOnnMahEz2bkpx/R/gRer
         h+Sxnxt+OFuwKsNBA8R+LWzRULuZ7dJjVa3sibviWPRoRS3At69bK76REP0tRmaXd0Js
         t4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrdbbYJLYN1A9NpG7aHq8VQP3FpKbnoaDhrpoWW65iU=;
        b=dwtf9E+hup71294YR/Js6Ya/KZnQod0hRkBu4s4+txkcl1LYMxJOUoCTCL/NvTFEmX
         E6QSEv0fjkW2AE3EVFzB2b+u5TZI+mUqJSdbHYuPYHIlrUTAr62C0Bb6DbyPCKs4lNhH
         7EEJPj0uUvILjlPYr4PVl54PLEntKWDgBHRv2DVF803QngqV/tbPEOrFuB2auH21MflC
         Mm4Fb9UVFoJJTdWuauq2PBWXIAwjpDEdFRYlVE8jrK7CeQ6aEyNX4GlpfEzt+GimCNlH
         fYgXCXj0dPhYG9qwytU8PgDXaqk68c2hnvJ/mGe8memRbuuo7sMcnm1UUeIDcPSPWFzj
         Eakg==
X-Gm-Message-State: APjAAAUm1CSsfYG+HGXO1Roy/wXhRcX/Ow3c7x4Vbyf2GaRUYHvELlt0
        LI6K5SIhTrdsNP/eh+f51OkI2QgXbgKxQh1K
X-Google-Smtp-Source: APXvYqw6Z6IvqNICYvXQsM2mdDxljh0XAtekqHXCkiHFZ8s40ngiWk27rX81fNKYDO1HU9ZPZ2QNgQ==
X-Received: by 2002:a17:902:e9:: with SMTP id a96mr20611001pla.176.1554862402247;
        Tue, 09 Apr 2019 19:13:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id a17sm55984568pfj.123.2019.04.09.19.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:21 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:20 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 5/7] get_commit_tree(): return NULL for broken tree
Message-ID: <e9400a9f773adb62315f75347ad7231b4476a2f4.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
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

