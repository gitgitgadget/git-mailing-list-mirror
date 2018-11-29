Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2799A1F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeK2Lbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:35 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49044 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:34 -0500
Received: by mail-pl1-f202.google.com with SMTP id m13so113800pls.15
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yiW8lXiaLJEOVYH0TLWhnHJ69Ec+jl2zbZwFM4K71ew=;
        b=Jejvayay0q0sv+bDQl6zh6j/ncT1AwPgJQx2pvoD6tFOmMm3ttOrtnvSU+5Pd0PxQv
         2RNQw4nACu5QRxGTVgprUrIjfosMHtZLN1VIv0j6JXx8JwEWCjBcpZ6l4jr0kpGqAtnl
         K1vU7ntExsJGP6F9hQ8ezlmbWiFeUC00hFSgVyQPAhh6xoctbfiI6VgLdXjcoY70hZ4Q
         rpasV5J3qQ97QjEuU8sEu/zx4q9PwPXJCEJdyFtiypfsNjSmisYoODehM8XmCh8sYB+f
         bSxYuLlsKUcVVdVXl+SCpvDclTOvBmGfe4KwbngZXsygbNGS8qzPLGVxM1m/twFvfqLW
         hG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yiW8lXiaLJEOVYH0TLWhnHJ69Ec+jl2zbZwFM4K71ew=;
        b=RnMEDdwWxIqma8xxJEam1bq0FuJ0PUuf0EA9exZGoD+7kU8jSsStpORuPAV68wSzL3
         s+DzmB7buv0sHotOSaTaJbXP2m8nFvXvLp3LBTN09W9VqMSZCl4Aw8RpRkFCMnl7QLQ7
         m15W4c1TkwmzGYNyHxjC4zZGnNSZmh2isrJU9K8Td+PvDIY54QQeXf2nSjKCA+ku57BX
         cjtgQDPsCLjHr4ndA7suWMrpi5keoiyeQv2ZwWdKWP3x91CwE4EroC8YGwvQzj17yoe0
         cIH7EFdlUftjHEWzUOJMZ+wP2RXK92ZvcgngOVJ3t+mplcAsbgbnytulnLEEvp8THJZu
         7ZDg==
X-Gm-Message-State: AA+aEWa6ygERGceJjfuYrWU4vmvk5gUCEmZXGAP3RVN790skCcrvttmQ
        NLCsqndsQgDEliyAm+5uDMQesj77as8UJPy6VSM2xgZrUvtaV5jDbrwUt95okamZv+MXCyaB8un
        cDuXq2ySjpuqKWQrSwTnk89Y5g+0EkBoQXzTAH+ysjHab2g3Z3lSVWAef3C3y
X-Google-Smtp-Source: AFSGD/WRZLwZTsv3A0iZhCPVgBSENQ1RHR8OmTrgM/hhu1goDvFdFixLR5+Eoe0VaQ41GxEovFwKFzQq42nF
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr2948784plb.126.1543451287601;
 Wed, 28 Nov 2018 16:28:07 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:50 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 3/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index bc48ea3b68..3c388f85cc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1283,7 +1283,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1377,6 +1377,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths(r);
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.20.0.rc1.387.gf8505762e3-goog

