Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BAC00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A9B206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="F94rruDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMXxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:21 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34486 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:21 -0500
Received: by mail-pg1-f170.google.com with SMTP id r11so262556pgf.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvNLEATWQXlU2p9oD9wdCuxAkVUEQK8+E+1dqDjbujM=;
        b=F94rruDaiecLIgZOUqOlC2WB2W8s4UJVGR6z1ENWUxs9GZD3wkOhvIGLTRhQk1Vx8O
         DrOD+Ty6pnu3x1Lts4s7oFtPrQc80MfePjEsp2lS91wKezsKhY5tIG0oc3qgse4e9OZ7
         vcFxg09lptN4AhprJfCEtaTlLd5hB/TBZi4rRgNudfkFd1SSqtnypNVcMn6rJOEb30Bn
         j5cwzIY1m6IJ5FvPMn6i4TxxliziOZDXbswzuCOtfxksY2/UaeJEOFP8WWIJ0LrUULGW
         2sIfKel4RnKUcnQAQLkH77Zdqtz1pOPhhvt+0GlZXYlZkYInV9tFaVRoSYuyGA6WtZi3
         ncRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvNLEATWQXlU2p9oD9wdCuxAkVUEQK8+E+1dqDjbujM=;
        b=RDimt2bp5tvQ6hkR5t7cD10dagmlPufnCkpyhFwi2/9TdVH+vEIKX5JI5fWlQXOcOC
         hSDYn3Cpx1tFIJ19vZdJolFBZVh2vJHacQmkLWDygiBAgjhOOAGmmJH2lGoz/NeUUcS1
         MbyIEMJUsVamw7PY2dDUoVaIkby4mpodKxyivfbRyLfcwV9RPpnwECISaPbxlc8e/X9+
         Ax1FkhMmYT2WCLxB4GHYs0PJZYjxTE6w4E2ggJQjtGFc7UDAZIIUpg8Vd+WZLFn0cHjF
         V47KwwfZ3LXNhrioq96n1ot7SI1eKBsGLLkZxkGgWT4mnky/AKCHwm+yScCMrLTONwfy
         HGMA==
X-Gm-Message-State: APjAAAVXApa3lssOhLtCfHV30ca/fCmXIwzLxQ+30Jw3oRU0/dmqJl97
        IS9yUwxj4dqpN4eDPNufCKpLqvMNqLXUqqOW
X-Google-Smtp-Source: APXvYqwF6A2USGfZxod6h/tJVGK51j9+I3NR+gn6ZeWTdavTYEUOnFgcuVJcbDf3eURC0I737eD8ow==
X-Received: by 2002:a62:154:: with SMTP id 81mr2466275pfb.126.1576281200053;
        Fri, 13 Dec 2019 15:53:20 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:19 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 01/14] git-p4: make python2.7 the oldest supported version
Date:   Fri, 13 Dec 2019 15:52:35 -0800
Message-Id: <20191213235247.23660-3-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python2.6 and earlier have been end-of-life'd for many years now, and
we actually already use 2.7-only features in the code. Make the version
check reflect current realities.

This also removes the need to explicitly define CalledProcessError if
it's not available.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..37777bb9fd 100755
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
@@ -43,21 +42,6 @@
     bytes = str
     basestring = basestring
 
-try:
-    from subprocess import CalledProcessError
-except ImportError:
-    # from python2.7:subprocess.py
-    # Exception classes used by this module.
-    class CalledProcessError(Exception):
-        """This exception is raised when a process run by check_call() returns
-        a non-zero exit status.  The exit status will be stored in the
-        returncode attribute."""
-        def __init__(self, returncode, cmd):
-            self.returncode = returncode
-            self.cmd = cmd
-        def __str__(self):
-            return "Command '%s' returned non-zero exit status %d" % (self.cmd, self.returncode)
-
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
-- 
2.21.0.windows.1

