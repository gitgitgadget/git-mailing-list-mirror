Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5BCC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B38206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="D6tNdfHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLMXxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfLMXxb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so265158pgk.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsFx78VLSxJNAtG4kOBuFFJgV8dMv4lwgcP7TH725+c=;
        b=D6tNdfHTVlJsAsR1nREUWwAVRGCbmKtvUzB1DsEqTBJe7G7S9PQJwahBqHrFhKTPd4
         t/yA9poEVA3lGSJN2BTtDVST9nZnw3BifOgcPgKRtDiq8BT1A8L6t1skb9HeponnoOQA
         9oXt48wUdEJCigNT7Lg44bDzexcptbfnG7gaB0Qd4tQeUskEarN8ldsQSgHKkHETUiZ/
         Z9scqEJYv9+gOV6thBqQfNwtnGt4IaszhJuP0KE9n6NjgGx33xcignuj7E1pQkEwuwE6
         oeRUAFb37vw6dUkrPGX1SIjXd2PhUfdEGFnVDZdZgXtbQENyZA23mR3S0JwmBckx7wmk
         EoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsFx78VLSxJNAtG4kOBuFFJgV8dMv4lwgcP7TH725+c=;
        b=PUjvKZyvVl4w1jrLM9VbtCXtHumHrhqh5Y3nDbt2sN6dx/h3mIuIuAO6JKNOTnxl0a
         DG1DDWxi5Kmq5lvujolafUfXwWLQSesU9Sh+00UxMFSfXZo4y1NKy2rPpV9e4mCqJaXU
         qRx8ZD3Hxtsrfuw9wz13pN4glwZ++jMRvLpeXioorDwrWIM3R2e91wY4O99+3lb9UXBV
         GeaDN2Az3ECG213Xr6hNmK72orh2LzzRMRK/N91RxBTLo60WAVEir0jGZB4OZjveLh+3
         TplfepMvE7ES1CIyXZyHaf7gDg1dxFAM5SeGHKZuJUdh7RzzOOw8vfP840xiZ9NKX0+y
         sDiA==
X-Gm-Message-State: APjAAAX049DAg1Bxax3aUwxOB5cNj6+wtLRHHIxaoPp/RSNkSgR7dzkk
        RVuv7q5o5Kzs32WLfNAVtLXVCzUDfz2+DnYR
X-Google-Smtp-Source: APXvYqyteDOP2DmNSiI652khGxCv/HSVwwPfZHLYriuOx8UTwaTErr6JfHDITweAyH1nYaHE6Mu58Q==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr2363813pfo.139.1576281210946;
        Fri, 13 Dec 2019 15:53:30 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:30 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 11/14] git-p4: use dict.items() iteration for python3 compatibility
Date:   Fri, 13 Dec 2019 15:52:45 -0800
Message-Id: <20191213235247.23660-13-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python3 uses dict.items() instead of .iteritems() to provide
iteratoration over dict.  Although items() is technically less efficient
for python2.7 (allocates a new list instead of simply iterating), the
amount of data involved is very small and the penalty negligible.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 7deee1b939..b7e31d4738 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1745,7 +1745,7 @@ def prepareSubmitTemplate(self, changelist=None):
                 break
         if not change_entry:
             die('Failed to decode output of p4 change -o')
-        for key, value in change_entry.iteritems():
+        for key, value in change_entry.items():
             if key.startswith('File'):
                 if 'depot-paths' in settings:
                     if not [p for p in settings['depot-paths']
-- 
2.21.0.windows.1

