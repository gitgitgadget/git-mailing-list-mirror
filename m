Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261AEC04EBE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F7921D24
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FALx1RsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgJHP3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgJHP3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:29:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB228C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 08:29:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t9so7073988wrq.11
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q6XHQLR43fpX/ID+IM2/mcbHfdm9ZBgkjaiOnHwyr2g=;
        b=FALx1RsNZgpxWq1iwquG3sFCbOkGyyLGECBDr1Qh8BwoUd9AwlezhMDO8K+6ryj+Ad
         1rzXz9eKLS0PKgqDd9PUnvk272Vbx78EzsN3r33/RfiR4LRhTYDNtxTGCuNvxwrr9g7B
         N/7TbQxPDcqO4ZRq7gIgH7ZaygT5TbAhhzOrSeIlABe49Fovm6isVID0YAk3MFm8HQdn
         b4FXKEHrP9r83gvy3piM4Cdzsq08s+66APQLjUvEnEVi5EW3Bsszrff4c8o/np7XaM50
         kFiJBFmuyw/uVuupV93aEmpw0zpAsoRLo28ISD6C0HXJ2vkTPBQPLi5IqBG4tMlmPEYm
         4fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q6XHQLR43fpX/ID+IM2/mcbHfdm9ZBgkjaiOnHwyr2g=;
        b=qNtZ6cLDGKx3YBrPLd+jIcmP02XHRiw5ikJrFfypzGoVTOIHvbLADYlj9GoT14UPm9
         J4lcAdOi2OdaOBEzD32KG8CvHrNGy3sCxar5rmy4069HO7/Fm9xDjjEtwSFNv3Kei6Vd
         WpSzbR+78KS/9iYrHQpoXLTpLrKxS/NWqSdObEvbPUQqtif+DBa/RcHOTMWG9Oh9MmSG
         N1PC3e5MW2/4xm6QQz9+iN7zDvmU6IhoaqxvrBEMTc8ATkG14lwtDXsrBZMgxe/STI6d
         DLYkfjkoBc6/g/HAqC1BU5FjRwIpQBelDSGX7FYCmcsQULesvqTRHx7xVMwXgT+7OrM2
         otwg==
X-Gm-Message-State: AOAM530YJZPZlQ7GYoE0snC9q+YwLaROy3dCmc3Q9k1+SjzIzcXTtn0L
        3T9aPM1/8rSDNn2OThxRTFjgbBINJjo=
X-Google-Smtp-Source: ABdhPJzBIXTLLBCWFHzgw2YcGsMRdyuyIeZMKPy/0XcOh0HTV3Ug+mlEnO0AQ7mkJvh4RXN0+bQ6UQ==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr10538593wrn.358.1602170979406;
        Thu, 08 Oct 2020 08:29:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm7828874wmi.18.2020.10.08.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:29:38 -0700 (PDT)
Message-Id: <931a2b8482dd10b64b506e70539ee1bf9f8cf2e7.1602170976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
        <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 15:29:35 +0000
Subject: [PATCH v2 2/2] ci: do not skip tagged revisions in GitHub workflows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `master` is tagged, and then both `master` and the tag are pushed,
Travis CI will happily build both. That is a waste of energy, which is
why we skip the build for `master` in that case.

Our GitHub workflow is also triggered by tags. However, the run would
fail because the `windows-test` jobs are _not_ skipped on tags, but the
`windows-build` job _is skipped (and therefore fails to upload the
build artifacts needed by the test jobs).

In addition, we just added logic to our GitHub workflow that will skip
runs altogether if there is already a successful run for the same commit
or at least for the same tree.

Let's just change the GitHub workflow to no longer specifically skip
tagged revisions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3eefec500d..79f81563cb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -149,6 +149,7 @@ then
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC:-gcc}"
+	DONT_SKIP_TAGS=t
 
 	cache_dir="$HOME/none"
 
@@ -167,6 +168,7 @@ good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
 
+test -n "${DONT_SKIP_TAGS-}" ||
 skip_branch_tip_with_tag
 skip_good_tree
 
-- 
gitgitgadget
