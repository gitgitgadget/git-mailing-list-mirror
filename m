Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0627C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8820E22200
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkSeJsMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411481AbgJPXjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411478AbgJPXjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 19:39:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72384C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:39:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so4948525wrs.5
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GuRDm4vGLO+uLf2k4ULjnoSgp2xYRObFS61Fp6VzLhI=;
        b=XkSeJsMRDdIxpDEhq5O/d38t0K3TpCL2bbnB8gr2mGsg6MkGIS2ZJOMhFgXCfvpsre
         8002MdEji+XJsE2plMzszV1IpCeH0EVBcnjX9/hzyVOjDpVZmEdR5fMFl4q9vCPass7u
         C8vbZ3JBWrPmJXFhsG3K6zGnH3Ld+5JNB9/Tx//AAyQ+47GHFjEMKAsduvvrDd+I3Bv1
         bM21drb609L48Q0QoEWyQB0djIHJAc1DD92DCY4SmroH0UcftsICX/x6X1V19mzod3VG
         vB3MUHams0LcEFH3rwAR5b5J5Odz+FDWS4iA+APjgbUsS/m61bfBXEJRkN/Qdy4jULGu
         XjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GuRDm4vGLO+uLf2k4ULjnoSgp2xYRObFS61Fp6VzLhI=;
        b=EtTG/uU5aFDW5t8yvyTgg+LJMJbkcwtDqzNOjrXRXg523ZKoAkNiqzKLYH+qL6siuy
         /W57gtQL8cmF0aSpDXGJcUg9iy6OpjzNwlkInDQyhI28xtVfuYRm35rQIFJLGRjd79w9
         4Mim+Jwtv9aVM71/6ElDSdERU31hm/pkM4wrNTwaeUdLSBpY+DESgBXv1TWthREgDw00
         3DLko2nTuBZMTed7dfp06N5Qj8ai70UvZgPDeUoH5HXDfzVqpHHMQcyvNwdR6u4wB57L
         OjjEH5byK2HIEjXfildKX84miiuvA182Vp2JDFGTuj0+xfw9NAapGtE/1uiXHd1pQvyB
         nB7g==
X-Gm-Message-State: AOAM5322k7O7XyrQ+lNOBgSMG5bTP+9n3jhh4/IXBGrDF4p63hdMR+TN
        rH2tRPlMeQvVqkp6OLhks8d3w2jmrbE=
X-Google-Smtp-Source: ABdhPJw3k38sSKQdUUsG2LNx0DvLKdyDZUVvMpBFwCRKI7Q51b1TCXYmYb5lxwvvELp9gop2LqiaPw==
X-Received: by 2002:adf:9504:: with SMTP id 4mr7071575wrs.27.1602891596065;
        Fri, 16 Oct 2020 16:39:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm5645727wru.15.2020.10.16.16.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:39:55 -0700 (PDT)
Message-Id: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 23:39:54 +0000
Subject: [PATCH] t7518: fix flaky grep invocation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t7518.1 added in commit 862e80a413 ("ident: handle NULL email when
complaining of empty name", 2017-02-23), was trying to make sure that
the test with an empty ident did not segfault and did not result in
glibc quiety translating a NULL pointer into a name of "(null)".  It did
the latter by ensuring that a grep for "null" didn't appear in the
output, but on one automatic CI run I observed the following output:

fatal: empty ident name (for <runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>) not allowed

Note that 'null' appears as a substring of the domain name, found
within 'gcliasfzo2nullsdbrimjtbyhg'.  Tighten the test by searching for
"(null)" rather than "null".

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t7518: fix flaky grep invocation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-884%2Fnewren%2Ffix-flaky-t7518-grep-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-884/newren/fix-flaky-t7518-grep-v1
Pull-Request: https://github.com/git/git/pull/884

 t/t7518-ident-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index dc3e9c8c88..905957bd0a 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -13,7 +13,7 @@ test_expect_success 'empty name and missing email' '
 		sane_unset GIT_AUTHOR_EMAIL &&
 		GIT_AUTHOR_NAME= &&
 		test_must_fail git commit --allow-empty -m foo 2>err &&
-		test_i18ngrep ! null err
+		test_i18ngrep ! "(null)" err
 	)
 '
 

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
