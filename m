Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F0C2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329AA2245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="XeDZF6nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLGAdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:54 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45754 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfLGAdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:53 -0500
Received: by mail-pg1-f177.google.com with SMTP id b9so3738403pgk.12
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/26BeqPQxq5NRAsqzlKRP27DLVO1x3i1q0Qn0Vu3Io=;
        b=XeDZF6nGpyYMKYflDFW7VdCda/LkrOFIs2yN8eVdoQiq9T33CUu/YTFi6BQUV2e+pi
         qC6Ltf3OXR+FFJtPkSP0YtWM9wj7SWbGliVi5mKxqsCIP7w/3k5lULOEmI38kmykmYj1
         jC0HIhYZaxNiMw73KmccEtrHOV9LnMpblyuHP6+5pCkR4tb01x27XqmAPereU0ym/WN5
         N54M35pCpSVNhTQOYgZ7drO7zr8/0ST0ZQOFMz3lIXBEy//XYJiNwqKLEOlNCIKb2FJH
         vOWKbg/3fmXP4gP5SyyFi7LqsFpXdJVuwF+s+bhIhgK9fYNqi1HgDjR2O3tj3ubdv+s0
         OZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/26BeqPQxq5NRAsqzlKRP27DLVO1x3i1q0Qn0Vu3Io=;
        b=cMYFpZR2duA9kcFAYM+Hj/V3pXuTG6NX67CrlO7uKf+VcdFIraNnTEmJwZC0+QiXSK
         rryVS/0qlibdWBTvKBC9CIChQ6raY+sFa0RU8TCyaSKzr+9OggBq/2yvJLz5B7Yd9J36
         YD7NLQnxmdLaaER11li2R2LEua2mohvxFdXllN3gPGLm67VvyS95zJ76xn33TdZMINCw
         UPNTUTEolsHO8R4j8bxsqxSTRFktP4dHhNBkVTRC9A2xTLxXak0p4gHSUMAHz3O6Xy1V
         FKweO3U/UdpRjuCArqp8vm4f0SER24NiSLXm67W9PR1qo9gBUtQUhIVEmpkO8guwvglI
         JTAQ==
X-Gm-Message-State: APjAAAVHHqFpj135HIwJEYGavzDmRTqLXGX3/g4fwRXMM0QT22nw1XS0
        LUSZ/YsyQYjz49P9cHYSlds6LUV/082d3g==
X-Google-Smtp-Source: APXvYqySL9fz/semqynXkWoYUnbTQrdSJ7Emi0Lul0/SQHpo0rb8M2jMVPST4xXNCLY/8IfZ0TTfMw==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr6900125pgk.442.1575678831923;
        Fri, 06 Dec 2019 16:33:51 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:50 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 06/13] git-p4: open .gitp4-usercache.txt in text mode
Date:   Fri,  6 Dec 2019 16:33:25 -0800
Message-Id: <20191207003333.3228-8-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Opening .gitp4-usercache.txt in text mode makes python 3 happy without
explicitly adding encoding and decoding.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c7d543b18e..bd3118e0e8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1402,14 +1402,14 @@ def getUserMapFromPerforceServer(self):
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

