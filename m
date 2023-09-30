Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD0E77354
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 06:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjI3GxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 02:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3GxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 02:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6A1A7
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696056750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bEoo8NXyMok4A6DNybdmYFaVh2MKAHbkkn7mDJedCFU=;
        b=Nrb7Y6IW5KEqSpYzREsOagnIZI7KiSjDUQjarPa5lmYLO+qCbJMOW7pJfNSFhQfnu+73Ei
        HMAwpvZ95EV6MHDBXcUd0311tL8lJjvXk6mWP5+iszkzfoj5cQGFtJIR4jMLsnjSFdiq6O
        C5eZ8wImndLnJYJGc2ChUHEDgg3eYPg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Pp0w3vWpP1G95ylNNAKOVA-1; Sat, 30 Sep 2023 02:52:28 -0400
X-MC-Unique: Pp0w3vWpP1G95ylNNAKOVA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5056cc81e30so1413745e87.0
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 23:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696056747; x=1696661547;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEoo8NXyMok4A6DNybdmYFaVh2MKAHbkkn7mDJedCFU=;
        b=Q7aVxjzLwaCARSRJSb0hgm1luSNCeszmcg+OK1feub5kuJJs+crYk/ILmAfBbtbTd3
         FwFXIcfwsp6YLUAC+E02cPnciv4RjPUeEAItULwEhZjQoPku7FibKOV/+tXlWSIHXMzo
         TCicsGv+0zHbTS6nsXLmzXquUnGU7lGdx0/adgwDMN8ab7XmuSfAecbUMtwkjSYyMcDn
         4NElGkzBfTm60O1cDZx0kxibCRYrW0B2frSE2z3TRSiJa+tC265860q6rj95Gk6NXBNh
         V+OxLNqjOAvRgzmWeao97ugMC8CEUok7bmMQorHJqHkQu4owT3J57amoR6FkKURDbKHO
         93rA==
X-Gm-Message-State: AOJu0YyUD7xbf+EPYzCSXw5tE0QN3Z1SM9Jg1HCvUqul/veEDmSbvDK0
        nRxFHdCYLudEy0ufkOpfpOfniS1V1AZUQQawHAv+rwbkCa6rT6aMWjPIUCZUhFuam9M9egk3big
        +7c3yjyBjMbrmnFOThE1mBm7Akk2VsRAbQyX/G3w2ow==
X-Received: by 2002:a05:6512:3b90:b0:503:258f:fd1b with SMTP id g16-20020a0565123b9000b00503258ffd1bmr6870015lfv.18.1696056746774;
        Fri, 29 Sep 2023 23:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8vPX9KU578nFckYRi6I/4lnzH1zShA4KLrgxU0+wtPmaVHGcYqxkRnPiIhF9jpWKQStRE/EJBdmbHrBZjNlw=
X-Received: by 2002:a05:6512:3b90:b0:503:258f:fd1b with SMTP id
 g16-20020a0565123b9000b00503258ffd1bmr6870005lfv.18.1696056746414; Fri, 29
 Sep 2023 23:52:26 -0700 (PDT)
MIME-Version: 1.0
From:   Irina Gulina <igulina@redhat.com>
Date:   Sat, 30 Sep 2023 08:51:09 +0200
Message-ID: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
Subject: bug - Inconsistency of git status and branch, ./git/branches and ./git/HEAD
To:     git@vger.kernel.org
Cc:     Tomas Tomecek <ttomecek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. create an empty directory in CLI: mkdir test_repo
2. convert it to a git directory: cd test_repo & git init
3. 'git status' will say you are "On branch master"
4. 'git branch', 'git branch --all', or 'git branch --list' - nothing
will say the master branch exists. And per man pages definition the
branch command displays existing branches. So the question is why 'git
status' says "On branch master", but 'git branches' don't?
5. check on 'ls -la ./git/branches' - it's empty
6. check on 'ls -la ./git/refs/heads' - it's empty
7. check on 'cat ./git/HEAD' - it shows 'ref: refs/heads/master' -
why? if we didn't create any commit, and no branch exists?

What did you expect to happen? (Expected behavior)
git status should not say "On branch master", cat ./git/HEAD should be
empty.  Or the master branch should be created in ./git/branches and
the 'git branch' command should display it.

What happened instead? (Actual behavior)
Inconsistency between 'git status', 'git branch', ./git/branches and ./git/HEAD

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.41.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.4.12-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 23
17:46:49 UTC 2023 x86_64
compiler info: gnuc: 13.1
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

