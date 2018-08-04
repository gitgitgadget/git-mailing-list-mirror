Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F4F1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 05:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeHDHg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:36:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34580 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDHg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:36:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so5557929lfi.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSjrizYrIiCVEWEKREe50syQMPJvmoDH0OWAldXqojc=;
        b=oJCLlU3JWQKn1eawMlxlzdyseut7mthGzH7sA311MOgnfxM7owFT7QCMeQUvxLrDQi
         wgfPzTdDDqRzWElf6oWDQ1RQwa5Z1440hNf9v1Jk58IxxDkOkLfe5JlsQQkUTl/oV+yh
         8Xymt1NtAbwBtbt+O25aUwUnRLSNNZ+f9I7cB0s8tCSPFUmM24N7NWX0ubA6cZO81+YP
         du/8JMByYRR/SJ2bHIajrQWvjtSK76e0FpfsFOHGlMGRMGPjnw1qyZ247keCC9W5rIiI
         O9qXY9I8X+CdOxUhMLvGl4bDSz1H4yqAjveiUH8qB8KcCLcQLcVpwF57CAmJi8xa/ktp
         hDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSjrizYrIiCVEWEKREe50syQMPJvmoDH0OWAldXqojc=;
        b=MQoJY2HVmf0+ojUZZRvPfWfUjvkMcErigjcEznNfHSSq8jRAhOmSeX/SJVpcVIfuUu
         2vMQX+re4tUR7ZO6rS8UzJzQ+hPuvCt61G7l08MrQc91+vkqEAoxT61FV+dZd/z30tpL
         Pv9b95+S0d8BovOmPwGp53NlcxzPwrvqWw7P/fjPi1Ny70DAW/EZ3RD1XdEta8vYE++7
         LNZ9GAjsg66QtRLTM+uINvAaF+gIm1SAslqcnh0azjgaU8whvE9UkIpCGr4Lx8T9beWA
         D5p1irXi9cKywIIgNc+UHOU5ETPSCR8fCuji3MhL6nVoEXztd/Tt/q10W0gyhQkmb6zf
         YhmA==
X-Gm-Message-State: AOUpUlEC58QqBO7I7tGtWb6n8EBRqGAQeGkra6TMeESc5tsbCqP2JVH3
        rbkjhisD5LI1OKtC+7iL3hk=
X-Google-Smtp-Source: AAOMgpdeifA1Nj5GmU6zJ2H0gmYFPOFgCxnHWC4wZP1khzPqbHP7ovmjhjO989xKk9DaGYiVVE/YTw==
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr6515801lft.74.1533361051368;
        Fri, 03 Aug 2018 22:37:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 85-v6sm1044021lft.76.2018.08.03.22.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 22:37:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v3 0/4] Speed up unpack_trees()
Date:   Sat,  4 Aug 2018 07:37:19 +0200
Message-Id: <20180804053723.4695-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180729103306.16403-1-pclouds@gmail.com>
References: <20180729103306.16403-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a minor update to address Ben's comments and add his
measurements in the commit message of 2/4 for the record.

I've also checked about the lookahead thing in unpack_trees() to see
if we accidentally break something there, which is my biggest worry.
See [1] and [2] for context, but I believe since we can't have D/F
conflicts, the situation where lookahead is needed will not occur. So
we should be safe.

[1] da165f470e (unpack-trees.c: prepare for looking ahead in the index - 2010-01-07)
[2] 730f72840c (unpack-trees.c: look ahead in the index - 2009-09-20)

range-diff:

1:  789f7e2872 ! 1:  05eb762d2d unpack-trees.c: add performance tracing
    @@ -1,6 +1,6 @@
     Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
     
    -    unpack-trees.c: add performance tracing
    +    unpack-trees: add performance tracing
     
         We're going to optimize unpack_trees() a bit in the following
         patches. Let's add some tracing to measure how long it takes before
