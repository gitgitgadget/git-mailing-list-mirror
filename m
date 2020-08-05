Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744DFC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5027722D2C
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mu0anZHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHERHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgHERCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD010C06179E
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so20167109qth.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=mu0anZHrAUBYnXrweJLqPjOiAxQc02RceY2O+269/Cgpl5P4CtCYThG/Vfw5fkhGpl
         OjpyE5jqxQkTrXpnG7QxncFN8yeGVsPGP3y5r3KE/tLhK1Ucy7RnlUNGNr9aAkkOpeOQ
         Op0nPK8ySsrI7fF/R4BN5/79fzqpgMT3fMwPs8T70TPL+j7KXuMW9/zPoeq4fM9ONCTj
         gWkBxSFHV2cmkCvkrafEy/RuTMx9nNDq/RCkis+4dY+sBnrUiJEHw05uvVV1Jd83UVut
         geWHPLQsoy1d1Bgu2jN8qz41iFmRFic+TbactpwzkwYDUFF2OlrdqchIdqPhowQd2DCd
         tPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=L0ROvhzIwEfsYNhcpJVZ5HpdyYp6tRlCgz/j+ttPCTSaBHs6buxkSz6Ng4bHQMBmSR
         VHzkpp4O2RbYYT5zHHiXFWt+d/R75d5fiT3M3Esr/7sRWL958qwhxeJMQjOzuJomOA6J
         g69GtnpR3HxEFazW6Oj3cz+VnfQyr77GPYF2Ld8cGUhaxzWkbQUwxYmL9co8kBGISJwn
         HC3K/Ewox75EjfwNY3T0+JFFNtcr8B7xMzMIgvkOScYpGXnsY7C9cF4nonjzp2qU/WGp
         PMth8IjhCttzRxL1rt0mdgXPUvBCJN83nR879vUhnG4I7iHPr/JYYsxDR5IgdrXxMhlD
         CzvQ==
X-Gm-Message-State: AOAM533jEX275BAvRb0Zu/1hmNWlH3OldHK43MhxpUpH8wXGpCzCqhLo
        wqVz7wdX90JN5q9w5WJKPs5jRzqWPMJvhw==
X-Google-Smtp-Source: ABdhPJzXTfocLWlEWnlDDFqRYsrmZdLbyeSWk/S6WImBC60CYUYs7kjVzCNaukLPfiPoyu6v8mHblA==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr4385355qtr.254.1596646949619;
        Wed, 05 Aug 2020 10:02:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id b131sm2094753qkc.121.2020.08.05.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:28 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 04/14] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <038e996ced8b7c6418894a791caeb7f80b2456be.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read-graph test-tool is used by a number of the commit-graph test to
assert various properties about a commit-graph. Previously, this program
never ran 'prepare_repo_settings()'. There was no need to do so, since
none of the commit-graph machinery is affected by the repo settings.

In the next patch, the commit-graph machinery's behavior will become
dependent on the repo settings, and so loading them before running the
rest of the test tool is critical.

As such, teach the test tool to call 'prepare_repo_settings()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-- 
2.28.0.rc1.13.ge78abce653

