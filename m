Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B2C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DE120791
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eTYrmKi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgICWqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgICWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31AC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so4676295qkd.9
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2h+pY4m7Cx+NBzgbnkk/J/U9/BuYE7fviacZqf05fNo=;
        b=eTYrmKi0TPM0q7pGAihSseCTgal0tP1FlDyIpRit3AMdzA5u/4Y68wEX+hhjyYda5R
         gTlS9KCnfAcG5pBfnHl6i1jM9BNyMdWdvLBjQ5NlPrk3U5ZsGp/Zzmnk263YoH9s0dqO
         A5rcsKtPQPK3af9Wo7yf4rz8+k4STOzJfb9ZKelTI6EaaRZ/bxlex9ucxVzhoL2AxQpj
         G6QPVOyXg2OLQWph8N04ApD2PwGlETbCICEgkB2wSpyLFjimmb49Nb5CZ5MpTSBCFjcT
         xfQv7IrJhvKmGwccyr7kGq8eRTGrqQbcWZpYI/hx6cAIy67XEFIXbs2vJfJECxVX1/Uq
         KaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2h+pY4m7Cx+NBzgbnkk/J/U9/BuYE7fviacZqf05fNo=;
        b=nRwsvcNRUPmBEF6f8b2ycRROzNMJPWAhUUPawsOUuor69ZT5GhfOrMAdilnrtB7h37
         ATMVC75JzuUlJdyriOsVMT2Uxlkix1C/8LRYBWhLndzdJiAlVrCQts61D4i+GsR++BoW
         0Ktpgz9mxK2Aizv9eFKQx/4mbLASKBq1rcw3iGhV6GXKjWoSYl2QQ9L7ktcExzOU2NCT
         XWFLQhIKGbHfCzpP7MowBDXtLT6DusOT/ZljViLkcOWOZKLdR7qjVILe7gN5SfvTM/+L
         IeBMzkGbBBLHX+qzrvMQdsj9g3/3ZuqiitTIhR3msbH+yp8NLslBpXnLxlTJjYxKyYb8
         TWKQ==
X-Gm-Message-State: AOAM531ZVteW5P+nSCAqsO64aQy+RGawDC6IjHK/K9s9tKk9Ln3FAKH2
        9slg2YH+YvXFsWyU875n41vgH/osvq+NG248
X-Google-Smtp-Source: ABdhPJxwdzCIzfPU3zLs1WQnqLqfbqmUSsdERQmTDV8MeWktKxLaP5EBIGjAcy9iJglkQHDk9qMxGA==
X-Received: by 2002:a05:620a:21cf:: with SMTP id h15mr5367493qka.123.1599173177555;
        Thu, 03 Sep 2020 15:46:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id q142sm3065593qke.48.2020.09.03.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:16 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 04/14] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <ccab59dfe4b2c1102c9f48f8205b8c01329ce1ac.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
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
2.27.0.2918.gc99a27ff8f

