Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968EC4363A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359BD2074A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJGetJ+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbgJOUqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbgJOUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:46:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D28C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so445688wmj.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yhPxL27bM6EAkq7vxmBKL71Eoj46r3/huiMFZw9YOCo=;
        b=iJGetJ+8uhJbF7Ohch2R1k+J77xUazyz7IIpbrWGlQWEQcGIDhS/qYUEQNlVurcd5f
         XtGlQ/fpSk9mVPnAnyWJunloQ4C796zDjZ/H6XQLjxDzEr0I8yXcBtJTgZjfva2YzAyC
         /VDKJpwcEy5SzT4lGpK5VDN990eCTWXQCkXr+raST0nwyXshDBL53uJQnEKO/vnNsATL
         gp58Yh7THUOufwBoFO5aoJOi4GxNwVf8VOv7MMxj7UmudxD/3EhhoQzjARfgTUsZn1s8
         YNkGjHPBWDn/3wZUhlRGZQ7uD2yMYf0NgEClcHuPE5zSZTfePzE9jf4t/CmNHHqYF2Xb
         mbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yhPxL27bM6EAkq7vxmBKL71Eoj46r3/huiMFZw9YOCo=;
        b=uYSJf0tZMFvjuNXVZ3E7Xa/nOJB28BTdRQdd2/14bpBSmjXNMyeUSFw0ccZP1O0Xs1
         4xK8yNf9JIpAdiZ5ayVQAW12POAE1f+t9wt+Qwgc2yfE1SzJ8uf2XpfWvFqZE2Eoovdi
         8gJpGJPoFvMtdqQReqRJTd3HjoG4UbJ1qD+VwR1H375nstTTFzt/p8ZVEv53bWMs9VWt
         s/zolgzHchSLBwLKWfrRCIquffUmGiaYuPAYgrCZDuwM/haYFUa53DXMGhlntooy0Gjs
         TeVCivEooIQEC5c2z9te/E/IP/F7Zek7hFKbh4z+FhL/DBjsuuIvR3GLVakyW4hZnJJT
         9uHQ==
X-Gm-Message-State: AOAM53382B+RWDIKQAfA+q6zCFKRtdz50FN3Tkn+qkOWPXjixqRR+Vrb
        pP7naUnFJqrF/bwemU0Lygva/FP3c3M=
X-Google-Smtp-Source: ABdhPJwQPzNpUMlW/3tUU0i2PRM/YWb5Dg/lFQGXFQNDyLCxzPIfCsPjZIwBn90q4djB8z5YRwi3jA==
X-Received: by 2002:a1c:63c3:: with SMTP id x186mr497007wmb.66.1602794792304;
        Thu, 15 Oct 2020 13:46:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm737334wro.3.2020.10.15.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:46:31 -0700 (PDT)
Message-Id: <pull.879.git.git.1602794790.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 20:46:26 +0000
Subject: [PATCH 0/4] Directory rename detection testcases and rules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While testing merge-ort on some real world repositories a little while back,
I found some issues with directory rename detection...some of which were
issues in the current merge-recursive as well. Also, I found that there was
a nice optimization I could use if a new obvious-looking rule was added,
though it has one slight side effect to one corner case. Fixing the bugs and
implementing the new rules is a bit more involved, so for now this series
just updates the rule descriptions and adds or modifies tests to document
the various cases.

Elijah Newren (4):
  directory-rename-detection.txt: update references to regression tests
  t6423: more involved directory rename test
  t6423: update directory rename detection tests with new rule
  t6423: more involved rules for renaming directories into each other

 .../technical/directory-rename-detection.txt  |  15 +-
 t/t6423-merge-rename-directories.sh           | 592 ++++++++++++++++--
 2 files changed, 553 insertions(+), 54 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-879%2Fnewren%2Fdrd-testcases-and-rules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-879/newren/drd-testcases-and-rules-v1
Pull-Request: https://github.com/git/git/pull/879
-- 
gitgitgadget
