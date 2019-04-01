Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC2220248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfDASwb (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:52:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbfDASwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so9287466edb.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vdwaa-nl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl4ibq6359IJZ6FLWUxwLAGyVNO6caLB1hbApIDGTys=;
        b=DhpZM6ryMniNBYQehKPNpajYKsGrTNGouanEGjlaObvrgINa+oCTikJdPghpBcZtq5
         Deu50qwSH2VmEUyNA3OZ1YCwwv/BolM1GPixgeefD1fWZtYGi1PF1JdlLMdn/Mq06iAJ
         QZnnEZgSZr1w/lHc0QImQYefQHBHsql104Ke7KdRsHNAN3XFUTV7jHTBPhgBNNemjMve
         rnZGuPcN0wdCm3ZtR22Sg0Ykx+l68C7DXJKBkgPRmdVy02zVSNOr30suEWyUokNcIpOz
         /AmEsrRDg6uuhSg4TvSM7N3udc7kdFSFynXl0BCvUnBzyzLwONH0ofIteZHqyTbDCIkZ
         Cr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl4ibq6359IJZ6FLWUxwLAGyVNO6caLB1hbApIDGTys=;
        b=r7xDc1OnZ8zXWUJV/pqoi7zqSXk7AQ8NOJrXRdaCKSqW/dnt/vpMbL16O7LHsmQpPX
         l4XA/rlSfe/Yav7YCHrAkxqKG1bMDp2Gs+fHUhr+OsXKVbpTMak46S6VbT2LZKbiCiyr
         iyQDLBESesnnkKFHpGmdTIAQjFVVJm1VVUYKLxCZRrbDKF09Ht3i7IOv+8+Yz150t4jD
         a6H4/2aadOHX0XSZwjoT7yxy7MYG+cMkSZFAF8tokSKBl1h7ZBsD53JpsrvreOuDIa+h
         sTeFEjgyaHrKKAGMyicaX52xk4ZDlJ3NyA5RG7fc6e+62azZS6fK7QxjQAIEdEMx+Mu0
         8v3Q==
X-Gm-Message-State: APjAAAXHgPXW9JmUc6R1U9j+bdh8cLE3np683masHMtrnCoJ2MNCXGmI
        VAnoMEEJpOkAHPqbokILs0rSNeC9Hb2Gdg==
X-Google-Smtp-Source: APXvYqwUQfwGnEE74HrDh563GhrsVFwtXku0Fps5irQOhcXQVBLBGsrT+jAm5VJJVmMesLkv3Pd8cQ==
X-Received: by 2002:a50:b284:: with SMTP id p4mr26752343edd.27.1554144741041;
        Mon, 01 Apr 2019 11:52:21 -0700 (PDT)
Received: from localhost.localdomain (83-84-17-34.cable.dynamic.v4.ziggo.nl. [83.84.17.34])
        by smtp.gmail.com with ESMTPSA id y2sm3422574eda.11.2019.04.01.11.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:52:20 -0700 (PDT)
From:   Jelle van der Waa <jelle@vdwaa.nl>
X-Google-Original-From: Jelle van der Waa
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 3/3] contrib: hg-to-git: convert data to bytes for os.write
Date:   Mon,  1 Apr 2019 20:52:08 +0200
Message-Id: <20190401185208.17031-4-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401185208.17031-1-jelle@vdwaa.nl>
References: <20190401185208.17031-1-jelle@vdwaa.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jelle van der Waa <jelle@vdwaa.nl>

In Python 3 os.write wants bytes instead of a string, decode the str in
to bytes.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 contrib/hg-to-git/hg-to-git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index d504624c63..26c7300011 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -178,7 +178,7 @@ def getgitenv(user, date):
     #get comment
     (fdcomment, filecomment) = tempfile.mkstemp()
     csetcomment = os.popen('hg log -r %d --template "{desc}"' % cset).read().strip()
-    os.write(fdcomment, csetcomment)
+    os.write(fdcomment, csetcomment.encode())
     os.close(fdcomment)
 
     print('-----------------------------------------')
-- 
2.21.0

