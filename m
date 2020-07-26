Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D3C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F602065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFegmTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGZO0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZO0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 10:26:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B338C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so7987580pgm.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1JuxiEFbBgSuA8iGZ0RpKI2x/jJRiy3MfqRBbgyn/Q=;
        b=GIFegmTYeetu9JLXr72v5JJxU0YmZiXbZCEJ6I7acDD8fH4Dqw993tVk0YNqJQAlUO
         Gt4xmJk19vrpRSJd52hr+CefExG4SuOtbkjgiEOQtfAb/GXiW0yqRHC3+o51EXYuHl7c
         09S2Xa/sN5OSVA8xaxftPAu1Isc7UlSq+vGg6q+DyVq+gMiYQQ6ebY7ygv2ycKj9cui3
         hRm+dV2bSFKoYBzFG7wwNt+Fi8Ooc4+liDGF7W4O9aaid5olFallR9axZK3I1umtpmEU
         Mp6gtDhZLeD0Kyw0ToY2OATY0VD0NNqeRXpPW62NSDSfnv4niVw3p5JYqSaxjr4keVA7
         g54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1JuxiEFbBgSuA8iGZ0RpKI2x/jJRiy3MfqRBbgyn/Q=;
        b=hhVI8qdsjErIm5RBLRcvNLaW8YyFLMo8bXDHh8hvax5j5OgH8AmobxFBGlXSHbGLhn
         Wc6CAFc5GxbFcX2mP2yzSXoy4apDPm7FyI5nQLWg7o7WXqHcQWHpfX7Fo687nkoeTDoB
         aekLgznZnIrOIfFsmggIuRuJkNhVh5A5GOiH29BJKs4jhe8zGp/r+dFzL/hPhIlee2gi
         0QkqyY+gb4F2AOh7Ep6fQ/Q6JJNzaSpxdUSywnoJ8tJLDUyx7OpzD+5BE1l0/AKcsn8P
         eXnzrqFFdMWPqAX55YUD9GAUlgAfDZwgzlZey+nX0AcJGu8TH/H8HdO0/e84KDWzATer
         q2Tw==
X-Gm-Message-State: AOAM5314oAucoos572Nma00JghMEv1SD8bwWnRH13oN7oeELRmxVVnRI
        ILBy560GlJA1cTCW6QSDlT7wXV4J/NI=
X-Google-Smtp-Source: ABdhPJzhScOGIutRvWtiiP6crX31s1e4tiWA5V/AOxm6IpbTJExj97t9VDRDfjGu1tU/ZIuI3zhEiQ==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr16522679pgn.35.1595773577204;
        Sun, 26 Jul 2020 07:26:17 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.48])
        by smtp.gmail.com with ESMTPSA id p11sm11278908pjb.3.2020.07.26.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:26:16 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH 2/4] t7401: change test_i18ncmp syntax for clarity
Date:   Sun, 26 Jul 2020 19:55:51 +0530
Message-Id: <20200726142553.42545-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
References: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
'test_i18ncmp expected actual' to align it with the convention followed
by other tests in the test script.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 4439fb7c17..18fefdb0ba 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -183,7 +183,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
   < Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
@@ -193,7 +193,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
   > Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -rf sm1 &&
@@ -204,7 +204,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 * sm1 $head4(submodule)->$head5(blob):
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -f sm1 &&
@@ -217,7 +217,7 @@ test_expect_success 'nonexistent commit' "
   Warn: sm1 doesn't contain commit $head4_full
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 commit_file
-- 
2.27.0

