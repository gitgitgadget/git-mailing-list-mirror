Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF20C63697
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F9220657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhu5Xk+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgKHVle (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgKHVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:29 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55EC0613D3
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:29 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y25so6928896lja.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1F97epblfnDEQmCCs3FCvmUL1lsWDWBZOptv0P/Sm44=;
        b=vhu5Xk+i7p4Gt+azDjp6R4diWy5EXjvECCapiThqVbpbOmc4Pcn9a1vwVsf3ltzvXF
         NEe9Sc+BnpZfJx9Xb9vLdNfJCCFrCVYxjxUh32ebNB6KqQyZ3zPPA/zKtvAwJ1fVL0bC
         UqcxXXmwrhGV50Q+1+eIhkHV6BtDSe+Crt9Z8/HlYJvC1Nmkm0U9PeZrtskl2o8FIakX
         8m2Uocltk9l8sLVNY8IpW/91Cv2pPIZ0jDaklFJzOrcqqkHZT+YXzrPlTVzbJwE52VOC
         j81N5Qec7WkQ5GHQbQpG29/He+oE4I7+gxYuibehq0AiFLPleJ24qUt7vBkwS9Maq4v3
         1Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1F97epblfnDEQmCCs3FCvmUL1lsWDWBZOptv0P/Sm44=;
        b=G97G9iC04f/5wZgN+t6p74RtGcYPxbR6Lmsu5olTZl0ZYsKDxtaBvfKqVp3YxxVS3h
         K33vLGDlE+5bKcMnCsOFFurpT1VGpCPNoX0vIPwRlQyJCqU13nhvqT6J9vzFpYGvT629
         VtJVwVKtKd43Y2XwXmGGzjop/VOjfI2UvU8R8T+k/nfRde0si6XO4u4kws1Wq3LKRag9
         W9JWjOPoL47zv9PtNPvwD8GRUvWwfAVXvuBoi+1KoFctOwemam0bMU9xeUTpUfvQny5A
         ec3xNv3PUjNlIZcDwkcX8aocqtMfS9EB5hD1YRVGaeFgmMnAv2Xacq37VqgLbN3HCVKg
         RIYQ==
X-Gm-Message-State: AOAM5327crsNlMccsZ2S0l7RE9Jr54KzpMFdzpqpxjyOvOq8SF68W9IF
        bxAH8sn9dSbS/f3FnuWyJ4Y=
X-Google-Smtp-Source: ABdhPJwbwV5p0H3g+5J5k62Nqg6CBOzvulcyqw714l+29Smi+PPqSuUUK8q8Frfx0rNbUmzCt5EHZw==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr1891899ljg.79.1604871687623;
        Sun, 08 Nov 2020 13:41:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 08/27] diff-merges: rename diff_merges_default_to_enable() to match semantics
Date:   Mon,  9 Nov 2020 00:38:19 +0300
Message-Id: <20201108213838.4880-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename diff_merges_default_to_enable() to
diff_merges_default_to_first_parent() to match its semantics.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 4 ++--
 diff-merges.c | 2 +-
 diff-merges.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7791c003c91..63875c3aeec9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -600,7 +600,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 	else
 		diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
@@ -728,7 +728,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index 9dd472803d15..bb08a92e3b36 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -54,7 +54,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_default_to_enable(struct rev_info *revs) {
+void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
 }
diff --git a/diff-merges.h b/diff-merges.h
index cf411414898d..20b727bd734f 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,7 +11,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_default_to_enable(struct rev_info *revs);
+void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

