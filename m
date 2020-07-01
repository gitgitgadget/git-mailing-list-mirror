Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0698C433E3
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C162206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmMHbtWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgGAN1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGAN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292BEC08C5DD
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so20819178wrw.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iUyFBGxnwdMin+a/xSqjifthXnKIurR1IAIYpOpNFqk=;
        b=CmMHbtWOUJyx8rOL/ru3UmnbqtwQ7KFdxF/Uj4fWf81hsCYQfVux5oKwCKecT1bujb
         t79Z86aB7+71zuc4Z/oRTYrTR+n1rmWDxXiE+ec1w7YFwryt84xemWi0yhU6wpfsefvr
         xva/H7Ks1djcJ7wSHQUGpxlZfyFc5dOYqmJP4x/etaZDl/aiUmuozRRy7O68DKk0h6al
         NZ86Jj9nQljSX7/lZ8NiyxRBzqXOAZgOgNlzDq9qFDyc8Zynp02Sn9PXPQRNvPczjxXX
         EmL1M9jLH3PYzQmz2VydFaOfpwEvyiOLf5DcZmhHOVgkembArJBq/8eygXVAK0eODRKC
         rBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iUyFBGxnwdMin+a/xSqjifthXnKIurR1IAIYpOpNFqk=;
        b=d5LxiQ7LoQ+Js2JG3uuiD4zS6wlQxY8NBwnWDswdsdSNIFz89/rR0I0V+uhfiur6sl
         it16jbEyUrvbuETUQ7itdPw3p1+zJwQbjg/g7CIHZCL5sv4lF22HhQklnVhcvWK9Lb1Z
         cNYCyrsPefaS9YY8FFP2Prw528/WKAv64lLQPsYLIiXNhhpN3t4pXyxNEkREYc+i664Y
         u7k6L5PfFPRvRRlboqxXaNrfdBulA9rF5i5cQDU3okoV9owYY6T5k9yygV9fE196wOTC
         5eIW+aG+iVahqVfh/8LQ7Rf9AEOyGwlwBPsMabWSXfG9855nPh+7bm8U01OPOpisg4Ix
         XtzA==
X-Gm-Message-State: AOAM531rsxeCarEpRLxFMbuw2t1YC6YUkNI8V+8fMDzsPtGyvRtMBpOI
        TKNU656SZrKZwPy5z4g2YFC7EJsK
X-Google-Smtp-Source: ABdhPJymVxnUpFqkYt9dV71WobbPFgMmLO1A2QJ97J+72sTEgru2nrLVjv+3RTEjpa1/cvptaD/fqw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr27467257wrn.398.1593610057747;
        Wed, 01 Jul 2020 06:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm7401076wru.38.2020.07.01.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:37 -0700 (PDT)
Message-Id: <b982c9bf80198506e3179badd12c63bb2566bc6f.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:27 +0000
Subject: [PATCH v4 07/10] commit-graph: check chunk sizes after writing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In my experience while experimenting with new commit-graph chunks,
early versions of the corresponding new write_commit_graph_my_chunk()
functions are, sadly but not surprisingly, often buggy, and write more
or less data than they are supposed to, especially if the chunk size
is not directly proportional to the number of commits.  This then
causes all kinds of issues when reading such a bogus commit-graph
file, raising the question of whether the writing or the reading part
happens to be buggy this time.

Let's catch such issues early, already when writing the commit-graph
file, and check that each write_graph_chunk_*() function wrote the
amount of data that it was expected to, and what has been encoded in
the Chunk Lookup table.  Now that all commit-graph chunks are written
in a loop we can do this check in a single place for all chunks, and
any chunks added in the future will get checked as well.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 2b26a9dad3..6752916c1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1693,8 +1693,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	for (i = 0; i < num_chunks; i++) {
+		uint64_t start_offset = f->total + f->offset;
+
 		if (chunks[i].write_fn(f, ctx))
 			return -1;
+
+		if (f->total + f->offset != start_offset + chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    chunks[i].size, chunks[i].id,
+			    f->total + f->offset - start_offset);
 	}
 
 	stop_progress(&ctx->progress);
-- 
gitgitgadget

