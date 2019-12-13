Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D515DC00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB945206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="B4L6jYnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLMXxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40456 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLMXxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so2292949pfh.7
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APGGNcfznxbhrfNSjyLU0pW4ZC5c1b9GUWn09pwP3PA=;
        b=B4L6jYnWGyHKZo4v6tDnR9Z0MpCD7822QQnCTwm8WCxrAMVDhv/3LnvwfcoP//ZN5Y
         774Rm5T5ZPBB6F6fCXvCoL47lFOwKq5WI7Mb6ftv1kf6/4ssC5+eWZEnsHsAH8cjxSVm
         CpL740f0nK5hN5EkU3HwP9yTTvnIO1WCp78olfnTHmtOXkbIZu3wJAEKBhKH+KFG9ZPM
         Xl5EjbAia/8TiKe/Y3NrtzOO155iW4IrXs54TwphxKG779rtp7CGWx3Vro0qb+nBIaI1
         XPVpIY3jq/1ljjVdIuwn0pfjvI96RjREBr/lq07dQZetepftzfuUdfi/Qiri7Ln23g7w
         5uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APGGNcfznxbhrfNSjyLU0pW4ZC5c1b9GUWn09pwP3PA=;
        b=gezpKwdRnxXCW4jZxJ6MDVp5oFk9uzNmigL6QZslQse8acsGGiFVMlz2Kc8U/SHitI
         OBXJvjmF2Xy2W8I0VZIgXkk7bvwUqjS9aIp33JuZLzRvcuBSFO3TPhr1fmwj/AxXrGn4
         LyPZVkEEY3cJIm7x0OK57Yw4tZwtsdx5XIM6N9yYfqt+z7eZFbNwt8K5uH89C2mgEP/I
         dDhMzPmY5lMF38ALpLEt01bC3cx0YLcNBdvUWohgASTnGQ4cAzzDhnJxcLbHQeE23ewm
         mQgGgmNXbLg4sRhH8DOwZojK+9W3NRNFjUzdoHbeteDJAuIa360AZbBcRlBA4hZn5R03
         tLsw==
X-Gm-Message-State: APjAAAVvAEpe5pQ9M25S+6ZBqI3Bq4VGUj45aPWsa7st52XY8p8cUAzs
        cjSjIzKXmnVj/SKGkPjqZe1uS2ks0eYtcw9P
X-Google-Smtp-Source: APXvYqyqBillTFwLMuqSaoytTIYHhaFkW1yWyAZzFZi0JjPyQPAKq5sfFNwpis6AimAMlE7VG65z1Q==
X-Received: by 2002:a63:647:: with SMTP id 68mr2449682pgg.202.1576281209880;
        Fri, 13 Dec 2019 15:53:29 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:29 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 10/14] git-p4: use functools.reduce instead of reduce
Date:   Fri, 13 Dec 2019 15:52:44 -0800
Message-Id: <20191213235247.23660-12-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
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
index 68f9f4fdc6..7deee1b939 100755
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
@@ -1158,7 +1159,7 @@ def pushFile(self, localLargeFile):
         assert False, "Method 'pushFile' required in " + self.__class__.__name__
 
     def hasLargeFileExtension(self, relPath):
-        return reduce(
+        return functools.reduce(
             lambda a, b: a or b,
             [relPath.endswith('.' + e) for e in gitConfigList('git-p4.largeFileExtensions')],
             False
-- 
2.21.0.windows.1

