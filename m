Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3F21F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbdKMV5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:57:25 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:51272 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdKMV5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:57:24 -0500
Received: by mail-qt0-f177.google.com with SMTP id e19so16678292qte.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 13:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5mmv5sv7D4tCCsGrwSFZcudFbfdkeuYgLNuStLl7I7s=;
        b=i9GddrQTAvPCzA3Tbak4JvS/maQdhcsFUdWRvPOLj5fCLZfQg6B7xz3xlbZEB8SkpE
         RmdICvY2V3u9KS+LGjKHU+5LGTmTgF7GKUj47CWuHijS5v/u6Go4pVf4gjl8RixVDSJj
         BuAMc4XL76zsORtJlH+0SpZLad7zaaK+Eltqtb4uUezg8QYxqr21/H6IBpX8WnYAZohH
         jrV+pxL2dt0zflJXi7TObFf4WiLHHQ3aIWoazmQibw0rmCaJs4VeChZeCi+FXThj1bJS
         KhsWZFoLhb9+b92kDWsttx6IwjUMrNhGMQbxDP9+plolqmc2vksRFIpvRgnX7hoppIEy
         LG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5mmv5sv7D4tCCsGrwSFZcudFbfdkeuYgLNuStLl7I7s=;
        b=SWkUkfyVspSMvNdLAtit+IxjJ1BNDNmLmudobChYKt40yNSfsThwIGXqI9706qp8uE
         qUaa7Yv3N5pZyDYC8yj3k9plAsytIcyhTFXdntG/5SQQZg3/hZri53u81CxS6ypQgTHr
         tpVomtLitlkUGnYxCVMIwjh6orZVf0EBMZfjTT71PRBM+PoixNraz8ZvJAKvMUR3FX9z
         GxJBJMzcNZyRga5YxaewKR6o6GDgBiPHTp17TQvKPUG0dea787qzfNURYEz5Bud9nxnE
         2UjBaXXub29g9ntXNRaB4zVu/ijWqR8KiWD813QrMaXrS/wbwkWwrhPzpkL/CGuQTda8
         wkYw==
X-Gm-Message-State: AJaThX5yf6rdE1qkEHjLfJMcd6PH0vBH7oklc4cOt+/ToU+QuykWJV75
        NZMNrXccZSchOG2qJShXjPwVkR4Z4jFhTxWAxVFC7bb0
X-Google-Smtp-Source: AGs4zMa14pwkJNZ12yyPT6helPVkGYzxG7EHxiSB/V2JnNoJ25DkkbIe9NB5Z4ZC5p+TCks6ahngGXyreth7t3GRq24=
X-Received: by 10.200.63.51 with SMTP id c48mr9678731qtk.200.1510610243128;
 Mon, 13 Nov 2017 13:57:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.60.130 with HTTP; Mon, 13 Nov 2017 13:57:22 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 14 Nov 2017 10:57:22 +1300
Message-ID: <CAFOYHZCvKG+3c3yvW1vdEwx+iQizogTF4wgFKAYCjZAvLUv1=w@mail.gmail.com>
Subject: [buglet] gitk and git cherry-pick --abort interaction
To:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies in advance for the vagueness of this bug report.

I was juggling a few patches around in a git repo (happens to be linux
but that's probably not particularly relevant).

I'd been reverting, rebasing and cherry-picking on the CLI. Then I
found I needed one more commit which I located with gitk. Since it was
already open I used the cherry-pick option within gitk, there were
conflicts and gitk invoked git citool for me.

At that point I decided to bail on the cherry-pick and closed citool
and gitk and ran git cherry-pick --abort from the command line and
that=E2=80=99s where things got weird. The abort put me on a different comm=
it
than where I started (which happened to be the commit from a previous
am --abort). I'm guessing gitk's cherry-pick doesn't fully record the
information in a way that the cli counterpart expects.

I'll try and get a reproduction going but in the meantime some info
from my terminal history and reflog might help.

 $ git --version
 git version 2.15.0

 $ cd linux/
 linux (edac u+10)$ gitk
 # not pictured here cherry-picking one commit in gitk and citool running
 linux (edac *+|CHERRY-PICKING u+10)$
 linux (edac *+|CHERRY-PICKING u+10)$ git cherry-pick --abort
 linux (edac u+13)$

Here's some info from the reflog abridged so gmail doesn't eat it.

 linux (edac u+13)$ git reflog
 d2b10042ccaf (HEAD -> edac) HEAD@{0}: reset: moving to d2b10042ccaf
 67ebefac4b7e HEAD@{1}: rebase -i (finish): returning to refs/heads/edac
 ...  HEAD@{2} through HEAD@{33} are rebase/commit/am/cherry-pick
 d2b10042ccaf (HEAD -> edac) HEAD@{34}: am --abort

Thanks,
Chris
