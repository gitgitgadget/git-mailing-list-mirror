Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B6B20D0C
	for <e@80x24.org>; Wed, 14 Jun 2017 12:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbdFNMbl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 08:31:41 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35300 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbdFNMbd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 08:31:33 -0400
Received: by mail-wr0-f178.google.com with SMTP id q97so187833414wrb.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OeNQfq0K1D0YLJtWcMDHAda10aJBqXp9TRb3Yg1wLc0=;
        b=lEXRXaw0ndICjPImg0hGzCKCZa1r9UGxPJHqcuQ7n6D0TItBdwflchz87KY58DdBsy
         GNo21D4ba8mbMsOmWtFm0Tr3YVyVgkhIrtIL0XqgtP30+MGsApVVOSljqxU59hoje0qB
         zNNAIzQ3ReDGM4K6ilPZQ45AQoJChbOOIO4wBhYV/aWWyR6bMiOjzMkBEn7HOHTRf7gb
         43W38LJjAwZzP/CNaNyWVdf06bMul6j0jwuPLzawU6uKDv9IIgZzJTXWjf75w7hus3Aj
         bz230pmsow5sQwUJzVaKi/JlMapnNYyTMIFasmSJV5vT2GsdpG4/EbyhMIwTbpnFZZYx
         Ojhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OeNQfq0K1D0YLJtWcMDHAda10aJBqXp9TRb3Yg1wLc0=;
        b=tERqMwHGMA+rfkGuu9+77Bcrwq0yJXeHbYi74YrwOQd/Z562IOy1dx4NmBBIGog8s0
         xNB+a9FzXbOtsS0rfAlvlKbRvcUZMwPJ2Tyb7wwjYCtRTu/jGUKvzwk+nzZad7Sr3vcK
         47YCjJuk/rU3L9pvbzRNXLkDiOoOUkoJFXIZ4ISTM70NBi0rQo9qv+P28BJ73f09gpL9
         cHnviIEvVKDD0bbZX22w8OjwdOzxEPiIkpvfpIFdVhx8nQBttfQ1F5whDH8ARWZkWtzY
         QjzkUrovxWpiMap7tICHlbcv9imrBUsRv+qaLct0foY7ClaJValwKnMj2LLVOaI5W12X
         svIQ==
X-Gm-Message-State: AKS2vOyvNdgpSMrXcWMsvphtH7se3OIrvE5zwHIIoxuADGzJHCx4WRmu
        gO5mhjZm8H/cUIHPOlFpg8GeQ2sUKQ==
X-Received: by 10.28.128.22 with SMTP id b22mr949700wmd.42.1497443492282; Wed,
 14 Jun 2017 05:31:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.130.41 with HTTP; Wed, 14 Jun 2017 05:31:11 -0700 (PDT)
From:   Yichao Yu <yyc1992@gmail.com>
Date:   Wed, 14 Jun 2017 08:31:11 -0400
Message-ID: <CAMvDr+Qxjdgnm0aW3WenDpFs2NBhyrNXZA2M7sjsCjJs+RzM3Q@mail.gmail.com>
Subject: Minor missing features in worktree compare to new-workdir
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've just learnt recently that the new-workdir script has finally got
a builtin version, i.e. worktree. I've given it a short try and for
the most part it works as good or better than new-workdir.

However, there's few minor features that I use in new-workdir that
doesn't seem to be supported by worktree.

1. the branch name in new-workdir has the same behavior as checkout,
i.e. when it matches a remote branch name a local branch tracking that
remote branch will be created and checked out. worktree gives an error
in this case. This is very useful for fetching someone else' feature
branch into a different work dir for testing.

2. worktree doesn't seem to support multiple worktree on the same
branch. I do this for testing different options and also to checkout a
base branch on a worktree before deleting the dev branch checked out
in the workdir. This will indeed cause one of the checkout to be dirty
when the branch is updated somewhere else but it doesn't seem to cause
much issue otherwise. (this mainly happen when I forgot to remove a
workdir so the solution is usually just remove that out-of-date
checkout).

3. There's an error when the branch name is omitted but the default
brach name already exist. Can it default to checking out the branch if
it already exist instead? (The behavior of creating new branch is of
course also useful when the branch doesn't exist)

4. worktree doesn't seem to be runable outside a git repo. new-workdir
can. This is pretty minor and mainly useful when checking out a branch
that matches the nested structure in the branch name (i.e. I'd like to
checkout branch A/B/C into A/B/C/ while master branch is in master/. I
usually first cd to A/B before running git new-workdir ../../master C)
This only saves a little typing in certain cases so it's a very minor
issue.....

All tests are done 2.13.1 from ArchLinux official repo.

Thanks.

Yichao Yu
