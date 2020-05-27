Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06E3C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C79520835
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv8wv+0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbgE0R6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbgE0R6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:58:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC3FC03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:58:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so324879wmi.4
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hug2+HGAr+Yof8+HRcycD3K48zAjtt2NaPLaqmMNsXM=;
        b=Hv8wv+0lnWmyWwzPK8kVjiVmiZ6VS0+S5TTcpSOGnuF25tOPIRDh7y+OEY4VKDRSSc
         XAfchdUuauUNVSg3nbu9HCcgUhWmt8QsGlL5Ke2G5rz+iKSUCwbnUIyI661Gdx+AO46X
         IDk+gh4iK6PCkgmanj7JuuDkYqxKPkDMMZLqJearheXRns6RInh9tQRKjODV0TqdrlpV
         pxNwGz1RPxqbuxBvWMPq09lNeyssd10PyrFo9J4/2FZoOz9SItK3Ed45K8+u0XRAgJzS
         7+cT41qwrvNw86UHRkCikSbSbMc3CvPVtIrCivm1tbq5Pzf8QR+kD48Px9zndr9XsKiY
         5lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hug2+HGAr+Yof8+HRcycD3K48zAjtt2NaPLaqmMNsXM=;
        b=S4VEq1h5ahsy09HUcK1cPQQMa73xdJfAAJy1RBmqhQpVfojtctSdEvUT/wTYuLuZnC
         Y9JZA5/0h058cLSQp+DzqYLXAX4b+F/FfprHuaJX3QJ0Y+azLU1ZTCkvZl8OYGtITzV9
         2pE0u50eJAbyMirfFS/XQTFRmlaLDjXC988sPLB0dLwAfViSsZ/6vmgTscHAfGKQeL4u
         ODJkdhWF6EUNwImg3AmIBvslXSEo7JD30lpythLZN/h15IG6oUUHIs2fN/DBg3NiSDWk
         tjKS5Um1J5xssE5+0JZ3q+tvUKeBnzEvgkfnA2Be5JunNXAyVLzeJuwm67sx1sS59Jex
         EDPg==
X-Gm-Message-State: AOAM532mEqErK20iBdlHn38KNib250BE1+0WK+Mi0bMYCKLgCX7YDEmT
        ZXdxK/47GIngwyuXcGU7LtY=
X-Google-Smtp-Source: ABdhPJz5zOdNQrWyJbekYEFXEOBZukU4AeDmO97zDY2fR9IQo6Z/P6Auw8Tm5ga3VgNa+l8TjBQ07Q==
X-Received: by 2002:a7b:c096:: with SMTP id r22mr5333115wmh.92.1590602279570;
        Wed, 27 May 2020 10:57:59 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id p7sm3471502wro.26.2020.05.27.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:57:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 6/5] fixup! rebase: add --reset-author-date
Date:   Wed, 27 May 2020 18:57:48 +0100
Message-Id: <20200527175748.54468-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527173356.47364-6-phillip.wood123@gmail.com>
References: <20200527173356.47364-6-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Sorry I somehow forgot to commit this before sending the v4 patches,
it fixes up the final patch

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3436-rebase-more-options.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 5ee193f333..ecfd68397f 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -196,7 +196,7 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
 	git rebase --apply --ignore-date HEAD^ &&
 	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
 	git rebase -m --ignore-date HEAD^ &&
-	git log -2 --pretty="format:%ai" >authortime &&
+	git log -2 --pretty=%ai >authortime &&
 	grep "+0000" authortime >output &&
 	test_line_count = 2 output
 '
-- 
2.26.2

