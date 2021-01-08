Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE45DC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63AE23A03
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbhAHQzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbhAHQzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 11:55:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07166C061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 08:54:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y23so8988102wmi.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 08:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z5QVLsHkqu6mTxE+diOg+xNOMUpn9cMj1TFID/7XTSg=;
        b=TvdY2d6FKsDueMB97aO+1IMMvkddPiEx/p/UloovqimXDZcYkaf0XvK4r2aCVJ2pxY
         8LzS6m7bxLikN/if9qXysR+hOIp5WkdvEW8+UjxhUIBSU18TPJBgPTuiW/Oj5dIk1PKn
         zmgtSvGgHtK38txGyvpjlg4J+0K48JvhHlM9EFn2uEP3eVnia+H2PlooHxyepNbOpCVn
         +UWmn1np/YVUj0VOWjVZbOYPszDGuod0VdnAQevT6WPv1fcc1Kn8HpV7CJSVBoMO9HO2
         WgSkonohBLgm03WQ5lxQ3iyhGLEPUOr7sQPapU4HFquvFqg2myDZUkJ2DE/9WenHohL4
         V7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z5QVLsHkqu6mTxE+diOg+xNOMUpn9cMj1TFID/7XTSg=;
        b=cOx0RLDcvvOswICkBGsCcaP7Qa7X1PsREH4rJGsjiui/vWvQ/D1JBjdw1M/yQo27gq
         M0jsnN0HxnPuhsV1o5X3KDfXCPeLfbKo+F7VcFKTbekAEZ+QtC+qel0oNCUNGhk1LYO4
         V/7U6SqKa86pY08oaFuvBfv70m5LIQ6Va2lw4fVOmFujB2XYtp4EZTBF1g0QK2+ng1MF
         h9FWnYFhrPZ1e3ZjMxchs4UK67OErsAfbg7j1o9IinjzgOZPu/zoG/FXnimVrEM6yzu5
         kxzG0gscHqNiW+IzwRUyDTL12UdGSMVe2oGv9kBj90gp6H9LO6psCpOIRodkcxRzJAM/
         Trvg==
X-Gm-Message-State: AOAM533rAjqGA/sM/cUG7KbD5lh+dAGu4aiMgi1nWfH4SEwBrvDCIINl
        ELndeKR6k7OeQUMRlzVywHd2E2HGSC4=
X-Google-Smtp-Source: ABdhPJwtX6enFjGia/MkaV2PjPzxbzRHujZ9DlArVypUQk0eo5YWBcPKc3eLCoYTYPhD3leYl65Z2A==
X-Received: by 2002:a1c:2091:: with SMTP id g139mr3905875wmg.133.1610124897571;
        Fri, 08 Jan 2021 08:54:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm13470927wrr.32.2021.01.08.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 08:54:56 -0800 (PST)
Message-Id: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
From:   "Utku Gultopu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 16:54:56 +0000
Subject: [PATCH] doc: remove "directory cache" from man pages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utku Gultopu <ugultopu@gmail.com>,
        Utku Gultopu <ugultopu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utku Gultopu <ugultopu@gmail.com>

"directory cache" (or "directory cache index", "cache") are obsolete
terms which have been superseded by "index". Keeping them in the
documentation may be a source of confusion. This commit replaces
them with the current term, "index", on man pages.

Signed-off-by: Utku Gultopu <ugultopu@gmail.com>
---
    doc: remove "directory cache" from man pages
    
    "directory cache" (or "directory cache index", "cache") are obsolete
    terms which have been superseded by "index". Keeping them in the
    documentation may be a source of confusion. This commit replaces them
    with the current term, "index", on man pages.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-943%2Fugultopu%2Fremove-directory-cache-from-man-pages-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-943/ugultopu/remove-directory-cache-from-man-pages-v1
Pull-Request: https://github.com/git/git/pull/943

 Documentation/git-ls-files.txt     | 5 ++---
 Documentation/git-update-index.txt | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cbcf5263dd0..0a3b5265b34 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -23,9 +23,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This merges the file listing in the directory cache index with the
-actual working directory list, and shows different combinations of the
-two.
+This merges the file listing in the index with the actual working
+directory list, and shows different combinations of the two.
 
 One or more of the options below may be used to determine the files
 shown:
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1489cb09a09..2853f168d97 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -30,9 +30,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Modifies the index or directory cache. Each file mentioned is updated
-into the index and any 'unmerged' or 'needs updating' state is
-cleared.
+Modifies the index. Each file mentioned is updated into the index and
+any 'unmerged' or 'needs updating' state is cleared.
 
 See also linkgit:git-add[1] for a more user-friendly way to do some of
 the most common operations on the index.

base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
-- 
gitgitgadget
