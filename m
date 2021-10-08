Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684ACC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2B60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJHQFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHQFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 12:05:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DCC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 09:03:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so31455715wri.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TyEZH3iwft+j4ndTCoDaxJOZjJ2baRcuGe0usCxGvQ0=;
        b=hT9HY7HiXO5sDKyTs0Isn6gasNMUJafDY7JYszHmx2YX6aOtE3fdrICpzRn2Cjl/us
         TNjNlgpuATdMAh+WNgFOC87hIiu4KZ3XK9zP1ayrf4c6hObtgYlCj6v8ywHmaKuoyZbV
         F3P7Rw4+8lmf5bLq2TxRCW7bDB0US3Ibd4fqHevcubkUWRGeg9RuAGHs8vxxNyzo63V9
         dWfIFmbBxGz6Fd8mkNg/nyELVRe0gLPCgCxCKb2W9G8o3SKf17Q57JxWqtUgAYp/AOFO
         7X7CC+o0l3EOKcw2eEdUWPz+L1tTKjqEe+PiKXb+c+m1YwdEenrSh191617+Ni2wCWAK
         xQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TyEZH3iwft+j4ndTCoDaxJOZjJ2baRcuGe0usCxGvQ0=;
        b=61b0D9IadmNm/JpPkOp+7eK+9qN3QspDKoJPriRwzBPCpL7584QKxO23pUjfZk+Yow
         AMoHFLYckV/ubnCG5NKrzig3ghzbyWpdsJDKoXJeYSfuCJixYFrkpDNhb98+AWkw3pnD
         OhZuTEmKEkV0HMTOPL1t9owhobBKCMKe8JVi48zM5ofi+5ZFAgHEed0xm4BNyl50Xlsa
         +6lGv02JeWTKwL7J4bwg+Q6+FvaK63dtZpbtTuR/hcIyleJPAJpLNWSxj9jBn8N4BEj/
         eIJ+SU8pOgZQ1us8Ik9dbZVn7rqxDFfUypvHBH9Gruk5mSsoLJSFZne1l8UZDIWnC6Uw
         qLuA==
X-Gm-Message-State: AOAM532Veno65HjVEdz2qh5iDQz6bTfkmhIQhFEt0i5kF7e8Ok2MSgXH
        G+gXnu+ieaN5WlJAy4SBLmkzrt5A83E=
X-Google-Smtp-Source: ABdhPJwCOcmg9EeHgEXiyAyrfkdJEXX6Rb1JvV7X5kHkYPGb9at/mihVMy/x5SQ1EDHIyN+zBPWDnQ==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr5160423wra.321.1633708987170;
        Fri, 08 Oct 2021 09:03:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm2866122wrs.19.2021.10.08.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:03:06 -0700 (PDT)
Message-Id: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 16:03:04 +0000
Subject: [PATCH 0/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some setups, packfile uris act as bearer token. It is not recommended to
expose them plainly in logs, although in special circunstances (e.g. debug)
it makes sense to write them.

Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
variable is set to false. This mimics the redacting of the Authorization
header in HTTP.

Signed-off-by: Ivan Frade ifrade@google.com

Ivan Frade (2):
  fetch-pack: redact packfile urls in traces
  Documentation: packfile-uri hash can be longer than 40 hex chars

 Documentation/technical/protocol-v2.txt |  8 ++---
 fetch-pack.c                            | 11 +++++++
 http-fetch.c                            |  4 ++-
 pkt-line.c                              |  7 +++-
 pkt-line.h                              |  1 +
 t/t5702-protocol-v2.sh                  | 43 +++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 6 deletions(-)


base-commit: 0785eb769886ae81e346df10e88bc49ffc0ac64e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1052
-- 
gitgitgadget
