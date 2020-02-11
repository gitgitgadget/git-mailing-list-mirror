Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B9C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054F121734
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unNrH0Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgBKS4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:56:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKS4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:56:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so13741743wrl.13
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=n/xRq8Ynb7jGbe091t8cDKZc8oXKJQfmU+GH8e1hI3I=;
        b=unNrH0UzkyP2rxY8Eky21XUsj/fFY4fIMomW/1sNve+UghiyAprTIENU9tIQPpW2cJ
         ZFyoOXZBLSltZOVQv4eXB1pqVeNAkUu5RcOOvepcAIvnzZfc8zW+NJMzkZKzHXD7n8cK
         e4IBjy8JZzzWwvUurkF75h0a6n6bmpMvFkeXRp4Ppp8QoP3QB5d38OxhNeZkEArqhshT
         5zxTK2uzrFCLCGWgDBy6WMEYqgY2d6Zy8VVls+MOGHTGsqridgxj4qBbedEhiKzFbVam
         yDu8PtQJVr8K5TK2ZceQLN+ISQCSh8oCW2uTFeNPtGjT9ZTuv2v5hYxuKKpUAs4ukP9A
         bppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n/xRq8Ynb7jGbe091t8cDKZc8oXKJQfmU+GH8e1hI3I=;
        b=CuETz69EYriP3x4zq6icrxeK2XIqV0fzO/np9crDuuXGMLG9KedwlOOrkOZAObzl6v
         EtMbJlQk+pRMRRPSQoCl1stYlaNlh61u1YbdjP20+Rqz40TIhvTdAFZEUbtljmsPh13F
         7Uc5tnyI2coKFEPgTiuy1zHGsNaeBawQu71zHQbCDi3hhWdjSAMF/U4aJqm2058h1lXf
         jTUekC9QrV1yoY1ujtJ/lJfh1I+rAhfzu/1Ej3ct+0Afbm16WvHM8HVar9Yw9m9ZMzoG
         vlAFSxZlEaDwZ3ivT9ycdM3nqy5bRscUKiNeCVrB59ooDc9C6lGooyjh3PBOO8Q7HLbT
         EsJg==
X-Gm-Message-State: APjAAAXokPq/ZYi0s3W7UUFYFsLho7D86bCtJxnbXTkTQ+htgKLQNaEW
        OC6ug8nKsg9Ygu5epdu7a4NTQmgz
X-Google-Smtp-Source: APXvYqwRxlWssvE6cTmHdKOL55iUdxwFZJUurJMfaHyLxCIQKOF04nm+oSkyPgZKVtKo0swbuAvW/w==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr9844533wrm.349.1581447379183;
        Tue, 11 Feb 2020 10:56:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm5021826wmc.27.2020.02.11.10.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:56:18 -0800 (PST)
Message-Id: <pull.551.git.1581447378188.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:56:18 +0000
Subject: [PATCH] convert: fix typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix typo "smuge"
    
    Just another typo I stumbled across.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-551%2Fdscho%2Ffix-typo-smuge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-551/dscho/fix-typo-smuge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/551

 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 797e0bd0b1..2b8549e5f1 100644
--- a/convert.c
+++ b/convert.c
@@ -1940,7 +1940,7 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
  * the contents cannot be filtered without reading the whole thing
  * in-core.
  *
- * Note that you would be crazy to set CRLF, smuge/clean or ident to a
+ * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
 struct stream_filter *get_stream_filter(const struct index_state *istate,

base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
-- 
gitgitgadget
