Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B210C77B78
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDNMTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjDNMTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:21 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240EB47B
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:10 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-187878a90e6so7696319fac.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474749; x=1684066749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HU0YFHDcYBZPx41JKBqc4qnKClKqOBzYP3RJug22/8=;
        b=h/xLUjrhcu/r2vg0hTcCs4muv2oo8WzSesf0zYDun2rTvZbREHCeuCKt5+dePo/Hlw
         BMbytf8pWE7Uaba0pdJODRcDNnCTQkwjn+eBza3SMTs/pvbe2Bw9Ow6d9sZWibvHvBUh
         b9JyP/2I0Xb0bH1yN1rNCwRGFqRiDIdxSCiW+osuWkwp1sFfPb98Zst6kC8CN/e7aFqP
         3j1V6zu+8h7pgE70/eeT0UXWcDguPGjNjkgjFlLCcCBzPvncjl39bEjA1KGJ9eBvqJdg
         bMaKZ3vrPdr9M+B77rDY1arnTe3CPrsm2JJ8ArqalkVAdxHVHG3TAjea6NZ/zusPubL4
         jB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474749; x=1684066749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HU0YFHDcYBZPx41JKBqc4qnKClKqOBzYP3RJug22/8=;
        b=T9Gj1YF5FsW/dAbvckeyUirWuzA+u0y5bohHE6ldJlIcS13QdwUlgpo6PQQ8dvMtTX
         9CFii9W4OKrQntJzh5VEQQuFcDr9tSg+dYrWqULmy5q7gGcrctqCBhfSTUuMP2M0HU9k
         MJJnwXWMz4S2+86GzSjVPSSht5rUT2dUd69jiDWE0ejP5T3kZ/Xbb0HBPMjNd5yMG6aR
         KKHM+QpQ9VvYDukM0C9mIB+Z4BM+JpW05vO+4FQjB8kSDAccdfBrBGxpygLC9uiBPnVf
         QSXM8uXCt5MZYGSb3JNh38NIW4wRIjAmASu16g+qpJrGOrEQ+68z0m5YF1Poj+C9o4L4
         n8Xg==
X-Gm-Message-State: AAQBX9eIObXpks4j0ieKmkdPB0j5MkKDgI5tWjB+iRNQ4wnoJRBZ1IeL
        P+ViRVDmGzTl/tltSvGt/jrqramarLg=
X-Google-Smtp-Source: AKy350aUJ8pECSHsdoPADGtHqW3FMJmpB7Gx+InNYJu44+u43wd8S4+ZxAWmOTtR5SBLvJLcE+1TRw==
X-Received: by 2002:a05:6870:c58f:b0:180:94ca:f44e with SMTP id ba15-20020a056870c58f00b0018094caf44emr3470047oab.25.1681474749301;
        Fri, 14 Apr 2023 05:19:09 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id zf24-20020a0568716a9800b0017ae6741157sm1734937oab.4.2023.04.14.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/18] version-gen: refactor GIT_VERSION string
Date:   Fri, 14 Apr 2023 06:18:39 -0600
Message-Id: <20230414121841.373980-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 2b0973f4b5..8f2250bb1b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -7,7 +7,7 @@ get_version () {
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
 
-VN=$(get_version)
+NEW="GIT_VERSION = $(get_version)"
 
-test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
-echo "GIT_VERSION = $VN" | tee $GVF >&2
+test -r $GVF && test "$NEW" = "$(cat $GVF)" && exit
+echo "$NEW" | tee $GVF >&2
-- 
2.40.0+fc1

