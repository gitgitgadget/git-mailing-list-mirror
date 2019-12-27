Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E42C3F68F
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E752520882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWee/0Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfL0Nrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:37 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:41790 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfL0Nrh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:37 -0500
Received: by mail-qt1-f172.google.com with SMTP id k40so24586800qtk.8
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OqXpG21GOUk4EeE47+9cV+f1Ev9L9weVvt0UqtPUdOs=;
        b=BWee/0MoGCMnAcSBc1Re8YNnFHy6AwPJHPZJ5LYR0fLUbwgPfAhSsRpEyWqtMK4Vkf
         lycug/EXnMVqeldpNDaBr4EdCsTdprUOoPXB58vSTRRn54c4oXGWBz0JXlL7OEVmqTpx
         Ie3pMYjunbA/M5UGaj3sweTE+K9H8Nj+Kl0liP8DToiy5xBcaQt9Z0bipfuL67i8DgqH
         7HrUtq+jn20vCPqWBIVQaIHZ72AIJmCgGD+zEgrCcdBCE+PjH2fbtMdZj59ArjqTiPD6
         HYWP0fjQ0T5t4+WN2+nYOIUym4WZvFHsafTqIxqiqStKjlVgvpIIXrim0WEYX//MFOam
         jTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqXpG21GOUk4EeE47+9cV+f1Ev9L9weVvt0UqtPUdOs=;
        b=TtvLEMJJ/kU54uI1Iel6KKKELgBv0g/c8TjkdgRcJglhmVn0YyyaoKaHyoOQD7q4EL
         VhtKzMucEnyAD/jttXTBqyCfpF3J86oHpuKvnUahme8IA+QAds+V8JfQDedFfiWJmTtS
         4tFDJqxzl2c80EA1yTm4P1F6fvVBMqsu9Gqeal4HxgdmkmP5w9M4mE8CIgA1/iulO5eR
         fLqXNC2qdkn4/J2RGurzHWNJxwpvHhn/apdBnvCP3lCZ1LkJRZ5p3OUqkBkm8ubSPqT5
         gkkbkEE0cYovbAMcX2epvYUBxZcaEkEVFLHHGF9oUMlOrg5plilADYLkMX+W6dXHfUt+
         hfSQ==
X-Gm-Message-State: APjAAAVmO7LvhuoFk+Mc8wWo0+ErJ+qs711ISQRis3jGxEbo8SVrpayg
        Jm8IkH95DxTl5xwbSSUZokfReroh
X-Google-Smtp-Source: APXvYqytrVp3t8AVXQrh3+aqBuYxCrPhbEPyXugUZ8lcffoLtyYRTyLvtLgYYWOpUmKmmRXdsjvFyw==
X-Received: by 2002:aed:218f:: with SMTP id l15mr31603742qtc.247.1577454456113;
        Fri, 27 Dec 2019 05:47:36 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:35 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 01/16] t2018: remove trailing space from test description
Date:   Fri, 27 Dec 2019 08:47:10 -0500
Message-Id: <a0199f1e48b88a93ec181113752fab132b22fa91.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 822381dd9d..e18abce3d2 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='checkout '
+test_description='checkout'
 
 . ./test-lib.sh
 
-- 
2.24.1.810.g65a2f617f4

