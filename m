Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8AC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60E20724
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="QIlWxUzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLMXxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:39 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:44328 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLMXxe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:34 -0500
Received: by mail-pj1-f47.google.com with SMTP id w5so373347pjh.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jyP80vwwKnkuAU276zRpKjBo7AE7L+0OfAIr/aaiRM=;
        b=QIlWxUzBae0/WfdYjJaW+L6r2N6SUNyfHNBCimp23XIVW92Xl0OrcxhFbVStbbhsLG
         pDam7xEunLIJZhy/nL64YJhUhwe8VLLhpV707nKDzQ/G8nmknIl07XV8GEiTyQD5j5Wq
         L+rJnm9TFdHjMhV2n4Jo0Cw9PTF8fzFY5YYt0FrqmAnuTVZhyPvq5ueO5CSRBJRuEJk1
         T2ReYAFoxhMMcgSgyXpoNMhEmxJU+6QWYaBqtqXd2fSh2oBXXOk4qfM1bJjWVxH4Ft76
         w/Ouku2oZ+Fb9NATGlnWf8EtDNgGTABJwJXu3cokVhsNZjayPVJZKPsbuls6Jk88qN34
         FVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jyP80vwwKnkuAU276zRpKjBo7AE7L+0OfAIr/aaiRM=;
        b=IrKVCAE6eJDmOTVBoZWu5aFQhXnTuKHFfht7EOiCk5apKvCNFojYLrd9gggsTumVqX
         H1KW7exrBr3DLshVa2d51N6UyT8IxYGZL0Ces1pmN3n/x/M44sVMyH1DXoAXuXaA3Iz/
         nzGTCh+80A/NhZBayBEHkv1TZBM0+HuBdZP0FBnRlYW7jbhdU7vv0n3cL2VknsGxTzGH
         KpvyI7RdeO75A64Sd4X6JpOXxoLCCAO4svrPc1Bmt8JZFAmJ2w/iZXXr2rIwY09Tnq2B
         U3wDqsaC8pgb51cB3RNwTgbFiE+ueFM2KdlF+PIlh8pxWAsThG/ow7MIjm1KRB+2lTSU
         mQ9w==
X-Gm-Message-State: APjAAAWSfeGPxHW57kNhEhk7Jbl228ZKpgzUXEzeO14h8dsspnSI/ksu
        E+KyDqpyQUincxBCDKlZ/S1NpfPAnhlbkV3j
X-Google-Smtp-Source: APXvYqwgUMOfiiGbMs2rMQ2NX+TSND/ukQekBkrUcTJyTBVJ6VZ+3JB0cIeDPEaUI9XiGmng4Oyhkg==
X-Received: by 2002:a17:90a:d353:: with SMTP id i19mr2516746pjx.43.1576281212905;
        Fri, 13 Dec 2019 15:53:32 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:32 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 13/14] git-p4: use python3's input() everywhere
Date:   Fri, 13 Dec 2019 15:52:47 -0800
Message-Id: <20191213235247.23660-15-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python3 deprecates raw_input() from 2.7 and replaced it with input().
Since we do not need 2.7's input() semantics, `raw_input()` is aliased
to `input()` for easy forward compatability.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 3af8df9f83..17f72f4309 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -27,6 +27,16 @@
 import ctypes
 import errno
 
+# On python2.7 where raw_input() and input() are both availble,
+# we want raw_input's semantics, but aliased to input for python3
+# compatibility
+# support basestring in python3
+try:
+    if raw_input and input:
+        input = raw_input
+except:
+    pass
+
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
@@ -1801,7 +1811,7 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
             if response == 'y':
                 return True
             if response == 'n':
@@ -2372,7 +2382,7 @@ def run(self, args):
                         # prompt for what to do, or use the option/variable
                         if self.conflict_behavior == "ask":
                             print("What do you want to do?")
-                            response = raw_input("[s]kip this commit but apply"
+                            response = input("[s]kip this commit but apply"
                                                  " the rest, or [q]uit? ")
                             if not response:
                                 continue
-- 
2.21.0.windows.1

