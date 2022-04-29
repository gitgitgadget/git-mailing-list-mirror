Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF95C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 19:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiD2TJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiD2TJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 15:09:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D3A1452
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:06:10 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f16645872fso94837917b3.4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aquatic.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=u+dxvBzP/vZlnFycHXglnZgWwVRNH/a1UGIvQXw2TNs=;
        b=WpsPxzsSSSsfkpZPoIhCfcKHNce1pNZ4LQw7T/ieXbgwdTBVe8q9wQCmvNh6kkHP2O
         o+h87QPtZj0oPCQd3PG9C7wLyyX3j6o+pW3GnMVv28OS1dPX4GPDS+Po8vvyFkp1jnS7
         BK71FyxgO1DyAfHZghg0OEiw6gNyyK0O/owSgmupyLLhO9kN6Y/Ymsa6iyi5D5VsfFe8
         wElvnBiqp32z/2JQ+i8QqFbO41xs445yM/cdMWamy/r7jvkb6jlSuppX58B9Ug6YeXJI
         Ph8O1xarv1vInJoIMeFc5T6z+52+ZK0yPeVF5pqQ1zj+/aTz+eyd5AdIlV0h+sA0wJuD
         SRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u+dxvBzP/vZlnFycHXglnZgWwVRNH/a1UGIvQXw2TNs=;
        b=2D5b1kXXRWMPyCFavSoTmYISa1qavT93TfLtITEC5GvtFXKykdWF4RUY5bH3dt7l7a
         HekLuTLlHpyaLx9Jhm2HrzOwRuCEWAI7Qb1Nw4ETFMqzD5S45i4OrfHgxorJ9jUZe7sF
         KuS/o9Y461QVJc11Z3w0CsBwJ4ehk53o2USGmP2QUKD+E2V8F8U6zv3iYy1zCUfl2s2h
         5e2ZN467/6qDG1f/DO4MxQGUMmUnmAWDwkAO2cOoiZiixmzhBux8FeOA1hePkjbZ64At
         YJGtYT21VWquqVAyUK0qcVqSRXU4MxR50BtHAXW1uKfL9WnOHQjTpaBkweJI1Hjo3UVw
         U55g==
X-Gm-Message-State: AOAM531lSQSdQThTTlN9z23m7XcRDSIBjnGS4pe8otOueBBF6lWQYfWd
        TDAU8re4z0RuD2h7X0AQ9kPeIPcvwErqq2hgbG0FjXqhtkxDHDH4uMLGBRo6LU2DqWBYXiitVgJ
        ZlGllzxBMD4R0+60UM4X+K5L7m5Wg3gCvxR/QkMS0pqh/Atic70Kidsvjj5bc0BPBBA2EPbl+6V
        7TSesbkigeSRIdvdsKAfspl4fBnyGAlMHIJLBJXQxscW+raj1U7SKjEjfPc5QjlX8=
X-Google-Smtp-Source: ABdhPJzBvpiy45b0V+/NfPvMVkBHzfNLdA6g/fMzjTquyDzci+VgE+SzRXq7gOAu5cyIR/oXHk/sOtC6ppPhd3GaXhw=
X-Received: by 2002:a81:23ce:0:b0:2f8:ad74:1185 with SMTP id
 j197-20020a8123ce000000b002f8ad741185mr804897ywj.120.1651259167070; Fri, 29
 Apr 2022 12:06:07 -0700 (PDT)
MIME-Version: 1.0
From:   Austin Morton <austin.morton@aquatic.com>
Date:   Fri, 29 Apr 2022 19:05:56 +0000
Message-ID: <CAAir=1MbwGtONW7yWRWoXKzAiwqwhOAqdhfWYMYLxt1vANuUOA@mail.gmail.com>
Subject: Able to checkout same branch in multiple worktrees when using symbolic-refs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When using a symbolic-ref I am able to inadvertently checkout the same
branch in multiple worktrees when using the symbolic-ref name, despite
being prevented from doing so if I use the target branch name.

Below is a minimal reproducer:

$ git --version
git version 2.36.0
$ git init .
$ git status
$ git commit --allow-empty -m "Initial commit"
$ git symbolic-ref refs/heads/main refs/heads/master
$ git worktree add ../worktree2
$ git worktree list
/home/amorton/test/worktree1 cd8312d [master]
/home/amorton/test/worktree2 cd8312d [worktree2]
$ cd ../worktree2
$ git checkout master
fatal: 'master' is already checked out at '/home/amorton/test/worktree1'
$ git checkout main
Switched to branch 'main'
$ git worktree list
/home/amorton/test/worktree1 cd8312d [master]
/home/amorton/test/worktree2 cd8312d [master]


-- 
Austin Morton
austin.morton@aquatic.com
