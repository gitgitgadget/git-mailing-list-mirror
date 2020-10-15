Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA0C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE812074F
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXmWVLpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgJOUqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbgJOUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93798C0613D2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so324576wml.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aZ7DcZvmrZ70pwj0OyykSGCvAzSFNgR9zrdY2/bw5F0=;
        b=OXmWVLpWwkRBD+JpcP+FYvNVhmx7f/L80THjAQxLOPJs9wEMti/8PVubfLtFr86vmT
         SgaAwYZd+ED9emCK1Mr6HQL0mbWz+2aA0Sb6lQaNF9QgCWfJeb5/rdth4E3YMpgGAimm
         GRtZiEM7PkqGf9dUjK5lP6YS6qMb+1zS4ch+Z8KHazfXi/kHLb6fjyrVdw9stWoOJySe
         s7vI4KEQgiXINg2Afvvi/4hUerLvkn+gMNM/m7LZnjv1DabvXaSHH5kB0KoOR4c/HJ7o
         14kTP7Iz5daXyyCc2L0j8HRGLblirVpMGM4FL/qm38LD3CMhBNAR25Vr9FMuKmMbhfA7
         cOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aZ7DcZvmrZ70pwj0OyykSGCvAzSFNgR9zrdY2/bw5F0=;
        b=n6LAYtkNF8UfYAMkvArMGmY0F1Cqc1Kds9qb9c/qjzc5TpIYkinLLPir4uJGYX9eik
         huaI1ezR29/ADYgTpeA9MyCgMxFjO+o5AZh0wqTojuJsB3Cxd5lxYz7O3Imr3strKulf
         IvSo8CpXEaWkJeDIu+zI9QDKyx0u8PavzLdGThniXw0+Nx7BGfXIzw1WaW/WlfdgRucW
         TKgmW5ova+9CL9061ZKBAUWpcXbkMEbW1w7WTzsa8Hhfkb0oOaumNnKE+1qF2E2jmauf
         YZos1MsSmJbEgSJVfVuKoC02JpuP+tLIR2o+Hs9cOANB5fErvY2wsmZchwUhD5d1e0B0
         pBcQ==
X-Gm-Message-State: AOAM532NQWQqGL3e1hWz/kuBxUstcq2ubynTwPjH8dG4LdCZqi9c+peC
        6d4Tz0aWX4pMWZp/AjDwLv9Tm7M7BQ4=
X-Google-Smtp-Source: ABdhPJxR1mSuOzLTaJVN4YwvP7xboBRfNilg7DTwK0R90eB5LlLOnX6eu8ODfldvHdEwmOCac5H4UQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr456695wmj.170.1602794793130;
        Thu, 15 Oct 2020 13:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm305996wmc.7.2020.10.15.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:46:32 -0700 (PDT)
Message-Id: <03af0de2b689f94a5b464ba1618857f55cb8b1bf.1602794791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
References: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 20:46:27 +0000
Subject: [PATCH 1/4] directory-rename-detection.txt: update references to
 regression tests
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

The regression tests for directory rename detection were renamed from
t6043 to t6423 in commit 919df31955 ("Collect merge-related tests to
t64xx", 2020-08-10); update this file to match.  Also, add a small
clarification to nearby text while we're at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/technical/directory-rename-detection.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 844629c8c4..ce042cfcae 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -18,7 +18,8 @@ It is perhaps easiest to start with an example:
 More interesting possibilities exist, though, such as:
 
   * one side of history renames x -> z, and the other renames some file to
-    x/e, causing the need for the merge to do a transitive rename.
+    x/e, causing the need for the merge to do a transitive rename so that
+    the rename ends up at z/e.
 
   * one side of history renames x -> z, but also renames all files within x.
     For example, x/a -> z/alpha, x/b -> z/bravo, etc.
@@ -35,7 +36,7 @@ More interesting possibilities exist, though, such as:
     directory itself contained inner directories that were renamed to yet
     other locations).
 
-  * combinations of the above; see t/t6043-merge-rename-directories.sh for
+  * combinations of the above; see t/t6423-merge-rename-directories.sh for
     various interesting cases.
 
 Limitations -- applicability of directory renames
@@ -62,7 +63,7 @@ directory rename detection applies:
 Limitations -- detailed rules and testcases
 -------------------------------------------
 
-t/t6043-merge-rename-directories.sh contains extensive tests and commentary
+t/t6423-merge-rename-directories.sh contains extensive tests and commentary
 which generate and explore the rules listed above.  It also lists a few
 additional rules:
 
-- 
gitgitgadget

