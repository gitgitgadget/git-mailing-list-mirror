Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678DE7735E
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 07:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjI3HFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjI3HFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 03:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11998C5
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696057489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rY8w+9pk28rsZqWS5K+cmhp8ySOrn/O6ykQrDhz9Pb8=;
        b=N4ZdSnwBQTbsxr+WTlFva7sKU2KLAAO6PKYpzEPRDHWx1AjErPDZYWBB2cLw9kAasDa78R
        wnLGwu5s1xlbjQ3qkj4sbQhug1YhZMvg8igTvglBSN+izBiAajAmCtE1ScyPhVadsHRhe6
        08k9vLEFez7hQeM+4KmfBknVoWZfas4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-O9C8LzrQMxiSF6Wu0btRBQ-1; Sat, 30 Sep 2023 03:04:42 -0400
X-MC-Unique: O9C8LzrQMxiSF6Wu0btRBQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50433961a36so19396527e87.3
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 00:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696057481; x=1696662281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY8w+9pk28rsZqWS5K+cmhp8ySOrn/O6ykQrDhz9Pb8=;
        b=Lshv0lDhy1R8edMntoOHwZfYNW7mi5PAzZHQoM0vQ7vTz8nJ2gbmYL1yxbjR3yrvgp
         eg0vs26BsKbZdCbszTpe/Mhk+ZDPwsVPnk1h8cCgsfVioAT2EWan72VAhQ7pVyO2v9Ey
         K4962cc/h1GOw2yZYPVMpg9SG2J0CEhuuVneqSRtDR6mvnnR6VF50dvPXiuXjJkKy3IT
         CGQgsNLKnCxysbzurSsHvkkfhIo8JehMx0635pJeNiln78IinK5a4kBJIyaOaYgma9fr
         gKTqHLzY9NzTEydeWB8jdxQriIoAI7DaeLVD4qhYuxnquC7AEK9ScLUk4eO8JyklammH
         JkCg==
X-Gm-Message-State: AOJu0YyDMMFQAbFbYc3UHLW6sHDSvUfV3ZJccqp7xcyEaJN3oShEXdGl
        Rw371uhG1dPDpIYHn4EfQsoqbrh/DWPSHU5xClwGGUBHHsoi1aIA/Jwii8ULli1WX7DKJb5ehQl
        V0xLswFHWu5QfDlR9zta+v51Myxa+FIhpUMqY9SA=
X-Received: by 2002:ac2:4ec8:0:b0:500:79f7:1738 with SMTP id p8-20020ac24ec8000000b0050079f71738mr4370654lfr.17.1696057480871;
        Sat, 30 Sep 2023 00:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJWFCqyZWq6m3x+b4SBjsKdWocCQFoE87xjvvGajYaJRRpiWcwpffrpAEQUTUMQezf91WTuVCYlsNqiXwYeE=
X-Received: by 2002:ac2:4ec8:0:b0:500:79f7:1738 with SMTP id
 p8-20020ac24ec8000000b0050079f71738mr4370644lfr.17.1696057480404; Sat, 30 Sep
 2023 00:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
In-Reply-To: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
From:   Irina Gulina <igulina@redhat.com>
Date:   Sat, 30 Sep 2023 09:03:22 +0200
Message-ID: <CAAcHogUEtcsFcDYp16g=154CMPh_a5fmY6ABEfp9zeqEJBNb6w@mail.gmail.com>
Subject: Re: bug - Inconsistency of git status and branch, ./git/branches and ./git/HEAD
To:     git@vger.kernel.org
Cc:     Tomas Tomecek <ttomecek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

apologies for a typo: all paths written with ./git, meant to be .git


On Sat, Sep 30, 2023 at 8:51=E2=80=AFAM Irina Gulina <igulina@redhat.com> w=
rote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. create an empty directory in CLI: mkdir test_repo
> 2. convert it to a git directory: cd test_repo & git init
> 3. 'git status' will say you are "On branch master"
> 4. 'git branch', 'git branch --all', or 'git branch --list' - nothing
> will say the master branch exists. And per man pages definition the
> branch command displays existing branches. So the question is why 'git
> status' says "On branch master", but 'git branches' don't?
> 5. check on 'ls -la ./git/branches' - it's empty
> 6. check on 'ls -la ./git/refs/heads' - it's empty
> 7. check on 'cat ./git/HEAD' - it shows 'ref: refs/heads/master' -
> why? if we didn't create any commit, and no branch exists?
>
> What did you expect to happen? (Expected behavior)
> git status should not say "On branch master", cat ./git/HEAD should be
> empty.  Or the master branch should be created in ./git/branches and
> the 'git branch' command should display it.
>
> What happened instead? (Actual behavior)
> Inconsistency between 'git status', 'git branch', ./git/branches and ./gi=
t/HEAD
>
> What's different between what you expected and what actually happened?
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.41.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 6.4.12-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 23
> 17:46:49 UTC 2023 x86_64
> compiler info: gnuc: 13.1
> libc info: glibc: 2.37
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]

