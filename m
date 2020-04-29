Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C31CC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B4A2073E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgjn7N07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgD2Jif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2Jif (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 05:38:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94166C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so822131pfc.12
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qOwEeinbVqx+UYY5VFmoBU1ACTweIPnGxyxsZHBkyw=;
        b=bgjn7N07LmdQKWqeNEh3lTHPtTh1kr2jiSDJFfWFXxk4EQAq/Qq7JseIuZeb5Qt/Kt
         A8/qGFgqxsj+OB9HgW9NMRaMgtXIpiJSXzM22fhbwzXfKhHvVTMR23oevcz+11ZQr4Y8
         5wBcP+K9Sjk0jYoNRUT0tQ4AGFRbenCoWyGQovQUYpagiBqx608g1mJ9tYYi/Aavpd1a
         s1/zs5W2Pzc27RLQSLJl2AIQQCu2pFlCDQjGIYE6Um9xjMk4JNT/CXO8IiY/8pkhlzV4
         mMEOFtCXwKqjoG1Iz/+HuBPsVZafCXMukhq7cpRMi1ScS+4+1DuJcj0/DjWNX5PAGOUf
         BOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qOwEeinbVqx+UYY5VFmoBU1ACTweIPnGxyxsZHBkyw=;
        b=EbEGpm2as0QT+C/aPpunrEMX+0QaQK3uAWTYC04Cc/REanuG5ygu6qTmKOzYqxZpKa
         1jzwwgozatNtfetfce+4OQq1QLcUk8K4BvKvKCUU/HmhPX9OwX6tGgI44j95WE681Njb
         7BYyrOoVrn04dSae/h2y+/xKpLpIdi65m5J01NooM6hbnag3n00MFTxp0XQ45afXH40O
         v3S9j5OzVdC2Tftw9ZOYjraq+jnUzBR5pwY0pXw48JzXrYmoKIksaGx5wcNJVjmhoiF8
         fSA73dljnCXJdUrcz6V3e51PsWBgp0O46y+8NBWm/NuBbxoahstOkC+Tf9dl1hcqf6vn
         tGUQ==
X-Gm-Message-State: AGi0PuYYjj+YKEVt1HRWFbVhrPFY2w26TldppDpWPxb83Au5h3FVVZBI
        TDOMh6Fy0XPBE78hOm7E7TGGe9Ykywo=
X-Google-Smtp-Source: APiQypK2tFEUjUNtI+Fs7tR2KS7AYaJ0SOPLgX8VI9HB+0v733P+idBefHXpm/1KQ0+y0YePIk9o0g==
X-Received: by 2002:a63:c604:: with SMTP id w4mr31490271pgg.270.1588153114601;
        Wed, 29 Apr 2020 02:38:34 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id o30sm667721pgn.12.2020.04.29.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:38:33 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v4 1/4] gitfaq: files in .gitignore are tracked
Date:   Wed, 29 Apr 2020 15:08:08 +0530
Message-Id: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
Git tracking files/paths mentioned in '.gitignore'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..b1e758ffd1 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,15 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they are still tracked::
+	A `gitignore` file specifies intentionally untracked files
+	that Git should ignore. Files already tracked by Git are
+	not affected. See linkgit:gitignore[5] for details.
+	To ignore and untrack the files appearing in the staging are
+	it is advised to use `git rm --cached <file>`as well as make
+	the file pattern is mentioned in the '.gitignore'.
+
 Hooks
 -----
 
-- 
2.26.2

