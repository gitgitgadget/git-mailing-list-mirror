Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3EC48BE5
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 00:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8B061040
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFMAqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 20:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFMAqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 20:46:48 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423CC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 17:44:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so1730301oor.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZmXvKBYeEeUDtrbQApgaFsYSEgAvFI0iMVjxYGYPWM=;
        b=LRVh1W6s4ihbRD1HhcOHlkWE4Wo6wvxP2cFs4i+9Bo2/Y2dC549ChurtTKJi9s8mAJ
         hI8/lectwV+DxSQUIpjvTsrEUeEbscedWI3KRoa38jYRzI6pN8qUVYmu9uGY6YA83tDf
         zDJyOkiSfs8EyBfgysyJQbbicfUPAEcZpOdC2EptEAZ69eBt29KFqthEEackx9IrXRZi
         e6G74Dsy9Le+31IYLgW93fNriwzX2e6pfZb/s+lP/71lTZHxoW3/dc2E2+QgXEBHBIUp
         VGC5KPsst4w0QYg1Mguvc1/9/HKJQ8rTe/Lei6In9nlLSWycPA8coWXEOcuGxf7F1QQ9
         Mp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZmXvKBYeEeUDtrbQApgaFsYSEgAvFI0iMVjxYGYPWM=;
        b=ZBZ1eGAfoIOx0+PRJ1vA1ZqioCYZOGJORmO85f2bdGkmL0Xi6SlzwksGca1dtIbWiS
         l9gzwJc834Eu5VKUyzCncKDdmcVfYAimfgHNoCqSXeU8EltEl4vrV1VnToeJejJSsvBx
         5J9i6wXhHbywKSnrk0FIY+gxHl3qvZIooG/rjGvcojnPPtsxxb1+mWleECMLdzT+IoJh
         FkRQ3SZhGR9IEWpro/tad+BVWUn6v+bpr1U1kbJSkUsVsncvhcz8kYwun+aYfflZPbM6
         hZgcteAPbS5HFdLwJx90AvMLaIV1fldGw+6m0Fw8CUzb7pL8YbMKt89ZCai7fU+GD5MZ
         bKzA==
X-Gm-Message-State: AOAM532DY4l5zrEAiBibUJ8l6Oeh5C/vboGjq5yiZfn9QlBUcHrXAHS+
        vcsLCJAkOG3h4sDkIqbkhbTi6eH9RAuhig==
X-Google-Smtp-Source: ABdhPJy/OWSvslIeczuezC2XGvPEf4HTCF9svzJd7hH+bpnGXWCyGXTnqCaNhbtohRJE/n87fbIY2A==
X-Received: by 2002:a4a:3e8e:: with SMTP id t136mr8558695oot.83.1623545078635;
        Sat, 12 Jun 2021 17:44:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f2sm2121810ooj.22.2021.06.12.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 17:44:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: revisions: improve single range explanation
Date:   Sat, 12 Jun 2021 19:44:34 -0500
Message-Id: <20210613004434.10278-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original explanation didn't seem clear enough to some people.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/revisions.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f5f17b65a1..d8cf512686 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
 
 Commands that are specifically designed to take two distinct ranges
 (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
-they are exceptions.  Unless otherwise noted, all "git" commands
+they are exceptions.  Unless otherwise noted, all git commands
 that operate on a set of commits work on a single revision range.
-In other words, writing two "two-dot range notation" next to each
-other, e.g.
 
-    $ git log A..B C..D
+For example, if you have a linear history like this:
 
-does *not* specify two revision ranges for most commands.  Instead
-it will name a single connected set of commits, i.e. those that are
-reachable from either B or D but are reachable from neither A or C.
-In a linear history like this:
+    ---A---B---C---D---E---F
 
-    ---A---B---o---o---C---D
+Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
+commits, but doing A..F B..E will not retrieve two revision ranges
+totalling 8 commits. Instead the starting point A gets overriden by B,
+and the ending point of E by F, effectively becoming B..F, a single
+revision range.
 
-because A and B are reachable from C, the revision range specified
-by these two dotted ranges is a single commit D.
+With more complex graphs the result is not so simple and might result in
+two disconnected sets of commits, but that is still considered a single
+revision range.
 
 
 Other <rev>{caret} Parent Shorthand Notations
-- 
2.32.0

