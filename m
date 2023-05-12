Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B36C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjELRPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbjELRPm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:42 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429CDC44
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6434307a64bso10324117b3a.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911737; x=1686503737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9aIyZsHKWt/WXrctl0MWBZHtOrnvY1GGul+Q1rxBQ=;
        b=umgpqlXmkWEhEiNf7RpQXd5FSezMqVDuI7RQTP92I2bVXtI27qBJqcpjRrNj3D/GVe
         nIu9/mDuzktDa5xVK7EsqCsmEGSJPzbVpwF7m4Qem1KhcB6ivfwBZqp+D4QdnTN7aZpG
         nKREVgrsXkYe0Xo7O+zSkvPsH0mStt2svne6nmEBaNBFrqA44xEzd0qmiVnuFCcT0MiH
         ZbdsydkQjls7WpJdr0O7UMTY+jjchgloWBCFegmjZaYttShxrgjk1Ui4QUAJAaJxYRD/
         lTg9UlyajrQ22Ueewp7lytceMbND1sCQNVv83UeP4A47rLMmqeDJIiYEeO8tW/QGC6ip
         N4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911737; x=1686503737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9aIyZsHKWt/WXrctl0MWBZHtOrnvY1GGul+Q1rxBQ=;
        b=KgPeoLbaDrWUfmcB5FvWd8v4c1Pp/+GSYro9bPS30wCzJpOMgVI7mW8P7+GscmifWC
         JX/A8H0N969v7LojgUshaiqQh2gcEUcwcFkDIhj6b+jFTo08vqByArw/Kbvk9XDIV502
         /I1R8qdSpiTtBWR9z8ipLPmmeAdbXSFnxOKPrRFLPQPyR1h5IFKbyk0lj2BdP/5OjXod
         ji16nViUKXSM88BtTZlkOe1uLFpsJG3tkqcSSDG9M4r8KpcWYbItpCk4ImJOYVZwMIfJ
         KE76rQjWTIMocE3w/6d8P1iJqdZv5tvjze6UzwARWH4OgJiBaoi8q+OSae5PmiA9tVwv
         wWpg==
X-Gm-Message-State: AC+VfDxwyO9R0j5EvBbkoMldvnIFJE3sw+CNtoHHD/tfeJzFod0BSxet
        5zytY2CrQ0NMhYlxtliKjQf08/ZAEXz3OUb6DT2jqHlTaOXdL6WcR360OrmcqQw68aYBW5DQTbI
        1Rpi7C8R5Ztvp+yrS4hJ+LjEbsIa9+QLmy0WVrq5FBfZLM8nnLYXXLDiAuE2FU9gzEw==
X-Google-Smtp-Source: ACHHUZ7xgzaXa5DCe1eGylc1BE6VfBgMIk/dB6gmMUriPAmUEvmqQanlIQFir91cF4DXJxsUVDCP9eAEtJaJqKM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1713:b0:643:a3a6:115c with SMTP
 id h19-20020a056a00171300b00643a3a6115cmr6810702pfc.0.1683911737471; Fri, 12
 May 2023 10:15:37 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:15 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-6-calvinwan@google.com>
Subject: [PATCH v6 6/7] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
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
2.40.1.606.ga4b1b128d6-goog

