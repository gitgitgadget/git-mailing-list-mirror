Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F06C433E4
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D166620656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luiVk8df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHUREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgHURAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E24C061798
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so1283551pgd.5
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLKYEQh2ASyGkfl7D0NE9HMv4t3yOOMzWWsPLW7TZT0=;
        b=luiVk8dfxdDCzir+kcA7vI76Go9Gr2L35j2QpC5k6f3XA+veocd8Doo8oeF0DlM+MD
         qLY83LgXqq7r//J5BVvURpBMEHTysXRYE/RivQIrJms8vR0NuEx8DEutp4RA7dFZe4Cm
         9hP3El9tiyTOlNNOQliEv0wr0qmAT8kCYeZ48T7g+qwyAcllBdMysyLSy/Pz/vwnWv8C
         l8XCP8sEPXBEPrl7z0FppXPVEI/7D+/tUJHJ86KhM5Z2xN9zDSnEKIg4kvD2TRVhC7oB
         w/rl+ecPq6fbvG5BJw9RmwyQvIcW3dGCgqaa8WlG8QqTS8EUUyyKnCCIuchjcSbuzLAP
         gxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLKYEQh2ASyGkfl7D0NE9HMv4t3yOOMzWWsPLW7TZT0=;
        b=GrL6FhS+AIHzWYWzTYx6hLaUHSYao3aZ6watFZW5BqM1JYpeAJDzOEC1cJLml7ThYd
         iXTASUjJamHq90uwpEy76Mlzin9y6ZypeW/HHrG/s8csE9+3CbBB79M/lFbeu+pvRkxm
         irRkZ9B2r66zWXp/D6EZfzmIHS+Aho5ovZv6EiRPfaCx/aAokp9v+8eyDOCnj+Ak8/kM
         yS76GHEP8We1kwd+B7l6Ys96BmmziTrQN+jZLAFiXx2XkBqHxKIQgp0htmFG9tfMnc08
         3LF2voaKSGeEjrdTSf3HpGj0jejtaMMbV1jI/XiG8fz7VnAreDWbGgvXfj4z5XZnI4J+
         5fig==
X-Gm-Message-State: AOAM530U29hBg7p/HpZ68qRsE3W6OeP1xg9rRFJ9G8mXqo9bsy9YOI3r
        7Ye5aQ3fwvXMhEnHBZLrq/WE2sBXab5Vmw==
X-Google-Smtp-Source: ABdhPJxh9LWBBhs/e1wOn4Bw/4fdr64RxjrWdSeMbjaNaDMEiLQwv4HUbjUuF8DYdz+DZXVOSFsuoA==
X-Received: by 2002:a62:d10a:: with SMTP id z10mr3328978pfg.7.1598029209774;
        Fri, 21 Aug 2020 10:00:09 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:09 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/5] t7401: use 'short' instead of 'verify' and cut in rev-parse calls
Date:   Fri, 21 Aug 2020 22:29:49 +0530
Message-Id: <20200821165952.14376-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
References: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git rev-parse' can limit the number of characters in the hash it
outputs using the '--short' option, thereby, making the 'cut' invocation
redundant. Since using '--short' implies '--verify' as well, we can
safely replace the latter with the former. This change results in the
helper functions getting the hash in the same way 'summary' gets the
hash internally.

So, avoid the unnecessary invocation to 'cut' in the helper
functions.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 07d4ba0b26..ccbac875fe 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -21,7 +21,7 @@ add_file () {
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short HEAD
 	cd "$owd"
 }
 commit_file () {
@@ -125,7 +125,7 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short HEAD
 )
 
 test_expect_success 'modified submodule(backward)' "
-- 
2.28.0

