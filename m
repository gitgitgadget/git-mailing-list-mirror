Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630B11F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965188AbeFSIE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:57 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33175 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756444AbeFSIEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id z6-v6so17876728wma.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=diHpdS+K1bpdVrerZoCZbrubcwm+E4TQW+Wlk0M0s1M=;
        b=aLpZHzvgSDpSWUbfEHP/w20Exp0vdk1VJlT0LwSMmphQXKqLTEQ4GkhlWBlG0twUJo
         MWPxjypSGYR7XCre4Bhix5lwIztVgSW1JxycYQAqG/2LJTLWgcdSCOKTEyh8XQ58FjkG
         EQ7dBkTOct1+yYsvS5thrL30S4k3cbPTceDVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=diHpdS+K1bpdVrerZoCZbrubcwm+E4TQW+Wlk0M0s1M=;
        b=L7mRfAQo0VdNx+axFEmmL4DoH3wUidEtwFNp2tA9tOlsnhqg57p8L0445ODELyvr3X
         Nj0PfgtAU/pGVEXoGqLnPqozz8MbgzdTf0tYHmrwWlwnErT5L7hwdhdolGvwpLOOlQ3f
         +yMJwVJfgTQ5MwI8N7FR65SvmLnsMhh8aiJHNW5WNGGo6U32uc3Eg+Z6ydgBYKFikMnb
         MM4vSg2sbcGSysXdEaCdooG5g/WhvBqd9keg6zhItzPqkCIX/SaqV7QCc72dju7jx10N
         U4j5aRXpNFQhVp6oCoYo2PDg52unBahRklIjEnSojn1HEKo4bqgpjbGdMAL05/7LU4xc
         qARA==
X-Gm-Message-State: APt69E2UAMtrRYyhv9xg3rozkYzZlf/R/gBcXsRrOt8jehSgxeWqDxWj
        fq13uXSNwBMVVDFoVO9nnDrW2kVv
X-Google-Smtp-Source: ADUXVKJtDZOkEfTJ7BcY/zZ32LA0nFUhp2MqSdFb4nyBJ956cgDn9QuG7TmJMNzObAoFifR79vPkbg==
X-Received: by 2002:a1c:58d5:: with SMTP id m204-v6mr10388848wmb.118.1529395462902;
        Tue, 19 Jun 2018 01:04:22 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:22 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 4/6] git-p4: python3: basestring workaround
Date:   Tue, 19 Jun 2018 09:04:09 +0100
Message-Id: <20180619080411.6554-5-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-4-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
 <20180619080411.6554-2-luke@diamand.org>
 <20180619080411.6554-3-luke@diamand.org>
 <20180619080411.6554-4-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Python3, basestring no longer exists, so use this workaround.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 67865d14aa..f127ebce27 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -27,6 +27,22 @@
 import ctypes
 import errno
 
+# support basestring in python3
+try:
+    unicode = unicode
+except NameError:
+    # 'unicode' is undefined, must be Python 3
+    str = str
+    unicode = str
+    bytes = bytes
+    basestring = (str,bytes)
+else:
+    # 'unicode' exists, must be Python 2
+    str = str
+    unicode = unicode
+    bytes = str
+    basestring = basestring
+
 try:
     from subprocess import CalledProcessError
 except ImportError:
-- 
2.18.0.rc1.242.g61856ae69a

