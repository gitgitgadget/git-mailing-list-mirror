Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2445C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbjFFTs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbjFFTst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB018E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b03f9dfd52so25900095ad.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080928; x=1688672928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aGN9nzp+rpkMNIrIGBkrs93WwNFnCMhWBLomfxJlUo=;
        b=sZO58U7FA8Kj3tO42n49+Ny3USwgu9HVeLkgbqE1pa0rKLlQm+RIHXLI9AltqelIAo
         ImOwjB/AMo11bHoUX54zdgpqZsfOTEHn4faaUpw7c6ToWMgEZ2Zp25JRHuCXHPFDHQdS
         hOtmxvP1q0J16w0FHdudyZnh1vhua4hSC3nl/zr0URNJtHBxi/Y5M9rWsdXboTMPUtOp
         5JYj/e3WfkNI5xbls74SP+oV0WXKQC5aw8WVFq0uho0DX+cKMi90j9j7In/V3EZx3Jlt
         78d3/TErryWQFbDMoAcx1nEe1WbEUsahvBB24+SY7WxDZ3Wb4QmGkHnCDNaKqXBVlONz
         LsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080928; x=1688672928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aGN9nzp+rpkMNIrIGBkrs93WwNFnCMhWBLomfxJlUo=;
        b=LrFOUwQqnHQnXrZxJ3Oh3NpLN0rp1InXSs2z/ZeKkCWK54wiTJmNyWXyph0URrQuiZ
         xJi1CAn81D9huidKj18UAYK6sdiaPZKT84RVVhc+NOyUhzsxEOZzz8fEomrkmzhXXCy3
         RSHfsNDtC+1pfV++CxhwnuJ2+UuTsbtdniXbet3M260CW3Fvy0HztZt3/SXUCnJME0TU
         mgnOo0dwYS1b06vl3b112Kt2t2j/ahMP+2tVB/p9iVzMyRmuHlP42YlpOlHscKzYc2CP
         ktcNMsXgZ92rkGGmkyYSl5Y26x5FVy6/B06oDfwoqRvxeB/HDkIUOuwRUr9pIxAUCAQM
         9kGw==
X-Gm-Message-State: AC+VfDzQHPf4eKI7bodXjn0fJ2Kln9NDaWuJ0AcGVhdRCw5ijK3vVww9
        YGvrtqsW2mnGdfZeuJpQpnVfVHs/f8iU6Ci7yG53mjNxpZGr+0sgJb7z0SyRxH78xWPDB8hqcyk
        bpI9Y0KE4jHlqW6uIsSMHJEV+PqTiS+UantcBD6mLN6JGCBy2+dASLyKwQrKKq/UQPQ==
X-Google-Smtp-Source: ACHHUZ4MoCK1q9wTj1v91WF6KTpJ75ahn1/EoWgNAR5e1vZ+drewHYX0lXGGMOzdGAw9ugbwXrwYTz8wbZgZGzM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:dacc:b0:1ab:18eb:17c8 with SMTP
 id q12-20020a170902dacc00b001ab18eb17c8mr1001607plx.2.1686080928431; Tue, 06
 Jun 2023 12:48:48 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:38 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-2-calvinwan@google.com>
Subject: [PATCH v7 2/7] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs.h was once needed but is no longer so as of 6bab74e7fb8 ("strbuf:
move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h was
included thru refs.h, so removing refs.h requires strbuf.h to be added
back.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 08eec8f1d8..f5dfd093a0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -5,8 +5,8 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "refs.h"
 #include "repository.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-- 
2.41.0.162.gfafddb0af9-goog

