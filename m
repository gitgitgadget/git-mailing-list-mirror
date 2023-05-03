Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0DC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjECSvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjECSu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254B8684
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52c219bf675so2029603a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139845; x=1685731845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWG/+S0pEkG9Rcz9k61ni3HDuVyEZnHiCAyEi7lI+0Q=;
        b=OQuy++4GO4vllfti/INtb+YDm1PXM+lBbDYxmJALJCZMxJqhOdnR6ECgPpd/3bBwra
         PV6Rf98gNRywA4hQVhCoTQHDa44lLA2eX8+gH6NQBvFOj3wM2umZGq9Tud4Z7juZFfti
         aaG1MmfXnKcr16PVjIqkNT5M8rIND2F5t3dVCEKxOOsNS8KwyJxDWTd0823BM8AbBv6n
         uw4Q7ApjQkrGstUqnX8AFy0MuhP4hQX2PTQrj63ZDun0s7pHerCBJS4uTMiDfsApoELQ
         LMmSTWURXH9jmvlskO5Qm4PJ/n5xLj9M8LbQTKFDrSPaQfYkuCiaSPf8Rscv6jjKi4q9
         O3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139845; x=1685731845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWG/+S0pEkG9Rcz9k61ni3HDuVyEZnHiCAyEi7lI+0Q=;
        b=YjWDg9ZGOpc+8rJ6L4ZdroUE9tsiGD1T876an4csi0LlQmOJxLoL/Sn4sjh3rkd4xY
         rQFVCX2dg42uN93gV0QmPiFVGE4zXzuB2DsG0GcHUzaFoE0uoFHAVnOOfpff4d/om31T
         5aS5YrTvBi4l760idBRdsgVqj+ZjDsXsSwqO8IEUhk0/SWROjQCVC6NXoLasCcx/l0WH
         JoitxzPiYGjJFoOX952x/oR2WxvUK29YDbxzezQC7X+p45wzQHq82ZQ1Eoj5flxCSR5u
         5M3AE8GQ1dRQCp1OfVPW/0YB0lJrgAclHLaOeFJOJO0ptA7O3JrUk8tWScY67cHL+Egu
         038g==
X-Gm-Message-State: AC+VfDwewyeYsuigsFk5ykk5HboG1aRA4x0IjHEZaZdngiB0P73q3rdo
        S9jEurlPC+irvnT5/855SJy7G29IEsR+cuW7LdA0v3n48yYXp2Y7/Q7OGkIbDMhGEoFQ7424bC6
        NJgavU+H5BoSAbv2nhHveI5Ie9ym2ZWXnt9x4sTrKrwmcyAKpYbMnDqVSKy8Lta916w==
X-Google-Smtp-Source: ACHHUZ4B2tieYszX3seCCnLoZ39HG9gOPO32ZNmwCZJ9qoljWQiOBDTRKVsYAKs/KOBUj2UWv/uJcirnxR/HRwc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:2ac8:0:b0:52c:6149:f6c8 with SMTP id
 q191-20020a632ac8000000b0052c6149f6c8mr714870pgq.4.1683139845384; Wed, 03 May
 2023 11:50:45 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:30 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-6-calvinwan@google.com>
Subject: [PATCH v2 6/7] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
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
index 178d75f250..d5978fee4e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-- 
2.40.1.521.gf1e218fcd8-goog

