Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED124C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB5E2084D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsZK8jgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgHERwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgHERuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:50:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A0C0617A1
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:49:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so25676876pls.9
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whHTi2PgYuIlHWf9MWsZT104mUeL4Ulx6vg3RpDG9VI=;
        b=ZsZK8jgHetoHDIzepqTfdpLISDLvcJqvWWCz5gYIqrbNniJA79cC1L/9KtMk4yRT5+
         nUMqfqGSpINC7ORF5OhjWoXfzkL6jPtb2Z6ctExFQihX46lDMrTZwESxyQkU8Pp4nUEu
         T63wEJaF7/LvWPztA4jOrbraJYfhIQkLTvbmy28n0Ul1O1ggUZVIPFP5RctmIKGf/Ek8
         Ct5mCZjOH+NKd/OS7TJUlUitZAxdzJ2K1i3NBFjtiv8YUqFOzCG+CbMKl78s0rsKtzz2
         YWkQiicxoJUsOPMrL8cDhs251/xq+U1QPOQnLYvKuiLc4AtbBKZypvboFP3Gj6Qdjve8
         jQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whHTi2PgYuIlHWf9MWsZT104mUeL4Ulx6vg3RpDG9VI=;
        b=hQpXOlboRe9LAbFBK9XRVqRJk0XDXr1VdCf//zVhLqBimX85io8VUMRJ+9//DL6X9q
         /3xU3OR1QzTMkVv2tAgqpxLY9P8217YKzknZHSquote2rUdcU6IW5vdGnIgZke21h1ri
         H7S4yE40JFVVcrhgLfqQRXvYyJlgqI7J9cKjwYx7MBrazB6haUKCOF0irqtmXSywnCIr
         p251atE1b82YMOVZKS6CjQp0pxIG6Bnm2c1RQpbvSWrgvw5tz5QJPV3WtX/GQOilJc8/
         IQEJRZDLI9jvxI9KbxFCLOySQ1+mxFAWXQvaOCHGkJg84zonkKJAlWWHrbzfXSelRAbY
         Z2eA==
X-Gm-Message-State: AOAM5307phmLmQ0hFzQlITCR/HYLAwYcCaBlYH3Hh5pUQ6/ruVk9nC+1
        b6ZQedzZxEv3A2eRh9P6szaSVYwSUIc=
X-Google-Smtp-Source: ABdhPJwIwAUXSSGDLvs0zTr0I5Aix3RWgDm0bPf60TQnk8xPwlOu6fLTqq9cVhcafcdm/xYsqHTxPg==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr4570666pjb.226.1596649796595;
        Wed, 05 Aug 2020 10:49:56 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.185])
        by smtp.gmail.com with ESMTPSA id z77sm4765150pfc.199.2020.08.05.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:49:55 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
Date:   Wed,  5 Aug 2020 23:19:20 +0530
Message-Id: <20200805174921.16000-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--for-status' test got its expected output from stdin. This is
inconsistent with the other tests in the test script which get their
expected output from a file named 'expected'.

So, change the syntax of the '--for-status' test for uniformity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 18fefdb0ba..145914cd5a 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -285,13 +285,14 @@ EOF
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
+	cat >expected <<-EOF &&
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
   > Add foo9
 
 EOF
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'fail when using --files together with --cached' "
-- 
2.27.0

