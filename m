Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E609C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4233A2076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUHh78G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgHBGdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgHBGdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 02:33:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8ADC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 23:33:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so12665526wmb.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BNjfujnPglAO2EIpu8Q540juo/u+tsgEDm3yaYTo5nQ=;
        b=vUHh78G08Se7uSXasKwGacxQvbCrxjACY4HwSylVcfVL8tC7NLP2G4qmvypb7A1Wg6
         MqbvRudXlwMnhIUEQRtv7AitCIgx9xo6kTn/zFr9X7jcA2NQUC6fRP/8j4+TiJ7HtY81
         7K3qZ+Gyu5GsRFJ90BHeyXpaprSW0Z7o0LJ3v2m8rxdSArvUEDUzD1XfCSgRhZAWDzoe
         Zgg+1KGUREhFIcjUAP2sWJT0UpRi/9eaM1PPKwmqb/gWPZ8m1uKZTad0Fxt8x+6/MCiO
         ySk1AJsvR2sYbb1wEYxpHZ6eR7hWCJbHZmxsF9QzxZ4PODdY4rUzpokNxuDHbhNqV4my
         giVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BNjfujnPglAO2EIpu8Q540juo/u+tsgEDm3yaYTo5nQ=;
        b=fwxJSnITQMjwvgqnb6cGbAd4BCZvKx4iJ/D2VLBqao+yEqBhgROjXgNVGdEEP3kfPX
         j0hgVKV0WLv5AHyeJNb2+uAcrAKOCQV4OyFFtLc0IX6YkHH32QQunYD3K1aeb9A0dL6+
         /1VZYq1gY8OrqP0ZOdQpyuYIAJNa6t4jsD21xCtNzIDiAJqcQPZwAwrRIwMhqbagDFcn
         5VEqyg7sLxLtJqJv1dFMFSZXCPrLeG/0tTUV91NaKgJUXJ6NCSAF4ItnNJrCDQb5/yt1
         EXwtgkgyeYquHk+fqKXRIQFmi3+lFYJYXGdLZF6/5q+ABZ7Uc84UyBqUXUPUlSCmTY0K
         sx7g==
X-Gm-Message-State: AOAM532rKsXQJYHVCnYqldjjpZYLxHJjyRapXb8L/lHNuaYaLTgXeSBN
        Q6f22tuGu6LUH259oN3socr/nYiU
X-Google-Smtp-Source: ABdhPJzwkb6Dnzwbj/XpAruejEsbRjFRmT/aJnOFguWje/HVJDFMDRHNqEy/yQdsOqlrhzaYb8ZwRQ==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr9968620wme.166.1596349987941;
        Sat, 01 Aug 2020 23:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm13039782wrw.77.2020.08.01.23.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:33:07 -0700 (PDT)
Message-Id: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 06:33:02 +0000
Subject: [PATCH 0/4] Attr fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few issues surrounding .gitattributes files and usage of the
merge machinery outside of "git merge". All were issues I found and fixed
while working on merge-ort.

Patches 1, 3, and 4 are definitely fixes. Patch 2 only touches a testcase
and might be a fix, or might just change it to a different kind of
brokenness -- either way, it leaves the affected testcase as
test_expect_failure. I'm kind of curious what is correct expected behavior
for that and similar testcases. I probably won't implement it, and I'm
worried it might be rife with multi-layered corner cases and no good way to
define correct behavior for all cases.

Elijah Newren (4):
  t6038: make tests fail for the right reason
  t6038: fix test with obviously incorrect expectations
  merge: make merge.renormalize work for all uses of merge machinery
  checkout: support renormalization with checkout -m <paths>

 builtin/checkout.c         | 18 ++++++------------
 builtin/merge.c            |  7 +++----
 merge-recursive.c          |  3 +++
 t/t6038-merge-text-auto.sh | 20 ++++++++++----------
 4 files changed, 22 insertions(+), 26 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-825%2Fnewren%2Fattr-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-825/newren/attr-fixes-v1
Pull-Request: https://github.com/git/git/pull/825
-- 
gitgitgadget
