Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757BC4360C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A3222CE3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390916AbhASOtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbhASKZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 05:25:44 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C8C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 11so11954253pfu.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bYBvwGsH0oN1qTd7dW+D63aD9IqJ24qjt3aT90Casw=;
        b=naV1YpJEkfa2mFnLqtZbyoK2imUMsDCWsJO9oA7V7wQQl+QQpHWyqs/LhxajL8X0Nh
         6fyrm5ekCNc6FcSbJt4bbedfNnk00TvMax7q+johdZDsi21LP5aL5691z/UmRQrQ5kCj
         8lkUwqXZ6e63OoXebuS7s5Z1+tR+lBb4F7NXPKwJp+7KLqIEGYXlOEfw5f6so27CNKIs
         NV7UyTdYSWAk+p0PLSDZZMrpREOJFhGPJCE86QCyLm6xJb7JMq5oiaesaAgtRtd1yW6R
         NMyrFhqx5UJxFcLorCu/bnazvUID+difZFhwdUnAvM8asgHw/e9OC863Zt849GFSl60u
         Z6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bYBvwGsH0oN1qTd7dW+D63aD9IqJ24qjt3aT90Casw=;
        b=F4FiD9XXoR2x2welOCAMGGZdTKpbvzuJJNrT6LXe7OWFFIWnhcuSWT2jdwk+UfoNlP
         H9a0mvVOlJSx55C2EjUvaujd9pcE4ylo3LPVHQ8AWHGrUjdMCci1IceCMXX+asFd/EIS
         e5SZRUX0yh47FYXY0zWDyMVt9fuZBO+fRbR7atZnW6rX0yRnGdJQ3yf3wEKvxj/VBqAy
         4PC+4flu81SdXzrEp/Hls3udV+srnVLHy4Ua22dNIf+khli0x7goPGE0ML++BIL7Le6p
         1yj3Vb+0MfmbH0JeLgbMik88RYvGBa7pN1lCVuahKKVz4joH19QKZIgdOHu4EEtU6hXf
         Br3w==
X-Gm-Message-State: AOAM531Xgs+ua+rmGBJcyG5/KUgZzg7Y5EgdEH4so6QkIuJKUM0A2v3R
        o09/Rg7Jo8O3Z9vfUHMJ3iE=
X-Google-Smtp-Source: ABdhPJxarixcnWGr2BAS7p6vq658TG/HhManHyG2gCL6YteefOmbM5AjllEYDVXWBgYabA8s2MSB7Q==
X-Received: by 2002:aa7:9af4:0:b029:19d:975a:3ef2 with SMTP id y20-20020aa79af40000b029019d975a3ef2mr3745187pfp.5.1611051902891;
        Tue, 19 Jan 2021 02:25:02 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t8sm2400032pjd.51.2021.01.19.02.25.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 02:25:02 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 0/2] t5411 out file overwrite fix
Date:   Tue, 19 Jan 2021 05:24:57 -0500
Message-Id: <20210119102459.28986-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
References: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

t5411 has some test cases on the behavior of failed 'git push'
commands.  Even the 'git push' command ended, the output file
may still be updated with messages from 'git-receive-pack' command
running in background.  This breaks test cases which reuse the
same 'out' file.

## Changes since v1

+ Use different 'out' file instead of removing it which does not work on
  Windows.

## Range-diff v1..v2

1:  037e52118d ! 1:  3ec70c1c68 t5411: remove file after use to prevent overwriting
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    t5411: remove file after use to prevent overwriting
    +    t5411: use different out file to prevent overwriting
     
         SZEDER reported that t5411 failed in Travis CI's s390x environment a
         couple of times, and could be reproduced with '--stress' test on this
    @@ Commit message
          - A mixture of the output of 'git show-ref' abd 'git receive-pack'
            leads to this issue.
     
    -    To resolve this issue, we can remove the file 'out' after use.  The
    -    long-running 'git receive-pack' will not redirect its output to the new
    -    created 'out' file which has a different file descriptor.
    +    The first intuitive reaction to resolve this issue is to remove the
    +    file 'out' after use, so that the newly created file 'out' will have a
    +    different file descriptor and will not be overwritten by the
    +    'git receive-pack' process.  But Johannes pointed out that removing an
    +    open file is not possible on Windows.  So we use different temporary
    +    file names to store the output of 'git push' to solve this issue.
     
         Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Helped-by: Johannes Sixt <j6t@kdbg.org>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t5411/test-0000-standard-git-push.sh ##
     @@ t/t5411/test-0000-standard-git-push.sh: test_expect_success "git-push --atomic ($PROTOCOL)" '

     ... ...

-- 

Jiang Xin (2):
  t5411: use different out file to prevent overwriting
  t5411: refactor check of refs using test_cmp_refs

 t/t5411/common-functions.sh                   | 15 +++
 t/t5411/once-0010-report-status-v1.sh         |  5 +-
 t/t5411/test-0000-standard-git-push.sh        | 32 +++----
 .../test-0001-standard-git-push--porcelain.sh | 32 +++----
 t/t5411/test-0002-pre-receive-declined.sh     | 10 +-
 ...st-0003-pre-receive-declined--porcelain.sh | 10 +-
 t/t5411/test-0011-no-hook-error.sh            | 20 ++--
 t/t5411/test-0012-no-hook-error--porcelain.sh | 20 ++--
 t/t5411/test-0013-bad-protocol.sh             | 95 +++++++------------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 95 +++++++------------
 t/t5411/test-0020-report-ng.sh                | 20 ++--
 t/t5411/test-0021-report-ng--porcelain.sh     | 20 ++--
 t/t5411/test-0022-report-unexpect-ref.sh      | 10 +-
 ...est-0023-report-unexpect-ref--porcelain.sh | 10 +-
 t/t5411/test-0024-report-unknown-ref.sh       | 10 +-
 ...test-0025-report-unknown-ref--porcelain.sh | 10 +-
 t/t5411/test-0026-push-options.sh             | 22 ++---
 t/t5411/test-0027-push-options--porcelain.sh  | 22 ++---
 t/t5411/test-0030-report-ok.sh                |  6 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |  6 +-
 t/t5411/test-0032-report-with-options.sh      |  9 +-
 ...est-0033-report-with-options--porcelain.sh |  9 +-
 t/t5411/test-0034-report-ft.sh                |  6 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |  6 +-
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 18 ++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 18 ++--
 t/t5411/test-0038-report-mixed-refs.sh        | 10 +-
 .../test-0039-report-mixed-refs--porcelain.sh | 10 +-
 t/t5411/test-0040-process-all-refs.sh         |  6 +-
 .../test-0041-process-all-refs--porcelain.sh  |  6 +-
 ...t-0050-proc-receive-refs-with-modifiers.sh | 18 ++--
 31 files changed, 224 insertions(+), 362 deletions(-)

-- 
2.28.0.15.gba9e81f0bd

