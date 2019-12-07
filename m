Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F58C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01C205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="FhnICS6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLGAeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:34:04 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41038 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLGAeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:34:02 -0500
Received: by mail-pf1-f173.google.com with SMTP id s18so4184842pfd.8
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zhXpLzZDgtm1MlyEi+R/FJfQEttb6Pu04P7Nh/tH+A=;
        b=FhnICS6A88M1W1usD79l85NFAGGC3VFYjzOUq52m6ECWzzJVvJESHrFRLWA6jmZl88
         3SC+/gUFcBGBdHVFHsveSdDCCVPLxe3PZlfpjADBa58qZnEImS7xbmJy1sPCPrPc/a8C
         2DXOCf2F+zW22qAChxgb3i0b14MX7tiXUNkXXRc42G6/BvCHmfIQSSiouyQe+t3L+iEG
         zZK9rF9wAgZzCLeT1gL6YdCeylenswhR4x8bjiT4pe2mUcTzhS5KCDgnAlQt+c4gm9jn
         xwoyqr+lD2+Y0pEcKEHlJW47TgsIeavGtU1GKQWI+Czj9jKyPQ0SJvnNE2NMBt417fu0
         ySVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zhXpLzZDgtm1MlyEi+R/FJfQEttb6Pu04P7Nh/tH+A=;
        b=Eq4CWTFTnY4IpRjg1BHAUY+DD1PXIMH5vS0Hg0878Y+9ODXGn9PCeGWAHSOTuqTVfV
         uZj0s+X+qOQNhMBz/SYyezU8u2pt9FYWV6yL2llcCylmthKk1S8RiIJosNl5vwq+1rjd
         flWgdRDPe72H6Q6foCcZitdkXDcwr6HHupvZTp87iILcqcro4cXraaFEhGkN7JWl8m3O
         tlPhPjnfQkQ3XRfIcWmrvSxAN5EM/6aNi3r4f5F3fgjTzZck860gvi2H9a2rl7Vs6PkR
         XoWlf/ehVgHbaIwcTQ458RpDxMFqOIIYgPFLxO+7AlQBiT6YEXCl++nmB3Xi5qrfB+XH
         9J2g==
X-Gm-Message-State: APjAAAW/wpHHG0ZT4LfOxZuQoUHK6Buz1c0BZwko5lSfciZV1keUfvI3
        Z68iCuouV/OU/aIchzFEgWkaf3h9YNhzgg==
X-Google-Smtp-Source: APXvYqxUbWrLOWnyq4NGCNMuK2Kms/BCOMT8NJDO7yq4RB4rK6zFkS6sH07LMP8xYdmvo50TTLOSgQ==
X-Received: by 2002:a63:c406:: with SMTP id h6mr6756530pgd.213.1575678841276;
        Fri, 06 Dec 2019 16:34:01 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:34:00 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 13/13] git-p4: use python3's input() everywhere
Date:   Fri,  6 Dec 2019 16:33:33 -0800
Message-Id: <20191207003333.3228-16-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
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
 git-p4.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f975f197a5..97a9def657 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -33,6 +33,8 @@
 else:
     bytes = str
     basestring = basestring
+    # We want python3's input() semantics
+    input = raw_input
 
 try:
     from subprocess import CalledProcessError
@@ -1819,7 +1821,7 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
             if response == 'y':
                 return True
             if response == 'n':
@@ -2390,7 +2392,7 @@ def run(self, args):
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

