Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F3C43333
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA420757
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krKqAc/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgCVA4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37213 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgCVA4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so3296955pfe.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKwXDdEgvqNCZQueomXnm2UFK9k6/cUTSnGqiZI2BBc=;
        b=krKqAc/n1dnUVxqOjQRrOtS03fReJgh68fn7cPpDibiIuB0TC3ARCax4HOI3MznHp6
         qgHNhJEBEtt82xtvy9+hGwUxUmZU5yJ4DxBSIm/8RGUpqEc0G68z2NA7ysZ9Fu/FpY5p
         pdVsRA5hkFJGJo6CioliCmma9lsvY1lZa+KoVHQh5KxSCq9ZR4F5JTSx5gOZvs4nX9dJ
         +I8ronHBrG+zLOIGZYwFVuwwGNcRhEjJwJXifD2czIIQrn+bvfWYVZHo7aOeaofkHSQE
         aUJSAiypSs9XqWkQyQA83iTvpLuRLBjF7KjYA2+HrJpob/plB3azv6W4n+0+p0N9LnhH
         4jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKwXDdEgvqNCZQueomXnm2UFK9k6/cUTSnGqiZI2BBc=;
        b=b3d42g6RAq4mYT5fQ+13DJMtlNjxf2N0ss5lYTYohewdnIvzJmdHjKhbhSKEbUFYFg
         cGtyEHDg2m4AZUPDWrpeFGZg422NXw1F4hYPCnRiPQ66v2Sjpfq6AJ/jbpZ5S9X3k1Jq
         2JPYNNt9iDcmNWCo/HhB1MQtd5HMqkSXHzMIiThPfOsP3iZo67we2b8TYvGH15vVCVJn
         AfRINkSitvwyNFurMz0AGZTJkjeS9z0nABsV9S3qUYfZwaImciWaQ3nIegUUXG3o120d
         WGA6sVyBler7ZEMb7sQVmjRhpT4jpFDPOgrnw7iDUuFVjp6VXp4VzdC5+yS5b4LpM4tm
         mRyw==
X-Gm-Message-State: ANhLgQ3+KqRi/jGuYO6zR4nIMC6N05zPRMyfnhEL0tCwuiiW1sAiHhEX
        DVbmjfS+1zwHqgQfPERVuO+Gs3io
X-Google-Smtp-Source: ADFU+vsUphGz7CNBasl8Bmx5MeVjfb/CSWOt5rSjBRhVp+4O3Btg6Fzf25BOz1zBZbZXGMZPtOBl9w==
X-Received: by 2002:a63:5d60:: with SMTP id o32mr15008838pgm.126.1584838570175;
        Sat, 21 Mar 2020 17:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:09 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 4/6] t5616: use rev-parse instead to get HEAD's object_id
Date:   Sun, 22 Mar 2020 07:55:16 +0700
Message-Id: <ce976e850c277fff812610266c14b0db03c6295c.1584838133.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838133.git.congdanhqx@gmail.com>
References: <cover.1584838133.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only HEAD's object_id is necessary, rev-list is an overkill.

Despite POSIX requires grep(1) treat single pattern with <newline>
as multiple patterns.
busybox's grep(1) (as of v1.31.1) haven't implemented it yet.

Use rev-parse to simplify the test and avoid busybox unimplemented
features.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e976..135187c5b5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	git -C srv.bare rev-list HEAD >headhash &&
+	git -C srv.bare rev-parse HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
 	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
 '
-- 
2.26.0.rc2.310.g2932bb562d

