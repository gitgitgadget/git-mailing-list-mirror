Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B7EC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02162611ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhD0Kjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbhD0KjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF27C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a22-20020a05600c2256b029014294520f18so2235356wmm.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X0PzUSzC+SRtK99yWFnIg18G/Wq5vdZArXandSlRw4g=;
        b=uf+ky12uG4Rv7GWrN8wvRkIbC7Qwa63iAfUl1DdFRN+y0Alhe3zo8I9bSyF0CbOOwn
         NZ9R71iVYz8j375f7k7dprdu/gFKpvGfXsYw8kJyKpOoPpCSSzAsq2JG5ceRWv+WlOqJ
         oa2wpcXIK3qzuR/tPMNwVK0NlHTCH5sVvYUd1HHqpygrDPZbd7in7Vhq51JnDE8cUP0s
         FEHWVveUwmTxZTq/6xhzyJl/Y4yobKL5QjXYKcf9NsKgeo1/IG9CdNmHZH9p2OdVIMMl
         ssawm6PW7C0wy36dHjGRwDgg9pXxGGapY8/geHfQCC0nihN0hX/zvTf5QDJNWM0fg2Cr
         Hv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X0PzUSzC+SRtK99yWFnIg18G/Wq5vdZArXandSlRw4g=;
        b=kpxatoSi90ayj81N4f3l+TV8gGjhnr+mT7BNlhVLyNix6zVU9D9OFLKC4X1BMCvGoI
         vZyDBRsmi7EKbEah9F0/JPQDAQ3eNVB7BGuR7Lb5qL0NQB7DWfQweNCyyshR6iBICWzR
         ULRgnmK9GTLr6lFKqI/87ZfHaEUcAZGEKESvDVUgOgmedAoP/13vexVrJHX/XyWjUU2c
         sPB/D6oe0FlxiwqWXGpbUWy94ReJIZ6mGx0PDFm6yDUt2qze45X9dboSu0Pxew5MZOm6
         cLln/I5xG8cu7bXimePDogMKulvGp9MgeCwxuw7zTdBD9iDWmrhUvve8l+NFHP/EWUu5
         lKOg==
X-Gm-Message-State: AOAM533O5gElfpNTt24q0xkIknVIsQqSB+G9vEnRi062nfKhQZUhDsvX
        ph/2H31iCpUA9Jf0AwcKWDLeQqzAhI8=
X-Google-Smtp-Source: ABdhPJyTLOEbNNdP71FJoTfdGcKYlGYV6azxSgfR3PvLEIGP2yfF4fLdp0B3QTEpn7/KObWu9VF0rQ==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr3704914wmj.64.1619519910245;
        Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm3328864wrr.77.2021.04.27.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
Message-Id: <4bf1bf16bca35002453c4542c6758e3545e4844a.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:11 +0000
Subject: [PATCH v2 10/21] t7003: use rev-parse rather than FS inspection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7003-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1349e5b2321c..cf30055c88dd 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -395,7 +395,7 @@ test_expect_success '--prune-empty is able to prune root commit' '
 test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
-	test_path_is_missing .git/refs/heads/prune-entire &&
+	test_must_fail git rev-parse refs/heads/prune-entire &&
 	test_must_fail git reflog exists refs/heads/prune-entire
 '
 
-- 
gitgitgadget

