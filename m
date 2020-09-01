Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E0BC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F7B2078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MSWRlrrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIAW2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgIAW2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 18:28:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F8C061246
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 15:28:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s4so1485860pgk.17
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=etdLckWIK/n78+om+ANrQQ0AQ8TPQ2oYXvYj3MsOT9U=;
        b=MSWRlrrD4qnY4/f0zIIPKRVFvS2OPEWdDs+HEq7NtYU92K/6zkGmKNr01jj7NDyuPc
         yR0NLrUH/nWYhqc64bGliv7df+PXdW8ICXHk/+OrQVU7UxLDZvE6cuYkHFUUPyXYU7YP
         L4U/c/HkPgww4tHBoExNrBOzFgqmkxXgWXZO2PmTG/bq7O3oPF/AF5s+ky+N94Ra3JYh
         EsWDIccsVzw1TkyTcmOX5V62S85ssL0FyQXR77nG/HrStI8w/BecSjyPW3gkq/Bm5vEi
         638/pFwh44QZRraDTbrX+ubR5Ws4EvLAvXSJBLcNX/u5DXd+TaYsim2W54VjKJE5p+b4
         7YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=etdLckWIK/n78+om+ANrQQ0AQ8TPQ2oYXvYj3MsOT9U=;
        b=gcCHHAGOimVb/ZizARfUZBvFsIFQy27CFPpyHKsmO/8eqdHmLeaGxhOr/bCP6FOijI
         OxBYjRj4Q5HYbhV+/fImz3AhaQW/IAeBITlX0cNAA/l2c4/mqLurvoG/94rQRHQNC9yU
         hgqClp8uQQQL08/usDknRuRxdveunp2QDzgNGQRJbO7arhVI7L5vDEfnkgw8YLOCRzhJ
         QtgD+sM9w3NXcYZibrH23mPMq54bGliisdpRToFHL2lt/gxmHyH9JdOWnMnaqwkTRgAT
         IRgNbGOJLD/k9o2t7XQsN37dZJXrFU4+OuW/vEd6vK8seYzknxTbLBNprsWLohzSyHJu
         40aA==
X-Gm-Message-State: AOAM531K0NpO3eQP7O6of764Qpsh6XDl/rMV1sYptIT9lIZvhMU1cbRS
        gkvXu+/D/xl4NqP0yhwP8/7k9yE65RZon7kOpvLjj0VbY1uxjfDLyi6sb3WU4ALugDo0S3YU0f7
        vXMdifRA8JF4fG7C5bDD8IYN6MN7xuszw/egVGkDnY70UliY9rYHdggtxQWTAj/c7dIvg0mk7Ro
        v2
X-Google-Smtp-Source: ABdhPJymsgHUjia+osXIMP8QOJS77ILZBRiyFSf2Zpz+7jI64AdYkFyLnpOkuO7Rp/5I23ecNj2PbeYmCJKjBMnanuk6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8d8c:b029:cf:85aa:69f5 with
 SMTP id v12-20020a1709028d8cb02900cf85aa69f5mr929909plo.2.1598999298520; Tue,
 01 Sep 2020 15:28:18 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:28:08 -0700
In-Reply-To: <cover.1598998706.git.jonathantanmy@google.com>
Message-Id: <6b3e3077e6db3aff3295c66b6a030ac1de8288cc.1598998707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com> <cover.1598998706.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 2/3] refs: move dwim_ref() to header file
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it clear that dwim_ref() is just repo_dwim_ref() without the
first parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c | 5 -----
 refs.h | 8 +++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index cf09cd039f..0fa6067340 100644
--- a/refs.c
+++ b/refs.c
@@ -623,11 +623,6 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 	return refs_found;
 }
 
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
-{
-	return repo_dwim_ref(the_repository, str, len, oid, ref);
-}
-
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index 29e28124cd..8cbef96a8d 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,8 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include "cache.h"
+
 struct object_id;
 struct ref_store;
 struct repository;
@@ -151,7 +153,11 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix);
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
+static inline int dwim_ref(const char *str, int len, struct object_id *oid,
+			   char **ref)
+{
+	return repo_dwim_ref(the_repository, str, len, oid, ref);
+}
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
 /*
-- 
2.28.0.402.g5ffc5be6b7-goog

