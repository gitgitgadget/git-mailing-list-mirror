Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C966BC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBUWCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBUWCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:02:22 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901B32CFD
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:02:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d73so2675726iof.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV7IfmUXvpOwUDG37iQUNtLShw8AKANIjrfr6OBe6tA=;
        b=KP6Hl86M0jrLvFCV/24XiQKcU8zvxmm1+UufUdknS14w3FuCck8rHq6XNbRL9tuNZt
         IA5EJq6UKBeKTQyC5gRjzuGnXed/hNTHwF6k8LL9I0seg2powZtS8wHzZEcG9dx+5llG
         nM5SgaJgDKfhVZq8feZos3yXv+p0DFS+18n7ErxfLvbuCeXXGQAvavG7Fx3dQcOC7BZt
         lbQy+S4PJrzZ9Kpp3WpMMsxAKxCY9cbob2FVvIUjuCVpeqVW7mnMgq04TBJY1XERkOlN
         g7SxZOx2IWuSk+I1pyKuuAttLP98eGa0RbS7BVdWsXzGM/qaL5zs7AghATYO2k6mAH6C
         U1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV7IfmUXvpOwUDG37iQUNtLShw8AKANIjrfr6OBe6tA=;
        b=YuIx6Viesd6Nf3U2uEUi8tQ7p3XmNnW+1mj015ag5KKErkY7RcIS7ptHMBz4d90Z0z
         NV6EFe2ws7YvIY7asYoRl+rMfkZivghzuNNrelIyEUwe6cPNrhMufkZy/hU1yJpVVipL
         UedjPVdF5JX7mPxhulBxfx5iULYnbIIb+8tOCN/oVIE7HuzUVZB5q/T3hMKiOsEbuGsu
         2tkr2PvcP1Z1P6Py7mp8aVu7tI7wSFKKDM9fg3fl7MrJ6squVisgOg3g6689W0WDFPw1
         mIOFfln/6QGunM8IXtImzG3eWcNoXVB4kXTb1RE5+vEjwX+iJ4Tne8yF00B8m3z7OstK
         kXEw==
X-Gm-Message-State: AO0yUKW2ln6R8H+GJmMwBUjk+CXdf9Of5gUumnEh9CjDNHE9VSSWXmGM
        WKcc4FAYyEZ36d/rF1lW5x+4+qby5KXwCA==
X-Google-Smtp-Source: AK7set/ICqMlbUMi/VsfltOHM4WKO0ekbvpbMXsx2r8OhvTjgL5wvJmLsG1EaKM3t3C2hUb3qfOD9Q==
X-Received: by 2002:a5d:9f47:0:b0:74c:7ef2:fd79 with SMTP id u7-20020a5d9f47000000b0074c7ef2fd79mr2069811iot.2.1677016927999;
        Tue, 21 Feb 2023 14:02:07 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-j.epic.com. [199.204.56.215])
        by smtp.gmail.com with ESMTPSA id g17-20020a056638061100b003c2bb1bd5a4sm5188762jar.34.2023.02.21.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:02:07 -0800 (PST)
User-agent: mu4e 1.8.14; emacs 28.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: [BUGREPORT] Why is git-push fetching content?
Date:   Tue, 21 Feb 2023 16:01:04 -0600
Message-ID: <m0ttze4qzl.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

    # in a new directory,
    cd $(mktemp -d)

    # initialize a new repository
    git init

    # fetch a single commit from a remote
    git fetch --filter=tree:0 --depth=1 $REMOTE $COMMIT_OID

    # create a ref on that remote
    git push --no-verify $REMOTE $COMMIT_OID:$REFNAME

What did you expect to happen? (Expected behavior)

    I expected this process to complete very, very quickly. We believe
    the version where it had been doing so was ~2.37.

What happened instead? (Actual behavior)

    The fetch completes nearly instantly as expected. We receive ~200B
    from the remote for the commit object itself. What's truly bizarre
    is what happens during the push. It starts receiving objects from
    the remote! By the end of this process, the local repository is a
    whopping ~700MB -- though interestingly only about a tenth of the
    full repository size.

    This result in particular is strange in context. I would expect to
    either see 'almost all' the repository content, 'about half' (we
    have two trunks and fetching a single commit would at most fetch one
    of them), or 'virtual none at all'. There isn't a straightforward
    explanation for why 'one tenth' would make sense.

What's different between what you expected and what actually happened?

    Why should git-push ever be fetching objects? This doesn't map well
    to my mental model of the relationship between push/fetch.

    I would expect the local repository to stay in that 'git init'+200B
    range.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

    I've truncated the system information normally included by
    git-bugreport as I am sending this email from a different machine.

    Versions of Git that can reproduce:

      - 2.39.2.windows.1     (Windows 10)

        git version:
        git version 2.39.2.windows.1
        cpu: x86_64
        built from commit: a82fa99b36ddfd643e61ed45e52abe314687df67
        sizeof-long: 4
        sizeof-size_t: 8
        shell-path: /bin/sh
        feature: fsmonitor--daemon
        uname: Windows 10.0 19044
        compiler info: gnuc: 12.2
        libc info: no libc information available
        $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe

      - 2.31.1               (AIX UNIX 7.2)

        git version:
        git version 2.31.1
        cpu: 00F905E64C00
        no commit associated with this build
        sizeof-long: 8
        sizeof-size_t: 8
        shell-path: /opt/freeware/bin/bash
        uname: AIX 2 7 00FBC37A4C00
        compiler info: gnuc: 8.3
        libc info: no libc information available
        $SHELL (typically, interactive shell): /usr/bin/ksh

--
Sean Allred
