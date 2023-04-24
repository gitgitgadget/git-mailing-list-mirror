Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6DC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDXQv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjDXQvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:12 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB95A256
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:59 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1878560f69cso3329687fac.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355058; x=1684947058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXkHT+ch50NMOJnl5ZeXy+PF4WNdISENyavN39eTFjc=;
        b=j9KkJd974t2LUrYJfGX5gY1U1nCHHNpDhOikA7e7J92sxILkonu6ZjpdmccgMMmvTs
         nWq1ADBz+nYOvXvo0HN3w1nuOel55CELFevj7ksb3WNzyI85EyAuxmYM9RVhIuGEkS6Y
         lRjX5+6/pDMNbGMhwOBaMCjFBP2vj8rAYQkl/N1SRsx8jyD2hDCrLzYgiyf7EZf7DJd2
         NrxJPAB0EYZYqJxm5x+6fI+dQH7ZTZ+fYNEqJRVJNZSWAIKEE0lvHytEYnG47SJM29ni
         ppNPzrmmAdomcHKqjwQ38/pBjsaHbNVb1U5EBS76VQsUwgQQ14UlmSAtOzBglT5Iea+9
         s+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355058; x=1684947058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXkHT+ch50NMOJnl5ZeXy+PF4WNdISENyavN39eTFjc=;
        b=AKpHdM4yK6ISiISGEVenNB26ffJ4Vh3SHplvPyjJMbm37cwDmsNlKiJF+cuW7YcpoV
         RAMQM4lup4m3Y4Xaf4oB2sQUzFFk0t6coJHR/KZ5LRCMy5JMVfrhiuAcLEgJd60bXr2W
         fK84kR5SlV4j9lvLIOwuaBgDmg/O5qR5NzinSLwHNTssV5M8Gb9txlpSyucHZ5T1ia42
         HQf8P5/6l5BUJmkjUlrfXIS5vmQHDoWPPaGumUjrdJPssnHN4N5PtM76aXzyNiUPyvyA
         QtEIHn7+5wgtjIHd3qcJQBIVbzaIDrfHEVcSGVNgQH6CQUZ6uwf/3COV3UlmFIl4O96x
         8YSg==
X-Gm-Message-State: AAQBX9cxtJQIfFSm1K2lyOkTFvxguR5+5kMboKTzqH0P00gIkKYSg1It
        hLB60VoDCyd3l5QY9HnmL7Ti8sfRi7k=
X-Google-Smtp-Source: AKy350atzgOqJfMlfeA6Fi/DYcUG37eSqfvNVXRCg246xPlx6uyD1qQC98HXirV7Mi+lZyVucKDoNg==
X-Received: by 2002:a05:6870:c191:b0:17a:d2e0:1a18 with SMTP id h17-20020a056870c19100b0017ad2e01a18mr9420461oad.43.1682355058203;
        Mon, 24 Apr 2023 09:50:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p12-20020a4aac0c000000b0052005fd50a4sm4972549oon.35.2023.04.24.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/15] version-gen: move v fix into sed
Date:   Mon, 24 Apr 2023 10:50:38 -0600
Message-Id: <20230424165041.25180-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are already using sed, might as well take advantage of it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 40502363dd..6bf932c281 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,7 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=2.40.GIT
 
 describe () {
-	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -15,7 +15,6 @@ then
 elif test -d "${GIT_DIR:-.git}" -o -f .git
 then
 	VN=$(describe)
-	VN=${VN#v}
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

