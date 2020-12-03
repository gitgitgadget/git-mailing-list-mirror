Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44410C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E222E207A5
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgLCQAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLCQAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:35 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B6C061A52
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:55 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so3170484wmc.5
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A64k+DC/Jzh2ojutC880/vsJ0UtdYQgydsE3M1hvMT4=;
        b=DxclLTQM/eG+7h1oMoeaHMhy9vCObtE/Z24sDuYPqt5kqtGrKnfDa84vXzVpAZDWPj
         d54g5kgm5uV3rR8YpwUt7iUXKo93rkfnZqBJdX2enSxSwHFcF2uqdokwtHVqQKNtmY/1
         OxHjuB8++S61fCZxx33e6Vlk2c4XzpDezS7T9Zt6SiJvUkTNm42eMKCtpZfXG7ugXvgu
         Btn0TTJICxd2cxh05qXXeTa7MQLuX/OGschbzwYfr/RzyZys/PmL8QGdsBDTWAmXoD5K
         QQLDBiJQ26RE1iy3SQ8I/1Guaf1M2snIzaERAilgV0rpWAl88cdv3tui9Dkoz2BJ3gfc
         DyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A64k+DC/Jzh2ojutC880/vsJ0UtdYQgydsE3M1hvMT4=;
        b=h0EpBZ7DgakH5bcF1uFbIZC8higp0a78yPNBkU7eWu7egE0v8zJTXoreLYP3F0zfZd
         1Xvp0Qbu0BOYKi3GqJ9LwdT9EF1SX0/PQPkbX2zfqOcg8whrJ8o8UJIXW8imd/xPOXum
         rSidA/H8CVDcw+J53ZWMAaSAZ+VIxXXeRjju3moU5Q5EOOki3hR/YZYOLwLs0W0Mtqzp
         Kvp4QcgF72JroDWQq1lMLX+44I7e3SU31EwkrSCbNtO4X+wiQ7Hm+/7pp6RmAe2QPFq+
         h7XXFHMIigVeNLm56cfIsUd4X33RCOZLFK+rUxoEEXSoJRb3rrWAQul6+H49RzVdNgNJ
         h+iQ==
X-Gm-Message-State: AOAM532jzOjbJpcGHEKhbJNlEEXCwe2q3QCirzfFjLha/q5AblPT9px4
        k1O+KZ2+iWfWOzgwQPSFGI8StyhDY4s=
X-Google-Smtp-Source: ABdhPJzxTIaWW3RswzcN0gVph5ATqNgKstyTXZC/5fw8nw30B/gm1x6+OzDNNjA4+M91XAmn2OSzEA==
X-Received: by 2002:a1c:4904:: with SMTP id w4mr4057290wma.140.1607011193779;
        Thu, 03 Dec 2020 07:59:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm2293549wrv.76.2020.12.03.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:53 -0800 (PST)
Message-Id: <5d73827b8d6c254f5bc4a99afa421ae34f07182e.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:41 +0000
Subject: [PATCH 2/7] merge-ort: add a clear_internal_opts helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Move most of merge_finalize() into a new helper function,
clear_internal_opts().  This is a step to facilitate recursive merges,
as well as some future optimizations.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b556897bc0..0654c76c8c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -194,6 +194,29 @@ static void free_strmap_strings(struct strmap *map)
 	}
 }
 
+static void clear_internal_opts(struct merge_options_internal *opti,
+				int reinitialize)
+{
+	assert(!reinitialize);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them.
+	 */
+	free_strmap_strings(&opti->paths);
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All keys and values in opti->conflicted are a subset of those in
+	 * opti->paths.  We don't want to deallocate anything twice, so we
+	 * don't free the keys and we pass 0 for free_values.
+	 */
+	strmap_clear(&opti->conflicted, 0);
+}
+
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
@@ -1132,22 +1155,7 @@ void merge_finalize(struct merge_options *opt,
 
 	assert(opt->priv == NULL);
 
-	/*
-	 * We marked opti->paths with strdup_strings = 0, so that we
-	 * wouldn't have to make another copy of the fullpath created by
-	 * make_traverse_path from setup_path_info().  But, now that we've
-	 * used it and have no other references to these strings, it is time
-	 * to deallocate them.
-	 */
-	free_strmap_strings(&opti->paths);
-	strmap_clear(&opti->paths, 1);
-
-	/*
-	 * All keys and values in opti->conflicted are a subset of those in
-	 * opti->paths.  We don't want to deallocate anything twice, so we
-	 * don't free the keys and we pass 0 for free_values.
-	 */
-	strmap_clear(&opti->conflicted, 0);
+	clear_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
 }
 
-- 
gitgitgadget

