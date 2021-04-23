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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BEEC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78095613B7
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhDWPc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 11:32:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B7C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s7so48726511wru.6
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=he8jYxd5pGLBa9SivbXsw4UrQ8VucJjI2q2qnfYUPoo=;
        b=q6x0DErog9P7P8Y5Zh1DEQJteOQryNt1OYDWM0oYueRNUnvqyl1HMIZiCLffK1IEhO
         uplOvxTR55eUhCzk3zVX6YiziBBywpThLpqA2GpiB0mYMvja1pw4JyAn8mgnAKHVC3Ds
         4IAYk1moo372TyAio8yZ02mqsXoyoKheqowIfty9adU2QrZZeroHI506eKazuKuvkRhi
         i8d3KZnsmW9zNVW16WqP46VucBlmH01ijUHukTSQ9BM9dD9WWIXS5vIC8PM1wj2gkN26
         DbWiq4mlN4EJf9eyo4UHodrl8L+x/YZDwflzouDeJYXS/FlwmwJU+mK0+vF1gS8rFST4
         kNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=he8jYxd5pGLBa9SivbXsw4UrQ8VucJjI2q2qnfYUPoo=;
        b=DUXkcHmWVgskroqUIg+w23poWE9ts882A5jRkoAA/6dBoLzCNt2WhQXEvC5TQvPHpO
         s8vKlm14+hvgCgzDoeehXyfZ80NtrfRhEmyYxe0r5hEgFzvt8YdFpQksKl6xW3DyJJlB
         rWHyM5IDF2srrl0O7msWlsIEtj9UD3gHHOWnOfYrj9B72TDKB+d0IJ1eUujqz7AsGSbS
         MyZKHZ7o2QRg2rGpb8kVBsUuVFMCJOnj28kBspeoCl95AZqTqp+d9fhW2cJ1u5l5NIRq
         80MimZ4dBKPZsVCvOich33iz898VMsoC3GCro9Py0YMV+4OrxPaozx1pyjPQKyu5Hn6C
         IFGQ==
X-Gm-Message-State: AOAM532sv3y4qaxdsrbUpl5Y4XBVI2WaxwqTZxVx+HYBADdrGklvNzmp
        mL57X/TlTh2jKKal5fYox0/EYH0PUUs=
X-Google-Smtp-Source: ABdhPJyAMzAtognxEOFDc0Z7ScQgleBRjpv1v72HWU/S1W3t7CVrGTiOZO0EdM5qaOkLMRGpyN1lkg==
X-Received: by 2002:adf:f303:: with SMTP id i3mr5415369wro.213.1619191909263;
        Fri, 23 Apr 2021 08:31:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm9335863wrm.93.2021.04.23.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:31:48 -0700 (PDT)
Message-Id: <7e8181e77d409af7595e357ad233b7781e026b78.1619191907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
        <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 15:31:45 +0000
Subject: [PATCH v2 1/3] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
references.

The files ref backend does use EINVAL so parse_loose_ref_contents() can
communicate to lock_raw_ref() about garbage following the hex SHA1, or a short
read in files_read_raw_ref(), but the files backend does not call into
refs_read_raw_ref(), so its EINVAL sideband error is unused.

As the errno sideband is unintuitive and error-prone, remove EINVAL
value, as a step towards getting rid of the errno sideband altogether.

Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..29728a339fed 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,11 +617,10 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
+ * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
+ * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
+ * broken; set REF_ISBROKEN in type, and return -1. If there is another error
+ * reading the ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
-- 
gitgitgadget

