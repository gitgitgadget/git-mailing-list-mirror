Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2EC00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CE622527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="lFVMXnSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLMXxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:30 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36757 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLMXx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:27 -0500
Received: by mail-pj1-f49.google.com with SMTP id n96so391064pjc.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voJ5PIZDOMnXJCToHfNX4qb2Z1KJm1SJx9O0w+hWOdk=;
        b=lFVMXnSDAcE/6vuQD3d7nxbFo+g3XStvF+Qk01q6flmNWJpltDuD4J3iEBEAfX7UoL
         Kl80gH1OGUhlsr6AeKPwTW7PbC2y1hphJd9WnABfF6eXXzZQiqfu3avwkuCjxk7/VXYA
         4RTbgxIJZDEgQtXiqDYC30eJYzH4fEwHpf66QmKWKWLcEYzb9CYqsoxV7BPbdH3b+k1K
         bUiI5ZTOpCbS4ApWs9uP0oxMP6jbJ2mDPUD6fwelkYldoRn1ahOicCizzN9fO5N45tFn
         4GvvhRjfcF5Mis0MR3VmZEHGSbZKBIEt4Ak1PVJgPIFJzqZkijb6Vdq/bDj6gJ2KWO5a
         aFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voJ5PIZDOMnXJCToHfNX4qb2Z1KJm1SJx9O0w+hWOdk=;
        b=TDwpXK6Ui463wJsDt4yL/Cdfmj4oC0lWjy+/Eu5XU2J9ARqLau+jfa99x+JJ62SnUw
         6hHLlik3nYUcRd8FyFyPhWdoWOiRVAC7b4A9J7jo7vDNqI34C5LbsolD57u08OOaTZUa
         COl947PO9dl00/z3qrVnv2HB93bqYwGsO3F+foA2ADLCgI4m7BptOQmbHWnnPbB8FBOL
         l+vc5iaAz7a5PcMeqB9Df7Gxqr93mtSZLyn9A/vPKnX7yNSxbjolLyZzXX41Yu5CMa4g
         65iHWpQ7pjFmrrnJ9/QrrGp5pnbLI8U4DhOD+K9prgTSx9Wy4Xpl9UpKV85X2zXwEC6q
         CwJQ==
X-Gm-Message-State: APjAAAUOeN3EgkBeVaFW+N5Cg5+1OqCFGlvAWYUvYZkh8qpcge3+hLsP
        6Q1J/dHZetfEURZeocMdyvY3c+AZUJi4RioV
X-Google-Smtp-Source: APXvYqwaiwhyyzq+e6T7EzvS0TpHdE+qnCX3Yt7cj5ktYr+NWKocOCluJ+RL86e0JuE8bLNXtUWCUg==
X-Received: by 2002:a17:902:ab85:: with SMTP id f5mr2317543plr.102.1576281206801;
        Fri, 13 Dec 2019 15:53:26 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:26 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 07/14] git-p4: open .gitp4-usercache.txt in text mode
Date:   Fri, 13 Dec 2019 15:52:41 -0800
Message-Id: <20191213235247.23660-9-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Opening .gitp4-usercache.txt in text mode makes python 3 happy without
explicitly adding encoding and decoding.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d43f373b2d..abcda60eee 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1395,14 +1395,14 @@ def getUserMapFromPerforceServer(self):
         for (key, val) in self.users.items():
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), "wb").write(s)
+        open(self.getUserCacheFilename(), 'w').write(s)
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
         self.users = {}
         self.userMapFromPerforceServer = False
         try:
-            cache = open(self.getUserCacheFilename(), "rb")
+            cache = open(self.getUserCacheFilename(), 'r')
             lines = cache.readlines()
             cache.close()
             for line in lines:
-- 
2.21.0.windows.1

