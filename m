Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC2C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB50C20870
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qyRx4Czv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgIRC7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgIRC7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288FC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so4674061qkc.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGfGCVFPtkhsPi8ZMCNg/ZVeSF6pajxzbPDE0d5wSI0=;
        b=qyRx4Czvnxggab/otKbbDivYLOwMQoD4AWIPAXz/iSuHjdjuFpReTbsLpEPaDsJv1p
         3ff6jiXugdEjSGseXhOi+SHG7Bw+GDOvxdWjLjQoIhXjeSGTf2CgXz0z3Ry/DvoGGR2Y
         obTmEvWD7qWdOKvqau9eN3GuGVbdgqEquJRGNq9+LIe12eH9jKHN2kqDRznrN4YKp7Jp
         WejOeUDC4x1fEN22C3wLvMidsAwCiK3r/BFSp62yez74gRbE3CxB7Nb2vfn55k0dnxe3
         JAGe2XwPyUIJCJJh+vtGIkN3NTLw3e8uCrJzihfrt4OU183m0KgGlbFBVZ425UZ+axGn
         Fp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGfGCVFPtkhsPi8ZMCNg/ZVeSF6pajxzbPDE0d5wSI0=;
        b=BvL+oivw8+mV3CIb6MZnMSxlkvJjGcJu0Zo2p/4HlT6Xbjzr4T0EC5Kw+3+3sDIofn
         neNBaou4yJHa8FyBsGLy8sKvz3ql5x+Mn0j+rmAB31qWBiJi4+Fm0OJxq5HQd28eYkLY
         fo3WQVVYXtnpfiDxu55pw71aDDjAIAiQ/cTjiLacKcEfsFOsdyPAdC5HvjhO70PaimIg
         Ga/v1PCp+9HoEkx7g8F9Lks6TrmPaew8J+m9aDFabzSW0fvk+qYQ9pFPPsBB0O5xP0vY
         Cw7utSMrNiK6A2MHfbSNwtlfMtrpQje8W+AUpR95k5K+EDlxD5QRb4p3Apev+miXkjE6
         ejRw==
X-Gm-Message-State: AOAM532McBsON7ln1S2m2D1Tst8qTWlyyJj/rDAwIja6EsjqAAmC/6dJ
        ShdAIBK2BD6SeIDORDFPV1o5E8XOqMrWwuge
X-Google-Smtp-Source: ABdhPJyyFGjwVoKKg6GD3JaCK65Mnp2YlTEHYQ0QJlVS8bEbzPZ4oXD4UGrpP8oVMOAoJbm4ceHdhg==
X-Received: by 2002:a05:620a:2213:: with SMTP id m19mr30544428qkh.472.1600397949848;
        Thu, 17 Sep 2020 19:59:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id 76sm1188441qkl.127.2020.09.17.19.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:09 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 04/13] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <e0a6484b693e46f848b2d86c4c3c9d6368d56e93.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.28.0.510.g375ecf1f36

