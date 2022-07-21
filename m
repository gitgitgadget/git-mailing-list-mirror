Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA5FC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGUOWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGUOWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:22:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03C85D51
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:21:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x1so201690plb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anbos-de.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u7qBlqjKQq+7ESgiTIptTy19LExvr94Aa/Uzs1+Pw4I=;
        b=JZXoglNFKjzrEek/nD9KGYBCOyMImANur34UaMeIRLz38N8NcZlGOIAzIsWChOUfen
         cW080VXu9Q5Mr59WBxE+9/vxLj7lgmBu9iwJ0p+sbyVkHvQZzAB9aBToMhx0Ftxi2m7Y
         NornZKq2Chf+VNZ7PmMJfHwqU5Pr3jPPWpJW8qE7kpubo5Er0s9yjpzHeBW6ktnvDlZo
         OlmKc0cQlb+BP4YTSdzA11u0+Z73g/sMHWj6t6X5uFFfQE6VXjJ+tgVFmsCjq5mku4pl
         ljnqj+cRhLuLZ+upabq+Hl1DkhPRB0+oSNJ36UbJhCr4P3ul7v2IVwk60iCt5e1e9njg
         tWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u7qBlqjKQq+7ESgiTIptTy19LExvr94Aa/Uzs1+Pw4I=;
        b=1wJ8Cuz+4LrGUNj+9Hh7/j/l0IQYZwZtYddpa9TnsRZhCHovr+hN5dVlF6srJEu70p
         TEwG0MjXGefTr0DBSdW4LO/NCzP3mBVWT/czRk97LjfQ2LCz9AazE3GgaT0Sk252XlTR
         raqclaFUer36P+ysln2ON4ROoXRsn/ErzEhFpKzxhk3MO3oJlArZY9UvOz5PPU7ZcZ3Z
         dENCAVdH/J9eEt9zFR+9G1qe/l2Spm58ool3KwBccBlAQYxK5mIcfZ0BJ70ADE+qbaNC
         SfAxfxLLCbepPNN58rbPJOe5XlPVrbuVK57L0afopibcVZtsS/CaeeIka2xBE9oG8fFD
         jCjg==
X-Gm-Message-State: AJIora9DvfywPWautAGFDE/E+XDULxqwrIkTZ7/nBhiaucS4xcai/VjA
        6ybsiKJCPUXbmcESekHtKWGgOE4Werpx/EOXkq6IEX8pFKnJLQ==
X-Google-Smtp-Source: AGRyM1sgPBPrqcrBtZB3OHHwLUhJ51cLJ5MhDXBBViYAn5XX9ukzgsjfPcrkKoLz8LBaJA9mYUs+pNkQ72CC1NSOMN4=
X-Received: by 2002:a17:902:7285:b0:16c:ce55:9dba with SMTP id
 d5-20020a170902728500b0016cce559dbamr31579548pll.156.1658413316565; Thu, 21
 Jul 2022 07:21:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Bossert, Andre" <anb0s@anbos.de>
Date:   Thu, 21 Jul 2022 16:21:46 +0200
Message-ID: <CALzBCsFjw3DfY=gbL+23XL0MwKJHv_-znSADfh7XBrmMv51hyg@mail.gmail.com>
Subject: git citool / gui and signed commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

using commit and tag signing and now also enabled it as default.

To circumvent the necessity to commit every change on git bash in
order to sign it, I chose to edit the global .gitconfig and set the
following parameters:

```
[commit]
  gpgsign = true

[tag]
  gpgSign = true
```

Now using git gui the problem is, this only seems to work as expected if I
- amend changes to the previous commit
- create a new commit with the previous commit being **_not signed_**

In case I want to create a new commit and the previous commit is
**_signed_**  I fail with the following error:

```
child process exited abnormally
child process exited abnormally
    while executing
"close $fd_ot"
    (procedure "commit_committree" line 24)
    invoked from within
"commit_committree file1ed02482210
9a6a25477c6f52d405158e68974da5cf41afe5d6 .git/GITGUI_EDITMSG"
```

Workarounds are available, true - but "git citool" is pretty
convenient to review changes before stashing them, add the message and
commit in one go.

I'm trying to understand the tcl code but may be someone uses signing
and has idea or more insights for me...

Regards
Andre (anb0s)
eMail: anb0s@anbos.de
