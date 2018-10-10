Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287121F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeJKFOY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:24 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35769 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:23 -0400
Received: by mail-qt1-f202.google.com with SMTP id s56-v6so6741590qtk.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hqZc7ihSQbUNrkq0Y9fju6ghoKYXJorGJuvYpPGIIwo=;
        b=dbSP+nNpT7BjYhYoIi8x4Blqkg9SRuekQg6RwUVC+t+Z5dNMcihxE2FlvRGviyK2hm
         RFOHdanhN+NHKWb6M6eXzcX04PYpKBYdtTsbNDU5p8kj4LBYNk6BqOvKZknC+BMBqBKw
         r32M+Lvqc4ycjh4EdrIbFqnrW2ApFAu2rv/B3PFgOAGF81Qm/t7NeVvIrUyNoLLIruzE
         s/QWS26ieWCdO6ypV2XHEWPULUTsFThAdVZflig5mOk16ZhCLbbI54jFMjk6h+qjc875
         FcYt5nz/lZzc/TyfvbPzYQnNurLvgWMsfPVWoQgJ/LJsjTpQ0JPOD99dcYB3mAAYXQeK
         cY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hqZc7ihSQbUNrkq0Y9fju6ghoKYXJorGJuvYpPGIIwo=;
        b=VFgoOr3VINNNUewMrQiWlDx3oLbc9Vu7PCaaleOxTAoRilwyZeABRmvyUB/Axm+3O6
         PvJpuZ4EB3I1j4ABdrleXbPWOsNyMuZDXIT8yDjucrb7AUQHMZPEwDkmaoKYGxE6JgTH
         dbdyb53+pV6EPV0nD3lmXiZGa3dbCDFPmKhE3C4F1h4dGzC2zFGyG2YO8J3yCTXXSilm
         m0lRLBQVXpgCkqA5sOVrvDPyVIS4kFoxaDOHuUKuDDu0hyzkfvbMXqBnhrsl0eAoJZ5L
         OQ+KpcrxrLDl4tGI+rbIucyr+3WwQ06ntQznJ3d/tTD84loa0RECeQqyKpspOkgdIrYO
         RWAQ==
X-Gm-Message-State: ABuFfog1J1kxxK7Z6IjJH4qqij2IXQqObOxf6ATQ0C7RdR21wkdC3gEw
        LEaM0KvYYB6nu/YwLhzQuEYdSvG6yRXmOsWDsqu9CqIjUsMbhacPNNCpcbEzYWvUv2h51Cejr1M
        EYF1kXJG7iykgLI5zOgN/eybm7bG1BvMv2c94QeTAbJlQCjXscDCvf+RBVJoQ
X-Google-Smtp-Source: ACcGV63p78eT3vGjMbNJT1RQCFppY3WZsxH6jwb9wRPQYRV7qHV14b9HvRuoXQdcSEgIft6Ysc/safAwRXy2
X-Received: by 2002:ac8:4108:: with SMTP id q8-v6mr634753qtl.17.1539208218171;
 Wed, 10 Oct 2018 14:50:18 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:02 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 3/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can string_list_insert() to maintain sorted-ness of the
list as we find new items, or we can string_list_append() to
build an unsorted list and sort it at the end just once.

As we do not rely on the sortedness while building the
list, we pick the "append and sort at the end" as it
has better worst case execution times.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0de9e2800a..22c64bd855 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1256,7 +1256,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1350,6 +1350,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.19.0

