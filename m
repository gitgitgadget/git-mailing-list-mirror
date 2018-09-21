Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9F21F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeIVE1a (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:30 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:54335 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:30 -0400
Received: by mail-io1-f73.google.com with SMTP id l24-v6so25715487iok.21
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1V9VDzgdE3qRBsghEtQGr9pDi3zbWh6RGSxhIhwaeWg=;
        b=TkWtgd6dbUzglv5Ud7UQ588UGdV0OCAsPihSPJ6iNoem9NBhv9aWzyF8EGaauXNYcV
         FUfCzcpV9i4zu0OTSLr13ks6WLRWfxazakMGUD9p6bNvBf4fMZuqPOXIVayyjJjBZ1FY
         Za/fUmnnFiGhBU/pCNp+yC607nuwOdf4M4Wy8Z3LXV4wlAq/TGV23J1/KQOrs905fY3G
         gUHB+EDd8Pe2uNUuQqXO2gVgV1Eu6qLpiC0FedOolAYE9DgtVfpzvqVWs8xFjJJZJdJi
         dOfaO3rioDnRQgVTvnDwQgcU9AvlgLCmI6xL8BY43JcyW10GJKDsIQjCqXR3K+gJMkB+
         Onig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1V9VDzgdE3qRBsghEtQGr9pDi3zbWh6RGSxhIhwaeWg=;
        b=n02loM2yqayf1zD188tCEKylxDujrz45gMohlocnOXTu7/klvcca8Cpn7DCk6LIg2f
         BmNmkgzn51hD9LVnUgahni8Xw8TdtcrW4cLHl+EqXsi9Bt/A0bBm7dZSavFqPswyeXjf
         xOuJrr3FN8vki/eFq/iIRNgx5OypLDjW7em4jqK9Hk+Q80RKQGeOMwlD5FE1TJt0moev
         ZVXVPwFNnEzOmpP+BRFTF3VRvR0UKxaj5CtAtDeE4t3IYanXHZ8gUMrNE9UhXVHqRsLL
         3ATTyO45bVqVvBKkXUQZ44fnRruhcINyqgQ54RyCmDZhXHVuXcKit/DIKeqcMhBfi5ZK
         gy0w==
X-Gm-Message-State: APzg51D+EQZP/X6gNji1Ws8Y8dtyLbEx2wONQzJN29rHT7gJTjk/hvXF
        be8i2+74cXwXpxKOF//MeNSDUSDwvR9eAcCzg8wseSyTOih5NEGlmVkM5cMn1Krypn9XNN/bLWY
        ywUq9ntYv76zlEJb+6WI63p0ksQ+aY8imwOYvrRMRTJsMoiRo73qNTyUlE7Si
X-Google-Smtp-Source: ANB0VdYiPmpol44zIuOxy7Y7HbsUyPKMDqWixr3CMkgDFDBrGtOYrFGiwroxFKRWrsrWEkHm4Qfn/h462g6x
X-Received: by 2002:a6b:da12:: with SMTP id x18-v6mr36049221iob.28.1537569393653;
 Fri, 21 Sep 2018 15:36:33 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:53 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 3/8] submodule.c: sort changed_submodule_names before
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

To pick which one is more appropriate, we notice the fact
that we discover new items more or less in the already
sorted order.  That makes "append then sort" more
appropriate.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 67469a8f513..2f5c19d0aac 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1257,7 +1257,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1351,6 +1351,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.19.0.444.g18242da7ef-goog

