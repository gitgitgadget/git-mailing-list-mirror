Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D2C47E48
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B404613BF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhGNWMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGNWMd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:12:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F6C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r11so5067207wro.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xhWXY8hL35JFxMfYXQiAK0oQT2ZQOEV21h6NvgZt8Q4=;
        b=GQTcwFlGuU1Gmj7ZPErmMZLPvmjpSTkwRpajmllg7fpYDS3XBdgAN1L5dVCpXXnzeT
         l8GbxFwlC3UjRL0APExjUsxCpWUjxldMvycsS6/Wd3mj+btro7yrRN1zeh6WJLWlhXpE
         l3u+lpCbN3IjkmjoUCjEyGYxU5T40qUSDJ+BydS8KnwZrsZepQbgrBqFz1UIhCooS0/9
         r+cEZnBvk07AluqJypZUpCvGUofFwyiH71bjm+NXBAJFxjZd9V9CYTmYy5wQW2iGlS6z
         UV8/Br30ZeNQQSSWryfBHZ004o/ZiTK5jhsJ/4eKG8l2z7HZpjSjJJFRJtlK+a7z6qZ4
         IOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xhWXY8hL35JFxMfYXQiAK0oQT2ZQOEV21h6NvgZt8Q4=;
        b=JKf7s3Tt7wYVo7KnX/U9sNZTlkcD299AkQhKMBf5uD3JdlBIQag2oXUZ8Q2PC8Xrch
         4B1cbVpLPJfu9Bus5Y3OxW21ZZ2UEsAktfn8dIfIn8xe4YNToznxtQnkfS+ySF72MdiR
         rALLrJu+KWmi63Uy4aOs3GC6XgTdu7TJZTtlHzLIrICCdi8KJMn8cU+EH3Xg+tZqdNbe
         b+1YQTg+D7q07/JlaejJRVYpl8iFGTMR3iv2XthHgeWuFvZxqAomR7QMDMGsqH4Ykjyk
         ScSiUoYHGjp/8YH0LfWbmbhwguhTM6XTdzBkQSkR980RyNRdyCke8mMPXpX35XVgboQe
         dJsQ==
X-Gm-Message-State: AOAM531mBQZ9mEYeECuuLWqyya/FF9Wylo4Tuaq64Adr8/qdeErW7Hxb
        NhM4z26y38LOj2fl0+vj8mp7G5b4IHU=
X-Google-Smtp-Source: ABdhPJzQtn88okQdHwPQVnG8sbgFPmD5yTjJ3a18J9b9sKAUv1vFYgEw02lqxg1Qvz5hMB3e3PBrjg==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr339773wrc.280.1626300579481;
        Wed, 14 Jul 2021 15:09:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm6375730wmg.46.2021.07.14.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:09:39 -0700 (PDT)
Message-Id: <b54c137cb14527c14bd7c990f9cf32dca50ba5dc.1626300577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.995.git.1626300577.gitgitgadget@gmail.com>
References: <pull.995.git.1626300577.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 22:09:36 +0000
Subject: [PATCH 1/2] ci(check-whitespace): stop requiring a read/write token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of some recent security tightening, GitHub introduced the
ability to configure GitHub workflows to be run with a read-only token.
This is much more secure, in particular when working in a public
repository: While the regular read/write token might be restricted to
writing to the current branch, it is not necessarily restricted to
access only the current Pull Request.

However, the `check-whitespace` workflow threw a wrench into this plan:
it _requires_ write access (because it wants to add a PR comment in case
of a whitespace issue).

Let's just skip that PR comment. The user can always click through to
the actual error, even if it is slightly less convenient.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/check-whitespace.yml | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index f1483059c76..c53614d6033 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -51,21 +51,5 @@ jobs:
 
         if test -n "${log}"
         then
-          echo "::set-output name=checkout::"${log}""
           exit 2
         fi
-
-    - name: Add Check Output as Comment
-      uses: actions/github-script@v3
-      id: add-comment
-      env:
-        log: ${{ steps.check_out.outputs.checkout }}
-      with:
-        script: |
-            await github.issues.createComment({
-              issue_number: context.issue.number,
-              owner: context.repo.owner,
-              repo: context.repo.repo,
-              body: `Whitespace errors found in workflow ${{ github.workflow }}:\n\n\`\`\`\n${process.env.log.replace(/\\n/g, "\n")}\n\`\`\``
-            })
-      if: ${{ failure() }}
-- 
gitgitgadget

