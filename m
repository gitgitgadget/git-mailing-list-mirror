Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4951C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E80520724
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="1o/H7JES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLMXx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34329 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLMXx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so262667pgf.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bO4jqekpdixoY18WHt+1rc/8RaVQvk0lNgf2uN6uRV8=;
        b=1o/H7JES0GMPYa29s4JLnJQGI62prhsZcSIN+EI0dUBLnxhr4P69984pE6hiX3LXXL
         2iZQEsTXJPl9XWjZkCmheXb97lnsE4hD+8lu/vQcVfQa/ww2zA76H9YKffqn0M0Tcs4O
         2GUhIXoY9jTqSoC4Y0Ff6nbClxxwR+sXAckK/s8Ru5bnnw5zVB4FaAPn8rpEE8b4IB/f
         3GGFo6x8db98SaSjGK5pBvVBQl9ZjFHSTt2T0eIWX3BzYQ8ZsqcB1KRPcRibZYruBGsg
         k3tDbwIORE1Z8ljKar3bd7oH/l2m3vYLZRsgXHR0+qETHXPYM6p4M78sTgptblQvjm9n
         NByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bO4jqekpdixoY18WHt+1rc/8RaVQvk0lNgf2uN6uRV8=;
        b=kPnCm61Y59+KSGh67yZ4bnj5hhfcksmIjMkNMQ9qmnxt5YUjYfP5kPLiB3UbaCk3iC
         VVean+V3VviYhpzlYcgYoXqA8AbzN9b49CzSdEQrgPCxWlUZI0uRKTAa7igVBRrrEgCg
         WLu/KTBVWmcg3i1okQJKGZcVSNCV7fk9osaEFybpHqgxk46c2TOt2Uubn/UhIli7SKWd
         jAKqw9CvgaQ2OWXQEarrNB6d0IKSq75lSXASiU5ie005AhGYETm/JTbWMpnjKp2ItX+j
         pRkwPxPJ9nTYcQ30eot0db6hmSnIw0UxASCDFHdBu1FPWwb3+hu2oTOPGBGjOct57/sk
         VpyQ==
X-Gm-Message-State: APjAAAXA1+SIIM5mX4qYZLvx5OZXxUEhxeJG9J73bAJw9xrLRlw7evN6
        3qlx/EfmfklYrvMBld8eQkF/K5BCNc/BJtXw
X-Google-Smtp-Source: APXvYqx/EKcbtMuOIVmUiC7DfgJe72jGFfgyDdvo6rVCsZM8Btgmwntr4oI7yl5D42f3ne/v3+yVEQ==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr2443201pfg.51.1576281207862;
        Fri, 13 Dec 2019 15:53:27 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:27 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 08/14] git-p4: use marshal format version 2 when sending to p4
Date:   Fri, 13 Dec 2019 15:52:42 -0800
Message-Id: <20191213235247.23660-10-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p4 does not appear to understand marshal format version 3 and above.
Version 2 was the latest supported by python-2.7.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index abcda60eee..c7170c9ae6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1679,7 +1679,8 @@ def modifyChangelistUser(self, changelist, newUser):
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

