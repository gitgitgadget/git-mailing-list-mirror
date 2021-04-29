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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51478C43460
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C246141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhD2PdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF7C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l2so15063354wrm.9
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=he8jYxd5pGLBa9SivbXsw4UrQ8VucJjI2q2qnfYUPoo=;
        b=GW/XSjxL3GabwY8Fus41+y+4i5I1p1E9lql3OJ0CsRygfJhCE3WmpT/msUdIIBZFby
         rlRQYzminhVGe79SXN361UJUqcCWkYjIFq4C72wZkNLZy/lcyM1lmCTYFENcCEtQv9tX
         JmijlVotk3m8FfEKydDZXmhVB7n31kAPk/OUD1yOr+NG0b2TOtlrUZR+Gzkr3IoN0vkS
         nfI4gM+Qf28ZNgf/fwwOWlqYi2y8bi8gdQkmr769tHXUPokdaTZ6DvuXkPupoDeN2gWU
         v9w+669kf3p531wwE0l3QgrmAfmTiChO9q/k70I5w+DjRVGGuVg6u4NRzgL8VGNCVrZb
         aVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=he8jYxd5pGLBa9SivbXsw4UrQ8VucJjI2q2qnfYUPoo=;
        b=Mn/g7apWcBRfmq79iZSGE57evAGmh1ic13xoVfsYYcHqUi5tnf5BTyVJ773wDRaVnO
         LkCnxLOj44u2bpsjLpIJYGjBC7fvLtJcOie9aVzYegaZHU/EFaF21hnLxGlH6KwfWH/N
         6ecOKqAvURbieEP/mWa6lhQzsL2+ClyO8Ox5EVHs/OMk687Qflc5w/KIQ/YWm+OsW0kx
         4oS181QWUrzApE1p4DinYMOTmXoE7m9eU1RRJY1iIes2TinVXX4pP9NYlfdaioqozEoh
         2BMF4GRnLJ2mxRyTr1uuV4bLpdOqRSKe8xsLo7jd73YeySB1PZevxOO8LUv9KOZkTwKn
         IzVg==
X-Gm-Message-State: AOAM530uOuzFfcQnzfse5X16dJLdUccFHgwRcBF1AaIYwpAVnGNVXHLw
        PHL9XWl6CVqRDORzBvPWmkHfWVoYOd0=
X-Google-Smtp-Source: ABdhPJwbY+VH5IiUUYliS+o30K/bUmjOdY3F0k1YtujR2hvEsyuqELsOe9FE0NdHu3FcTvAYkZy9MA==
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr472816wrz.72.1619710331058;
        Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm11030856wmc.44.2021.04.29.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:10 -0700 (PDT)
Message-Id: <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:01 +0000
Subject: [PATCH 1/8] refs: remove EINVAL specification from the errno sideband
 in read_raw_ref_fn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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