2:  589bed1366 ! 2:  02286ad123 unpack-trees: optimize walking same trees with cache-tree
    @@ -32,6 +32,24 @@
             0.111793866   0.032933140 s: diff-index
             0.587933288   0.398924370 s: git command: /home/pclouds/w/git/git
     
    +    Another measurement from Ben's running "git checkout" with over 500k
    +    trees (on the whole series):
    +
    +        baseline        new
    +      ----------------------------------------------------------------------
    +        0.535510167     0.556558733     s: read cache .git/index
    +        0.3057373       0.3147105       s: initialize name hash
    +        0.0184082       0.023558433     s: preload index
    +        0.086910967     0.089085967     s: refresh index
    +        7.889590767     2.191554433     s: unpack trees
    +        0.120760833     0.131941267     s: update worktree after a merge
    +        2.2583504       2.572663167     s: repair cache-tree
    +        0.8916137       0.959495233     s: write index, changed mask = 28
    +        3.405199233     0.2710663       s: unpack trees
    +        0.000999667     0.0021554       s: update worktree after a merge
    +        3.4063306       0.273318333     s: diff-index
    +        16.9524923      9.462943133     s: git command: git.exe checkout
    +
         This command calls unpack_trees() twice, the first time on 2way merge
         and the second 1way merge. In both times, "unpack trees" time is
         reduced to one third. Overall time reduction is not that impressive of
    @@ -39,7 +57,6 @@
         repair cache-tree line.
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/unpack-trees.c b/unpack-trees.c
     --- a/unpack-trees.c
    @@ -170,7 +187,7 @@
      }
      
     +/*
    -+ * Note that traverse_by_cache_tree() duplicates some logic in this funciton
    ++ * Note that traverse_by_cache_tree() duplicates some logic in this function
     + * without actually calling it. If you change the logic here you may need to
     + * check and change there as well.
     + */
    @@ -189,12 +206,3 @@
      static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
      {
      	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
    -@@
    - 	uint64_t start = getnanotime();
    - 
    - 	if (len > MAX_UNPACK_TREES)
    --		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
    -+		die(_("unpack_trees takes at most %d trees"), MAX_UNPACK_TREES);
    - 
    - 	memset(&el, 0, sizeof(el));
    - 	if (!core_apply_sparse_checkout || !o->update)
3:  7c6f863fc0 = 3:  c87b82ffee unpack-trees: reduce malloc in cache-tree walk
4:  6ca17b1138 ! 4:  e791cdfc82 unpack-trees: cheaper index update when walking by cache-tree
    @@ -40,7 +40,6 @@
         attempt should be on that "repair cache-tree" line.
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/cache.h b/cache.h
     --- a/cache.h
    @@ -119,20 +118,6 @@
      	free(tree_ce);
      	if (o->debug_unpack)
      		printf("Unpacked %d entries from %s to %s using cache-tree\n",
    -@@
    - 		if (!ret) {
    - 			if (!o->result.cache_tree)
    - 				o->result.cache_tree = cache_tree();
    -+			/*
    -+			 * TODO: Walk o.src_index->cache_tree, quickly check
    -+			 * if o->result.cache has the exact same content for
    -+			 * any valid cache-tree in o.src_index, then we can
    -+			 * just copy the cache-tree over instead of hashing a
    -+			 * new tree object.
    -+			 */
    - 			if (!cache_tree_fully_valid(o->result.cache_tree))
    - 				cache_tree_update(&o->result,
    - 						  WRITE_TREE_SILENT |
     
     diff --git a/unpack-trees.h b/unpack-trees.h
     --- a/unpack-trees.h

Nguyễn Thái Ngọc Duy (4):
  unpack-trees: add performance tracing
  unpack-trees: optimize walking same trees with cache-tree
  unpack-trees: reduce malloc in cache-tree walk
  unpack-trees: cheaper index update when walking by cache-tree

 cache-tree.c   |   2 +
 cache.h        |   1 +
 read-cache.c   |   3 +-
 unpack-trees.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h |   1 +
 5 files changed, 158 insertions(+), 1 deletion(-)

-- 
2.18.0.656.gda699b98b3
