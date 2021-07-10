Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE236C07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2645613C3
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGJNkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhGJNkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4950C0613E8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p8so16523119wrr.1
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW1SRHaWkbKF75XBFUeFetQ7HmluAjjHrZWZ3oFnjbM=;
        b=pLfE0rktRJGfB3owWoRLn5/UIBeyeSWJl0jxMS4nYFlRFgKcXiXKZhavlUhWG+/2CD
         fgzea+YwrWkSKmV8HyYFGN28KCiToVbKN2E5OKwdIfVfeaFVq8/V7JdA/EO1PfGmPrOb
         2XS9LOf4DZQwCIXJPS+nuIE+8JUx6SXTcG+7fDUYfrkU1b0bNIiFsROJFv+FoS+lWlJ/
         bWWGhaWgIljoocINmdSbke4OK+Sicx7uQMLw6HIHBv+UT87odAGexnQAfoH8p+3tXq8J
         omspgMnwGu7ZXy+khVEhKzrVU4wRILxf6iDX/itf647htXl+yjIjxIaqSnhQQWZWwpiH
         eRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW1SRHaWkbKF75XBFUeFetQ7HmluAjjHrZWZ3oFnjbM=;
        b=pG+IIiX8jp8wzuDQXU45SlvgvP9eH3tl06vlbw3SXtgONkBC88Clz94G4Ce+iCgcHd
         Yd1iJ9rDN7dcJVCcmK3Gu/COkf4+NTI+YwOfnte2dslOV5NTkIm4QnrrBbcF/L9h49RV
         d3vub9FTsrbqATtHOEIswu7yUs3UxN6jiiwoZ8AVW/5UIOPrbWO5kHSHZ8UTTAFNxhtr
         4s8AsdnE7vuRY6SWp70CpUlzDxM3I9ZTTKfL2ZQK12y+GAa2dkisbF6LGMrEGGYwRiKG
         xCFuLYK8RQgqxi0wKOBYBABmLKfK4MXMmsX0FJq1eDpMBj22GlBQMrLX1S+xF3AEuDHz
         nb4g==
X-Gm-Message-State: AOAM5336pVWDXgPur2Y/R6ApZ8GpJ2tK2QkdZR7rtW1GhmxDMuyXGo/d
        pG7pw9ZI+lDPeCtA7kr3eYJBsMRA//Ewhg==
X-Google-Smtp-Source: ABdhPJx4qkj18hsqCeskkwe8fZn8RmefQ3laSJXtcD88WivLFYCJz4GSrOvyGOhUMHsQcJ9SKN0kUw==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr48891094wrs.389.1625924254067;
        Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/21] rev-list tests: test for behavior with invalid object types
Date:   Sat, 10 Jul 2021 15:37:08 +0200
Message-Id: <patch-05.21-f8d0b630d0a-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the "rev-list --disk-usage" feature
added in 16950f8384a (rev-list: add --disk-usage option for
calculating disk usage, 2021-02-09) to test for what happens when it's
asked to calculate the disk usage of invalid object types.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6115-rev-list-du.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..edb2ed55846 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,15 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+test_expect_success 'setup garbage repository' '
+	git clone --bare . garbage.git &&
+	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
+	git -C garbage.git rev-list --objects --all --disk-usage &&
+
+	# Manually create a ref because "update-ref", "tag" etc. have
+	# no corresponding --literally option.
+	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
+	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
+'
+
 test_done
-- 
2.32.0.636.g43e71d69cff

