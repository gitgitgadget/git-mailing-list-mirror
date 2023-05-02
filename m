Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76935C77B75
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEBVP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEBVPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EF1BE8
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:15 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1aaf7a766e1so26715285ad.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062115; x=1685654115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jhML6KQDP90XY9ekb1pmUyhvsxjsSqTVFKjtg4gVJQ=;
        b=YVCJVY0sb7JFWaQ7qW0FoH5vcbKZsLpW+lVrr5t7zrpxX783YujZ4vg+iRBNwRjC7w
         kLvmqEYFG5+SF2QLL5jaitpKeOON5oQKomT5JZanF+1H5RmAzB1JoPqErDLmK5u3iocA
         Zbqc/TmZf0hrLK6fZNX+IcFbqVb1liTdSem6varW5wcEbzg8oJYpNxUvl5pd/JDHbMCj
         9EoCrdWHPT0/wb/gPESbRufRsFvCT07gEMCzMSamK6E+GfnBiybD/CKHmdzp7fTeffVk
         KYm0UlFe90eAXJGI+IWvHWleeEiypz4pAFAtJsy/jdTrri2vEQ+YRhpqNFj0FnXwaQqD
         knQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062115; x=1685654115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jhML6KQDP90XY9ekb1pmUyhvsxjsSqTVFKjtg4gVJQ=;
        b=ZByAlCIaNCqvmc9IjIuoe3CLkdBMRgkCurcawfwPET0H0mE8j3qrAqS0rgmtJB3de0
         WOHNoare+/dEXJO2PlgzKMu8CPGHXCvlCv10mYxwlMKYdD65IuzexgWGe4pLI3QuQGVU
         FiFPCM1C+L5eZjOtWAxkqfrWZSzBuOJef7yAJ2zciLmhOils+CSZXbWGp0G2EMPUGkGP
         E707uSl+im6jhyE62gJ3QNE0XzKRukn1n0wub0oj3vbo11CvPU8OaRUwRuaIlJK6e9KB
         S24jyRf72fYX5qPbRTgWWY0/D4yOj4UKiMZCaQs3+17ZvCg0o43IHAPAZKCuz9uKqrxH
         mTvg==
X-Gm-Message-State: AC+VfDy155lrluQHxPJA3BFxI+49q8fD6uQcIpDTCUTU4ntaiZhVBOkS
        n1Z/jjoJrP2/4cesMBEZeZqgkK9s+DPpcLDnk2GRP7aDCbSWV2BSInB9l4VXpwIlzixI4dTbsmC
        p00DkJJvkBMlsNKMs1HCBkFNKequacwT+QI2uChQdtjpnd59bWF0GhASYxEL1Nv4HSw==
X-Google-Smtp-Source: ACHHUZ7+0S4WNIn6nu1v2l/VPXexjB0g7lHsb11pSyY6i+feCiboBnXPbjMdMbUk43uh0vejtFTpezFKaOML+Pg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:1d1:b0:1a9:8e56:9e14 with SMTP
 id e17-20020a17090301d100b001a98e569e14mr6162965plh.3.1683062115412; Tue, 02
 May 2023 14:15:15 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:53 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-6-calvinwan@google.com>
Subject: [PATCH 5/6] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.40.1.495.gc816e09b53d-goog

