Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF2C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A936B20663
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmwlXoVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFGJsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgFGJsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 05:48:38 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB4C08C5C2
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 02:48:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so12389149qtg.4
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLrhIobyg7qPUD5ywtJziY54AkWghLsERboA0ayV0qQ=;
        b=XmwlXoVPEImHjbaTeKeiSvytRHruycyp0H0xFd46Y+CS6BWJ37tqT8xBSQEmUUSBfB
         Q+7LD9RcdoOon7942hUYq1yaQEBWpTAQEk4LxV/6mDNt93PD+YSUVYG9alW1S4v/RLIz
         kaXF3UD9hyNE7DYPEZGodwd9TwCv313JiBY5GEpUO25iOI0DDazXGo/68h7db1EPSDo8
         gowmWj344Fa7tQ2UUrDTdxNSOyqAVlbPbU3dJXzqKtmRBlMtTC1oVVkDSf+7jam+EQGV
         LOtxeMXE/+OrnDNw5AHdcHWD8f5A9i4Y0i/0xr2OT5naW1ZdOxH3ktgnRZA+TUNSPzAz
         1PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLrhIobyg7qPUD5ywtJziY54AkWghLsERboA0ayV0qQ=;
        b=VFkvsZm1AYCRGgHF3ayxTi1ZwXx73CX2dAPgTpQ+GLfX1KYltYxNKFeCO+y5ObUYSS
         BFEGJdvtrAELjtTiaflPyVvfJ2KOdtBnLypz/FGRQ+yo3eYWgGS29OPFA950BXlJlu79
         RV56VA24/o/dnb2ODsbxRNAcwlCXNNsN0Equg+WWaIuZbruuHxOHmyXiKAYavQ5z3KGT
         Re/Oj1jLBLd+gnmmAvgjQyOk9S4EfLZZrTbfJT8FCgw8icpobsMS00C7A5oGYqYhXCRb
         DUrDRb36uQq4BcNY44QWhlIoyXb4s4o6rojbhBC26LM+fSxmQufqT1ILaxeP5BXhC6+N
         IQNw==
X-Gm-Message-State: AOAM5306FT3X7OsRgf8IuaJKpzvxcNSLUmCuvP5P5oh8xh/DYSREE1rx
        wJCpHMS2eElnPlLn/JoCzzr7/ieQ
X-Google-Smtp-Source: ABdhPJwn+LYklVPDWH+Sy8lVXImClrHyPU0NfYrN7/1GG13Xcr0X8gDF0b583dcsllp3hfUFD9Cirg==
X-Received: by 2002:ac8:1bd2:: with SMTP id m18mr18471404qtk.64.1591523316402;
        Sun, 07 Jun 2020 02:48:36 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id b53sm4848354qtc.65.2020.06.07.02.48.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 02:48:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t/README: avoid poor-man's small caps GIT
Date:   Sun,  7 Jun 2020 05:48:26 -0400
Message-Id: <6cbd5c34b5cba6087cf8ee900e3a8285d2af2603.1591523289.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.107.g134631ef42
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 48a8c26c62 (Documentation: avoid poor-man's small caps GIT,
2013-01-21), the documentation was amended to spell Git's name as Git
when talking about the system as a whole. However, t/README was skipped
over when the treatment was applied.

Bring t/README into conformance with the CodingGuidelines by casing
"Git" properly.

While we're at it, fix a small typo. Change "the git internal" to "the
Git internals".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/README | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/README b/t/README
index cf863837ab..70ec61cf88 100644
--- a/t/README
+++ b/t/README
@@ -1,7 +1,7 @@
-Core GIT Tests
+Core Git Tests
 ==============
 
-This directory holds many test scripts for core GIT tools.  The
+This directory holds many test scripts for core Git tools.  The
 first part of this short document describes how to run the tests
 and read their output.
 
@@ -1117,21 +1117,21 @@ Tips for Writing Tests
 As with any programming projects, existing programs are the best
 source of the information.  However, do _not_ emulate
 t0000-basic.sh when writing your tests.  The test is special in
-that it tries to validate the very core of GIT.  For example, it
+that it tries to validate the very core of Git.  For example, it
 knows that there will be 256 subdirectories under .git/objects/,
 and it knows that the object ID of an empty tree is a certain
 40-byte string.  This is deliberately done so in t0000-basic.sh
 because the things the very basic core test tries to achieve is
-to serve as a basis for people who are changing the GIT internal
+to serve as a basis for people who are changing the Git internals
 drastically.  For these people, after making certain changes,
 not seeing failures from the basic test _is_ a failure.  And
-such drastic changes to the core GIT that even changes these
+such drastic changes to the core Git that even changes these
 otherwise supposedly stable object IDs should be accompanied by
 an update to t0000-basic.sh.
 
 However, other tests that simply rely on basic parts of the core
-GIT working properly should not have that level of intimate
-knowledge of the core GIT internals.  If all the test scripts
+Git working properly should not have that level of intimate
+knowledge of the core Git internals.  If all the test scripts
 hardcoded the object IDs like t0000-basic.sh does, that defeats
 the purpose of t0000-basic.sh, which is to isolate that level of
 validation in one place.  Your test also ends up needing
-- 
2.27.0.107.g134631ef42

