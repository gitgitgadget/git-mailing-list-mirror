Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB1C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4317761165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhHYCXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhHYCXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FEDC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so13410084plh.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSdJD/zcXLyFdHkY9uKDoUWKgqf53ytifKQnKDMMuXg=;
        b=jZoEWInTXOf5Oo5fOwlqQx4xp3isbtTLoWAXK56d2T9h44dt61ikeuKuaytQl/aZjm
         W6U3b3TZCMGxNf5kYAiBgddKDnVXFPBq3M9lXU4hcSAqXJAFyrsZSIllNyitaStaNTcY
         Sy1AJ4+4JU6V4aczZITzQaTyiw4apGGFtYSvR5rkyUtj+Gwi9zNXChP2sQ/jFDUKhOT8
         dLuuBCw6/dssEyEr5ldia7Vk663XA+cTvabdBrx8QWn0966aeG9hUGqCDwpNULwOIpx0
         8qb46CgJ1zhIpuUFNphASVTKaGCta+V78aU9SalBluyPFi0aZpldZTFIQJFNUONlW/47
         73Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSdJD/zcXLyFdHkY9uKDoUWKgqf53ytifKQnKDMMuXg=;
        b=CWq4yxjc2UflItvfP/orFLbrB19oIUt4B9tuDtVkDAPNrivw/zDkbNpY4TA29Va31o
         b20kyP/09O5ZckkQ1r2xL/nkRmFBvhOu6RAk3U32cu9OkT2qFQQbyeYOd/+KKG5O3D//
         f0IXXqClgDLjEdxEURq2YYXe68Vf0Tl1oCFg59IGv/eMqrQRyD3kQCajL9cBI5dZaip6
         NDDlc+jL9OwFfp1f47ZCWFSdlxPo0SpEzPBo/cd3NElXJCCUZPhXYqLgawn6sHe88NzO
         GTIG8W/1duIelPDl+xNqMIaRMYzfAPGk/N20UU0ZSnf74QtklUYsuw2rcJR5/iUyf/mn
         uGqQ==
X-Gm-Message-State: AOAM532WalAOznISF+frwh1lobpR/+l56116gpCVrHLnndrjoY8NwaCr
        gDC0Ys0HWymck5q2Yc2e1/A=
X-Google-Smtp-Source: ABdhPJz1+hBD7+oEEYV4OM01f7c5EkrlvRD941ePavjizxw/f2hlr/N9+o+AEn8Y4lNyMuabTA4l4g==
X-Received: by 2002:a17:90a:5583:: with SMTP id c3mr7594784pji.133.1629858159126;
        Tue, 24 Aug 2021 19:22:39 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:38 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 12/14] packfile-uri.txt: support for excluding tag objects
Date:   Wed, 25 Aug 2021 10:21:56 +0800
Message-Id: <c83db0055cf71d4db6893379f5fb41958f586001.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index c3e4873956..bf5939cb8d 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -39,12 +39,18 @@ server to be configured by one or more entries with the format:
 
     uploadpack.excludeobject=<object-hash> <pack-hash> <uri>
 
-Value <object-hash> is the key of entry, and the object type can be a blob,
-tree, or commit. The exclusion of tree and commit is recursive by default,
-which means that when a tree or commit object is excluded, the object itself
-and all reachable objects of the object will be excluded recursively. Whenever
-the list of objects to be sent is assembled, all such objects are excluded,
-replaced with URIs.
+Value <object-hash> is the key of entry, and the object type can be  blob, tree,
+commit, or tag. When an object is configured with `uploadpack.excludeobject` which
+means that whenever the list of objects to be sent is assembled, the object (also
+include the related objects in some cases, the following will introduce) will be
+excluded, replaced with URIS. The mechanism for exclusion is as follows:
+
+	* blob: exclude blob object.
+	* tree: exclude tree object, blobs that the tree list, and recursive into sub-trees.
+	* commit: exclude commit object, and recursively exclude all the reachable trees
+	  (ditto tree exclusion) and blobs it contains.
+	* tag: exclude tag object itself, and the dereference commit (ditto commit exclusion)
+	  if the tag is annotated.
 
 Configuration compatibility
 -------------
-- 
2.31.1.456.gec51e24953

