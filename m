Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D895AC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03AF20880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="MaioPWHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK1B3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:29:11 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:34351 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfK1B3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:29:09 -0500
Received: by mail-pj1-f48.google.com with SMTP id bo14so11075550pjb.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jirMrtMbbfygz0Mvte69eBi0wwNFaFcYUyLoCS+ocHw=;
        b=MaioPWHW/Ab2pCsYxA/taA4JOdhpPaqnaIHD6hs7DzUdJ327jMSm+ZLh5DNjW36oEX
         HgYg2W/3VEloNxyb+vm8FVTyUZFPcytkiH2v4mYjGozE2xyFPdRTuriRBCsHv2RFvwt9
         6nv3x+Gfyp13R3yUpOJ6/N3Hmaoemdhf2kFCuQY69JyO/w5V0/S4Pe6q3Wm2H9VT2fuY
         5XrehyzQ12WCwVvYH4CH30t4DkqAnHw7+Cw5JglYw6J3CJp4xiQh2O8YgqmR9QBZH5Wt
         LF3wVr9tfL6Ibw6EHNg7zlp7G+RPZxY4hNmP0EVgNWV7KR4GFV7RiMfDLbpTWyBY0BtB
         KN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jirMrtMbbfygz0Mvte69eBi0wwNFaFcYUyLoCS+ocHw=;
        b=iAeE9Qks9VSMav46hhFTn159U8+0z3SlODuuPfE6jeBY2q0xJn4F2KL1kJ2RbzkvtW
         qjEk8IFvohezDIsN13xIjfRHvsD8COJvD7qTvEuBmlsD4jmaAYX8nzcOl6i9Xp+Hy/T0
         jtNkRVA7X31pIH69PBKgh3BFNEcsjrBaOUogtNZSNs4UeEXla50cRcoXRov5wPyNMhHX
         OpMz/Ju7WowsIeDitrmRpe/B4/y1om01pJHrTKXLQqfKehkOaEJf4I4WOvy4kLSxBa57
         ygk2QDsEY4oPGzIQJGfdPsmdwGWDR92vTzSRNkU6FVEQoevjTyQzPtA2VcmjDrKh6BOZ
         2XYg==
X-Gm-Message-State: APjAAAU9a+vL8jaS7Ig25jnldIzkKkzWZ07zhn7W7H/1uwCGZylgJi0c
        qlrEsmkypmlCAbGWQzL9aMoUKv3Vwpcy1A==
X-Google-Smtp-Source: APXvYqxieo2B/1y/aOJgd2JNNZK1DpQcgTVOKDhSTjkcRTE1y28CJQsjWFwH/wj8ftKR49PHtyNyQA==
X-Received: by 2002:a17:90a:4e5:: with SMTP id g92mr9707128pjg.94.1574904548383;
        Wed, 27 Nov 2019 17:29:08 -0800 (PST)
Received: from SBL-PC-YZHAO.skyboxlabs.local ([184.67.13.114])
        by smtp.gmail.com with ESMTPSA id w15sm17507215pfn.13.2019.11.27.17.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:29:07 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [RFC PATCH 3/4] git-p4: open .gitp4-usercache.txt in text mode
Date:   Wed, 27 Nov 2019 17:28:06 -0800
Message-Id: <20191128012807.3103-4-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
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
index d79cbf7005..6821d6aafd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1387,14 +1387,14 @@ def getUserMapFromPerforceServer(self):
         for (key, val) in self.users.items():
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), "wb").write(s)
+        open(self.getUserCacheFilename(), 'w', encoding='utf-8').write(s)
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
         self.users = {}
         self.userMapFromPerforceServer = False
         try:
-            cache = open(self.getUserCacheFilename(), "rb")
+            cache = open(self.getUserCacheFilename(), 'r', encoding='utf-8')
             lines = cache.readlines()
             cache.close()
             for line in lines:
-- 
2.24.0.windows.2

