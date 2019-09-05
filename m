Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BAE1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfIEWFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:05:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44453 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIEWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:04:59 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so8249051iog.11
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seLlX0fcmQdYngBz51Tl2dewAbX6NRJKhiYBEXwO93s=;
        b=u3QAuV2USFYAYd0ZivODNI+nNda9gzflLYt2focGl96tVUhFz4SZpkKEnGx6TWu574
         FNioTya1/ZBd/rd1xu8J1uyd8FJFjXEfKckskNZPjFihkMOoSXU3OwfTX63BnI02/cqo
         ganD6zhyGcYsBaE5lA3mRfUwKwiCafbCq8Cr2k4Qm3Di5f6Z3Wx3hAcF4O0V0/WXyor5
         ecTFwbxQ5wXOkdCvRD7pMQhgQ/sBt/DoNZqhQOmP1q+1Jvf/5a9dXl0H7XOhtHmDdKvj
         oLVmiiuEug8LhN/YdDz83IHjOn2y0KBHvElrZtFyP47PwItcJISJ+IiPzzr4hM4p1vVG
         SHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seLlX0fcmQdYngBz51Tl2dewAbX6NRJKhiYBEXwO93s=;
        b=g6Or4ZS0oYPPvmqvAptWkSvZJEGXt3D4fAKbLpM7RBvovyGrICARMdHKPfNqRidul3
         16ReqUD03rKtmCdnDTXLWLzFMOS9fGrUMK/lHqxcPkqtKzXRLYxkBAZ/lLK/VUXSAFkP
         Sa3pcvD5wYzIhUDq6MG9j0PeplbmDtzSfT78Uo4zL4w7fVCMukZNOyhqIBT1j97Jt2Q9
         v62aC9H/5k836hBM5oAVGp2/vFIpKn27hPImbjWxOq67743OC1IaX9veiowtT+PkzllO
         /TzkGbIOatY/XIU9B6RztXl2z8YzGbdBJbUcAHlQqACJ3Nxy3dHnJZoc9OW45SqEndGV
         vBaA==
X-Gm-Message-State: APjAAAWHXrk9qcSk4cifUTrYgj6YBoPEsgb/nhvXblc50nE7vBarFREi
        8HroCPQ9DFnmXai3FlvAd9MnRl6a/fet4Q==
X-Google-Smtp-Source: APXvYqxkIOp060G9CYmC1vNu0IjfDACtmE4CoM0QxqZZIKxvBVrPO1mzbPaXX+KUUXxMu3nZYb44/g==
X-Received: by 2002:a02:2a0b:: with SMTP id w11mr6598102jaw.43.1567721098308;
        Thu, 05 Sep 2019 15:04:58 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id w6sm2785733iob.29.2019.09.05.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:04:57 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:04:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net
Subject: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
References: <cover.1567720960.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567720960.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as in the previous commit to handle an unchecked
call to 'get_commit_tree_oid()'. Previously, a NULL return value from
this function would be immediately dereferenced with '->hash', and then
cause a segfault.

Before dereferencing to access the 'hash' member, check the return value
of 'get_commit_tree_oid()' to make sure that it is not NULL.

To make this check correct, a related change is also needed in
'commit.c', which is to check the return value of 'get_commit_tree'
before taking its address. If 'get_commit_tree' returns NULL, we
encounter an undefined behavior when taking the address of the return
value of 'get_commit_tree' and then taking '->object.oid'. (On my system,
this is memory address 0x8, which is obviously wrong).

Fix this by making sure that 'get_commit_tree' returns something
non-NULL before digging through a structure that is not there, thus
preventing a segfault down the line in the commit graph code.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 7 ++++++-
 commit.c                | 3 ++-
 t/t5318-commit-graph.sh | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6aa6998ecd..cea1b37493 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -839,6 +839,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 	while (list < last) {
 		struct commit_list *parent;
+		struct object_id *tree;
 		int edge_value;
 		uint32_t packedDate[2];
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -846,7 +847,11 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		if (parse_commit_no_graph(*list))
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
-		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
+		tree = get_commit_tree_oid(*list);
+		if (!tree)
+			die(_("unable to get tree for %s"),
+				oid_to_hex(&(*list)->object.oid));
+		hashwrite(f, tree->hash, hash_len);
 
 		parent = (*list)->parents;
 
diff --git a/commit.c b/commit.c
index a98de16e3d..fab22cb740 100644
--- a/commit.c
+++ b/commit.c
@@ -358,7 +358,8 @@ struct tree *repo_get_commit_tree(struct repository *r,
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
 {
-	return &get_commit_tree(commit)->object.oid;
+	struct tree *tree = get_commit_tree(commit);
+	return tree ? &tree->object.oid : NULL;
 }
 
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index abde8d4e90..5d2d88b100 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -607,7 +607,7 @@ test_expect_success 'corrupt commit-graph write (broken parent)' '
 	)
 '
 
-test_expect_failure 'corrupt commit-graph write (missing tree)' '
+test_expect_success 'corrupt commit-graph write (missing tree)' '
 	rm -rf repo &&
 	git init repo &&
 	(
-- 
2.23.0
