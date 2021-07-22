Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7262C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE99860C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhGVUsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGVUsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E523C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t17so223352wrq.2
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y1QdNT5ovN1YIBKzQ3suY0ScEgGTaNi6HDcrJEsJ+RI=;
        b=T0k+7EphQ1MI0V+qVg4rQqIy2nnr7IwzihfsDcDYpIuCZ64oYC8BoZQpY0N0ort6nJ
         xOuF2OQ2gMF72MqIkEkN0BNv9cvtjx3Sho/d0ndh9wSfe28ptLOyjn2UhuTBJRmZH12Y
         BxXfj8579H0Afq7WcP5xuzyhCHxOrP2ZkPhubOR5xDbjpetgkVCjl+uiONWnS4Noh2Z1
         TEjKksalxubBNrZQROZ8ZkzIvaAArGqQuC99p8p9nrB/J4PLVidU9EaVC/sze9mBK3iW
         f5+1pmw452CQPu1WggcXqCqxBOe5knbni/rwTOTtG9PYbMta45Agtc4iYN3iDXvIZFyX
         +7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y1QdNT5ovN1YIBKzQ3suY0ScEgGTaNi6HDcrJEsJ+RI=;
        b=sdrCmfHxqrlvTwBbUXJmH542LhPmqtJXKLmiLukZBlnSW47AHuEisveEoLeJKQYsbr
         l+uAVNwRvIFXMR7BTl6EQHr5ngeHbLCHKEnvqvzepd3QfAFumy1EeW0DOhoo7DCsGMoX
         UYjhGMzcPqvrKHCa8DU9SK6Y+VaVDo/1q3tK2ZTa5YNrHE0R7QSPkhQHNFgB7RZktkMa
         ADVdsQetSAlrAMO/nGwWnGIZPueQTK3an/OETLkhj0fl38lhjaUn8+wi1s0aIPQWGa5S
         wM+rDUazEBp5x67i8uHt+L3U8KpYMfnhkBODydYi2Z50GavZ3GmY8+fNHG74+SLkKp1g
         9XoA==
X-Gm-Message-State: AOAM531j1DDAC5Aj5//dN1Ky7cUG7ibY9VuE/nP2VjB2N19I0OkJnm+I
        +O4dxotSvE5BXqAlZNn1sceJD40XseA=
X-Google-Smtp-Source: ABdhPJyRTxb18af34OvckBtFow/LkANonJ7Kmoo6wSwJbuP/dIbLi04Jf8hG6BTPQvRvx/QLJtiJsQ==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr1972394wrn.111.1626989328608;
        Thu, 22 Jul 2021 14:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm3429980wmq.38.2021.07.22.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:48 -0700 (PDT)
Message-Id: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:36 +0000
Subject: [PATCH v2 00/11] Fix direct filesystem access in various test files.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few test failures in the reftable series.

Han-Wen Nienhuys (11):
  t6050: use git-update-ref rather than filesystem access
  t1503: mark symlink test as REFFILES
  t6120: use git-update-ref rather than filesystem access
  t3320: use git-symbolic-ref rather than filesystem access
  t2402: use ref-store test helper to create broken symlink
  t1405: use 'git reflog exists' to check reflog existence
  t1405: mark test for 'git pack-refs' as REFFILES
  t1410: mark test as REFFILES
  t7064: use update-ref -d to remove upstream branch
  t6500: use "ls -1" to snapshot ref database state
  t6001: avoid direct file system access

 t/t1405-main-ref-store.sh        | 12 ++++++++----
 t/t1410-reflog.sh                |  4 +++-
 t/t1503-rev-parse-verify.sh      |  2 +-
 t/t2402-worktree-list.sh         |  2 +-
 t/t3320-notes-merge-worktrees.sh | 12 +++++++-----
 t/t6001-rev-list-graft.sh        |  3 ++-
 t/t6050-replace.sh               |  2 +-
 t/t6120-describe.sh              |  6 ++++--
 t/t6500-gc.sh                    |  5 +++--
 t/t7064-wtstatus-pv2.sh          |  5 +----
 10 files changed, 31 insertions(+), 22 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1052%2Fhanwen%2Ftest-fixes-v3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1052/hanwen/test-fixes-v3-v2
Pull-Request: https://github.com/git/git/pull/1052

Range-diff vs v1:

  1:  61a5c3718df =  1:  d7616038d88 t6050: use git-update-ref rather than filesystem access
  2:  49994a0d154 =  2:  cbd2128c331 t1503: mark symlink test as REFFILES
  3:  695921cacb6 =  3:  cbf90c13e5b t6120: use git-update-ref rather than filesystem access
  4:  94d7e144f54 <  -:  ----------- t7509: use git-update-ref rather than filesystem access
  5:  cc400e9131d =  4:  7b98d092811 t3320: use git-symbolic-ref rather than filesystem access
  6:  4d83f70e133 =  5:  0047266de6b t2402: use ref-store test helper to create broken symlink
  -:  ----------- >  6:  eb2c53d19cf t1405: use 'git reflog exists' to check reflog existence
  -:  ----------- >  7:  05dead16f1c t1405: mark test for 'git pack-refs' as REFFILES
  -:  ----------- >  8:  f931a26de58 t1410: mark test as REFFILES
  -:  ----------- >  9:  3685ba90f60 t7064: use update-ref -d to remove upstream branch
  -:  ----------- > 10:  ccdbf3749fe t6500: use "ls -1" to snapshot ref database state
  -:  ----------- > 11:  81e46f95536 t6001: avoid direct file system access

-- 
gitgitgadget
