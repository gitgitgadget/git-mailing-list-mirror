Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031BC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB1C61954
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYTlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFYTlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:41:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38714C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:39:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso6442254wmj.4
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ODOJTCqvmjw5DOl/mCrJ/Kf9rV4lcUS1rXQTTqifZa0=;
        b=m+NTEPl/Msh+LoyZoHg1WzuLHU5wKLBEmuC4EZOwx1iIPN/nC/Vl2s3hJdIi6cUH/+
         d28CXjNRcv4y1oJq3Z4nh6lrpU5fbVOgcPzsCzx194q+hO96w8b1XsKQ783s2cAcyRP/
         2PBoI930O0fuImvA/EyUTSOuUK/nNos6LZX9/w7pu3IIJpLHz5e5tqQhlGOt0BAl8I1e
         xsa/TBTJDXgfC3wMpiGsxKq8SOCy6DCCJAqv6VRfkG6updWKCf51jJ5nnfa5abxlUVvo
         yA85Y5B73cMnTr2PNFZoEFo4K0GFkoKXAHzHvgW9rLEKyIozynwyNFEcGhgOXtCTupnm
         vq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODOJTCqvmjw5DOl/mCrJ/Kf9rV4lcUS1rXQTTqifZa0=;
        b=oTvUxeWSxkrn3QzfJw+lB5zfIgayvbagWu8poHMBIfUMjWw1+/gCo26ZMuHYE5qymI
         vNJ6JcU+LHa0y7VhHnPCOVOdu4QW77n6AQyqrfy7OvUzRMD8Yc08pGVuhJPW9MOdhtMB
         ozGipcMgqtR7PhuI+3W9ZyEops19rJUgN4Si/PoUH+NXNCDBKOsEWql+CXbxGoON851k
         DiuWZ65JXPE24kkhAjG/793nmZaF4cBJRfNM5ZNchopKdyNyNKJJ3l/JjQMSzektZFPA
         sWxiKrsQc4jLWl0vvEI3XU/Rcmlb2tGpH7Uewnf/7lBnJopTu0/Pbrmp3vQ80LD7DgQf
         tbTQ==
X-Gm-Message-State: AOAM532RtVmATrHs9EKU2EFii582k9BtQ14C7tgHAzjtRkyqzOY/0cx6
        3EjQAG7tiZL1Q7uaVLT6X6JJw7vmyQfcn/OPVsWANw==
X-Google-Smtp-Source: ABdhPJypkmmuw9yGxG+E8ERVIjiNV2q2r6ZwwqmaJqqYg0XxLrHKXn+Z9sFeVcn82fpXMrXiGa0pMQ==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr12537578wmi.87.1624649938603;
        Fri, 25 Jun 2021 12:38:58 -0700 (PDT)
Received: from localhost.localdomain ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id c18sm6679233wrt.83.2021.06.25.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:38:58 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 3/3] git-worktree.txt: fix typo in example path
Date:   Fri, 25 Jun 2021 21:38:51 +0200
Message-Id: <20210625193851.2233114-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625193851.2233114-1-rybak.a.v@gmail.com>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f1bb1fa5f5..66e67e6cbf 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -387,7 +387,7 @@ These annotations are:
 ------------
 $ git worktree list
 /path/to/linked-worktree    abcd1234 [master]
-/path/to/locked-worktreee   acbd5678 (brancha) locked
+/path/to/locked-worktree    acbd5678 (brancha) locked
 /path/to/prunable-worktree  5678abc  (detached HEAD) prunable
 ------------
 
-- 
2.32.0

