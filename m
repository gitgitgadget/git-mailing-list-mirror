Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849DFC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC162073E
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBg01rwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgFSJdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbgFSJcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 05:32:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2658C061795
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:32:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so7809154wmh.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BfDfykAv0hNK6rgcFqoxRt3bgyJDv+Tnb2XsORmlSQ=;
        b=LBg01rwOPFex9dILo6O0qRaVBT1PyGR+QjyvF6DTTScXXOPdFGrMlgbRimyGbm/3C9
         7l7CdU0+Ilgfe981JOr6U8ndAAbsqkSvORZ4NT4bfayVWrIb+Y8NhDFscwY7NXyVWLYZ
         +a1tXDliqyblFkxrV7fgZJjOWwKE+u7ATaIxi42krHrDbd1/AFZQPQF4xkR+V2et5Fml
         MnSv4p60xso82nbHvNvw13JE8a5yZAAv6BO/YVzw2daMB/hrXBucKo95vj+7Ge9p+v3V
         GRvcrXbubulAUCeqaDkvFjMuDar1lToXWNqlOZUIlL0NG7bu3GpYSpnpaPpESlEHGoQb
         FVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+BfDfykAv0hNK6rgcFqoxRt3bgyJDv+Tnb2XsORmlSQ=;
        b=Awqed21cDZb/FA+8F53xqIQP+wmRbgiCZCnfyLNn30+fw3vV1AuLbSP/OWM5ti9k4b
         2V8brzTZ1CLoRFGbLj5COkhAt2v7kH83Fvi3yYuDNWhmXH1ffuh7GcmwOUD3WTNc09jT
         g/WQ0guWm6FQHoQh5gpugCrmegUF7Yf7ltI/rnR6/vNj1KZN3iVC5yn9hO0QlD0171Ju
         Pr5jVSjRK+Wjn9K+d8+0hzfZI8Dj+uX0zW+3dgy1s5SjA1wE/Q1kWX0yt7H+C5L0atR3
         v//qpuN+/QWo1CQJmWyZRlQIWrFhH9ouSaL56HgU9bC3GX6br9r//qBhpVnzXFvK1EcF
         mPNA==
X-Gm-Message-State: AOAM532xc3/i+64Zgp/E0zhZrXLGywn3OVvnx4Tk3qg/hwGdb94Ufrng
        2usTf2gLVFIZ8ZBJIz9V1rSpZw4GzCU=
X-Google-Smtp-Source: ABdhPJwrFSJl1Q4PmuFeJkgc0qExak9OPhZ6JGMcZ1+idtpzmLST7N0spUls3fiTx4Kvhyt8mg/YDw==
X-Received: by 2002:a1c:6744:: with SMTP id b65mr2787988wmc.170.1592559132026;
        Fri, 19 Jun 2020 02:32:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id u13sm6435973wrp.53.2020.06.19.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:32:11 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Cc:     msuchanek@suse.de, Till Maas <tmaas@redhat.com>
Subject: [PATCH v2] tests: do not use "slave branch" nomenclature
Date:   Fri, 19 Jun 2020 11:32:10 +0200
Message-Id: <20200619093210.31289-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git branches have been qualified as topic branches, integration branches,
development branches, feature branches, release branches and so on.
Git has a branch that is the master *for* development, but it is not
the master *of* any "slave branch": Git does not have slave branches,
and has never had, except for a single testcase that claims otherwise. :)

Independent of any future change to the naming of the "master" branch,
removing this sole appearance of the term is a strict improvement: it
avoids divisive language, and talking about "feature branch" clarifies
which developer workflow the test is trying to emulate.

Reported-by: Till Maas <tmaas@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 t/t4014-format-patch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 575e079cc2..958c2da56e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
-	git checkout -b slave master &&
+	git checkout -b feature master &&
 	echo "Another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #1" &&
+	git commit -am "Feature branch change #1" &&
 	echo "Yet another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #2" &&
+	git commit -am "Feature branch change #2" &&
 	git checkout -b merger master &&
 	test_tick &&
-	git merge --no-ff slave &&
+	git merge --no-ff feature &&
 	git format-patch -3 --stdout >patch &&
 	grep "^From " patch >from &&
 	test_line_count = 3 from
-- 
2.25.4

