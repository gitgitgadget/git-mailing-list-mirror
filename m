Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D2C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DB823104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhASX3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbhASXZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41736C0613D6
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:16 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j18so10062159qvu.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYijZNcLlp7HHkwd/etFfg07yHQuIff2NXDeqICmuX8=;
        b=dwSGCMUsuV+LrYBuvUiCPwh2wPGjHVmTjdmtT3EmlJQ+0BgNAKbwV0jSInhSD/Kehr
         cx8kybV4gdMogFRg+4wLxnlOaqdk4Ob2IltPUjDm47crRJYVfguags9xSL/jRlSCLuuC
         vbqCppsngDivvUMmoL6JfJ7Qu5+M9VZInxZM+CZTKnGfc0vN+0ad+ukELGRhxHjCnjBD
         EAze1W1wK9dt512VSeqyxIq+qSQA06Df2VhyQ+E4VeGhFJR5Vm0nOM2LKBBDbdVTAo6p
         b3EW27x4oFvtnrvYKkngJUvgDg3i5+DrHwFAQc5tQzRfZXmNWIwsqemOfNGYIZ6hcHdq
         xw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYijZNcLlp7HHkwd/etFfg07yHQuIff2NXDeqICmuX8=;
        b=deZ5pOh4U4sNlnkZPuwlJGc7fUpQa9mkQmyDe9sbCak8yOQ5cDON6D7+G8Gx10IPng
         pRJbrPJUl/+nQOseYxSt5/5ToYw+c+QOxW3gm3SeDukZuWgFe8NpQknxs+iysYWZgTN0
         uhtw4QszTuu/UrG0ho1qWncypCgkxRG18EXrJdHgoguD0ei3YzCpVJNnf+Nec3izE8YZ
         aha5jIc3FHaFByBN4PjxDIAoJHyDOuQnGRPmBkRoq5dwEk/MCdPQFHaOwsRznDehj2bB
         sGGME8sQnslkFQ7J9nSFPimTUqLzrwdkw0JZyek3wiD9maCRDlg6nx26Xyy93vkLXEW9
         gtxA==
X-Gm-Message-State: AOAM532u+H+hZR/7wRo3Zd/02qn7BvQfkdqLCyFaiaiVw8C7sUAtC+5j
        nc8PoB46L13SX5n/rpJp7BwhqvNPRw9NbQ==
X-Google-Smtp-Source: ABdhPJwhMxdG2ZzsuUIjtMheMEHOrRzV2G/hMxCKs2pkL9ErVqrYo+p6KgjYJRjx0IoUgWJnXdP91g==
X-Received: by 2002:a0c:a525:: with SMTP id y34mr6929954qvy.37.1611098655341;
        Tue, 19 Jan 2021 15:24:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id p75sm177300qka.72.2021.01.19.15.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:14 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 04/10] p5303: add missing &&-chains
Message-ID: <26b46dff15ce89f8ccab3866a0e230d99c538697.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

These are in a helper function, so the usual chain-lint doesn't notice
them. This function is still not perfect, as it has some git invocations
on the left-hand-side of the pipe, but it's primary purpose is timing,
not finding bugs or correctness issues.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index f4c2ab0584..277d22ec4b 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -24,11 +24,11 @@ repack_into_n () {
 	sed -n '1~5p' |
 	head -n "$1" |
 	perl -e 'print reverse <>' \
-	>pushes
+	>pushes &&
 
 	# create base packfile
 	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack
+	git pack-objects --delta-base-offset --revs staging/pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
-- 
2.30.0.138.g6d7191ea01

