Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB511F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeDFXWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33527 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id f15so1800457pfn.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AwzkloiLoBieQ166fCj5bw4q0zQkdmplFDlDDmS/tBo=;
        b=NHTNqx32JnI3xJehu+iMfs/7dIrYE/5qEBuxSzbS9cFi6OR31fHjb1ZwuZjznxwWDB
         EbG+BReliPjyrUqhtQ1gQWXDGIcfSKjp0mvw+wTZoIsUGmB6ps5AnA2j9aIAos7HHRPP
         kd0MF+X1RS3me93O85tOHNI+XUupfbGbeeknehcLGCY4FAzwLsLJKuPEhr+k1sT5Wvvm
         tqTP7C++LPVsH5lLxaksVva1mYdB9EOvzxAxjYj8SxGq/Dn0EmyyBHacM1aN4AVcFD8o
         BhjZRZ1FG43bUQ5QMNwYWw3cQb+AypLaocyZt96ETNG5z833k7CSw+gVUXAhwgnRz1C7
         R2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AwzkloiLoBieQ166fCj5bw4q0zQkdmplFDlDDmS/tBo=;
        b=qL3+fhTKh+RBbNMsASZmKOv6oqAKOw0+qNPfgxcoQlnG7s3jksoz+EywV0GeSx1uhh
         iZYnfnN4Dnktasdza8xGZhx7f3EHN31krztplzFaoIrQlhfoMiKh1MpWPTec+cM7JvSn
         InuEbpJdqOteGQb7gfrh/oBdqJAG3A0VT33Xhngmmrc1lS47F9l2aYn9LEj5Z+LDJP3O
         qJWEC3ggG8XRLjZAoBGsRGaXMDBYZpk0hRiitCbmUH/XS9W5mHBtEzS8x32+XCkc24QF
         giZHK9K7s5oK7R/QRsSM6cMnULCBJ+RJQ6+WFpmwNbp5FT12YFACer1qZXZnlUivHSCx
         83BA==
X-Gm-Message-State: AElRT7HCOrnK3ZCmRpBWCERuEyPCcaoFVN57ag5du5ObSPceLNRpN/jO
        5vkJu9QvzAs6RHYYL/9VRdQCwg==
X-Google-Smtp-Source: AIpwx4/nAEJUyLqpru9ZQeU6V3iy+1Cd7qo9ar0iTOOyQREZf0SkBwf77sx4wAoY/7LkwoKIqzZAxQ==
X-Received: by 10.99.114.2 with SMTP id n2mr19199872pgc.274.1523056934304;
        Fri, 06 Apr 2018 16:22:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o88sm22041482pfk.91.2018.04.06.16.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/19] replace-object: allow prepare_replace_object to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:34 -0700
Message-Id: <20180406232136.253950-18-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index b3bfd21541..967d794687 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -72,15 +72,13 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-#define prepare_replace_object(r) \
-	prepare_replace_object_##r()
-static void prepare_replace_object_the_repository(void)
+static void prepare_replace_object(struct repository *r)
 {
-	if (the_repository->objects->replacements.prepared)
+	if (r->objects->replacements.prepared)
 		return;
 
-	for_each_replace_ref(the_repository, register_replace_ref, NULL);
-	the_repository->objects->replacements.prepared = 1;
+	for_each_replace_ref(r, register_replace_ref, r);
+	r->objects->replacements.prepared = 1;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

