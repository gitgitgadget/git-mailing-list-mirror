Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED2FC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357744AbiFVN4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357752AbiFVN4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 09:56:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87134666
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:56:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so16784717pjl.5
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ycrTXLXKC71RvRcr6YM9y+XFhoyvvXrqSdIjtcWW3Is=;
        b=qJpB28yP58+G9HNpKaw6aU4+1ZZ2+iGU79DNPetxrFTKdyGJod81/VjSZv6fUIXnfj
         s728QRvKd5EbJXyjDHjeI2z1ZvKQSFkjhNU5U/ohvJndsPvHvyI+fcKAycSPYojECjBo
         rkiFHc4GlV3AoDF9l/9FEO1RXwY05sOLtVhmjf0QVGSIu1Um4NIqq8p7AiJu+99eQmTJ
         amNO9V7cWbq6HhjHx9x4fc7hG4GXz++s2hcVTR8wI9UflDMJwwjbv02AYvWgSE/BX7m+
         WplucShOOrSdzwUsb58nXh+Cy6uCl2EvNSfqGquGOVqTqVrZJmEgMtIxJYHWlNXMDxu2
         XioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ycrTXLXKC71RvRcr6YM9y+XFhoyvvXrqSdIjtcWW3Is=;
        b=OCD8OI2REj1sgvmGyC2u4XJzOaQZENTiM5m+6GBrHOR1fnFItAARCgShlzAWb13YhK
         21d91/VYkeKUDNcd3XYi34S3+4ZWtMZzuF/2I+MvtANAUEB+QntPHEDFwEVTLCbaCeor
         IiN3IYlmaG5yHxYzF6TQybrPCXHwBw2WhsypC1EsFJhRXkc49/+oOdk3TYYDcbA7tRG1
         USAALjWsngPjxd3fyuLX1YEnZWd1fTtv1YZVCpRfwuXEYDv2E3hjl6wLQChxdWNQDNBf
         L3Qw858ALPUA0ED9rquqSrrcvfkjbwFMYm01ONPUc52LB8hY1M5Ne+qmnkik0WrG4bna
         alkw==
X-Gm-Message-State: AJIora+uZretBMS172z/9w4Khv7nffE5nsvSAzg4yE+22JzIaFKfuBYy
        ZH0RDkVJ2likxtsM1JhRw3miE1Axq5xcHVMRIBrUQjf9qQM=
X-Google-Smtp-Source: AGRyM1tEq+bFjpVd8MyUDs1nPRCIxKqMgAAf0t+O8OVPlRX4ZOIuIL65u6Nf/e4i7yFOpZziWexm0A3aXNNE0+l9drY=
X-Received: by 2002:a17:90b:3143:b0:1ec:be03:e0a5 with SMTP id
 ip3-20020a17090b314300b001ecbe03e0a5mr3969362pjb.30.1655906167694; Wed, 22
 Jun 2022 06:56:07 -0700 (PDT)
MIME-Version: 1.0
From:   void f <fv729164860@gmail.com>
Date:   Wed, 22 Jun 2022 21:55:56 +0800
Message-ID: <CADRR3BHq4ZmjHh9HJfh-nGrKR5X5TUPq3-eyr0Atbz8zM8oOxA@mail.gmail.com>
Subject: Bug report. Out of memory about git checkout.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E2=80=94env:

git version: 2.19.1
os : center os
memory 8G

=E2=80=94 how to repeat this bug:

Build a repository with large lfs-file use GIT_LFS_SKIP_SMUDGE like
this:  (I can't push a 10G lfs-file to github, So I can=E2=80=99t give you =
an
example repostiory)

```
hecanwei@MacBook-Pro lfs-test % git st
On branch master
nothing to commit, working tree clean
hecanwei@MacBook-Pro lfs-test % echo "$(cat Xcode_13.4.1.xip )"
version https://git-lfs.github.com/spec/v1
oid sha256:a1e0dbd6d5a96c4a6d3d63600b58486759aa836c2d9f7e8fa6d7da4c7399638b
size 10783587696
```


Rm Xcode_13.4.1.xip

Git checkout .

You will see =E2=80=9COut of memory, realloc failed=E2=80=9D

It also use too much memory above version: 2.36.1 macOS


=E2=80=94 reason of the bug:


When you execute git checkout, Which have to checkout a lfs-file to
the worktree. Git would execute **convert.c
apply_multi_file_filter()** to convert lfs pointer from git-object to
the lfs file. It will execute a subprocess to convert this file. But
It is strange that git would read all of the file into memory When
finish the git-lfs subprocess. (The code is about pkt-line.c
read_packetized_to_strbut()). Lfs usually is a very large file even
more than the memory. So it would throw out of memory exception.

With this bug, it would have trouble to use sparse-chekout in a
repository with large lfs-file. Because you must init the repository
first and set the sparse-chekout config, than use git
pull/merge/checkout to checkout your subset worktree. It would out of
memory when you checkout it.

I think git don=E2=80=99t need to read all of the file in memory. It can us=
e a
stream to finish the checkout.
