Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE5C19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiHCQRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHCQRl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:17:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3720F61
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:17:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so22153133wrh.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=F0ioeswXfO4vLCXjYT8JM39cNwkf+wbKNJBs1Afj5xw=;
        b=UYuv8UzzlbrMRPr9WLWw4aDGJZvhRYQ5NAPEMaOAusCWQCrBMbga3+szU3xG4ru9iQ
         La6mVV77YZiEi+nPuQotfWrsVnVFPlM+47RKW6x0dtv2/pgdFhS1SQ3uDDfl400FfbM0
         gmgIzSJuZmUX6ZGK2SxDk4ebON3dUmQJT2a6WJD4/1SPEqfB4ip0moS3j4EZrIDj23QN
         2twpna+GZqPqKr7FJTCt0pPncb38lKv96l4O9Zuov6ttC6+15+U+rTaTZNX11y1+3xS9
         3+ry3/3gLn1ZtBc8/Lqch0nu9lAJpdIP1Tv+F2w/Ks9+ZJLbA070AyGHBuxqBVRb2Y0L
         tDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F0ioeswXfO4vLCXjYT8JM39cNwkf+wbKNJBs1Afj5xw=;
        b=21JUr8EhEMmSJ/ZI2s4kp/16Iytt+27T8EWjdXZIEsLJaNiVDS5qBaUW0+d55B++wI
         gxJ6iZQdUqPJbPUvmBWMPo1RCIZgMFPhspgyQ6ppMhhWrF33omXLAE9kxlxbnCFEK8aC
         L//CGmVivNUO+P0Fa+mtA9pO9bQrghfuYVGPmBT3kYdQjFs9+wXZvritEJ++BbR3Z4XN
         2qzAmrWAOxT+ssJjfsrz0iQp2gS3ok2VCIlAXMEWvrvDvLy9ilhs2oQM7GWJDuHHMTII
         PSct/jzkZ0WyJkiZPKBR69+tV27n5tCZnmeeW0UScSs2LNlNcsSwbK3MqgjUfd9SlGUM
         WeYg==
X-Gm-Message-State: ACgBeo0WroqWxMhYe5IrPbfmWjRFHVU9/JaxNv28oFRfQCNfSsPxt/6r
        R5LN4wElhnY8nFotNlCXadOE9PUvG8I=
X-Google-Smtp-Source: AA6agR6Ynoz9Ho+0zxMR45Yo0si/j3YBVu3CLtQOqRNjS9mZqzQL1nYwRjTzJQxELcJ7q5oNAZIN6Q==
X-Received: by 2002:a05:6000:18c:b0:21f:170d:446e with SMTP id p12-20020a056000018c00b0021f170d446emr14011165wrx.304.1659543458909;
        Wed, 03 Aug 2022 09:17:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c088700b003a35ec4bf4fsm2782973wmp.20.2022.08.03.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:17:38 -0700 (PDT)
Message-Id: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Aug 2022 16:17:34 +0000
Subject: [PATCH 0/3] refs-advertise: add hook to filter advertised refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and is possible if we add a reference advertise
filter hook just like what Gerrit did.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase and the commit fetching phase, each
reference and will be filtered by this hook. Git server can put
reference-level control process to this hook and the git client does not
need to change or known about that.

And there is also a partial clone issue says 'Dynamic object fetching'
causes the server send a full set of info/refs when the connection is
established, and if there are large number of refs, will incur significant
overhead, and if we put such kind of hook maybe it will help.

In Huawei company, we are trying to copy the reference-level control feature
from Gerrit to CGit (which is used by our git server), and we think maybe
this hook is a good idea and wish for your replies, thanks!

Sun Chao (3):
  refs-advertise: add hook to filter advertised refs
  t1419: add test cases for refs-advertise hook
  doc: add documentation for the refs-advertise hook

 Documentation/githooks.txt                    |  70 +++++
 Makefile                                      |   2 +
 builtin/receive-pack.c                        |  12 +
 ls-refs.c                                     |  30 ++-
 refs/refs-advertise.c                         | 246 +++++++++++++++++
 refs/refs-advertise.h                         |  11 +
 t/helper/test-refs-advertise.c                | 202 ++++++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-refs-advertise-hooks.sh               | 138 ++++++++++
 t/t1419/common-functions.sh                   |  80 ++++++
 .../once-0000-abnormal-refs-advertise-hook.sh | 199 ++++++++++++++
 t/t1419/test-0000-standard-git-clone.sh       |  56 ++++
 t/t1419/test-0001-standard-git-push.sh        |  34 +++
 ...0002-ls-remote-with-refs-advertise-hook.sh |  95 +++++++
 ...03-upload-pack-with-refs-advertise-hook.sh | 127 +++++++++
 ...4-receive-pack-with-refs-advertise-hook.sh | 251 ++++++++++++++++++
 upload-pack.c                                 |  42 ++-
 18 files changed, 1588 insertions(+), 9 deletions(-)
 create mode 100644 refs/refs-advertise.c
 create mode 100644 refs/refs-advertise.h
 create mode 100644 t/helper/test-refs-advertise.c
 create mode 100755 t/t1419-refs-advertise-hooks.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/once-0000-abnormal-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0000-standard-git-clone.sh
 create mode 100644 t/t1419/test-0001-standard-git-push.sh
 create mode 100644 t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh


base-commit: 350dc9f0e8974b6fcbdeb3808186c5a79c3e7386
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v1
Pull-Request: https://github.com/git/git/pull/1301
-- 
gitgitgadget
