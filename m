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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5CC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0451F60FF1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhGNWMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGNWMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:12:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F0C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so4810151wmi.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OkB9I7D0I9wVq54BhY2BYBAyIit1MkUkA0vnraqOD8g=;
        b=Bw58t1bR5T4RebCYaa3nVEBG4zj2YnLEeR0RelqDw48w9YZ6Kg8nPFvtLItfj5S8ym
         j4wqefIxyheMQX+dXcvIgvoGbsRZGY+uGoActiIaXW+FSRvi8bA370hM5vavSuHDrz/w
         qP66TVP8k9m2peT6cOvyKYpKI2eyDpQ9t2nyA+fN7ZO1RlPiovli2qRXRqc9WL1ZYno+
         RuVMyv1a67y2hHB/t0XC3X0q+xHKw80aZ9FEq7EjV9cDbpePKdK1al3hlL7T4w4FjhFK
         xsJXRzx6ff47nDHFPKAu1pjzlV9uO8Wh8i39oVHfIoJr0lmjvQ6uoIZtjv9K3Yqpm5yM
         KPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OkB9I7D0I9wVq54BhY2BYBAyIit1MkUkA0vnraqOD8g=;
        b=WNNtObHp+i2hau5DFrqCOsFC+xXSzyEdpJNnn5bryJNN/5c1jfpGobGzS8NivIL/9r
         lBfSs8jyL/u8T/U8ncWV1A3KcE++oBf73hJYqygzKu+aA85QbZGGBFzUpsFN+cbCRNFq
         VXlttB/BeASdlJxc2myiFd4LBN4tVqui/RvX7Rp1XQxgif0fWQeyvLtKQRP56UN80VqL
         gdcOE+DvWZNL7gmelYwhbRnGGWdF6D22abEHPzkEt30pn7zZs2HNotcynE5aB5qyYTh5
         iYdgHuXbNeeuu1FqNbJf4vNGBU5KBLjfVK5kMC8Ib04btoYNFoP3bdgHp3JlOEdTKtxP
         psRA==
X-Gm-Message-State: AOAM532U1evSInVR0AdJtDa4uEfnmUgG38J+8cbwGCVeps7r1V1ub+Yp
        i55b+60Glmfx3y0d/BTncLLhTqfRL6E=
X-Google-Smtp-Source: ABdhPJxNS7iZtzyPiWRgsKlZSPg12xRW1ZV2400v6cysLpwCO7ToGJ1gnnaoG4rVFOEreveDi88ZJA==
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr6328058wmj.87.1626300580061;
        Wed, 14 Jul 2021 15:09:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm4223012wrv.64.2021.07.14.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:09:39 -0700 (PDT)
Message-Id: <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.995.git.1626300577.gitgitgadget@gmail.com>
References: <pull.995.git.1626300577.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 22:09:37 +0000
Subject: [PATCH 2/2] ci(check-whitespace): restrict to the intended commits
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

During a run of the `check-whitespace` we want to verify that the
commits introduced in the Pull Request have no whitespace issues. We
only want to look at those commits, not the upstream commits (because
the contributor cannot do anything about the latter).

However, by using the `-<count>` form in `git log --check`, we run the
risk of looking at the wrong commits. The reason is that the
`actions/checkout` step does _not_ check out the tip commit of the Pull
Request's branch: Instead, it checks out a merge commit that merges that
branch into the target branch. For that reason, we already adjust the
commit count by incrementing it, but that is not enough: if the upstream
branch has newer commits, they are traversed _first_. And obviously we
will then miss some of the commits that we _actually_ wanted to look at.

Therefore, let's be careful to stop assuming a linear, up to date commit
topology in the contributed commits, and instead specify the correct
commit range.

Unfortunately, this means that we no longer can rely on a shallow clone:
There is no way of knowing just how many commits the upstream branch
advanced after the commit from which the PR branch branched off. So
let's just go with a full clone instead, and be safe rather than sorry
(if we have "too shallow" a situation, a commit range `@{u}..` may very
well include a shallow commit itself, and the output of `git show
--check <shallow>` is _not_ pretty).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/check-whitespace.yml | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index c53614d6033..8c4358d805c 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -12,15 +12,9 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - name: Set commit count
-      shell: bash
-      run: echo "COMMIT_DEPTH=$((1+$COMMITS))" >>$GITHUB_ENV
-      env:
-        COMMITS: ${{ github.event.pull_request.commits }}
-
     - uses: actions/checkout@v2
       with:
-        fetch-depth: ${{ env.COMMIT_DEPTH }}
+        fetch-depth: 0
 
     - name: git log --check
       id: check_out
@@ -47,7 +41,7 @@ jobs:
             echo "${dash} ${etc}"
             ;;
           esac
-        done <<< $(git log --check --pretty=format:"---% h% s" -${{github.event.pull_request.commits}})
+        done <<< $(git log --check --pretty=format:"---% h% s" ${{github.event.pull_request.base.sha}}..)
 
         if test -n "${log}"
         then
-- 
gitgitgadget
