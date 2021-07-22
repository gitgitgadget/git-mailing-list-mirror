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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A0C4320A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6160C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhGVUsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhGVUsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9DC061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w12so120129wro.13
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=TMhlp8KPo0P5vwJ640dczcGZx8YQVjGs8pvjmwih+KLt8e61MHztwBDZTBzeTHobVI
         0ufb5fBAhZuFoUOZLF9Rooo/MKmqiUqnE3meW85kwwm0XSo79LSkCKJuA9Isb+k5Xmr/
         TxR17prtIYxoS939zCkIEzHafN4Ca4ET10PI/NeBFHD0wHQPIWi77GW9Qz+GBGt8S9JB
         ny//2pbeLb3uoJlznxrg9hgyPhapywGZRxm+Z46EdYmt9MUx0ftO9J3ef4iOQmsqXwfs
         lJFDpWcqJ8Q9ADMxTNn4PHjFPnJ8UkTqMPJESA7zPOpMugg2eqRNMrOUuqHNYDSNuytA
         lTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=Tg2Z/JiCB0ne8IfYIE6Py8GGakfHiju1/A1jnzQNQXlrIldrTU2LhpzJsNE0x/jCDA
         B4A7NgXjn/qxx0jcZxT52x0+N6dsVi6qZA68s7ir/uQc26F3Da26glvmGHcQTpwiemZk
         ZG06N8BeFZ9Yh3Xv/HRJpiVEQJrrYF+hIWwFY49lJfHJ9OeDn6srsA0NTSe/Q5o76lkW
         uWr8YTQgEqV8NrywJkjOcy21ZNGtRI8NN7J+hDyg2VlzA6I8o3nZYdgHmPh18HB/9eVI
         vZUQaiycmBxkWcK52ZDAzUQNWw7gec5ZWRcziJgxJRAke/mPEhZjpzNNBVVGBQSdI2C8
         WOEw==
X-Gm-Message-State: AOAM532JljCxyCHZiZB3GLqSK2hGftpWlfL9fwuUltMKDLy+RbXC1Baf
        RV+r9vxjmmb/2Y4i9u1/WGUntePHFWk=
X-Google-Smtp-Source: ABdhPJxAHyt0PxxED99AtMZoaFGP+Z7qbkg2FBL1hzRWuYIvoZo8CyK3q3i0jrym9otsrAi35wBuFQ==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr1997374wrw.30.1626989329185;
        Thu, 22 Jul 2021 14:28:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm23714664wms.21.2021.07.22.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:48 -0700 (PDT)
Message-Id: <d7616038d88f0f3bca9fec2a57abc2c9ca896e78.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:37 +0000
Subject: [PATCH v2 01/11] t6050: use git-update-ref rather than filesystem
 access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6050-replace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index e33d512ec11..2500acc2ef8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -132,7 +132,7 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git mktag <tag.sig >.git/refs/tags/mytag
+     git update-ref refs/tags/mytag $(git mktag <tag.sig)
 '
 
 test_expect_success '"git fsck" works' '
-- 
gitgitgadget

