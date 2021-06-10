Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BDC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8315C613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFJNAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJNAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:00:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E7DC061760
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so6537217wms.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=64mz7XOZtANGvbIXOxuTCZ/Y32JaXbRfNk+XitbMcgY=;
        b=tgm+obF3kzxRTjLjpbMTWZn4rS3DhJk5jHY6DCHhwDkfNd3JfhCE9H99NZFANrLWXj
         S3HslgAOTqi4+ZFxaKgUF28Ng3Co7PCkAsqLngDKtQ0HqAf9YUgVvjQrVqqA4msWbigP
         V5R1RufAkjBEoWPILRGG0LPzkqq7xMdKo+AXQ0f4M4cirTOgFFot1HFn9FRpVLhrBXBR
         sR75hRctVUv7syha7Jkui5jDsZP7iWyAR/nOReAB5gPxr+9kpqicqrFqpgMYm7MEFODt
         n8602lfViWpRjc91RQ8c5raBM7VrZjNgKTz0CQSzzhgeHTrBtarFp9zlMXcXX1Xx0GL3
         Df5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=64mz7XOZtANGvbIXOxuTCZ/Y32JaXbRfNk+XitbMcgY=;
        b=iFNU3IeS10csMMPqI6R4SjO1dXYkLy5j+A5N851/6Vx/JD0709c9bJZzRnL50NahXe
         TwnY+9V/30s3ZEi0o3L+Nm34Og5xcaeC53EoOyEJR4lFbyf6wJKv6Q2i2hBie2tXWqob
         cTPjCK2VW5DqHlyAHDZHc3AJDLaLYF384GfGo+pG2xbOne22UG6w7UWFyVrWVCL6iec9
         LCLGNkzxYd4nfRNr78H9H25zq4Km/DzRNRBPobze0Z8hutY6qPvBFvnn2Vx2pV/w0vUP
         Fe//LVOl0zDakjwJmqzRfm+fejlvP59vkQatWoZEap9nl5TcGxUrQn54q+swmGpntraM
         Wt6A==
X-Gm-Message-State: AOAM530Ayq68kNMB/RyVBveIfYjCi8ByO4JTJgY/V1RGQqE718QXsPdi
        GROxxS12TR6roUCVYKupLSjEeAanWgk=
X-Google-Smtp-Source: ABdhPJyFA+QcbPAmvAT7ERfba7Qq/U7Gf95eRvayIk8c1vHkyVFl/Cssh+GuHNimcsUCCoaYtHfh5Q==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr4879512wmr.93.1623329872735;
        Thu, 10 Jun 2021 05:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p187sm2958529wmp.28.2021.06.10.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:52 -0700 (PDT)
Message-Id: <11b2184044d766183edf5ee1888f38945e8a7fd1.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:44 +0000
Subject: [PATCH v2 4/8] refs: make errno output explicit for
 refs_resolve_ref_unsafe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects of this refactoring.

In a follow-on commits, we will

* migrate callers that need this error information

* clear errno in refs_resolve_ref_unsafe() to make sure these other callers
aren't using the error output accidentally.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c               | 12 ++++++++++++
 refs/refs-internal.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/refs.c b/refs.c
index bebe3f584da7..64e2d55adcfb 100644
--- a/refs.c
+++ b/refs.c
@@ -1781,6 +1781,18 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
+{
+	const char *result = refs_resolve_ref_unsafe(refs, refname,
+						     resolve_flags, oid, flags);
+	*failure_errno = errno;
+	return result;
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 904b2a9e51ae..eb97023658f8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -153,6 +153,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type);
 
+/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
+ * failure. */
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno);
+
 /*
  * Write an error to `err` and return a nonzero value iff the same
  * refname appears multiple times in `refnames`. `refnames` must be
-- 
gitgitgadget

