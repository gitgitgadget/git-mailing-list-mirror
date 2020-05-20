Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A2FC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6611320748
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLbYsYb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgETDpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 23:45:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72676C061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so620742pjb.4
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04/JYjKUKXaLwff96hkthUki9u9In6mW0M1dwuflJwk=;
        b=eLbYsYb/3SDeL7g8pmJ11YO41DFEN8DrRaaoO29ksJnRU6z/RfgZFV/x4KdQxMAkpH
         0gN9bJd5jw8ix4Zy8XDFFt0ODOLt0p2anJXFOsGis0d2JvwNXnWm5iAOssUA4FW0HFCc
         vJvo9g/5uBtJfpSvLkYAXkKo9C4ebeAcXjVercBTM4Y7PMmRTiA6jULiQyE2Mdzt0s2W
         B+viiyghKZhHSFHEMHqX9kHpiCK8cVrUNvQYd1AHsdToIWNzpzZ8BoLefiP5uisHSqIq
         unyUSBgrfmO1jYeC/EpFVCHuPj6Yg53DsqVkB4oGySnk27iIp6coTbahJzhVeezrKI+P
         Fswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04/JYjKUKXaLwff96hkthUki9u9In6mW0M1dwuflJwk=;
        b=DS5TeYGxG94aVgQ9IPVD1I/NjYdoIa1IE9E44hdMusPpfZncncYe0DRmkUnvuRmanR
         hOmKL8sao8czzbyCFJfJhqCRm9mDMEd0s+cOJvr0JPO2RM1SZ4wIQogICjwpWn/TTBx6
         6JoCSOtOfOR+zcob4nC/dfAnjLZXTVw7HXZqfhp4uGR3NID3d7gLDAigNlv8OxwCgwi4
         jwgkX9h8SBqMwPJBdq3Z3H9fW7zr51c8ipJXicI6QksMSicu3ZXp38T9A+uOmtMQL0ZY
         wdsH1R7vgH+xottJnt0yAeHfJrQWiiIyhor2uK4M2nOi9rjMXHzcpX5BkMCseOUPDELx
         r8bA==
X-Gm-Message-State: AOAM530juX+zr12kNBjLZX6huVF8gT35TF6nPq/Xh522xUrNtRE49ha9
        nMMp1i81L7gJqW73qAZE0TdvUl/I
X-Google-Smtp-Source: ABdhPJwkbIZFUG4QZ5f+XAhMzqlQ80/tQqTBgZmrIgns6eCWj8NtfqJKybFznQWxCXM+iFUX1CNfKA==
X-Received: by 2002:a17:90a:3201:: with SMTP id k1mr2882404pjb.202.1589946304719;
        Tue, 19 May 2020 20:45:04 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h4sm762820pfo.3.2020.05.19.20.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 20:45:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] t4216: avoid unnecessary subshell in test_bloom_filters_not_used
Date:   Tue, 19 May 2020 20:44:42 -0700
Message-Id: <20200520034444.47932-2-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.187.gede8c892b8
In-Reply-To: <20200520034444.47932-1-carenas@gmail.com>
References: <20200520034444.47932-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seems to trigger a bug in at least OpenBSD's 6.7 sh where it is
interpreted as a history lookup and therefore fails 125-126, 128,
130.

Remove the subshell and get a space between ! and grep, so tests
pass successfully.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 21b68dd6c8..c855bcd3e7 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -70,7 +70,7 @@ test_bloom_filters_used () {
 test_bloom_filters_not_used () {
 	log_args=$1
 	setup "$log_args" &&
-	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf") &&
+	! grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
 }
 
-- 
2.27.0.rc0.187.gede8c892b8

