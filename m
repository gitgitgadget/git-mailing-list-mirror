Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C32FC2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F75A205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="uB4/UPuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLGAdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:50 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37207 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfLGAds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:48 -0500
Received: by mail-pl1-f182.google.com with SMTP id bb5so3407342plb.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1FxdPV0xnSaQlKxxVPFCu4Q068GmvCoutzbjsb8U5M=;
        b=uB4/UPuQup5AKM28YecsZhUJ68n7/QAfGEf2ZCAxt5TSZ53L2TJGzdohI//13gsKND
         aoZl0GspXQFEwTnXcVFsrlxkmmx76yJo5vbtB4B24ejo6JZITE/8f65Ztx07yUKkt5k2
         MUuHg1aIfoTVe2mkWEsPNcj9/71DqnKXCGzbclOaDUn/kxf0KTIk0unozA/wovStkw0t
         ZnmLmZ+5KYLghIKCtrseMauaAXy05iFNwgseLFv8w952FbM/d3TcpQYkVOySsHESxXie
         CDMuN8QfhT4nMkZlRLvgJsLlDGV7v73a5qcYj9vm10y+p118YlTW9jTj3qNDKq2MZ3RU
         Ojtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1FxdPV0xnSaQlKxxVPFCu4Q068GmvCoutzbjsb8U5M=;
        b=dJvLzjJWTTA9ORX1JZ1hxxXOiSxwYmAOtXCkW6gv6bu1puJ1nRWrW5UxpAR9YFToDh
         xwUkkLTeLbVGR6jBnfZnBJjTtB3KMXeBrCQUh2Ss0h4lFj6buD1J0hP/cGHJAH3m7zy8
         Tg1ZzU1TjJZRdvDsyk5HfcrgfNZ9j4sjwRDF67Vj3EVuzDkgnjPs+kt+2vRcYlajiY57
         lgmahtnfvxCRJDuHr5F6+4LymqHbxv+zHZaRZv6Ou+EaqyrtBi40ctSD8gExMDHZSoZS
         ly2W6Tqv2dW3p6IPN8JIJMzpz8FkDYMD/rxYP8xoqJDEA6wPVicJsTqYbMRLCXmBDA2c
         5LbA==
X-Gm-Message-State: APjAAAUpjtUNg9n1U6HFDmziH5E8jAgI17qV5/itn4QLVNlyBvTceCV4
        mn3bvHWva5fP5HnKaHz2mw5UAaoeOly0TA==
X-Google-Smtp-Source: APXvYqxLEG2chrLZY0cpdQZf2vZCSOxi9E25YraOJqqKHZprT9lbr65STuGM3AAdGhGPQxB08O4eEQ==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr19091495pjq.106.1575678827564;
        Fri, 06 Dec 2019 16:33:47 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:47 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 03/13] git-p4: simplify python version detection
Date:   Fri,  6 Dec 2019 16:33:21 -0800
Message-Id: <20191207003333.3228-4-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of type shenanigans, just check the version object.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d8f88884db..ebeef35a92 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -27,18 +27,9 @@
 import errno
 
 # support basestring in python3
-try:
-    unicode = unicode
-except NameError:
-    # 'unicode' is undefined, must be Python 3
-    str = str
-    unicode = str
-    bytes = bytes
+if sys.version_info.major >= 3:
     basestring = (str,bytes)
 else:
-    # 'unicode' exists, must be Python 2
-    str = str
-    unicode = unicode
     bytes = str
     basestring = basestring
 
-- 
2.21.0.windows.1

