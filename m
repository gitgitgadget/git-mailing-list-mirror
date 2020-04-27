Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46EC4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E361F2070B
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWEG4ljf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD0UtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0UtK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:49:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55629C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:49:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q43so21914665qtj.11
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=SWcbI9Mjk9YQNj/gi21VKbrX1uciP4FGTNs+HpCduCw=;
        b=LWEG4ljfqMTb8Crnc34oRwbeAJxlz0y7m+D7jA6v/VCfOTvMpQHCqYofNGCQAGAlLT
         gfWa49QCyE7GquDK6UMvl5bh5/DLOWR6TCAM9NE23xa8p34fyRb2SSYza2QoL6PLvDqd
         OC/mKdma3tPkndVcw6OWdJ4zH9U0eEjJvY6bz5vvXjCTa7z08ahVIRU6J+5kGQz4w1ob
         UBXsjfIRsJp7aURejmfkDQYOQg/HNBgepD80te+wdqRqp91lBZXjSJb3OhqYgGY8pmOE
         OpqUs7bWjM0vP7D2ox4/AVniDLZAltPLJx3jTCVvhdDvDHXxsePfpfJggQIsm5x+Kp5e
         mJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=SWcbI9Mjk9YQNj/gi21VKbrX1uciP4FGTNs+HpCduCw=;
        b=n0/sVG9iyZYMer7QLZcf3bZBkRqxnGHXbf/Wz4S0244Jh24AJc2OoDLokSAyz6NuZ5
         2zcmGmYDARN7C8NkND1rvwAXNBXt6hyytPUGO/MJGkWDwXJfwE0zbLA57KrqX+aOBqox
         ZWzaaPFiMwehHEtdCJ/aHfbHEREu5KhtyZlUQ+1+xvNp8XTVP/mVVME+SXQPmfL3u83h
         V0IB2wcYSp54BQ4wobWafBZ/SuSwZhqXYN0xuMhD3z6L9oA/P/Dr0FpHLWHaNbcLK9L4
         UxXMib5LeUgfI7Mjfua/f8o7rQwh5IDCqlZHe9a4yn1/AIyQv8ffhrUyAnuflUh4iI65
         5JPA==
X-Gm-Message-State: AGi0PuYQU/DGwcSKffHzhgx1IKMtmP5bNAgJPTdUOm20L2UYN2R5evbQ
        hdbIL+mZm5dYsZ8z47XL998H3j/IzRi8eC7dzWI0L7Xm1jpRCRNiBWYifZP4ZWag0eamzekeHvp
        ELcOZVwSPZNpmtb974i7vN9nnqgIzFjI+XgHil+m9tvbo5pw9wb/Bjsh8+4mUp8OdppKaUi7j2A
        ==
X-Google-Smtp-Source: APiQypKdPjIq/I384fcPA/Bv+7EanrfS2n93hQ+El0vgU3+xfkgHLGQw39zbkdxR8Fa7uZytoQ7AkIgzr9lXPyRlpH4=
X-Received: by 2002:a0c:f34b:: with SMTP id e11mr23952265qvm.76.1588020548402;
 Mon, 27 Apr 2020 13:49:08 -0700 (PDT)
Date:   Mon, 27 Apr 2020 13:48:59 -0700
In-Reply-To: <20200425003002.GC17217@google.com>
Message-Id: <20200427204859.171084-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] bugreport: drop time.h include
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out in
https://lore.kernel.org/git/20200425003002.GC17217@google.com, we don't
need to include time.h explicitly because it is included (and possibly
managed for portability) by cache.h. Drop the include.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Thanks for the observation, Jonathan.

 - Emily

 bugreport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index 089b939a87..e4a7ed3a23 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -2,7 +2,6 @@
 #include "parse-options.h"
 #include "stdio.h"
 #include "strbuf.h"
-#include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
 
-- 
2.26.2.303.gf8c07b1a785-goog

