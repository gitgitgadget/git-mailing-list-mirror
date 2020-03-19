Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E72C43332
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F29320722
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyJ4uLdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCSD7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:59:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44659 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCSD7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 23:59:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so653793pfb.11
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xF7llzGdvXkSNWCDUKglJML1OkfF5FEdnEK+pv5u9+Y=;
        b=WyJ4uLdfiLKakA/AMj2ogjExh5VRurgOI/vam1nWek4334LX+QoKQPypJPc5ouHEHh
         Mwv9dj7SjInzcMLZlNnPJY0ANAecnDcEPOBjBLbOnW3A5VGmy2HVmKSgXXg7SiBG/q48
         fOQGdXeGjmMi90wC2wNKbqMCZlOwGerJFfOvpLq9WHSibh1PO+rwy5aS5kord6X1U9/a
         Gc2ZUL6dOiu901kz7xLt23oNKaV7csV/tYgxq2jYcwck6cmavefzQehB/PLend4+t6/a
         9FEHV/ULd8n+SMudYcaBM9kG96usgZ4nX8kJEyYXM3KM2wqLVPI2wXxUqv9Diu9BIWMo
         LU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xF7llzGdvXkSNWCDUKglJML1OkfF5FEdnEK+pv5u9+Y=;
        b=kVHshGr0n7zFYr874QuzEdhsX+i4MI9CoQAoeqIoZV7H7wpQ33Dvuwdod0PqC3bDP7
         0KVLB82PcwuneYi7vKY0O2LUFBpIsJkDKevY3ORr076Tvuc/ADyBMYhzETffWWkduQ3E
         4NxiJ1CpmWVvZ5tWF6++GyZGPj754V+eyR1i/BxlWXXdakVqqC+d7AuVaCuNU3MhFYwC
         T+JSjBRp/sZ+XmOLjgTBN0p1502oh5AQSuQnvR+t0FezeNSuAWYwY1nYgeYGVt9ljXqP
         i6VksMWJMpo2ABVkF6siBKekL2z4R58xhNDKXUgEueGGHjW+8653JINBL8yMZH0voDUr
         qfig==
X-Gm-Message-State: ANhLgQ2HvDILiYDlyjiXBjwVwqgDkSjZ867BejVyAyWQ/PYeQGFSP7Ct
        UM4tv4W5LpdGXIwtucWL8DCjPb1f
X-Google-Smtp-Source: ADFU+vv1eSAkEaYZFY5+vzYBnRRlNfrf8Iz0CBHaKOaK34GDX0NKZLQsoJ1vUnkpXSqogMmjoMAxkg==
X-Received: by 2002:a63:64c6:: with SMTP id y189mr1210270pgb.176.1584590348898;
        Wed, 18 Mar 2020 20:59:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id u6sm506604pgj.7.2020.03.18.20.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 20:59:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 2/3] configure: respect --without-expat flag
Date:   Thu, 19 Mar 2020 10:58:56 +0700
Message-Id: <0dc2f0a7c56eb36479bf8793d7562490dec8ba0d.1584589859.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584589859.git.congdanhqx@gmail.com>
References: <cover.1584516715.git.congdanhqx@gmail.com> <cover.1584589859.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5a73a592e1..896996e177 100644
--- a/configure.ac
+++ b/configure.ac
@@ -632,9 +632,12 @@ fi
 
 GIT_STASH_FLAGS($EXPATDIR)
 
+# Respect --without-expat
+if test -z "$NO_EXPAT"; then
 AC_CHECK_LIB([expat], [XML_ParserCreate],
 [NO_EXPAT=],
 [NO_EXPAT=YesPlease])
+fi
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
-- 
2.26.0.rc2.234.g969ad452ca

