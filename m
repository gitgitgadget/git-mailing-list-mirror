Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E66C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328D620774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="F/hF7J5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLIQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLIQL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 04:16:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB5C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:16:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1229249ljk.9
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CIT/1fpUNWejp9/SuxAR1U5Fgg7pLB3hhnoXTVJnD4E=;
        b=F/hF7J5lDIX85H3LfQJ2p9CNIb5rODIajHtZpEN2IH57KhBBwbIVN2xuN3RcG6lKul
         Gesm991BmpvjBYUP81LaY9rS2iYuKDfkFa+jmXQyaK3zi/BmhFVYsZ4PLP4ZjGCN8luW
         NWQitjdJg1horiMBzzvqzr54SCMAcwq0IjbTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CIT/1fpUNWejp9/SuxAR1U5Fgg7pLB3hhnoXTVJnD4E=;
        b=ZJ/R+MCLOe70YeReiqearBdjjStQBA4qmGGjkKGhGaX1YdggOGRO8n0dZcIAydJxxS
         XjYpXSN24OsiBbIpoblCgZHogUdsy2q4CVtkeUDivLBJRnyhpk0el6By/dqvoa38Kxhz
         hFRCfmtfBGpWMJfa72nkxUjyVblMUCDcEACwi8eIipyyb5FADDIuUKXpUSPnx6GsyIMh
         dYMUw32r/F91jJRg1mLWCJW2Gon8Wyzf6rdJtn9zzSsVWrxKy2U+bah25/lgGWYPdyi7
         Rt03lsdSOvsKqkliNerlQseUWvTX7k4HaizO8F4BPTGP3GBXDs4JLd781PGQJ2kiayxs
         vchQ==
X-Gm-Message-State: AOAM533pvdFFChQBbfNUhO67u7MMTs6eTYnjxg6lvMv+h9TCSeAG/Y9n
        vO9aHDGwnYUto6ONG1Dgu71MKHDHju4=
X-Google-Smtp-Source: ABdhPJyy6AvKwRw0qWupBA5FmXmLZ+4BTqOZyLylaVjA1HlOpxgfbByJ37YW4PJnFnigPfQQdcUA4Q==
X-Received: by 2002:a2e:9cd3:: with SMTP id g19mr4865582ljj.229.1597220169064;
        Wed, 12 Aug 2020 01:16:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s3sm278614ljd.44.2020.08.12.01.16.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 01:16:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v4so1278504ljd.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:16:07 -0700 (PDT)
X-Received: by 2002:a05:651c:1050:: with SMTP id x16mr4507045ljm.457.1597220166917;
 Wed, 12 Aug 2020 01:16:06 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Ost <ost@ieee.org>
Date:   Wed, 12 Aug 2020 10:15:55 +0200
X-Gmail-Original-Message-ID: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
Message-ID: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
Subject: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I tried to install git on a filesystem that does not support hard
links (specifically, on a Linux bind mount).

Despite installing with `make NO_INSTALL_HARDLINKS=3D1 install', the
installation process tries to create hard links, and the installation
fails (a quick workaround is `sed -i git-gui/Makefile -e "s/ln /ln -s
/g"').

Here's the bugreport:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
./configure --prefix=3D/filesystem_without_hardlink_support
make
make NO_INSTALL_HARDLINKS=3D1 install

What did you expect to happen? (Expected behavior)
Successful installation.

What happened instead? (Actual behavior)
Installation fails with error
  ln: failed to create hard link
=E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-citool=
=E2=80=99 =3D>
=E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-gui=E2=
=80=99:
Operation not permitted

What's different between what you expected and what actually happened?
The makefile `git-gui/Makefile' tries to create hard links. This is
not expected when running `make NO_INSTALL_HARDLINKS=3D1 install'

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.27.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
uname: Linux 3.10.0-957.10.1.el7.x86_64 #1 SMP Mon Mar 18 15:06:45 UTC
2019 x86_64
compiler info: gnuc: 4.8
libc info: glibc: 2.17


[Enabled Hooks]
not run from a git repository - no hooks to show
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thanks for checking this!

Best,
/alex
