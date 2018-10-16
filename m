Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C6A1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJQH3P (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:15 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50990 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id ba5-v6so15666340plb.17
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ReCRIleJDeibh9gTQRtBubKvPIUIX1xgVfM26n5rPI0=;
        b=IxAJF1cRDJ/GjMkdMfLpLn4G53ND4wsfEQLDJg1ArJAlyr5Fhj27Xw46tcvgE6+AH4
         xj7sns+7Rz/mzaFb93tt48SFHqkh7ZfPxotSsukAJ6C8T+nUF1067SB1y62KSvovPK9z
         A9Xg1tc2Lk3jXRtHUFmNeGsfnb1w7SaIYk2ZmgzyLHPFccin+MoDkst4x3tdrsDBtHWF
         v4lNbAMVwUWar1RZEh3smoAm22VeA4ivs/AGUsDK5C+LBRb0HrFI04TGI9DZzCf218yq
         RHGaUELJ3rgk6hGtGr3+3xS/7WcraDvU0HZfOFZCoB4qyFq3CJNyEZAkdaX7Y9SuOvUX
         D8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ReCRIleJDeibh9gTQRtBubKvPIUIX1xgVfM26n5rPI0=;
        b=sFMmoeZYNdJjqzyEKVoxdTkIAHhjJ6VVyhaMcXuxzWU4zrESky+PM+HQ6NqQA/u3OX
         5O76f4Ttosa2dvPi0CBtIniiSEmmzBw5runeew4XmyaQ+bqY9RK/iY9KBc1p0cEFipVC
         FuJ4WmzT2KDcqahn8E1yQUTCU8yx0UCPeISX9W2Krn3Y+D8aWpy4vxCJMFKS5SCzRrr1
         OooalHT5uGehjR//MyieByPw3ACuzWUVpDGcVVg/3igCnLgIty4eMvDa6youEsQfG634
         1ryq7ZHxdxLZpDXjMVMbSwZxU+I60+NxfRVmsMLY5xXbS4MHZiiE41qWIyddxnThrDCn
         7NDQ==
X-Gm-Message-State: ABuFfojtlRotGpJwKM35c+kI/AL3NtirE3MEe1y359OX/cnNw9c2AnOx
        gIq5FnxLbb8+BXI9/pXfX6w2wRGM7banZVH3KiD+or6gI8Nux/13J3rfoHjzu3aRHYvXlW2w0bX
        xUgDHRlrDP6ejDuSwTI8DvZzs42zA6JleUR5TlMFyMZmyDT7pcQLWkoxg/U3A
X-Google-Smtp-Source: ACcGV610k9WD8CD1uhHkgyzwUlQL3ncGL6m46Liyy32X7am04ZvzbEQE6HZLtLEEmsWwpuzi/iyAzE564/PL
X-Received: by 2002:a63:d347:: with SMTP id u7-v6mr11584972pgi.30.1539732990240;
 Tue, 16 Oct 2018 16:36:30 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:46 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-16-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 15/19] commit: prepare repo_unuse_commit_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                | 6 ++++--
 commit.h                                | 7 ++++++-
 contrib/coccinelle/the_repository.cocci | 8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index cc5321af8c..8e7b1138f7 100644
--- a/commit.c
+++ b/commit.c
@@ -318,10 +318,12 @@ const void *repo_get_commit_buffer(struct repository *r,
 	return ret;
 }
 
-void unuse_commit_buffer(const struct commit *commit, const void *buffer)
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *commit,
+			      const void *buffer)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
diff --git a/commit.h b/commit.h
index b8437f66e2..f3ef497723 100644
--- a/commit.h
+++ b/commit.h
@@ -130,7 +130,12 @@ const void *repo_get_commit_buffer(struct repository *r,
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
-void unuse_commit_buffer(const struct commit *, const void *buffer);
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *,
+			      const void *buffer);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define unuse_commit_buffer(c, b) repo_unuse_commit_buffer(the_repository, c, b)
+#endif
 
 /*
  * Free any cached object buffer associated with the commit.
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 4018e6eaf7..516f19ffee 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -115,3 +115,11 @@ expression F;
 - get_commit_buffer(
 + repo_get_commit_buffer(the_repository,
   E, F);
+
+@@
+expression E;
+expression F;
+@@
+- unuse_commit_buffer(
++ repo_unuse_commit_buffer(the_repository,
+  E, F);
-- 
2.19.0

