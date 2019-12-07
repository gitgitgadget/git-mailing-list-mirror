Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB0C2D0C3
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D32245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="cGFap2aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLGAd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLGAd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so4139133pga.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAs02EjjdehEFOiy+U41vm8FPVh9OER+M06Mk6ZqvFk=;
        b=cGFap2aYKRR7Yf5gQiMc4SuN6kImXVwppE7qiu6NTOuSu9brUFZhfFQe32KAfzFbtp
         zlvH1+Ac+5uUhvnM3RS/NX9ju6l7W9IAcWhcUDHQY3/u42uJAPLRiCyijzHeq+SOVKuc
         16dUyxTQ7zgbwUxmd1DPIPbLBc3f86fi/GVZFOPVz7lqBlnIt/idwiXAb2KoUK2ZonoR
         opFZg240U+Vv3BSbTFWkxPwD0BMvkjh97DpAbnsUl3fqWWDbsMTnwzt2N9dqzKfS35a0
         OxiN7Um5pvWPVzyvXoYHtBafVWcJsTbDXbzNZht5VDEMCLpXkZ6VXdyZZXmVK4/ZTb7C
         Al1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAs02EjjdehEFOiy+U41vm8FPVh9OER+M06Mk6ZqvFk=;
        b=fMd3Bs3JDir1DTVNSaOWDJXKNXVApofRuf7A+GtgrbO1hmJX5ARtCYIDQot1auj5pr
         ttMen3pYolYgwalh2HnqGq3KPTilvNQyjHkJNd+ZgdAVo2gdYMxUuFsk1ei1zKucD928
         idyDIJqRm+f6HS9N4hEAml8qg+N6SfOybfqhSfLeZiDy5q3lb3rylBmYy80LvbO69YbA
         Xh7E95+SRg9e8ottH+VFbjQtpGijDHkf62BQz4TUp+WAWZTGUaB32oTxG5dFT9ceXOaZ
         Jbn0kZXC4X0RRNPN26Sb6fxm+zNSRa/PkdxeLBx3rTJ8pTiMbxzGE2oUX5hozkPNWAqJ
         Bf1w==
X-Gm-Message-State: APjAAAUwLMVH8cRJSdonY6ijd88xYX2Gh2Dm1N8Q1gPQaRjGOV7zwOpg
        1WqWGzbBvCGOItVUYso5rGTCUGeK/IdrCg==
X-Google-Smtp-Source: APXvYqwXiIfIWQmLuKIyXZhNvCQGoEnrYRh8GRpBw1KENimifP+7xWGVGHarDCpN5pXJ6E5mTA/p1w==
X-Received: by 2002:a62:f243:: with SMTP id y3mr17684264pfl.146.1575678835720;
        Fri, 06 Dec 2019 16:33:55 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:54 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 08/13] git-p4: use marshal format version 2 when sending to p4
Date:   Fri,  6 Dec 2019 16:33:28 -0800
Message-Id: <20191207003333.3228-11-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p4 does not appear to understand marshal format version 3 and above.
Version 2 was the latest supported by python-2.7.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index af563cf23d..c2a3de59e7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1697,7 +1697,8 @@ def modifyChangelistUser(self, changelist, newUser):
         c = changes[0]
         if c['User'] == newUser: return   # nothing to do
         c['User'] = newUser
-        input = marshal.dumps(c)
+        # p4 does not understand format version 3 and above
+        input = marshal.dumps(c, 2)
 
         result = p4CmdList("change -f -i", stdin=input)
         for r in result:
-- 
2.21.0.windows.1

