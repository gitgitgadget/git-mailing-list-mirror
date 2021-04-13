Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11193C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF3561242
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbhDMU0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDMU0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:26:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59516C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:25:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a9so7552859ioc.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j/+NWMTahuBkquacxBA7Gv/vJtrGRAdFgZciLtbaR6k=;
        b=gnNem02Udjsf8O753RWjZB+A5zlAEf1NCxPhseTbRkw92jX2xYz9HlDQszRzsOv9tw
         iFHmoEmOQIlMLXH6w1BnBFiKLEXib02xIG5QWHnlHUkLmkrrgoOEDHvRHnqkg9e/R9XF
         XeTYvXnjnSWcLPphSiMWBHUVXOFkzXN0fL4Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j/+NWMTahuBkquacxBA7Gv/vJtrGRAdFgZciLtbaR6k=;
        b=r1uDftMw0DdpsziPizOsuGF0QQGrWpoKr1e8F2tCflz0A3Zlz6JeCrSubG62SpT+k4
         AoR6xMO5fcvl0PGmje88p38nAD4tmkN4bPTtcSjwh6KtvliQP1Qd3JCSxeYdFZ+h5NOT
         7hL3xYTJGKbXhjzTZ+Dvdeo92aZS/xHUOMkkuvQW1Gm9EL81OQbg2zfkrMkerg/Ur2aJ
         X/hKMpeIEMkrHfQJ0dtLqXwLo+7RIq4DNr4Egc66YAFAnYvKFwpMmZQt5vzumis5K7SI
         I/uGHOyFkdzcanH/KUR5CaihRX4oNvXt+5bFsux/ggwJsw39nSIEAXr6TFCMMYAwsb4T
         /wGQ==
X-Gm-Message-State: AOAM533lZg71MHlLOE3WKUUPMzdloJhOXrH6wNzq+oJzWYpfpHUpjBMP
        uKjVIszEZAxGTHlpj60WGyx8+BeNvb23RYgEbj2MCudXHk2zZg==
X-Google-Smtp-Source: ABdhPJx+ZvLnOVmn8XEnGG34CJKaLBb/8iVFPjKJEVMNhUdW/4FHknsav/iljR7b7OR7K/6CK1XkNRcEct9kEOG8DPI=
X-Received: by 2002:a6b:bf07:: with SMTP id p7mr28384676iof.15.1618345543393;
 Tue, 13 Apr 2021 13:25:43 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Bostock <sam.bostock@shopify.com>
Date:   Tue, 13 Apr 2021 16:25:32 -0400
Message-ID: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
Subject: `git fetch` not updating 'origin/HEAD' after branch rename
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Hopefully I followed the instructions on https://git-scm.com/community
correctly to report this bug.

Long story short, it seems to me that `git fetch` should update
"refs/remotes/origin/HEAD" when the upstream HEAD changes, but it
doesn't. See my filled out bug report below.

Thanks,

Sam

----

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Clone a repo with some branch name (say "master") from some remote
origin (say GitHub).
2. Replace/rename the main branch on the remote (say "main").
3. Run `git fetch` locally to sync with remote.
4. Run `git rev-parse --abbrev-ref --verify origin/HEAD`.

What did you expect to happen? (Expected behavior)

The `git fetch` should update the refs accordingly so "origin/HEAD"
now points to
the new branch, which should be output from the command above:

    $ git rev-parse --abbrev-ref --verify origin/HEAD
    origin/main

What happened instead? (Actual behavior)

The "origin/HEAD" ref seems to not point to anything anymore (because the
branch it was pointing to was "deleted"). `git fetch` fails to update
it to reflect the change.

    $ git rev-parse --abbrev-ref --verify origin/HEAD
    fatal: Needed a single revision

What's different between what you expected and what actually happened?

The HEAD on origin has changed, but this change is not reflected in
the local refs by `git fetch`.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/74shlfgb18717ixjlpivpxd7iqcyhyn5-bash-4.4-p23/bin/bash
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05
PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
compiler info: clang: 7.1.0 (tags/RELEASE_710/final)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
