Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E940C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2049860E09
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhHRInY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbhHRInY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 04:43:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67453C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:42:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cq23so1897844edb.12
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slight.dev; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=OP/cDseKnij4lUgbTM/XgNPzP4r57ofu1dqf9a6HV44=;
        b=Odtiw5aQAKVKJO2gOYYXRIHN2jg0ZWt2b40qimUR6RY6ZjIPs9GFX3+dhaT8iVX828
         m3IqClgQ+3dP8q6FYweLEmbp8TL56JpXX7s5wvfmLcHfQY1GitXF+g1JXEg0ZYZYfmYF
         oEOayo7tlKhXu79PFnUemTbldlMSx+9zlqsNJU2U88CenZ+Quc970IYkx+T7Ck91ovSn
         64U3a8X4vEWW6pOgVer9EoFzscxRgwnpT/gEtKHeokXCUPefRvF4nq4NdFEUyCLmFQHe
         Wqi8ysDn9d+dYz97QYUNiEP4GKl9eyIUBuX/0G1XnwMN6oRb8WCExr/BPOA+TGZshOgi
         kZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=OP/cDseKnij4lUgbTM/XgNPzP4r57ofu1dqf9a6HV44=;
        b=bqVqS8YmO+YUVLXoU5hdHWKvfNJ8OJMQsO+oqQis+rtRiI4DJnS8FJEdTZldBynniV
         V9uOPDI3CuVIpwN9rnUX6T/dcmPU/f20KHT8CP5emqrosSVUuFcKCv+gUo1mSfaI0pWv
         iy79lsHDN/Yw8VeZxAvna5w05M61bi9R38rbh9+9DBWekzHQ2pU4U5jUPeD8rcj18Hh5
         lzWqarZ+XpqdoaH/Ppf2nWKdXmRRI0JCKoTu8bP6B0WaSfqi5M8oFsf7AAYqEEfdrf3W
         lIFvA5Fw6RP5yPRSl7JBLEWS8ZUNe5FprclB7F54T2dn5LA/oBtOgXWJ2pG4GSPMe6Wz
         wJvA==
X-Gm-Message-State: AOAM5301DaeQY0ZoEEnL4Qa6YjFosSuIKdTr3oEjtnLEnIbTPTfpogu9
        fx+kCu/nwEPr/1cjMyChTISLZRun/SeF6Vwu
X-Google-Smtp-Source: ABdhPJxt2Yvb6D7v/KMy9jniPwieAIJSIuonNBK1LHqYyBwZXF+wpMHL804FdUaZRk0m3CGVb5og1w==
X-Received: by 2002:a50:d509:: with SMTP id u9mr8950929edi.35.1629276166359;
        Wed, 18 Aug 2021 01:42:46 -0700 (PDT)
Received: from smtpclient.apple (82-217-163-254.cable.dynamic.v4.ziggo.nl. [82.217.163.254])
        by smtp.gmail.com with ESMTPSA id g10sm1709412ejj.44.2021.08.18.01.42.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:42:45 -0700 (PDT)
From:   Thomas De Zeeuw <thomas@slight.dev>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Bug: Segmentation fault in git diff
Message-Id: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
Date:   Wed, 18 Aug 2021 10:42:45 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is my first bug report to Git mailing list so let me know if more =
information is needed.

Running the following command results in a segmentation fault on macOS =
arm64
$ git diff --name-only --diff-filter=3DU =E2=80=94relative
Segmentation fault: 11

I was rebasing while it happened, trying to resolve merge conflicts. =
This is roughly how the status of the repo looked (I changed the file =
names, but keep them relative the to output, i.e. ../actual-file.txt I =
change to ../some-file.txt).

$ git status
interactive rebase in progress; onto a4aabaa
Last command done (1 command done):
   pick ad0e02e WIP
No commands remaining.
You are currently rebasing branch 'my_branch' on 'a4aabaa'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   ../dir1/Makefile
        modified:   ../dir1/http_spec.yaml
        modified:   ../dir1/tests/api/file1.rs
        modified:   file2.proto

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
        both modified:   ../dir1/build.rs
        both modified:   ../dir1/tests/data/file3.sql
        both modified:   file4.go

Running it through lldb doesn=E2=80=99t give too much information, but =
just in case it helps:

$ lldb -- git diff --name-only --diff-filter=3DU --relative
(lldb) target create "git"
Current executable set to 'git' (arm64).
(lldb) settings set -- target.run-args  "diff" "--name-only" =
"--diff-filter=3DU" "--relative"
(lldb) r
Process 10619 launched: '/opt/homebrew/bin/git' (arm64)
Process 10619 stopped
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D =
EXC_BAD_ACCESS (code=3D1, address=3D0x8)
    frame #0: 0x00000001000ea2ac git`run_diff_files + 864
git`run_diff_files:
->  0x1000ea2ac <+864>: ldr    x8, [x0, #0x8]
    0x1000ea2b0 <+868>: strh   w19, [x8, #0x50]
    0x1000ea2b4 <+872>: ldr    w8, [x28, #0x38]
    0x1000ea2b8 <+876>: ubfx   w8, w8, #12, #2
Target 0: (git) stopped.
(lldb) bt
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D =
EXC_BAD_ACCESS (code=3D1, address=3D0x8)
  * frame #0: 0x00000001000ea2ac git`run_diff_files + 864
    frame #1: 0x000000010002a65c git`cmd_diff + 1820
    frame #2: 0x00000001000043e4 git`run_builtin + 420
    frame #3: 0x0000000100003948 git`handle_builtin + 272
    frame #4: 0x000000010000322c git`cmd_main + 812
    frame #5: 0x00000001000a6ec4 git`main + 140
    frame #6: 0x00000001a19e9450 libdyld.dylib`start + 4

I got my Git binary from Homebrew, tried version 2.32.0 and 2.33.0 =
(currently the latest on Homebrew).

OS information:
macOS Big Sur Version 11.4
$ uname -a
Darwin MacBook-Pro.local 20.5.0 Darwin Kernel Version 20.5.0: Sat May  8 =
05:10:31 PDT 2021; root:xnu-7195.121.3~9/RELEASE_ARM64_T8101 arm64

=E2=80=94

Regards,

Thomas de Zeeuw
thomas@slight.dev



