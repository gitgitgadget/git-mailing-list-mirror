Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42350C433FE
	for <git@archiver.kernel.org>; Mon,  2 May 2022 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiEBTzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiEBTzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 15:55:07 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA4625D
        for <git@vger.kernel.org>; Mon,  2 May 2022 12:51:36 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2442907a1so15283461fac.8
        for <git@vger.kernel.org>; Mon, 02 May 2022 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b-rad.info; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=RHjZPHFtUHQu8H3zabbfJU+0Ezz3w8rWKWf4GTtV/W4=;
        b=FBFUlx7qrTw4a9PytnH3e1Zv3DT0qC4Zy3fzZIwc80MpTFOMLRCX/nf63h5Brrmo93
         Gl+gdja4quTPiZuy9yMlPoX9IBlqqlfNUmJMEeOCe6b9ydMJh2EhEItrrHFDzCYnqvMy
         GHEPy/BIJrQKpL8Q4FinXwBOd8v+kCjdyOjd7UdHluvwXj079fedL1RyCD1VG1VgbKMP
         BYDGqFwKwfA/t4M2zEz5Ufy3Qph6yKzAYOGwT3PWV8/kkNqboSWNd09YHEJv0pxbq8y8
         gyXJHpx7TSzLfZut4AB6NGp80ei/jeIryy56Epa5Zv8Lk8LRkrl2VR9gRggKTDkR/3Ou
         vmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=RHjZPHFtUHQu8H3zabbfJU+0Ezz3w8rWKWf4GTtV/W4=;
        b=1KqWU2aMNTX4e6GfQIGiSIERCSW1BGJZpf8qgu+cOpQ8R/LLI0/rNw7QrhE0RPXjLD
         8pdSCMr/h0DKNlzZzHmMIaraFctNBc9VNTS5GfqGPnmyWgM83dTbzDZfDv1U7H2OyK4a
         zel9xR+53Id54sjcHGnsjj1XwgCM1h3elP0G2hYV+LJfJolaxP/zvg12W07wfaYOhyCG
         sA+YA/NhTnLouzY5HLyz/iEHBCKd1VmuJTQ9L4Bqo9U/Nv7UXj+B65d8JAzMvGyCBZKC
         gdgU33ahYPoVJq85MX3bZIut4HV5JquTk4M1OVTzXnWkqaI5oDdpK/uTWs6gp4LBKau9
         yP8Q==
X-Gm-Message-State: AOAM533/mysb73g6mKkjUfEL3XOF2jMqY4pGzbRsI9eok/Ph6CGr7xm0
        7N7DKElXoqbp52jum+hoHNdnWYqZBpuiTg==
X-Google-Smtp-Source: ABdhPJwViisow4lmOkHdCu9QnhBw31WxB96GQc4+4aCRKa/RqdYEhQgA8aHlkV5vS1SFr+0bMF2+6g==
X-Received: by 2002:a05:6870:e0d3:b0:ed:7e8e:97dc with SMTP id a19-20020a056870e0d300b000ed7e8e97dcmr368553oab.240.1651521095167;
        Mon, 02 May 2022 12:51:35 -0700 (PDT)
Received: from smtpclient.apple ([2601:300:8000:13:b84f:754c:4713:b43b])
        by smtp.gmail.com with ESMTPSA id b11-20020a056808010b00b00325cda1ff87sm2670949oie.6.2022.05.02.12.51.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 12:51:34 -0700 (PDT)
From:   Brad Beam <brad.beam@b-rad.info>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Bug report - ssh signing causes git tag -l malloc failed
Message-Id: <16668F1B-7670-4136-8AAF-ABAAA802C7D4@b-rad.info>
Date:   Mon, 2 May 2022 14:51:33 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

When using ssh signing `git tag -l --format=3D'%(contents:body)' <tag>` =
returns `fatal: Out of memory, malloc failed (tried to allocate =
18446744073709551323 bytes)`

What did you expect to happen? (Expected behavior)

The tag to be returned without crashing

What happened instead? (Actual behavior)

git crashed with the above error (`fatal: Out of memory, malloc failed =
(tried to allocate 18446744073709551323 bytes)`)

What's different between what you expected and what actually happened?

Anything else you want to add:


```
[14:23:54] (0):~/src/github.com/my/repo
% git tag -sam v0.0.9 v0.0.9

[14:24:03] (0):~/src/github.com/my/repo
% git -c log.showSignature=3Dfalse tag -l --format=3D'%(contents:body)' =
v0.0.9
fatal: Out of memory, malloc failed (tried to allocate =
18446744073709551323 bytes)

[14:24:27] (0):~/src/github.com/my/repo
% git tag -sm v0.0.9-no-annotate v0.0.9-no-annotate

[14:27:19] (0):~/src/github.com/my/repo
% git -c log.showSignature=3Dfalse tag -l --format=3D'%(contents:body)' =
v0.0.9-no-annotate
fatal: Out of memory, malloc failed (tried to allocate =
18446744073709551323 bytes)

[14:27:26] (128):~/src/github.com/my/repo
% git tag -m v0.0.9-no-annotate-no-ssh v0.0.9-no-annotate-no-ssh

[14:28:10] (0):~/src/github.com/my/repo
% git -c log.showSignature=3Dfalse tag -l --format=3D'%(contents:body)' =
v0.0.9-no-annotate-no-ssh

```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Oct 12 18:33:42 =
PDT 2021; root:xnu-7195.141.8~1/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.30)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

