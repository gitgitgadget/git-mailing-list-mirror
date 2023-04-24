Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775AEC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjDXQvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjDXQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1AA275
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6a438f0d9c9so3730181a34.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355057; x=1684947057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQX6LIbnw1CWCYBYW9kF2fMJhM0mHPuKXGj1IEdnRJM=;
        b=VBAI/20Qm5M+WV0GAWeofuAtzIUyZxOO8TbMITMReG/R/bNGqNV0FoLZ7GRr13QVKG
         TRpHWLIfPqFoMCTb/MBNRoe2hK8W7tKuASRU8oKUlOaccP18LbYH7ic3fw0hHP5V0Ei4
         j6b1EpYX7oFq1JeqaaqiFgPaYstYnorcXl215pxHITvpB7CuW86bl+CstIKFZD5EGtsQ
         umf7g7/7+KnkRqJJjB5VBL/g28g5rcO8UUgaCeeTRvkLx1HYmvENKNOjjgLbmggfMTqg
         Xxg7LUWQtC9fafMIzbQ0QbOVcCo5N8dLis2HZX4fm/KxyhxFTPvEVXlGSQcA6ElQ5b6P
         Hwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355057; x=1684947057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQX6LIbnw1CWCYBYW9kF2fMJhM0mHPuKXGj1IEdnRJM=;
        b=KQc+LNCP+BCALTUp9jGjjGE3bmoX68OMIKgXFxJloYQuJ+CyEZhkecUIEHF2DuPaTH
         74tvkSTpjUNUVX19fdeVJg0FwyS9ZRzYQqfW8VUx8IQPrrB0jxuyMIWzs3cIa3cqHfP/
         ULPVbitxUhBn8tQ4ajCn8yemd9L7pYt93+X4DkXTiisGZPrNqPPsItYQm7MgNdpELbRF
         GnoVpZv2ddJFtTSqRPiFyfzKP7o2RTE6lCCdgvPvAL+gPCdKC+Roh2VC+nZkrExz8kES
         ZGGqd5G3v76PKUrpsfjD8aV9nw3jmLx3N19UBuRtFmU5p2zlQPYEFdf9GUPRn/PSGR7w
         YgWA==
X-Gm-Message-State: AAQBX9cYjwCM2AUrO9Vftph6AJi4uQFh4KenS5dD6Bv0ehtLBIEa0oPm
        ynteOlYmQOtVlHFzfsyKlE+HGkNbA1o=
X-Google-Smtp-Source: AKy350Z6F3VtNhTbsJvLltPpBOYC/Hs7PBgbNdD3BzuCKfeE6QslrZTcUECQ6KCLAI1JdATAzP7erA==
X-Received: by 2002:a9d:76c8:0:b0:6a2:dd75:1791 with SMTP id p8-20020a9d76c8000000b006a2dd751791mr6706380otl.7.1682355056950;
        Mon, 24 Apr 2023 09:50:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b0069f9203967bsm4758695otk.76.2023.04.24.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/15] version-gen: do v fix only when necessary
Date:   Mon, 24 Apr 2023 10:50:37 -0600
Message-Id: <20230424165041.25180-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in having a v in the default version only to be
removed.

The only time we need to remove the v is from `git describe`.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0eaa813cca..40502363dd 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.40.GIT
+DEF_VER=2.40.GIT
 
 describe () {
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
@@ -15,11 +15,10 @@ then
 elif test -d "${GIT_DIR:-.git}" -o -f .git
 then
 	VN=$(describe)
+	VN=${VN#v}
 fi
 
 : "${VN:=$DEF_VER}"
 
-VN=${VN#v}
-
 test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
 echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

