Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DBC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78E22245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="j2O1raRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLGAds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:48 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:45572 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGAdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:47 -0500
Received: by mail-pj1-f54.google.com with SMTP id r11so3424976pjp.12
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CADdXLVahndlaqvmeSNPYEQFyOBkF+EvJf8IL5MDjU=;
        b=j2O1raRYyKe2aXy8P8O9b8iKuOqYmtMKnOb/NBesXBbV0FsFfbJ2Bz10BEJ9tGR7yP
         a1G4mCOWwOgPy/ZWfrX5J3Kypr4EhiFgrY1Y3Rk39yTf05h3Q0Q1EVvLkKZvXvaD/1op
         LEakac35cwaqdOep/qqOVOWpUZwgs/OmpGE2Qp7G4qBdh+FB16CeOX48Fc8QVNeWwqoX
         ya3gfI/prUAcfpOQVwDLgB8IVCz9Ek5f5/7VQY2wRz4U4iRywg32iwzJBuev55RS5u3t
         RGJ9TkPFQK0c11OvcM4/CXIUnscAfjjx8KBzALPGBTbXdP16JEVF8TgDGJCDuGDl1Cnk
         97qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CADdXLVahndlaqvmeSNPYEQFyOBkF+EvJf8IL5MDjU=;
        b=gz+d62JUz5/Mqv0oLQdWhFC2TEnshcfQdwcIFkKYXihwDjvnIOhzEa1HpZ/1uUjSNX
         HOBpj0Ui8AuqmsT8l6030NWHoK842F4E3bOCvgKdSnzPYyqAVGCGQ7cBL1V6INYiEJUe
         Y7U0iTyOg2PCQZslJmtmN51kIZUuN+OKKfQLpRkl+S3ZUjYjUijkoOeyGRLUO3i7bed2
         sryjiHQgAJFvn/IdOaEnGifgtmrUIjlpCImLPwp/PtFg/qdNCIion4npLGW6AlGI4xEo
         Fv/gKRc3coAusFdgeaiqPwp/aV7ecUVCC8JpOvpW6WOa+u/vt5fwQlJUJQo5x9np51E7
         hr2w==
X-Gm-Message-State: APjAAAVqsaDh+AUai4XOy1a4tPklCMHgCt/zF3D9Rys9QIh7iyyCR9m4
        pOKCLnXaFNyuYgLtRN8rB36JB84jN52Zsw==
X-Google-Smtp-Source: APXvYqx3i1u7mbRvYSbjt6BVGjIfO3+NVeLTbdkRs0L1m2tjM+v3yOqjg+XfIAc/q3Mm+rZDrQaaTQ==
X-Received: by 2002:a17:90a:974a:: with SMTP id i10mr19415780pjw.0.1575678826642;
        Fri, 06 Dec 2019 16:33:46 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:45 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 02/13] git-p4: make python-2.7 the oldest supported version
Date:   Fri,  6 Dec 2019 16:33:20 -0800
Message-Id: <20191207003333.3228-3-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python-2.6 and earlier have been end-of-life'd for many years now, and
we actually already use 2.7-only features in the code. Make the version
check reflect current realities.
---
 git-p4.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..d8f88884db 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -8,9 +8,8 @@
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
 import sys
-if sys.hexversion < 0x02040000:
-    # The limiter is the subprocess module
-    sys.stderr.write("git-p4: requires Python 2.4 or later.\n")
+if sys.version_info.major < 3 and sys.version_info.minor < 7:
+    sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
     sys.exit(1)
 import os
 import optparse
-- 
2.21.0.windows.1

