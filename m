Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F36DC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0032C6108B
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbhIHCSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhIHCSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:18:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFEBC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:17:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i3so508696wmq.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3MKQuhMnBuvj9UqWXBeyQ0tIi/TQD2V5Xt4KmYSIWVE=;
        b=FfDXMbxPrOBjqfLj5h9y7iOY/aR+HqWHbF/VPMCrhtrtQScE6ZQ4LUNVPAhzAbcaJa
         r2PHMcs6LYOtu7CPk3vj2D3Cs+E0jl+4KPOS01eyZPVZgEFeTO1i4RM7I81YH8rUQgqk
         65x7hMhCwet5nGV8PcbkSkWO79SNMPmVNZ3ewgjwyjCcnvXNnyItZiwgh70h2ygzwxx1
         KKZH37gnF9e5Pr8JSeHWkX95QnEXtHGHy+JrvuL7UNGIC4XERIyhG2CV+Tc0/bTB2DgU
         75lIanUblmpZ7wI3AmskcgtYvQGTRIxxQwzO+30NovHo/eq5WIuBE+MXGPoWWjB6hinN
         NLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3MKQuhMnBuvj9UqWXBeyQ0tIi/TQD2V5Xt4KmYSIWVE=;
        b=KyFh3kwCpajOXJ3tx4qtxTTEqyyWEuS6gw/v6cjgK7Eh6T6zQIyMlboFYdqARJEGkd
         5AftsxlfNshzT6zMMpW1kqJ3EuukLjB3BYg33IjEKj71qCwdSDkJnd1bNJFy7YMrMMTD
         xD/unR54RA3jAsj39fNVCxAqHIFjBvjmN3UXAZRl+/Is+wD06+TQAssGobBa8eJkJQ3e
         ntgwnkXpVFbXKo8prbRzYaORLnjrkJOaoM4vg/v+f4achcnrjVBHQxnR13Th8iTPbQ5S
         JtNKssMLa2rfcs2y5lhTzmuw36vEyjLlpdPoRR4EsI+WscfTpHwPheh+ItoLfOv5sC1u
         v+2A==
X-Gm-Message-State: AOAM5304ev6/sa9cmyOFjPJvyFg1px5aHpciIIViUbrS9M+JdKpUoYFv
        5YgsPPTw2tbeyWsHMCN8HPsjSQwfrq8=
X-Google-Smtp-Source: ABdhPJww8+ASsDdkqEWlFYJTwvufFSMiPg/UZ42Hr65YxNkTZwBGhwDeHjlDyTRYyjCaIDLU0u+hgA==
X-Received: by 2002:a05:600c:22c3:: with SMTP id 3mr1106453wmg.133.1631067430162;
        Tue, 07 Sep 2021 19:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm721063wmd.5.2021.09.07.19.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:17:09 -0700 (PDT)
Message-Id: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 02:17:07 +0000
Subject: [PATCH 0/2] A pair of git am --abort issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series documents a few issues with git am --abort in the form of new
testcases, and fixes one of them. However, while I was surprised the abort
left the working directory dirty, I couldn't find any documentation to
confirm it should or shouldn't be, and reading the code led me to question
if perhaps it was intentional. Anyway, if it's intended, let me know and
I'll drop that testcase.

For frame of reference, these were some issues I found while working on
unintentional removal of untracked files/directories and the current working
directory, and I'm just submitting them separately.

Elijah Newren (2):
  t4151: document a pair of am --abort bugs
  am: fix incorrect exit status on am fail to abort

 builtin/am.c        |  3 ++-
 t/t4151-am-abort.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1087%2Fnewren%2Fam-issues-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1087/newren/am-issues-v1
Pull-Request: https://github.com/git/git/pull/1087
-- 
gitgitgadget
