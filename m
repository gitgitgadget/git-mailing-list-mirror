Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9AAC004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAUOGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 09:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUOGc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 09:06:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCD37554
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 06:06:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt14so20529276ejc.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tGKbQHa6Vndgp8GbgjQJJs4QzKaxGvjggxSnAjam0Ik=;
        b=dkOcYOjbbPVaZuTlkCvZlkH6ozgxtKCxoikpXbx7/UaYKSMc/seQP67IYpsLYqicSs
         Tst9xr6faknWZ7PBYeblOsukriZIhxIxanaYONikdRUWzowfxweSz/aWIBlTwyeEHN2c
         QqCIlqClvpnNozCHuPiZejRRDoCd+QDmzCJ88x6xWapddOcOjfzt5MAKhYeWJ0Z9Nj7g
         P19FNZy4EdJuY4x0BpG/rB1KjRZ7N/3hKO4E0G9nyjITaJdaHROqO1o71FQRANKnQrjL
         Mk4zeaN0JLJMOsCHAz8H8GGKU/mIC3HuQV8K4MM4EgUgqr9vDRby20W28bJg57GLAwru
         NQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGKbQHa6Vndgp8GbgjQJJs4QzKaxGvjggxSnAjam0Ik=;
        b=htvmXlf9tCPch2sx8tQin8ZBn+jUSuDLJePMryBIWSLUbIbVG8ZgekwR2DjVKCwoD9
         FASd9ETRpUdbl0mNdhUeBnH32aP+WyyhkT8a7LlndX+yJ6lVmtVOAOv8t+HigzTagjdd
         7arB0sLjxdHk4+zpADxSJnLWTlV3dhdlauFQDt50d4HnV2I9cdQ4l3srJ6YTuh/uLKKx
         3ErXaBMiKokOjgldSUJQ46cQAcgVbbeeFCWTlnrXDwnHG2lDVE8nMI5xUwd1A6RmTYZK
         Q/9XBEe8W58EiQqRR2Bu1trTBip0PR/YBqUjX3iI7v4zetoZpFLIEz/8Hr7QclgckIHR
         gdqw==
X-Gm-Message-State: AFqh2kq4WTvg3G4hNRERsHugfOBthABNg6l86kFy5tJFGg8qb2Gl+i9p
        bHuv5uYZt/ZF51EjGKrXKtVdpSdAKRhVyhZTY0LxaIP+ono=
X-Google-Smtp-Source: AMrXdXvt72BGoYwIaXOd9Y1ehDsiTj2UO0QCowgbgUGISyMvNzPcSZ9u9fLAjTXaN+iv/yadyilohwrqZE0UaHyaj7I=
X-Received: by 2002:a17:906:4717:b0:86c:9171:c63 with SMTP id
 y23-20020a170906471700b0086c91710c63mr2177512ejq.571.1674309987628; Sat, 21
 Jan 2023 06:06:27 -0800 (PST)
MIME-Version: 1.0
From:   Kusal Kithul-Godage <kusal.kithulgodage@gmail.com>
Date:   Sun, 22 Jan 2023 01:06:16 +1100
Message-ID: <CAMwnG+x=j-9BWqj8TwZEAvZrS6CcYd_o4GgnnQhbGfnxVyDNUw@mail.gmail.com>
Subject: Git worktree bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bug summary
--force-with-lease option not working with worktree based repository

What did you do before the bug happened? (Steps to reproduce your issue)
git clone --bare repo.git
cd repo.git
git worktree add master
cd master
touch file
git add file
git commit -m "Commit"
git push
touch file2
git add file2
git commit --amend -m "Commit"
git push --force-with-lease

What did you expect to happen? (Expected behavior)
+ (forced update)

What happened instead? (Actual behavior)
 ! [rejected] (stale info)

What's different between what you expected and what actually happened?
The git push command might be sending incorrect metadata as the remote
thinks I have stale info

Anything else you want to add:
It'd also be nice if the 'git branch' command and related commands
behaved the same in worktree based repos as normal repos - ie. only
list local branches

[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:08:47
PST 2022; root:xnu-8792.61.2~4/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/zsh
