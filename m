Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF9C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609F206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="P43ZhtSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLMXxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41695 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfLMXxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so381515pjb.8
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6hpro0bovGWTPkEBpi6ztIjb9/FgW3Wl1ARP6O6imc=;
        b=P43ZhtSaUZs8q8KtIAsRN0mdYgSv+vJOD7Va7j2HKhiigY8RkLNXCccFic1l/5a/Jq
         pNr2p+JwkmujYXuefhdWlG1CgQUT8NPjYFh76yYHjV74rxC+6Is4p0hFBFCc4TrgYOQ1
         CIypuY6ET4QAV32RKInqsruC0+myTWoyeRzCQqM3cacA0NiSR3NXleb9z1Nuod2rnU+E
         QUsmZBCPpnGNeTIYVDj2Rd5JUyai7ioAw7Z05mH0hth4yBbKo3n/Spx5kFiZgu0ZY/Qx
         puyCNLdUPCKC5K/swXqVps2O5tzmO5sBg+1skLrDEagJixu8f1DSY75sE1DwTmzmgsWZ
         ULUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6hpro0bovGWTPkEBpi6ztIjb9/FgW3Wl1ARP6O6imc=;
        b=h9V3QvJPBlX6BskJmwJA4qjFixKJYEAOy0V8eE1MeDQfzpc/hlqJOvYrojSdxFYv7/
         gVeKVAVYn7/76PV8fiwnoj4/N/l15hYznlIXqgWU6nSSGMDBKiQlbYXMB32AM89CMoe/
         uPwQPNZSO2nDr1POjTmsYgGjoGrRs9Nt+k0wGeoLosf9ipTCry6bDi3QYeCaDU8iHuT6
         UikCUfzQ8IuRYWHBT0I+K+x0E2m92HQDrogh3K4NX074y07PF8RDtoOH0406lcbmSCDp
         gaEOfJgl9vC9+IxUH+Rj+HIIBhVu5430LowhfmXoH6BI0uqw6WQiGhH8gqfETy0CZBEb
         zxAQ==
X-Gm-Message-State: APjAAAUPqLVrTMk8EiSTGMa99C2vCLIQgEYbcECf9J4SkNd9BD5Es8HN
        HKwNqXs3AV9Ikswil4e9drx4np757uj6PlKs
X-Google-Smtp-Source: APXvYqwouVJLr5GjNlTFD+olQQJKbIPxFN5IKHQxscAoAVRb9mgAhJ/v6ihbHyyl1T3QU8VUKZB1sA==
X-Received: by 2002:a17:902:b083:: with SMTP id p3mr2225162plr.141.1576281202237;
        Fri, 13 Dec 2019 15:53:22 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:21 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 03/14] git-p4: remove string type aliasing
Date:   Fri, 13 Dec 2019 15:52:37 -0800
Message-Id: <20191213235247.23660-5-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that python2.7 is the minimum required version and we no longer use
the basestring type, it is not necessary to use type aliasing to ensure
python3 compatibility.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2f177fb43b..153aff16f3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,22 +26,6 @@
 import ctypes
 import errno
 
-# support basestring in python3
-try:
-    unicode = unicode
-except NameError:
-    # 'unicode' is undefined, must be Python 3
-    str = str
-    unicode = str
-    bytes = bytes
-    basestring = (str,bytes)
-else:
-    # 'unicode' exists, must be Python 2
-    str = str
-    unicode = unicode
-    bytes = str
-    basestring = basestring
-
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
-- 
2.21.0.windows.1

