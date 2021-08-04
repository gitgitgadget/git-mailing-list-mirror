Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5FBC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFAA60E74
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhHDXvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhHDXvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CEEC061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:50:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l18so4083243wrv.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GspBKsOvQ/i5PkXexT/hJu2x1eIto5MOrbmWrr9Qnnc=;
        b=gsHvkZKiwIs3xOIjp5SA8elF3Zf7oYM0llvrIq+vIALFjlPI0qrF5PYM/NHbaztbug
         4/8gPgdhRBwXZuWE1tvu08cdeEq4kkICM5lYiWs7x8dZfvCaWSZCGjX0BYB7z4hIKGZ1
         pdzL0Lnx9vJghji4/0lQFZjVKt2mX3S+WJFYawIVtjP0FjftAvTPvfQLA0irYzgd8KQv
         lJOullicKxyWLhZ7MuHuOlTAQeN+6BXszpjaVfHs98svAll55aK12U+LgJ6QwcAiSkeW
         AXkzOf/YpwjlHbzUGPZE+xhcSHyP8MFV4pB3O8lhpzgSEIgr3p27rooEzXj6NjN2NgZc
         wh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GspBKsOvQ/i5PkXexT/hJu2x1eIto5MOrbmWrr9Qnnc=;
        b=q32A9n7OW0LMlLghLfFMuINZd0YIz85Pnu8rxjaYL5jDAPmo3lJLonwt0eHT+IeQvC
         lAsVrK2NmGC0gyMINMvYCGK5KaziJPRKtUpv4VfEcU+ZAlBZiGS2ZdtWG9tjRcXU2gq6
         e2NWklloK4XggcrxDW+CgJQ6501BRacNkmCHDK5I/O2l8jsPrZd8HyFkax+Eom25qc6g
         x7jSjhyQx87wmGt720rPZjjkQLiagH/KlZYkQwxb4VN/I+mGQd/Jh4YtmqkSDDei7Z48
         JgRhKMn2aNJOxaOXK0fpN+afIR/VxJSjbUSx1fP/uYVc7Gd3YQKymVbUDUIF0bhk5TdR
         0jUw==
X-Gm-Message-State: AOAM531/I/AENqxrwxQzv4s+BMZhG2/mFm6Hs1otUWhj3qvuqj3rkNxx
        F1agx/kC6OfY6ook2I9iDM/v9h4iRIg=
X-Google-Smtp-Source: ABdhPJyL5fNUnxvrH5ToSSFmbcU7Wp1qbCJCrxNWrmBSBsDojTKtL85zS0UL5Pigl0eXtGd46LN3+g==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr1850378wrt.244.1628121057394;
        Wed, 04 Aug 2021 16:50:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f74sm3735114wmf.16.2021.08.04.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:57 -0700 (PDT)
Message-Id: <69fa233483cbbed1f93524e63a681ade64951943.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:46 +0000
Subject: [PATCH v3 02/10] directory-rename-detection.txt: small updates due to
 merge-ort optimizations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 0c4fd732f0 ("Move computation of dir_rename_count from
merge-ort to diffcore-rename", 2021-02-27), much of the logic for
computing directory renames moved into diffcore-rename.
directory-rename-detection.txt had claims that all of that logic was
found in merge-recursive.  Update the documentation.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/directory-rename-detection.txt       | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 49b83ef3cc4..029ee2cedc5 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -2,9 +2,9 @@ Directory rename detection
 ==========================
 
 Rename detection logic in diffcore-rename that checks for renames of
-individual files is aggregated and analyzed in merge-recursive for cases
-where combinations of renames indicate that a full directory has been
-renamed.
+individual files is also aggregated there and then analyzed in either
+merge-ort or merge-recursive for cases where combinations of renames
+indicate that a full directory has been renamed.
 
 Scope of abilities
 ------------------
@@ -88,9 +88,11 @@ directory rename detection support in:
     Folks have requested in the past that `git diff` detect directory
     renames and somehow simplify its output.  It is not clear whether this
     would be desirable or how the output should be simplified, so this was
-    simply not implemented.  Further, to implement this, directory rename
-    detection logic would need to move from merge-recursive to
-    diffcore-rename.
+    simply not implemented.  Also, while diffcore-rename has most of the
+    logic for detecting directory renames, some of the logic is still found
+    within merge-ort and merge-recursive.  Fully supporting directory
+    rename detection in diffs would require copying or moving the remaining
+    bits of logic to the diff machinery.
 
   * am
 
-- 
gitgitgadget

