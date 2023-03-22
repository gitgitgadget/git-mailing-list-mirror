Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BEC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCVJmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCVJmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:42:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0E166CF
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d17so7869453wrb.11
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mdPCehhDjWhjZ+CDuX14oknaNpo3UgfgkDw5xRMq6yE=;
        b=cml6OmaKj+Yz7MFNqu1J+1tJMilbrG4mCx5kFb7YQzrDQ6pN3YVLXdPKYkPJdv4Gyg
         YWx9VcqUNGQ0HH6qVm0pITdHvhuRypWPqpA5nxXTkM6amTvF2x2a/ZtNRtkeswQ1TiIf
         +Q1NmIkJswvnQQerfcJlT/36k8mIluPrIH2j++CpcOlgq9Rolaj106eq9v1jaWcjHryM
         XqrczCXJ06L6e3gHsXsBXjE1EBknDjqhlDS6K8kJnYO0RxJ55Z7In4l9FPhoSoa6psly
         kPRIRaJKZBR/yiRXSgKpGEoIScs9kpSAfyg2GcayNm0DaXZ6fLVrhcNIR7g+kuBFl588
         XEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdPCehhDjWhjZ+CDuX14oknaNpo3UgfgkDw5xRMq6yE=;
        b=05JXqCGcj47c8JpsQvKK6Womj1qitenASPII7uIrInTlZBQChyKTMlLbPCgYbwrnW2
         Sp1nN/TGfVAb1MPYQH+D1cuPpd/iFWyDpfWpsTKv+qMovfa7c709e/qoghZ5GYvjF9FE
         f94tf1O1O7DfEZVogSD6MEFVn3+DXyYj+bn6b2LNzzy5QXWus8Exw1pv8fm1KvzywoHb
         6Un9Wz0eh4aKtd7w5RONfTA86xDD520K+ajeaczaiV1EloIJw8H62qff7gvByOEEqXKa
         O/7+P67/scxrnqDY4yZ8/CuVFSvaVEpAxUKZkX8+dFVwit8RjWjJYBMdJsAyOhis5JzJ
         7gDg==
X-Gm-Message-State: AO0yUKVX5Kde7i0p3bN7mooFMIWHlVRVZsfNSaOuMsg8XTMofp1GNdly
        d7x6HyYpSRirUc3uBAMtGNynlnvjcqU=
X-Google-Smtp-Source: AK7set8+GP7STIjuQkT19A43LT06paIZpWLxGSd3kqg9rJjG07mAaSStpFY4q+R8FwF0v/+Np7J0PQ==
X-Received: by 2002:adf:fa50:0:b0:2ce:aed5:7dc with SMTP id y16-20020adffa50000000b002ceaed507dcmr4372938wrr.68.1679478127432;
        Wed, 22 Mar 2023 02:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm13383984wrt.110.2023.03.22.02.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:42:07 -0700 (PDT)
Message-Id: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
From:   "ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:42:04 +0000
Subject: [PATCH 0/2] branch: improve error log on branch not found by checking remotes refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ClementMabileau <mabileau.clement@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when failing to delete a branch with git branch -d <branch> because of
branch not found, try to find a remote refs matching <branch> and if so add
an hint: Did you forget --remote? to the error message

ctmbl (2):
  branch: improve error log on branch not found by checking remotes refs
  Fix mem leak in branch.c due to not-free newly added virtual_name
    variable

 builtin/branch.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)


base-commit: 950264636c68591989456e3ba0a5442f93152c1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1476%2Fctmbl%2Fbranch%2Fdeletion%2Fimprove-error-msg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1476/ctmbl/branch/deletion/improve-error-msg-v1
Pull-Request: https://github.com/git/git/pull/1476
-- 
gitgitgadget
