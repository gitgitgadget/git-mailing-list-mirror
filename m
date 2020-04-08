Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FEC2BA80
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27DC20730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGP/sjvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDHEGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:07 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50465 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:07 -0400
Received: by mail-pj1-f67.google.com with SMTP id b7so512981pju.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEZd3ru7g0htbMk1iD1kYmV9OS4NXcNnckWUMiLwPk0=;
        b=NGP/sjvVoRS+RWXE+XuYy3SZ+hzM6RuIzE8Gy7qk9QE8OBG5LmbWEW3OwTTjLDQpp5
         CIWpyn8CEF4aZULDCSLlfBGlLWvtpWq4X+d/dMB8ROQL+oH7WPIlTcaYwn7jALmlt1zw
         G4u4p+pZ/gj0PX8UYLzYeq0Fnyv3z6o/Qs8vnZmtiA/13Mj7Bl+dpFeOc48mi9HMbLc1
         9Y4h6Y5lPSwxKBmWcBZnVDuZqXGrzB2pCsGwiZmMxZqxhxwFNORgoPNxdtSoUFeDLBXl
         M3Qvf6ePX/epxkH/sXV4+P6+SbMnAcpUY+bpBD4hSCn1GFz/l/iNMwuFIM6lQzJCkpIe
         Mxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEZd3ru7g0htbMk1iD1kYmV9OS4NXcNnckWUMiLwPk0=;
        b=QO3RWLHFkkJmG1rRSBNAXzfblfF2bR1bkiCVCMDVObb6sn3wulAx8PoreY9hpqO536
         oZLCDlU0kq2H/yxrHkW1aibJAr2j3IWEPsKsI9FnhPfmwtu4+SjgPz/FCbGBsGdeQzRj
         bzBJzsjQofW4NGbFTHVb3wqzGaOkWnXVkOLcozQGqh8Hsq9L0gSbAToE6zzTG6t7uhKw
         +RM/O/IwUtOKVD0gxvItPqvaNT1VLn70Rkpz0Mx06WQbdboFWeKgHHl9ciOFhlUiXEFN
         UAAQZNfTegbV2mWyejEZUH8175mjruGXeXHkqnuG13/RQQ4chdBhs7Ed6+p4cPsYi0YX
         F8uA==
X-Gm-Message-State: AGi0PubCXfTvZGvC252i3nerwKGqxOC0l9FeiZY9/3yne6nd1NPRpj6g
        Qa1Knn8gYOg8StdFY4oA7kL66CaoSUU=
X-Google-Smtp-Source: APiQypLXR3wZPWxzZ+6fEGoeMdRghjKw0ivXt4pQMEY/PXJFIYJeDV0c/dxKIZCcVGsikz6c/LKnTw==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr2987053pjl.105.1586318764827;
        Tue, 07 Apr 2020 21:06:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 04/12] ci: fix the `jobname` of the `GETTEXT_POISON` job
Date:   Wed,  8 Apr 2020 11:05:35 +0700
Message-Id: <1df60e677c0b98b010c74914ab49f32a544bc59f.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6cdccfce1e0f (i18n: make GETTEXT_POISON a runtime option,
2018-11-08), the `jobname` was adjusted to have the `GIT_TEST_` prefix,
but that prefix makes no sense in this context.

Co-authored-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml | 2 +-
 ci/lib.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0cfc3c3428..05f3e3f8d7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,7 +16,7 @@ compiler:
 
 matrix:
   include:
-    - env: jobname=GIT_TEST_GETTEXT_POISON
+    - env: jobname=GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/ci/lib.sh b/ci/lib.sh
index 5c20975c83..8b39624f3c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -211,7 +211,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GIT_TEST_GETTEXT_POISON)
+GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=true
 	;;
 Linux32)
-- 
2.26.0.334.g6536db25bb

