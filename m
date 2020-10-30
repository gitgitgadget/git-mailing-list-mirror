Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7512C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBFC20731
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1LRAWPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJ3Dmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F58C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m22so4468560ots.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hZwJcXg1847bQW9TogQcVSkC6c9DjAnVbgCTnjPFow=;
        b=i1LRAWPOCHAbppDXDA4R5FYWGDlvODw32jnLB+HSVSz6GYJKP+JK5PclpxY6lG7x/B
         x8sWZKi0O6T8Tvwx4WmnTxfM4nme4J1rDTT1wn03Rq3eR+h93Utx5A5uh2359+XWe+uO
         l+SGzmbNsPd9e0XN75kAYXjlGtEsW/g4Q0PPI//65qRfmaaCgqQ2KTd8L5s1JVXIRw9y
         fwRahS7UN+ruVKW+kvTwp9z2/XIdRSIdTP7JGDtyLpuvDsS05zgHzmY6jx8Y+tjqv8vV
         2Lc57VWG5goTGKdNPbjXNsWjsJFXON7k86WCmGkYDB9nwMGRB7NrnuLbYMhzOzZsmTm9
         JeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hZwJcXg1847bQW9TogQcVSkC6c9DjAnVbgCTnjPFow=;
        b=i0v7L+/PWE1oyyDOU/87IMapF7Dc7rMQJgd60dzh7VcN3pVDLN9iZ3BOZ9XZ5Pp+Rp
         nJDp/ouCo6WYGZAX1ZbLueQYB7qjhdHBteeVPg6cbClxyv5MQ250yoc8eJGSoxgnaaRx
         9drqEXy9+gDxTXVvsJ91TCzbQ0CzZDl/92pPD97rqXSrWccRo7i/78WK1Xt1VlC9M+UD
         T50gMATHJeot9kZG/wME4fb7YKwR42dvPiTcyZCmEJn2HRRjP73T3k0Wnj9P4NnECP1a
         LK16FtfbT2UA+Da8F4cScv/ETh6PxhqrJcak1kCt/6tDqokjaRJX4SpGSvfW57D6/+sm
         3Asw==
X-Gm-Message-State: AOAM5303dqTVRjNJAAQTcQQLKUG5M7xMKYnObTwIjVSTBFJgONpFczA7
        Z/tCv9eEQYPZXHvRO4zqc2SH8EdUgqkIoA==
X-Google-Smtp-Source: ABdhPJy4g3eiy0fTfjL840BRMrCM09Cx9u0VbtXZuKNyoaXy7z0gHAOIUvrTKQA6ci1xXJuTsdFw+w==
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr195099otq.76.1604029300425;
        Thu, 29 Oct 2020 20:41:40 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/20] fundamentals of merge-ort implementation
Date:   Thu, 29 Oct 2020 20:41:11 -0700
Message-Id: <20201030034131.1479968-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on a merge of en/strmap and
en/merge-ort-api-null-impl.

The goal of this series is to show the new design and structure behind
merge-ort, particularly the bits that are completely different to how
merge-recursive operates.  There are still multiple important codepaths
that die with a "Not yet implemented" message, so the new merge
algorithm is still not very usable (however, it can handle very trivial
rebases or cherry-picks at the end of the series).

At a high level, merge-ort avoids unpack_trees() and the index, instead
using traverse_trees() and its own data structure.  After it is done
processing each path, it writes a tree.  Only after it has created a new
tree will it touch the working copy or the index.  It does so by using a
simple checkout-like step to switch from head to the newly created tree.
If there are unmerged entries, it touches up the index after the
checkout-like step to record those higher order stages.

In the series:
  * Patch 1 adds some basic data structures.
  * Patch 2 documents the high-level steps.
  * Patches 3-5 are some simple setup.
  * Patches 6-10 collect data from the traverse_trees() operation.
  * Patches 11-15 process the individual paths and create a tree.
  * Patches 16-19 handle checkout-and-then-write-higher-order-stages.
  * Patch 20 frees data from the merge_options_internal data structure

Elijah Newren (20):
  merge-ort: setup basic internal data structures
  merge-ort: add some high-level algorithm structure
  merge-ort: port merge_start() from merge-recursive
  merge-ort: use histogram diff
  merge-ort: add an err() function similar to one from merge-recursive
  merge-ort: implement a very basic collect_merge_info()
  merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  merge-ort: compute a few more useful fields for collect_merge_info
  merge-ort: record stage and auxiliary info for every path
  merge-ort: avoid recursing into identical trees
  merge-ort: add a preliminary simple process_entries() implementation
  merge-ort: have process_entries operate in a defined order
  merge-ort: step 1 of tree writing -- record basenames, modes, and oids
  merge-ort: step 2 of tree writing -- function to create tree object
  merge-ort: step 3 of tree writing -- handling subdirectories as we go
  merge-ort: basic outline for merge_switch_to_result()
  merge-ort: add implementation of checkout()
  tree: enable cmp_cache_name_compare() to be used elsewhere
  merge-ort: add implementation of record_unmerged_index_entries()
  merge-ort: free data structures in merge_finalize()

 merge-ort.c | 922 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 tree.c      |   2 +-
 tree.h      |   2 +
 3 files changed, 922 insertions(+), 4 deletions(-)

-- 
2.29.1.56.ga287c268e6.dirty

