Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA622C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2773206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCU0+jsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFOUPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B8C08C5C3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so18443935wrv.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BXbvEG1mPAB6ks0Qh70LXP21rPdKex+J/+/ZSvvTGvw=;
        b=kCU0+jswgO0BTsgmzODbZeNfHXRjAI6Q0HAxwzN+hg6Ilm+6frk3TGK11+F0wzbSC7
         cOE72hXw27CsSR4gW+CBGDQ2AGYVUFuYZSF6B5gkKmSjGEAmgMS2Qvqtc/0jXCOvVC1n
         I1hzVmQ5H9v53UjxR1YFywuV/k4jgkojauGCwBe4Cm6xpbfuRD3YPT3dKX2MYwnUbHOe
         +hBKZhzxFVdWXjjukTt4i7okvO3j4HxIvguEu0Hgfr8jek85+HjerC/xR1bKlCVFxm4r
         zi6heE2E1IlwCl8skK63hOPlCA1H45yKn4xYoTSfYocMkNUfzwwhOnx3QVZLZi6RM1dB
         Vr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BXbvEG1mPAB6ks0Qh70LXP21rPdKex+J/+/ZSvvTGvw=;
        b=XDxAsP787tS0Tz2Dmf9ZZMkYTX3UMGGmEi9paD1JWRISO7Ilv5R8A+u869T648Jkwe
         8cnSmph3fWVKJurT496JbpHkiUmDuzwtbqkBLSOGQoOXFvPlDgp8qxdY5dPAGVNQZVZC
         pl5P6FKwQAKNzngQFChqFqVxtxBnCtGzRtk3O40mUM4q89SEay1zq6uuadJFZjLj1qaF
         +oy24qOHOfqsZLEuJKofDzeaR8+RYLG8n1ak7Z9cD/p0VA2ji1AHLkTx59tQz7pQV+2e
         yis5brkj1FprbcAZ8JBJ1ZrKYolgXa9WsmsOdjmN90+VuIlIz5oxxclSjZyQU51VSB4R
         yKvg==
X-Gm-Message-State: AOAM533BXFChTZvsAg5B83y3VHQmukwBLdqo0GdxHYhlrf7ftiXlDl0v
        oPa9BUregNreadi024yS6v+zfnre
X-Google-Smtp-Source: ABdhPJyUxbQvfupgJhd1V7jg+hQcL09qyW3YDRzK/S1ECuMdaBg8x9okEleRpldflbXfj4I5ZK3VKQ==
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr29230480wrh.13.1592252098243;
        Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm25565847wru.33.2020.06.15.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:57 -0700 (PDT)
Message-Id: <bdca834e6da21e75fa96bd1967d36b3a018d9545.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:49 +0000
Subject: [PATCH 4/8] commit-graph: check chunk sizes after writing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
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

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 78e023be664..5c8f210cada 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1659,12 +1659,21 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 
+	chunk_offset = f->total + f->offset;
 	for (i = 0; i < num_chunks; i++) {
+		uint64_t end_offset;
+
 		if (chunks[i].write_fn(f, ctx)) {
 			error(_("failed writing chunk with id %"PRIx32""),
 			      chunks[i].id);
 			return -1;
 		}
+
+		end_offset = f->total + f->offset;
+		if (end_offset - chunk_offset != chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    chunks[i].size, chunks[i].id, end_offset - chunk_offset);
+		chunk_offset = end_offset;
 	}
 
 	stop_progress(&ctx->progress);
-- 
gitgitgadget

