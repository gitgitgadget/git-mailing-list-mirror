Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B191F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfGZPxK (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45969 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbfGZPxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so24927703plr.12
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jI6bJznoT1kUHH+hGFs83qAIbvycj3Rophq/FX+N/Y=;
        b=c9YLxGNK05/ORAplEEI1BGNOgaL6wJvWtE0ob8BU+upNI8ov+w0vGCh4MLug6l9QBo
         vEfplESi5Sdk33n3iomSrlw+oE+uBfElsY7w+duRTkzt9ut4deBhbSO9YvCymiqO+5h+
         5YqMZ8w8x0mcyOdkE0vNPkaXmza/3ljD2yOpDA0/xjOO8Vtizb9keR9hsyaAjC/O6yfi
         nc+mmQ5N33h4p9TJ+yq/j/QOyEzhV4Qfdp1uVJ2XhSxWSL8/pFLh3AeG7a65FpBD5NZq
         5WfAMOxnGVupVaDi2QHwWakSByXS96BNPVZA5dxd/t6qhiTCMClc6J9nfqjKz6DKNTqE
         UVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jI6bJznoT1kUHH+hGFs83qAIbvycj3Rophq/FX+N/Y=;
        b=GhjDmCSr6oe6y/Nxh/1jD5nrrwFNT2FttKfUS1mXuO9np6ed4J8jtOwIaO1R6JJh+4
         qS5F/a9pDQzt1a3Ol4RSK/WHJ8Cw53RRxsWekbvnXhq7Zfj0wjGWvhsPMRExrg5iK0Pm
         Mv1W3HWAclneeXdB6txNkuHmABnKWh1m492GihMPk6+I2MJN43qL6wW+zXOpE1sBO4NJ
         xm9sbxQEBpjTRbc8nyZlIwzz4E9IDfTBuD8QHLn2/ufzmqwGREROtrmP2pXO3Fr6Rz9Z
         qS8IS9VU2AlaVWftsSnf08Sso9RPZa4k6RFWshZkkMt7UEMAnVOBpoky37mkm0ZMH++O
         8tOg==
X-Gm-Message-State: APjAAAVa7WJfJfix9AMsFwGt6uNZo6h3JoXoKtdWSlH9a1NKRHY5FOkO
        HRCPxSng0+AsilmCEQGwMhZ8W/dU
X-Google-Smtp-Source: APXvYqwxasokWx4yTa94DCIuoY//V0VDy3ysx84Ef8Nn77d66FR1dsGUM6Oyrj4CuHHYNpj39Ph+zg==
X-Received: by 2002:a17:902:381:: with SMTP id d1mr94834754pld.331.1564156387148;
        Fri, 26 Jul 2019 08:53:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:06 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 02/20] merge-recursive: remove another implicit dependency on the_repository
Date:   Fri, 26 Jul 2019 08:52:40 -0700
Message-Id: <20190726155258.28561-3-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d7cf3a96e9a0 ("merge-recursive.c: remove implicit dependency on
the_repository", 2019-01-12) and follow-ups like commit 34e7771bc644
("Use the right 'struct repository' instead of the_repository",
2019-06-27), removed most implicit uses of the_repository.  Convert
calls to get_commit_tree() to instead use repo_get_commit_tree() to get
rid of another.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1163508811..37bb94fb4d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3571,8 +3571,11 @@ int merge_recursive(struct merge_options *opt,
 		repo_read_index(opt->repo);
 
 	opt->ancestor = "merged common ancestors";
-	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
-			    get_commit_tree(merged_common_ancestors),
+	clean = merge_trees(opt,
+			    repo_get_commit_tree(opt->repo, h1),
+			    repo_get_commit_tree(opt->repo, h2),
+			    repo_get_commit_tree(opt->repo,
+						 merged_common_ancestors),
 			    &mrtree);
 	if (clean < 0) {
 		flush_output(opt);
-- 
2.22.0.550.g71c37a0928.dirty

