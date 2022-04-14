Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2AC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 19:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbiDNTfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiDNTfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 15:35:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A827ECC72
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 12:33:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bh17so11914431ejb.8
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gozynta.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=RXvmrEBrOQUliKC5FzHPfRJ9tWimgOaCY06wQkEh784=;
        b=N6FYs6i5JRBXQv9HWFQkKRsG+U6AcMaQnP37vPSZ4tTWorZzt0/VrC/VcAo5dg2wYo
         rJe7ruLGqnALCqnBpKgA/61VzjFGItzM3jiiu8HDwVER1jwaVyvCZDgOz74RFCglVcgm
         vuO8zNcF5sfrGNGlkxn09U0bd21WvytElb5HN54AiYtsAch6v79FNeMlHO6GgMJZbMC7
         f15/ICaWWDV7VIsBMElzYapmJEx4wuvU0rN4xmJJwPap7yTTA9kEPIu5OaeKxajjGIWJ
         nroiYJ9qZB5Kzy1q8Lhpz3vugNB30WOSq869TnxOhg25r3EIY4wts5B2F9ZQeawj8Fu3
         NnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RXvmrEBrOQUliKC5FzHPfRJ9tWimgOaCY06wQkEh784=;
        b=ic2YlnZimzUZVz/FwU7LsH1oA1JA3/GN+eCCgcoyVHCgchiJ6BN+iwuYVh5lYL20tS
         lm9qyslV7NzPZnYqdql7asZsW9TSi0332Xq9FS/QQqJyCw3Ri5G8j/2ugg9zJ1G/lJsl
         N2ljOTZAp9vYX3pGr6EYsEH7v/I56pC5gx7EddW5oenz5zIwWatkM9530s0nNxYonJCs
         SFPx1ZzxCQ9f2j8UBwFCRPdkuTZB69jKVloFXwLYa8HWmsQjX5FdH+26mds5rLJenQjs
         zK77WMlkXqYJowuzNEE/iKEn667g1u+YR1wPOsgn93CpcHG1MxENbuv8L99Fhzi9b1Qn
         z/HQ==
X-Gm-Message-State: AOAM533rjHppF5+0IKxis7+m1kOeeE3kZ5iKIAKCFcgIlF8tqmv/4RKj
        5gm8eVyUlN3xUyXWDCn2V2WEMEMgCL4aZ02sNXGxVXj0qiFabw==
X-Google-Smtp-Source: ABdhPJzO8S9VQxqiwHmH8RrU8+loGp0S9JOHWgQKAT2J2lq+VcZV2V/RAwy/H3wqPO+zq5SgbDy0MSmwOgUNYIlF508=
X-Received: by 2002:a17:906:1384:b0:6e8:46b6:d42e with SMTP id
 f4-20020a170906138400b006e846b6d42emr3663790ejc.366.1649964782562; Thu, 14
 Apr 2022 12:33:02 -0700 (PDT)
MIME-Version: 1.0
From:   Tyson Holub <tyson@gozynta.com>
Date:   Thu, 14 Apr 2022 15:32:51 -0400
Message-ID: <CAFboxAHGKGTSbyFaFjPCjnTMzz+N=jhX19_zoexC6U=pCLCeXQ@mail.gmail.com>
Subject: git subtree pull fails with gitconfig merge ff = only
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please see the bug report below.

Thanks,
Tyson

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
update ~/.gitconfig with
  [merge]
        ff = only

add git subtree to repo
  git subtree add --prefix subtree-path git@gitlab.com:some-repo.git
main --squash

push new commit to git@gitlab.com:some-repo.git

try to pull subtree commit
  $ git subtree pull --prefix subtree-path
git@gitlab.com:some-repo.git main --squash
  From gitlab.com:some-repo
   * branch            main       -> FETCH_HEAD
  fatal: Not possible to fast-forward, aborting.

What did you expect to happen? (Expected behavior)
expect git subtree to be able to merge even if default option is ff,
or provide git subtree pull with a --no-ff override

What happened instead? (Actual behavior)
subtree updates do not seem possible to pull with merge ff = only

What's different between what you expected and what actually happened?
subtree pull doesn't work

Anything else you want to add:
git subtree works after removing merge ff = only

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.35.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.11-76051611-generic
#202202230823~1646248261~21.10~2b22243 SMP PREEMPT Wed Mar 2 20:
x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit
