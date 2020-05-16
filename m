Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115EC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6582065C
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJBnoRGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEPRaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbgEPRaI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 13:30:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DEC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 10:30:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so2450299pjb.4
        for <git@vger.kernel.org>; Sat, 16 May 2020 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=889H89M7vyTDOTOTGB+Z+fJwEasAUT1D8YBXtryecbA=;
        b=iJBnoRGmds1DVEV76tz6mcVLHYHE5DA5PKGex6jJmlPP33qulZ5lj0q1ubusi5FUK9
         xNIxEOquaXE1uJHL12oArgIoApZ0lOytn/2mYuszHy8APLtryVJkTotaeSr7/VBXXdD1
         1wKTyM+HvkgtmMByUGj7VrHkcvWHAjQWhmVjHdc403BN5LWOGnLKIWGuaDM/CJl3pJ2s
         UD5J6rXPizVdLDX0L+BzgYWQlyDLXDPMaRm8rrpV2Mi36ejjQhN4wXgKRY24LFULf7Eh
         +AuE2YHZTUzJV1Etu4p1dor406WQgpEGoZBGb3CctdIVgSVI0foEH9zIYih3aMOb/73M
         ALDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=889H89M7vyTDOTOTGB+Z+fJwEasAUT1D8YBXtryecbA=;
        b=E3HtjiS3bGbQ6al32rXAgT/F0TcY8iqGwjm8Em/rsJ92l9CZ3o0nF5EzP+84Xd6/Kx
         ca2hceOlTFGVPQHQTxIYFb8DGzVbk2IfHmXpZYgVxF8oHaG2Im+Gz+8ZQXjx2tghTXzv
         2ahM4n6m6o4WSV/d8QvYr2bstiGS1Tmi2YeyFhzDcAtPnePDIdOAMo7vMnylC0uarBDQ
         vfdEns6yWLxDaqx96njM3XDJpfwdRydz52I57TD3SygIkJRlIVnFW22oF4T1w5P4I1JA
         UTt8ZZwRj2StVIvIdJREGWA4WFFJdzr8sOMv1ke3hkaTo++mNPWOsjFAEviEQaMIDmqv
         njag==
X-Gm-Message-State: AOAM533wTiSXyuig93bagaNammP8h1W2CvtB0g+xANFazKV2QfsKKbzW
        80FGqO3da8UkKzCN9d6Rxuc+qEgPHJI=
X-Google-Smtp-Source: ABdhPJzAMFGKpxaZCM0e7uybgCgiiGO5jEX6j40kQA/yGss5ltuatMz7AYE2tp5Pt5wW5Y5BBC/SCQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr10545681pjj.122.1589650207330;
        Sat, 16 May 2020 10:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:1c:9c42:c40:e2b6:f2aa:f55d])
        by smtp.gmail.com with ESMTPSA id o21sm4264681pjr.37.2020.05.16.10.30.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 10:30:06 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] commit-slab-decl.h: fix define gaurds
Date:   Sat, 16 May 2020 22:58:37 +0530
Message-Id: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit-slab was split into commit-slab-decl and commit-slab-impl header
files by a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19). The
define guards for commit-slab-decl stll use "COMMIT_SLAB_HDR_H", which
no longer matches the file name. Let's fix this.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-slab-decl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index adc7b46c83..bfbed1516a 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -1,5 +1,5 @@
-#ifndef COMMIT_SLAB_HDR_H
-#define COMMIT_SLAB_HDR_H
+#ifndef COMMIT_SLAB_DECL_H
+#define COMMIT_SLAB_DECL_H
 
 /* allocate ~512kB at once, allowing for malloc overhead */
 #ifndef COMMIT_SLAB_SIZE
@@ -40,4 +40,4 @@ elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
 	declare_commit_slab(slabname, elemtype); \
 	declare_commit_slab_prototypes(slabname, elemtype)
 
-#endif /* COMMIT_SLAB_HDR_H */
+#endif /* COMMIT_SLAB_DECL_H */
-- 
2.26.0

