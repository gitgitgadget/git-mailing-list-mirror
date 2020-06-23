Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C4AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084EA20774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F68nNeUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgFWJUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgFWJUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 05:20:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E51C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 02:20:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so5331399qtq.13
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PGH+kakfwFCaQs/0UXJUkntBdzdtbkzWqgAXMlujzg=;
        b=F68nNeUFXCJIlhvpAab6Xa7YgoAiUX1YX0uhfZDruGNdNor55UFamDbvXyizM+aUkM
         MPT6rC2jZ/L2pBn7puFQK5mY32AyVTnq2ppg3xvKpIv59leg6xy/0Q+FPOtDcXl37PHc
         53lvlIUMZGzDR5xIh2TreOqYmbbxczfIJeM7zpEVN93LRV3uJgEjCReBHmxDmkF80t1u
         IL6pWQGZ7DreWQP+5+dJDY2YHiOTkRCt+EMnIf02Pb7ZLhBfCMlV/5RGezi+sxPdodIo
         nC4YWMJlztGhvQBgwB8/tQmNE91WpWSnkUizFQGoj91nyfFUGd3wTh/5RjmMABv0CLKA
         C66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PGH+kakfwFCaQs/0UXJUkntBdzdtbkzWqgAXMlujzg=;
        b=PGGZ2LtaFEsKDz4oF6IE80l1DvH7fkywT0CN+ieNJjs2O7mDsqwIV7HCzRlXsmuipL
         u0sbrOKUpYmbwbXAwWws6CUgS1n6DPErnCpBi+E0s0AddOHUxM9MLaCLEn/jjJVeepwT
         IoVvBBff899ya/gMQ2qGGJ7UFynLvhVtNWHJy+zgqUBkl/blIcYc67NF5BmzbTQEi+CN
         l8HhKq4UyZxvTKBBj4mwbymi2V4HdCikaaiWo/f2JECO88Xz65fwp4gnSlUAAxgjCvcs
         n/5au7l3ZqAZ3GvXCw3TRv/irod1ehyIxnOsQaIYHXfiqHy2u/lnUVuhGEz1Y+2gIU2O
         4Eig==
X-Gm-Message-State: AOAM533rzzMYqssq2QWKhmcN0wAxfVdEY0X+2or3+QAF9rt5hgZE8I7/
        EyOEegRP/1JcvLtmIk6xuUaq7THv+0w=
X-Google-Smtp-Source: ABdhPJydKz81q4X+53r7hyMjfZ058/ImEDxIlJW9xmH3LpTDbYTvXWw0Y8wvTEZlFDRpLiFeNHUpQQ==
X-Received: by 2002:ac8:6f2f:: with SMTP id i15mr20609094qtv.73.1592904004374;
        Tue, 23 Jun 2020 02:20:04 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p22sm74590qtc.7.2020.06.23.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:20:03 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/diff: fix botched update of usage comment
Date:   Tue, 23 Jun 2020 05:19:49 -0400
Message-Id: <4a1e357c390690375374490cd5aa2431a2593b9d.1592903964.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, an attempt was made to correct the "N=1, M=0"
case. However, the fix was botched and it introduced two half-correct
sections by mistake. Combine these half-correct sections into one fully
correct section.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch is based on dl/diff-usage-comment-update.

 builtin/diff.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index bdae4d6a58..cdfb58d04b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -284,11 +284,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * N=1, M=0:
 	 *      tree vs files (diff-index)
 	 *
-	 * N=1, M=0:
-	 *      tree vs cache (diff-index --cached)
-	 *
 	 * N=1, M=0, --cached:
-	 *      tree vs files (diff-index)
+	 *      tree vs cache (diff-index --cached)
 	 *
 	 * N=2, M=0:
 	 *      tree vs tree (diff-tree)
-- 
2.27.0.132.g321788e831

