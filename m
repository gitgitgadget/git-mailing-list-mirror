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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F322160F43
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhHDF3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhHDF3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F7C061799
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k4so846076wrc.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=orxdWDoDW6Mkyzypekhi5kd1qSdh25358N+ckFh/UCA=;
        b=p7vfwzYVxQeJhU7oENWBdVGqnfrmf2aKEaZp9AWnGxYSJO/h/OLHvjZDiNIfajFjLz
         A4dJ2jQv1QW4nNB3l+o/YbIm7+D5182D6DiMHayYujkQtOJ0x68uLBBrDjgH3SJrft/O
         xYF4a6nK2d5mKVA+1Iqv3rOOPLZlgidCXi8/G8bHefhvCJF47uey2z3f7xrFhw+N01hp
         MxdQMz9nJ+34fJYegbY597jlyiAaNmeB6bSlLfxYQWdo46la1rzzIb3s9AYFkdQvX7EG
         Mm0p7f3yLIDr7uYfgCwNnE6DPZWKcRfzgO9zNL/2RL/Vh1rg7QcS56IXRGT1NngviQl5
         FoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=orxdWDoDW6Mkyzypekhi5kd1qSdh25358N+ckFh/UCA=;
        b=tl14v798O90ebuMSn5h7Ve/vye7HHs7m7Cy5sMSiZcn1rtuRr005n9uL/l93JB5Y9o
         9eMQCN8ivN7+LRSi5TbF3j7MTRkcCvN6vc4yKQVU9XhsI8o9r31WMQRcuFea5bdr/D//
         Ex2G7XluKDb/xHUDkfnBH46jP5xFvqo4kNgGj038dsj3kLHIpXsSWBGlKOc7SdSPRF7U
         i6spydnc6ZoR0aehzWnUbKKyH0DrRiDHzSsbIMbkbZwtuBb4otOSrl2bb0FEmZDLYEB7
         mADCu126zJhRG38NkLyUNFsnYvuy6Iu0YNKE2jBo2nYefbXlb18/ISbDaUv5fWVzZpo3
         Lt2w==
X-Gm-Message-State: AOAM5327TaRnq95SQSinBMyEDY8kRS0aejoHk/f99nCoueuZpGzuuhXc
        OYA8HxpAnVclHJuKLkfOyWUmLLTZSIg=
X-Google-Smtp-Source: ABdhPJxEy5ujgYlerDp/cgy5MYb9RWBV7MhHxrWHMi/ns4DMzy3VY31FBz3odKyGB6dy0Plo/OqPUg==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr26270256wrx.103.1628054939048;
        Tue, 03 Aug 2021 22:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm981634wmi.44.2021.08.03.22.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:28:58 -0700 (PDT)
Message-Id: <3fdd068231a22375f979212189dfdffd4a2e4660.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:47 +0000
Subject: [PATCH v2 02/10] directory-rename-detection.txt: small updates due to
 merge-ort optimizations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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

