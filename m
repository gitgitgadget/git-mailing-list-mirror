Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37979C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BAD64F73
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhCPA4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhCPA4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38819C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y67so7697399pfb.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRzqgxRED+G3WH3sstIxjkw2+KTh6NNCbSMG3GK3J/k=;
        b=tCgiCbDqkFYn8GCJbxEbprA3+pCXzavmsgk/yAuALfp0go53AWji2K4U9YH6L5IBjh
         LjVKQ7JZvV4QlS/KbdhkHsBP+SV41y/S0jbE/Uv9z72hIKSgX5ax5LgXzmNKolYB0EtM
         mgcXBO/UZaOPmEwfxaHce8SyAjExjVUK3pOyLO6NoF/c6oQCDelVshdbZJVOQGYXQymi
         Ea03Ajsk1rnY/ABpU0IwYJ7dDgryMQSGaohDxukmWemiLCiToNKHtQ5D0GL5jPWjWf9M
         lkDLg5W1hYSXxusSnOBa+Hk3rKpRBq7BjOmMxSGmqE6U+oDXC+4BU8ZHkDhlpo4KGqnX
         4NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRzqgxRED+G3WH3sstIxjkw2+KTh6NNCbSMG3GK3J/k=;
        b=qgbYhNmYgr8h4P/j+a6mPVTC3aHQOKfQesS75pYnpikIenDEiDfi6Mr15KfKmlqlXB
         9r5aKFX3UkLwxnAW5w7BG4Pjwa4FM6LEOelmhiCizswDAXO/qk1wg3AClkBOq2/ZhXj0
         gHCNs5HFJeZdGraMlB3XWPnEeNRlNUZb/SkJG4NspVsvIwraK3AdJtwAVGAhMZw3UKPb
         8F2KuIRoZv9wUPVwzAnrpFPHKca/LHWgttWyOmTN2M50Zc3lzyF/OthpkhA5YrpMVOSC
         +8rjqruPIKa6nU7LNm9LhTv/RspVDCsZ+JWiCjuqJ0tqRyXEzkWLgRgNk+ZnYaCqjvZB
         pAZA==
X-Gm-Message-State: AOAM533TwBdN7PxRQ8u0swbDuxQ/yvLCp+XX5XLy6rKTbHTsSbs7kSaB
        qP/11GPHo9zr3437S6V/4l8Tw+IEKBg=
X-Google-Smtp-Source: ABdhPJzIpqynDJIrKXu4DJehxLClhv2CFiKaHG9gEVP5ZdM8yq/1OAgcKft1PN4runBaKILH+Sy3Qw==
X-Received: by 2002:a62:7556:0:b029:1ff:5bf8:72b3 with SMTP id q83-20020a6275560000b02901ff5bf872b3mr12723663pfc.33.1615856190625;
        Mon, 15 Mar 2021 17:56:30 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] Makefile: mark 'check-builtins' as a .PHONY target
Date:   Mon, 15 Mar 2021 17:56:20 -0700
Message-Id: <c889973be754336005d0155ce670f16e322df9c3.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Then convention in Git's Makefile is to mark targets which do not
actually generate any precious files (such as static checking targets).
.PHONY enables the target to still run, even if a file is erroneously
created with the same name as the target.

Mark 'check-builtins' as a .PHONY target.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index dfb0f1000f..6dbecdb606 100644
--- a/Makefile
+++ b/Makefile
@@ -3236,6 +3236,7 @@ check-docs::
 
 ### Make sure built-ins do not have dups and listed in git.c
 #
+.PHONY: check-builtins
 check-builtins::
 	./check-builtins.sh
 
-- 
2.31.0.rc2.261.g7f71774620

