Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A4C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 16:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA9560FBF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJXQbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXQbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 12:31:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748BC061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 09:29:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d13so5624551wrf.11
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wds5qAf9PiLmAEDZZ+GOQozk6OaFBRsVfS5aEz2YfkY=;
        b=NfZdjT2+tsg6lK3nDMYdW4qnMGcHmulJg7teZgqdoGzkUx4N9/s8FyQSjyB27L8C7T
         Wqw43wut8rKlQBaO9LVFvbmL8WzNanNWtEle6s3BhscnhwXY9O/1HC03cmTYfaC0hi7z
         pdGl33Qcvf7+T8cYoAAXW4ib0Zna4JQVSB8CV1TK/aDuuOOH8onmZJIGZy6rLE3Sg5uR
         q6P91qd3p3newhlvJ4nfGt0ZEeUGFHYYDl0PBSaUaz9zX/JwtJIPK5L9bFQVbdcD3wgJ
         TMVAZKzPTDI9xVkGA/XlTKKFx/+RVZw4pT3vBnWy3uXPGNsjJYhWrn/l6ECRQzFns+Fm
         goJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wds5qAf9PiLmAEDZZ+GOQozk6OaFBRsVfS5aEz2YfkY=;
        b=CGq5XWPQhGi3D4NcHj1pAaPywHePzJSwuZ9ZPf0J40WT3yQedF/8JXbpSbiibCid3P
         d9H9inQ242u1BXNtchSNnEGPYXFwvIEkPr9NA1NJHENrcGoxhLNZUyZOYIf/LeKB94cY
         ezh8kvvGz47Sgip2ZS41ynnWHogB2GZLbxUjSEp1fBa2R+KZhM7pdbKML+IALmYDaAwm
         FM+wv9lcV2BfdSXdtIAvBKABqSOjFdVSyR0iMfmOcYV1HIhnHseKHFdMzmK9W7uQaqV9
         03cs9mHzxOTDGCzTsrLIKKiOiUNjakXfiYwXYHkaLLh5M+KAwfoqqd4yNLjfCZ41E8va
         sGGg==
X-Gm-Message-State: AOAM533PYTh7EnoWtU8paHXTnIliSWDw6aQjj2obH61rCSgkHjK8E5am
        BxgQNYlr0Wny5eMTPmx6WgAHOGgB1og=
X-Google-Smtp-Source: ABdhPJyHTuoN5UiYMRFoOm60wcNEV7Zsl5m1TMUITWH/y6LKjkcYW6YnOFwq2HOlzt8A3nHzcCTreA==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr16715104wra.182.1635092970408;
        Sun, 24 Oct 2021 09:29:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:2c2:db70:f896:2223:eb4e:b5ca])
        by smtp.gmail.com with ESMTPSA id g3sm15900278wri.45.2021.10.24.09.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Oct 2021 09:29:29 -0700 (PDT)
From:   Robin Dupret <robin.dupret@gmail.com>
X-Google-Original-From: Robin Dupret <robin.dupret@hey.com>
To:     git@vger.kernel.org
Cc:     Robin Dupret <robin.dupret@hey.com>
Subject: [PATCH] http-backend: remove a duplicated code branch
Date:   Sun, 24 Oct 2021 18:28:59 +0200
Message-Id: <20211024162859.6295-2-robin.dupret@hey.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211024162859.6295-1-robin.dupret@hey.com>
References: <xmqqbl3u5fhy.fsf@gitster.g>
 <20211024162859.6295-1-robin.dupret@hey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try to make reading the computation of the gzipped flag a bit more
natural.

Signed-off-by: Robin Dupret <robin.dupret@hey.com>
---
 http-backend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index e7c0eeab23..3d6e2ff17f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	ssize_t req_len = get_content_length();
 
-	if (encoding && !strcmp(encoding, "gzip"))
-		gzipped_request = 1;
-	else if (encoding && !strcmp(encoding, "x-gzip"))
+	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
 		gzipped_request = 1;
 
 	if (!user || !*user)
-- 
2.30.1 (Apple Git-130)

