Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D1C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6392082E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/roRq6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEHBZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 21:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEHBZ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 21:25:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1CBC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 18:25:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y4so8631217wrm.11
        for <git@vger.kernel.org>; Thu, 07 May 2020 18:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6yMUny4ZCOtXsEhV6ifUFaV2NHNtZgITaDqOQ/Cz3Ok=;
        b=K/roRq6VwZa8IS2aK1u08DgmCzRZ4otEg4+ep9/3z3NenWrdjYcKeIt/BHppzZl9mM
         v8qOIqdMAltF4paRZzIhwUAfhDhseTjlnPLlBxxQ2fTa98WA7b3ysrFzX45TSZwlmgP4
         +Zx38r6XNsGi3d3PZ4kUEB5R+20ISGoBmSj3PSF7EhdWM/WMe8WOJ7kpHsmfy4rzLNP3
         oFrPg9VtZZHlCat/y5FcV8vUVr8HJy82HOEdOKDvs/F+Lj+o51q4C6jQWW+oKLfO3+Hu
         ZukYmhRWtv3H4lyEWOGu3L3650e7dw+P+CMgn8xxd4VATzXHCYlXYE8UrPHjLySwDMwI
         fTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6yMUny4ZCOtXsEhV6ifUFaV2NHNtZgITaDqOQ/Cz3Ok=;
        b=JrojwTXfWqJ7pjm0Pcs8VOxdD06x4dC7/kpidT5StXdzOrTU9FU7yEgWGrhSluu0gF
         YyeQFH3+JxH5ti3rXyszwYYDupUkE9As/OW6XZ83J+mhfMNqUSJQ9nTyDR4rt8wjdeT6
         KaCW0EZovTCS2NzsZ7qbF1Wk8JQRMpstyNaZNBM+FMQYPNR+djfzYMBEFihtvnb8ixnd
         SsT47KMDdq4k1/kmv6nWQkdP104gXmSvIP7MZH3jcZH61ANFyIBdXlp4BYcw+SrV3DCK
         f5bhKmqrzv3fpgB5DjWc9lZMmBIreTmO2Y7yfGpseCZvq2rvhKNNYN/U4UxfGbwpORt4
         6UPQ==
X-Gm-Message-State: AGi0PuaBYnIQ8kbxJz/45IvcKcr0RcBENKF5e1Gzt3T81CYujd+GtR+t
        q3wK7eJHUwJjGLm4mGWxE/LIZl6c
X-Google-Smtp-Source: APiQypJAjsLi4SK5OAQkKw9+M6hPnj2VBPpLi9+A1yciLgpUqvfqZiJ0bBX/N+uwXW6n5Np/Ac0dAA==
X-Received: by 2002:adf:f845:: with SMTP id d5mr17508568wrq.239.1588901125199;
        Thu, 07 May 2020 18:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f62sm10442205wmf.3.2020.05.07.18.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 18:25:24 -0700 (PDT)
Message-Id: <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 01:25:23 +0000
Subject: [PATCH] Enable auto-merge for meld to follow the vim-diff beharior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, "lin.sun" <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "lin.sun" <lin.sun@zoom.us>

The mergetool "meld" does NOT merge the no-conflict changes, while the
mergetool "vimdiff" will merge the no-conflict parts and highlight the
conflict parts.
This patch will make the mergetool "meld" similar to "vimdiff",
auto-merge the no-conflict parts, highlight conflict parts.

Signed-off-by: Lin Sun <sunlin7@yahoo.com>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v1
Pull-Request: https://github.com/git/git/pull/781

 mergetools/meld | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f883..318653cc9f7 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -10,10 +10,10 @@ merge_cmd () {
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output="$MERGED" \
+		"$merge_tool_path" --auto-merge --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" --auto-merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
 

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
