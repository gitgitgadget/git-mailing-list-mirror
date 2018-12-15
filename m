Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEE420A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeLOAKX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:23 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36035 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbeLOAKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:22 -0500
Received: by mail-yw1-f73.google.com with SMTP id y65so4338356ywy.3
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b70SLontAiSQvlnWO/t3BXy3Zfptakm8RrjbpbOmtmE=;
        b=HzwI+pmIgDXev6D3Vak1rNBXa+eNYuDbNSGAkPDSoaKbk+T7IUtiUqupJzOmKk70Up
         Y5GxlCs9YnJGusGmnHSiAsof3lWPaOX1OOlR9s9oYxZv7wPtsBQIG58CwqUeZdeqtFL/
         Zg5Zp6WvF4T2Xb7LrcwJsN4VqrMJlg++eIi1HmrfcooXeZbeFRTINDaM7ZFV+vaW9LLI
         uBOkWt/dZsQH/dhi0at0pgBikfL4ulK00dFcbCJg+hAlJ5anU3YNRK30dNZ2cP9VPsZa
         4Ops20p1hDElHjVqs+dI2JPLQkoRU18d7aKbYfTdZ3IhPumVnh+NZX0qg6i5QL+IiUpy
         LlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b70SLontAiSQvlnWO/t3BXy3Zfptakm8RrjbpbOmtmE=;
        b=WQ12Ay0xXkeNpWOJcaspNGDq+d80gCEG75crbF2hZoykvvPwlwobJt/uuc2vy930sE
         JmGSXJQuUUYU1GLSXTbAtySYTQmaWsOVqZVu1vhlCVwm9tgO/WXahZU5smhC1Y24rIo9
         bH9BfZosUMIkD162p2o3eW9IZolztDdX75i088/ezobVEjwRJiHO+tL6uBBx9xlkHB/j
         GJXH/FbPaqOpniDwbo8u2eyo3o8dkygn1b2ZnXh18V/8GKrmeRpTseBCrBRcvz4PbnaH
         pCw3/PrS+WKq/LGJ6t3XacBYLplto8HsV2JCc1ltM6uG9SkJjedFoDjFxa5i+7edWl76
         3ktQ==
X-Gm-Message-State: AA+aEWbkSKHb35+Gy0IaDw8JbNvBZ9hK+nPQ/SC9/MI6G7A1JkTCdii4
        SgcdvKxpNSkEiVOpmlQzVHffyAIoErkZdmZN7R7HqaupKoxJ0juH4eLG2NKePq28ZZbd6asFy1O
        6E5c48ITdYjr0vG1abBb70CIj1P6rR2o83kVGbVdyFLB/HwjAQYtnb0z6G3Gx
X-Google-Smtp-Source: AFSGD/VZuhTOS8nfa/dr5fsIB2MztEt2F+4IT9vhUPnMZsQZIfCc+pn0A071tzpKw+H8bYEfeioNSSt61x3o
X-Received: by 2002:a25:8b81:: with SMTP id j1-v6mr3123962ybl.60.1544832621582;
 Fri, 14 Dec 2018 16:10:21 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:34 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-16-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 15/23] commit: prepare repo_unuse_commit_buffer to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c                                        | 6 ++++--
 commit.h                                        | 7 ++++++-
 contrib/coccinelle/the_repository.pending.cocci | 8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 4034def16c..7d2f3a9a93 100644
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
index 591a77a5bb..57375e3239 100644
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
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 4018e6eaf7..516f19ffee 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
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
2.20.0.405.gbc1bbc6f85-goog

