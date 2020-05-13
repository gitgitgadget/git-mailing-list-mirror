Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC5C433E6
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAFB20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Yod5hT22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgEMV7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730414AbgEMV7k (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F32C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so11567018pjb.3
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sf1HBH3Ck8IGRfflAMUNqcEFPomuAfRvMrpebeZSgpM=;
        b=Yod5hT22WVBxfLDaXagw/8Z6sbqEoesMsovsRV9L4AGCLkbT5lzIWkQLmKT/ysP4/S
         93w2oXByZYoDeldHZW2Vza5rDz4SrTyVNhuXUrVTuOrWkmaGmeR5rLX23Kn3un577SeB
         q0yFHD/WELJJ5x1nZWJOUD7MGUGyIawc1Xs3Qh2bJ05/BdbFUIDW0teayKgBw5MS6zQj
         jVjX25pMSFfyZ5Kn6/DyMaGCGg5YkAVDvqPRl9xfUCDgWjagObq1oiyStKsj4Yvg/o1C
         VTNoeBP5I59XGJ5wvAFvHHNnfYxhwiCCchM8jpCmuR9G+rhKxyI4UCjQR51zTiUuOqU6
         lzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sf1HBH3Ck8IGRfflAMUNqcEFPomuAfRvMrpebeZSgpM=;
        b=Pdlj01LYaeM+lJYRhMbY8adkjVyIAg7SYmdbbVGHHN2qfob7hS6FcrSOBn+KRkN6YI
         W0bcBYtg9aqDKMBxV2t9AnLb0xGsv5S7RR9kPBeGV7s4XfCQGKhFBdg9nVMrRpgpG6yA
         rRJx00PsL7INIau8tsFGyZmUyrwfiG6b+Mj6RIXyZt9vM2p66rIyIk4Y84dBRKAamZ5D
         p6KgK7iAj6Bu0ADkyDvIMLc00hPDZAnocvKEnSpKcWsjPoTdsiWCJ5XTrYPDKMcbBKhy
         e1nhrrNZUsPIgjCLeLbH8+VjS6SwkdM6RBGhpBoIa24xiPnyKAGOs0OhQlg9HxKE6zY6
         hUlw==
X-Gm-Message-State: AOAM5302Yjj7emM4Ju26TtUsq2kVPjeBSJrwdwlfGzKe5ju2eHxO0MdX
        4W6iyAue2FdkjyyOd96Ci6z8aNNiHs4=
X-Google-Smtp-Source: ABdhPJxeUjAlET1pHAs1+9T1XBj5y6yMkFLqij/Z62aTDfRHhrpBwac50DwL8GcL5KLMbGs85agi6g==
X-Received: by 2002:a17:90b:887:: with SMTP id bj7mr4633130pjb.186.1589407179454;
        Wed, 13 May 2020 14:59:39 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y10sm456643pfb.53.2020.05.13.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:38 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:37 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <74b424f1ac8168f599c73364e42581961ab2c6fd.1589407014.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating references (to discover the set of commits to write to
the commit-graph with 'git commit-graph write --reachable'),
'add_ref_to_set' can save 'fill_oids_from_commits()' some time by
peeling the references beforehand.

Move peeling out of 'fill_oids_from_commits()' and into
'add_ref_to_set()' to use 'peel_ref()' instead of 'deref_tag()'. Doing
so allows the commit-graph machinery to use the peeled value from
'$GIT_DIR/packed-refs' instead of having to load and parse tags.

While we're at it, discard non-commit objects reachable from ref tips.
This would be done automatically by 'fill_oids_from_commits()', but such
functionality will be removed in a subsequent patch after the call to
'lookup_commit_reference_gently' is dropped (at which point a non-commit
object in the commits oidset will become an error).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index f855911320..e7de91f0f1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1328,9 +1328,13 @@ static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
+	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	oidset_insert(data->commits, oid);
+	if (!peel_ref(refname, &peeled))
+		oid = &peeled;
+	if (oid_object_info(the_repository, oid, NULL) == OBJ_COMMIT)
+		oidset_insert(data->commits, oid);
 
 	display_progress(data->progress, oidset_size(data->commits));
 
-- 
2.26.0.113.ge9739cdccc

