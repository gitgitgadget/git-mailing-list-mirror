Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069201FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbdDKIdl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:33:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33491 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdDKIdg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:33:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so13538842wmb.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mz0/xt9n0QOCql12CpMiq5ojxUtjjW56bcX1w3jchpc=;
        b=BsBICEf8FT581saN9dNRc2nW4CPlsNEQPjRn5YPc0OQ7T8lIHSs1Awj7B7KA7c7bmZ
         d/5/43xHvXL81CpS368WvREwXLQ5wUF/tzK/S73cwSyUIvphTLkhK2xupPd7l2QSFjFn
         G7LzslbodSJ2DJkfhysHy0i0WmaYKmt5hjxPHkMoOWT8qAq6FT/LqQ2eMMVlBelWIfV3
         aXmyhlilvdVHvZPpPqgUa2K3Y3b4ufPdprKYbQzmgT3WiiT8hMhy4JDbMDxnkXMWQFbU
         DBN86tkK2QX/vs2kCDtmio24FvoG3QxblhAokeGrqUT1hPai6MluQIlVRSYSE51l2PPF
         Gasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mz0/xt9n0QOCql12CpMiq5ojxUtjjW56bcX1w3jchpc=;
        b=Vys6L0nO8gAeFMbdY+YJBGjygX/9tfo2+g0fG9AFUGCvUHII/WZHtX6fAIDMHQnWZ1
         VMWKlVUbr546DkJPvANxM/GZUy1KnWJthclrWvGfc3owPLWOW6NU+DXB1hlhK7wb4y08
         yhrkZX9OFodT1sWmDiC5K52kqd8wSjZCUAWatY+NGU/qnJcDJRu5xH6PWOMKvBmSaxvp
         7V/4Ulbk8JCRsTgNjZ+E82Gh7ZOZm1RON3AIaUPNWfqQFla4FxbKp6Ds2Xsy1tbfoiLh
         4dB34xyJhgSYaz6HsiM/Y+D0AiNOapVFrJxFKL3ZGTfYjqu5IH2ZhSNO0ebmd2iqr4lC
         Ynyw==
X-Gm-Message-State: AN3rC/6/jMFDI85bu/6ENKNfzlYIx8KgBqXtdG3NWNvmHK0O9ltU9FDz
        OT9A15hsbWoDZbzM
X-Received: by 10.28.152.18 with SMTP id a18mr7076810wme.35.1491899614937;
        Tue, 11 Apr 2017 01:33:34 -0700 (PDT)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d17sm1499083wmi.21.2017.04.11.01.33.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 01:33:34 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net
Subject: [PATCH v1 3/3] travis-ci: unset compiler for jobs that do not need one
Date:   Tue, 11 Apr 2017 10:33:09 +0200
Message-Id: <20170411083309.58315-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170411083309.58315-1-larsxschneider@gmail.com>
References: <20170411083309.58315-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TravisCI does not need to setup any compiler for the documentation
build. Clear the value to fix this.

The Linux32 build job does not define the compiler but it inherits the
value from the base job. Since it does not need the compiler either
because the build runs inside a Docker container we should clear this,
too.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c26f3bf789..e5e7c3edd7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -41,6 +41,7 @@ matrix:
   include:
     - env: Linux32
       os: linux
+      compiler:
       services:
         - docker
       before_install:
@@ -62,7 +63,7 @@ matrix:
         # root@container:/# /usr/src/git/ci/run-linux32-build.sh
     - env: Documentation
       os: linux
-      compiler: clang
+      compiler:
       addons:
         apt:
           packages:
-- 
2.12.2

