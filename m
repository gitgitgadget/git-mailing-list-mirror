Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A2C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F6B2078D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHrlO0Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJSio (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJSin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 14:38:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E46C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 11:38:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k6so6943490wrn.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=moSxWm42cLze6zIUdKAzKWBgf9DgSsorw60OW1bmpOI=;
        b=lHrlO0VfWCiUADwOMULxFhdXtNzlZgHGSv+j7ANzlXFmrK26dY1p36lKA2P/CRwlLb
         ig4fY9NF9DSCwntwRopWFcUyzkH4T9t8ytSteL0GdKOj+bmJA1fwpbkcfYrs1SQMLPsJ
         Yw5QkOyOLEHiQ4G0qQjTXRHMhcK+DmXA4hv1k7NAg5e3um0F87IX5r+89VK6m3DEK2tk
         ykaL8T2RLhkKyEj2if2CPDvz9lMWQ7nqysW60QvRKVASGAAVvXTD9BO5fQ9wd8geK3nq
         LFOrKupZGAT5Qr0Q54ZUusrmJHHoPYNgSSV6z2wshqTFSgGn1OkB6BQxsZEj0RPIi230
         gCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=moSxWm42cLze6zIUdKAzKWBgf9DgSsorw60OW1bmpOI=;
        b=AuU03pXPRfw8yrQgjRj3LqLdFstgY9mrc+7GEvzMu77e1CWCV+zIUnTuea+BI0GuYb
         rwi9bMOtz5brY5Oqg65AOOzWepVbpDv/mJNhg458TJRlHDBIKa0cw5hUhJZGeiNaHm7u
         duDLF1RzhULi4XGhYDz5tb9ctm9Z8e2twWFDVchBw6ScwtHk9tRT/P+FltIWV2eN4b1t
         75XvfGVGBxtu9zVwrPrsm3LJXNs4zUtVaIqG1TqsO0etUJ6rBmgSCWvT8Vx9QgBUyL9K
         2lj9SMo6Sk/zjGOqkzJ5S6ONtmHVUkZTD3wmV9vm1+6tlBH7QTFXTMZKfukGzPasztii
         HTug==
X-Gm-Message-State: AOAM531hhd5K9cjPVHVL/bKUS6lcoN67auV/dTGtUxe0NqABBvJfXXNt
        AAGxwqPuay7ohgeQ8R7obzmDMqvsAzIUdWcxPX1NObwvUNs=
X-Google-Smtp-Source: ABdhPJwnS/fQnEyd4v2iGtMrr1LZoWU3JnU0Io0sp3HfvLz0gP3g7Amlbx+eKFxQSBHNK0xPRgRIyINdDwkQLlsC3rs=
X-Received: by 2002:adf:f14e:: with SMTP id y14mr68969463wro.151.1594406321607;
 Fri, 10 Jul 2020 11:38:41 -0700 (PDT)
MIME-Version: 1.0
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Fri, 10 Jul 2020 13:38:30 -0500
Message-ID: <CAMP9c5k5kLSqhCh9400iLdZ=+-nKonavOYpBSs_NHdaVVJ_ycQ@mail.gmail.com>
Subject: --function-context shows wrong function in chunk
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using --function-context, the function that is claimed at the top
of the diff does not match the actual function.

Note that the change exists in main, but the hunk header
(terminology?) shows other_routine.

$ git --version
git version 2.27.0

$ git diff -b --function-context
diff --git i/example.c w/example.c
index d87b59b..346e2a7 100644
--- i/example.c
+++ w/example.c
@@ -4,5 +4,5 @@ int other_routine() {
 }

 int main() {
-
+    puts("Hello, world!");
 }

Zach Riggle
