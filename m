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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DEDC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BC06115B
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhH1JDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 05:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhH1JDE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 05:03:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C595C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:02:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so14128627wrn.5
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qEYoQVL6GPmPt6D+/Uk47Rw+wWQ335N9RrHR7M0KxW8=;
        b=VRT1Kd4xN8yYRJSEOiYIpG8LaOW2Mc6nBSoRXdcHVv8xCUk4DxGqPXppeypMJQwOrz
         0JH/ARRZ/KbRDiz7LaYmE8usJbRs4m2H4cc9NerVVvBi63T9uJfG7czei4fPMDH5YRaD
         SlR6sfb4EHbpgy+hdtqBEjlqlFVN2Unq+coAtP8bW7wcblTXsd98zL9ioN6oHp6/LWC6
         zNwDdy/YdhucZVim36Bdig/kug0AMoyhmyQ1ODyL+usYj5jrLh3XzH5PIO4lbnWWzofG
         O5jKoeD3EeynOPw4F97UZ/efld3PnI/2dghAcPuKT3tQnlXGwtJqN/oYJAfqzAqWHCjh
         ASwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qEYoQVL6GPmPt6D+/Uk47Rw+wWQ335N9RrHR7M0KxW8=;
        b=GWOxnE5x/jMW0ElRNlLWIUTE3A2RZsCfVPsDu75Ep4FEPfK/URpi/w4qo5hEnEXmxq
         eQctE9szdNVBTSHgnkoDKHZXODy+LDdsjTbfHWNRDcsqtI9QT8xaGMxH8WVGb/uwuP13
         5hDsT9LJaw8+RcuibhwZFwiJO5ajUfVbhRuk8aWrzFhJnr5KzOAcW3I6BMvKlLqJCX/D
         As+gOy3ayVVwfGMlxSIzPJ8YNfLUaxwVDqE6GmClZJYRXzVfbgwlkWP/SYqRpNnoRKoR
         lwXKzkG73xLCU1ARm7Rwyjrv02/vcCHqVFXq8ememqO1j/WBY46knPKcbnmB38ge0BUX
         0WZA==
X-Gm-Message-State: AOAM532K+iECPdgbXtj208oipq34NoOuc/R8No2HwHuU3A8XEhb40pgO
        NlLE71YYpjoUcDr2JrgI1SiUiHNcMxo=
X-Google-Smtp-Source: ABdhPJwMwwKIhis+OoVp9DjwILoFGoFcb5DkMRKmNsrrH92rItcfOvBO1QO8oVUX7StdtsR3BJ0SJw==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr15401842wrc.161.1630141333007;
        Sat, 28 Aug 2021 02:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm8940447wrm.74.2021.08.28.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:02:12 -0700 (PDT)
Message-Id: <pull.1029.git.1630141332149.gitgitgadget@gmail.com>
From:   "Zoker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Aug 2021 09:02:12 +0000
Subject: [PATCH] doc: fix syntax error and the format of printf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zoker <kaixuanguiqu@gmail.com>, Zoker <kaixuanguiqu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zoker <kaixuanguiqu@gmail.com>

Fix syntax and correct the format of printf in MyFirstObjectWalk.txt

Signed-off-by: Zoker <kaixuanguiqu@gmail.com>
---
    MyFirstObjectWalk: fix syntax error and the format of printf
    
    Fix the syntax of code hint and correct the format of printf in
    MyFirstObjectWalk.txt

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1029%2Fkesin%2Fcorrect-my-first-object-walk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1029/kesin/correct-my-first-object-walk-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1029

 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 2d10eea7a9f..45eb84d8b48 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -691,7 +691,7 @@ help understand. In our case, that means we omit trees and blobs not directly
 referenced by `HEAD` or `HEAD`'s history, because we begin the walk with only
 `HEAD` in the `pending` list.)
 
-First, we'll need to `#include "list-objects-filter-options.h`" and set up the
+First, we'll need to `#include "list-objects-filter-options.h"` and set up the
 `struct list_objects_filter_options` at the top of the function.
 
 ----
@@ -779,7 +779,7 @@ Count all the objects within and modify the print statement:
 	while ((oid = oidset_iter_next(&oit)))
 		omitted_count++;
 
-	printf("commits %d\nblobs %d\ntags %d\ntrees%d\nomitted %d\n",
+	printf("commits %d\nblobs %d\ntags %d\ntrees %d\nomitted %d\n",
 		commit_count, blob_count, tag_count, tree_count, omitted_count);
 ----
 

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
