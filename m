Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D6DC2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F62245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="EK0dTM4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLGAd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:56 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:39007 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLGAdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:55 -0500
Received: by mail-pl1-f178.google.com with SMTP id o9so3407175plk.6
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5MLgJnIyGwQUs54cy0581JvomjdONxzn1xgJWSLmeM=;
        b=EK0dTM4WRJ3dUDAgWyP5Ytl1xaqY30rZUjvHGz57ohmJWzM8I2JdvDJF8o5Pu57ecg
         82V7s5jgE88yPipBdyz0tLkWXdJQ8tIRYsmGHPGuBhg+6Fd2o4KW5WjH1AWn+BtlWaF8
         TAOw1ZephdtcSMLDIo4RIl9On/1NFgBC7bX1NEkCqJttadfLAtPMVVLcDiE9cF0UL9Yk
         wBNvrrAjdOSWlWDbpCPJ3cWFiuO06tNKPQP2F/ix8UHvjGVo/10BxKn4I2oHp4t+mJgc
         vTHewQy7qH2fCz51BuS532rIO6BJ40REmp5+gfvbqFxQ+ZKZ9z9ywf4/mFtmrwwrrJul
         NGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5MLgJnIyGwQUs54cy0581JvomjdONxzn1xgJWSLmeM=;
        b=XcVUt31MPd+/ewpeKExWLwNiz+5J7CyCSGzd+veCPXawfHzKu/CL8P77Nf+WisY1aD
         sjYfZary8R5WTQmldz8t4f23QAWhDrtFBILK7VG/daOph5EGUoMwtc6f0nQez/pC7mov
         QQQ1xkszuAW5Q4X4U5pToPSrX+7MK7OWQ333+Or0mc2bign2xiQmhlUVkPKP62A482Il
         5iHoNvCDjTV74QfEHaTFSypqDYhmhk8wPzamds0LL9aZKEMcw+pfjymMYDC6+FGRfVuX
         nb5J1vxkK1tZQByBQnl2Vo+tnz/1uEkhRKJ0UcjE5c52wYrbyHmB5O+N/w6qXxfzX9Dd
         0hcw==
X-Gm-Message-State: APjAAAWhgNpnjpJl8+dSfWvnl+inY5Z8lBSEohBViiqisKn9WFSYZHNN
        Ln8NNvOo3D0ZGjrQwM2gPlkNbzqK/6KToQ==
X-Google-Smtp-Source: APXvYqyfqe5KFz0IKVCFo6H+5I4hhgMP2bDVuQPt4NSBM89ueKt2Opn2NhA5eEQAq0zV5G066fGTcw==
X-Received: by 2002:a17:90a:8685:: with SMTP id p5mr18962049pjn.92.1575678834215;
        Fri, 06 Dec 2019 16:33:54 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:53 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 07/13] git-p4: open .gitp4-usercache.txt in text mode
Date:   Fri,  6 Dec 2019 16:33:27 -0800
Message-Id: <20191207003333.3228-10-yang.zhao@skyboxlabs.com>
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
index 088924fbe1..af563cf23d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1413,14 +1413,14 @@ def getUserMapFromPerforceServer(self):
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

