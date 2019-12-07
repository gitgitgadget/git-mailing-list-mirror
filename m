Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB37C2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3B2245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="BTlxSQyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLGAeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:34:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46939 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLGAeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:34:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so4119736pgb.13
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOA+CO7BKBTw54HSlvaLhxTmlUJ7yNCrhw0TQw7OcYw=;
        b=BTlxSQyjZu4xNDzp9Aoy/qpPTmHXSOYcgNsat9cBnfZNvwgtcmCXJ6W3qxa0WGFWBF
         5jv7pK+HaFU5SiL39P2qwygy7p3IAtESMx5qHmFBikHhEdFTXLFKf1QflGVdFxWVsrzL
         f/fdsCcOzT8oqpWVeATjVoB6U9RhP+qh3qBdutCR5B60C3dJlR7YD/mB0k72urbKb8lw
         8OKJ80cFlUS92Cu2roOF8X83Gr1KhlgjkkMZr0QpVcnPHP4wGX4e1sMbDyU5QEBynq0m
         Ab9gBh00yt5Oay99kwmNPWQVdVn+AYZlRTvX1MH/bXwBE6lXg4EdqQU3oN0fhoXU4KGR
         Nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOA+CO7BKBTw54HSlvaLhxTmlUJ7yNCrhw0TQw7OcYw=;
        b=tiJl0ISILIXyEYNJg6jpGr4Z0In+6a4O1l5lR88wmUC+pRD0jwj3QFD3VgwZYGbnyO
         p8SKNFxCMCY3DhQsE92Ho645Y0mLGCNa2jG/29/pDWv9ilHS3YjhnAb8DqHh2DpmlpCC
         hjuQdBvTKqoayVPMdJVx/G6qYwV8SzxBtC9WTlaHdJ87lxcjGF+s/MSHqf6Eqbz+ARI5
         C2l52XEuArhVjgGWUYcYkp7Jpm6doMn7RhT0mvGOYOpXLqmBMykXIt5sid1WMrlt35da
         vdb1PqBrBGn6A0OTwyVQDTMaTYaa81WVd6WrWY44e3znsYixiRgUT09nW1j8m7iatbYu
         +uMw==
X-Gm-Message-State: APjAAAXTsi7BmFta/gfX+BTuHuu7L9pzZaAxDER9fjVewaGWG4+0Pcld
        dfcAn4D6mWiNl+dxzMOTCgydWBp4qNkXTA==
X-Google-Smtp-Source: APXvYqyFpnueDGC313WLLiCHxGK7PEOcu5GOw/nMiy9A5ZcpAAq9eekl/PFHnI2tAN9JcHolnLuEMg==
X-Received: by 2002:a63:4f64:: with SMTP id p36mr6855102pgl.271.1575678839244;
        Fri, 06 Dec 2019 16:33:59 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:58 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 11/13] git-p4: use dict.items() iteration for python3 compatibility
Date:   Fri,  6 Dec 2019 16:33:31 -0800
Message-Id: <20191207003333.3228-14-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
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
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index c888e4825a..867a8d42ef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1763,7 +1763,7 @@ def prepareSubmitTemplate(self, changelist=None):
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

