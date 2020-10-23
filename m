Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6910C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D220FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoqq1dfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750254AbgJWOAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750246AbgJWOAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4005C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so1696257wmd.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BKbRSkXPcQHcQGnKZX1TuvUCbJMmbS1+4qVBRVDumII=;
        b=Uoqq1dfooUFLAF2rX7fcjL4hsmRXmX7REYLz1DCdvlDsKQaHzpOsZreR5Ca0Xf2YOl
         RbnTpbSp+Tq/p1fqKmVIIeerm8y6q9W8URF0sn355auijoiZPuv9l0A7sFQMiARpQNvp
         vyP/0VJ+9PzsYm5BCx5GtKgLKJhN79jbSFVQkwYEtIk9hzSJOTRPaRJiHxkypWiAmQaz
         dmkDGXnOvhFpXgefmL/5asLFLx/zh5fVcQ2w9J2cVVFzhlbi2TkkdeNcq+D9sdSyD0E6
         VDIljX7fqzicX6NuYoP773LXa8/Z/tVj9MbHccH7dX8lKa+j0noA3HZjLNFIzmqT+htn
         fu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BKbRSkXPcQHcQGnKZX1TuvUCbJMmbS1+4qVBRVDumII=;
        b=AKoY0c22lflZPlN8eOTekLr2p1d0+KetPT5168WgAPNOfUskwSm5E/ltKcrpr1u/wy
         YR5dFhC1WcvfAhVF0IXxRvVbo7cUI0kjtV6D9mHOHtndES3YJqXpzCKxjl6zu4OnBpU4
         AqHhfohhJMU1UvEugbttWDW0ggmL3X6BHDv8dsa8HRDXG8/WlBtdtm/hIhNHpT6kmvDn
         rgyynJ2CJlBzOy/AAfwPyjCreI/bAuNT1u5stEX6b1aBA0MMpv+0ytX4n7YxiEZijHcF
         pnoKh02bei6ga4Y0VxEHGVYTUYCw1mjKcrOFwL41q1MR1kgRdbu/IwDuk+LT+GFtBBrG
         Hqfg==
X-Gm-Message-State: AOAM531ObfhP4yH/J0yGDqiSPiu0XnBeT+1T0H413MpkIvUT1GLhXrJU
        HGPU4RIGUL7jVOs3P3nO5TKJ7/6/8JE=
X-Google-Smtp-Source: ABdhPJyZZZzC9FGmzxjy8Rf33fDhI+a0Osae2MBL6wTiA44gepcs4/FRO0NLiQ8sDDpDm4fJHqpJ0Q==
X-Received: by 2002:a1c:9647:: with SMTP id y68mr2403579wmd.101.1603461612612;
        Fri, 23 Oct 2020 07:00:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm3183482wrs.92.2020.10.23.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:12 -0700 (PDT)
Message-Id: <b557ea5ac0d344f183d0ab3b4e826a940e2d063c.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:02 +0000
Subject: [PATCH v2 5/9] t5703: adjust a test case for the upcoming default
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We want to rename the default branch name used by `git init` in the near
future, using `main` as the new name.

In preparation for that, we adjust a test case that wants to rename the
default branch to a different name that however has the same length. We
use `none` as that name because it matches the length of `main`.

As this test case cannot possibly pass until the default branch name is
_actually_ changed, we temporarily guard it behind a special-purpose
prereq, until the test suite is fully converted to use that new default
branch name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5703-upload-pack-ref-in-want.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index d9ecf0f4a9..b46940b725 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -383,14 +383,14 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server loses a ref - ref in want' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
+	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail git -C local fetch 2>err &&
 
-	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
+	test_i18ngrep "fatal: remote error: unknown ref refs/heads/rain" err
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
-- 
gitgitgadget

