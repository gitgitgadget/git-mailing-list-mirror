Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA64DC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 23:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiHVX6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHVX6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 19:58:48 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5265192B1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 16:58:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m5so6564212qvo.4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc;
        bh=YyRK+JvvZAhJeXgbQdzUTLGDivV3ySWTEjObuTbAnPg=;
        b=HwyIwJhUpjpbFxnLQf/ssXi3WDPLo13n5i9XWW3L1WcLVKdiIFuVQJ76Vyu5/UM9mW
         DBQkOY/tQTnPJZXFBftCdzWHN20tI2fxVdYQRMvzRpYYqhlrl7JnN5MLoAmunWmhc20s
         J+3De3QpJN4Rtfst2bTbAkG1NXvUZwJPdp9uzgI/vO1AfetCaoMjYcy87kZJ5yr47rzA
         PauklxgCm965u0Ee3V3GeEnmRh2HTq7fgz/6y1KTvF0WVpWZDHKoz7q4VnGqoqKs5jmf
         dFInspPauLJRY2ojO7fTerR1C1YUmvzj9ofOES5le35cTdyzBm3OQgi+zuZEEuRMypi3
         VVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc;
        bh=YyRK+JvvZAhJeXgbQdzUTLGDivV3ySWTEjObuTbAnPg=;
        b=baCp+gJpwfdNi3NFP26n/M1mucx3+tJVhTpF9AK3pzMatDnfrbBdhKuo+Q2rv4gdYn
         2/WrMAiWpDOjSoLEUJ5XKpV/lR8OJPKezjriNI8llujTM5JAMtxqRa4yiT0E27RDude3
         /0Zz/dcKj9tt+XZWN5p8Cy4RULu2GAl98WXarpp1dRsDpMOj37Kd0ioSW+vVXYC98pZO
         FPAVbbFSIvG+Jh0NtZt0lFaZgioUWJg787LsMy2Iq17B0jiWZcTGoMybuKgWoq2AP96B
         z64zDuuWqDU87Z+Fg230D9mgzA+G/o9ks0vDAuLQ72a6um23ktpJJJy5LkV3JfciQhSD
         +Q/A==
X-Gm-Message-State: ACgBeo293oyrBC3Z0h/z5RWD3BQ6kwcLWDh7eM4bZxS+IyD06vW9t6pa
        hHNBprPkuT5JtAg0vSdPEt4=
X-Google-Smtp-Source: AA6agR7bwSkSDFz9AuMdsOcJ+EgPHaPFWpplkjU1lW5ti2fQVegWESZmyE4mgqjf1Fkl1uQ/D1wc3w==
X-Received: by 2002:a05:6214:d66:b0:496:fc5d:e1f6 with SMTP id 6-20020a0562140d6600b00496fc5de1f6mr824287qvs.63.1661212725020;
        Mon, 22 Aug 2022 16:58:45 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05620a178d00b006a6ab259261sm11148191qkb.29.2022.08.22.16.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 16:58:44 -0700 (PDT)
To:     Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Bug in 'git log --remerge-diff' when used with '--find-object' and
 '--submodule=log|diff'
Message-ID: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
Date:   Mon, 22 Aug 2022 19:58:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I found two bugs in '--remerge-diff' when combined with both '--find-object' and
'--submodule=log|diff'. I don't know if they have the same cause.

When using these flags together, *all* 2-parents merge commits are shown (even in a repo with
no submodule!)

Moreover, for merges with conflicted paths, all conflicted paths are shown as "(new submodule)",
even if they are not a submodule (in fact, even when no submodule is present
in the repository!).

This artificial example reproduces the bug:

```bash
#!/bin/bash

set -euEo pipefail

repo=repro
rm -rf $repo

TEST_AUTHOR_LOCALNAME=author
TEST_AUTHOR_DOMAIN=example.com
GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
GIT_AUTHOR_NAME='A U Thor'
GIT_AUTHOR_DATE='1112354055 +0200'
TEST_COMMITTER_LOCALNAME=committer
TEST_COMMITTER_DOMAIN=example.com
GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
GIT_COMMITTER_NAME='C O Mitter'
GIT_COMMITTER_DATE='1112354055 +0200'
export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
export HOME=

git -c init.defaultBranch=unimportant init $repo
cd $repo
echo i>file
git add file
git commit -m file
git checkout -b side
echo s>>file2
git add file2
git commit -am side
git checkout -
echo m >>file
git commit -am main
git merge side -m clean
git checkout side
echo c>>file
git add file
git commit -am side2
git checkout -
echo cc>>file
git commit -am main2
git merge side || true
printf 'i\nm' > file
git commit -am conflicted
# look for a dummy object
git log --oneline --diff-merges=r --submodule=log --find-object=2c042ac4213768e55791098110d2ef2ef845881a
# same output with --submodule=diff
```

This is the output I get from the 'git log' call:

b4f1be9 (HEAD -> unimportant) conflicted
Submodule file 0000000...0000000 (new submodule)
a4ef223 clean

Notice both merges are shown despite none of them changing the number of occurences of 
2c042ac4213768e55791098110d2ef2ef845881a, which does not even exist in this repository,
and also that the conflicted merge shows 'file' as "new submodule".

Cheers,

Philippe.
