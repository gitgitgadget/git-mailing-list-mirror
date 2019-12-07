Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A4C2D0C1
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBFD205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="nwuJ1I49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLGAeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:34:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42476 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLGAd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id i5so4130638pgj.9
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/vHReJiSdSY85lqadR7LxXCOR/zXJ/7mqcdAb++m80=;
        b=nwuJ1I49wIf6moyRQEvircAtVQX3cJYKWaJo/L0/XfVMBKoN6sMZUSJnzoZPn5PtOO
         3BdRkVoT8H6qtOTUoP49ndDKbh+F0u4SXvrpSe0YWA1FbxIGPEGX991i3zvsY1qIURVR
         YV4RpR1WNxwf/u2DWTFr1kpXyb84uFXGVLMUzL7UrlO8K/6wxeNIMAMsAysz2LIy73sc
         iS5ZdAWQV4yarqP2T2vJ4M0OU5wqEst+J8L+Pn9tkhtNd98jLpFw6uPTACf5kP19BzCE
         kcKENB78Pny0yRKyDBZPt07KTTZ8jL3uY1hlmdwxid0NV+omJiND5LVxsqhfJbuRE4Zj
         NYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/vHReJiSdSY85lqadR7LxXCOR/zXJ/7mqcdAb++m80=;
        b=c0pHIazo9e27YQ+ezPbiXNMuYxipRB+L42o9l4buhp6EmgkXjMVzfS1zSNxYvkksMx
         swKaGJPhKW42XcstYmoio9HvDgtdZfQsqoopsfDwwihioUX51LXLp1vAWph9uTy9lu5Z
         lfqn9qX8OlLVtbmKpIS7bkn1/7supOv4L+F+J9qJgYZTxoQoUW4WJ7WDaww7W+PdMdIZ
         ijhMHkhvQi5pZ76X+Ry5d2BH5jhHJrvnTrqj1QUaumwKCtwBNyIGWMFBTh16tCqDiTUB
         ioGt67oq4oD2rPPZ8zmpAExJAzL/8NlJ4WOBzwSPDyn1EUtb/Bj9DZ2rMKucUqUt7QqO
         z+fg==
X-Gm-Message-State: APjAAAWY2jydfuWWFNemcFg74S1Lp6IW1b/wvqSTkUQX7saPw5ZwoD9m
        iq+r2We6iXJO74W3XFKLO6WDfkfZ9Ig6Mg==
X-Google-Smtp-Source: APXvYqwMRdrMHqVfJxu51Er79IitdE32d/iVa29NJnyw9ztPV28xGr+IMp8ZTKqEjw9LOfutOOMkkQ==
X-Received: by 2002:a62:1687:: with SMTP id 129mr17684638pfw.44.1575678838322;
        Fri, 06 Dec 2019 16:33:58 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:57 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 10/13] git-p4: use functools.reduce instead of reduce
Date:   Fri,  6 Dec 2019 16:33:30 -0800
Message-Id: <20191207003333.3228-13-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For python3, reduce() has been moved to functools.reduce().  This is
also available in python2.7.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 1007b936c8..c888e4825a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -13,6 +13,7 @@
     sys.exit(1)
 import os
 import optparse
+import functools
 import marshal
 import subprocess
 import tempfile
@@ -1176,7 +1177,7 @@ def pushFile(self, localLargeFile):
         assert False, "Method 'pushFile' required in " + self.__class__.__name__
 
     def hasLargeFileExtension(self, relPath):
-        return reduce(
+        return functools.reduce(
             lambda a, b: a or b,
             [relPath.endswith('.' + e) for e in gitConfigList('git-p4.largeFileExtensions')],
             False
-- 
2.21.0.windows.1

