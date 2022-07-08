Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC20C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 02:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiGHCpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 22:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGHCo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 22:44:59 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264A74360
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 19:44:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e5so2852445iof.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malalta-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pZYtxXWNbP+d4adM/9Trie3LS7FZ4KHLhP2T17i9qCo=;
        b=uCsoCnflTD3uWVJBJExrqroQCZyKpxaWg3XEfmahqkXycDU8lp7Oi5uBbx4p+y/RgI
         AzyvQdmrL3zirVpydiOW6xGl+B1W92ZdpbzTxbUjjGP8f1jDbV9pXFjqpH8CE317L0jq
         wSQvpM0dmWkBuX9y02pEAIX26zsV982EtPu6PlNzuS/j7o+nk6NVvOzUwIK+0OXLb75w
         Q0zA2iInCiBHGp6rpgeADE2k0abmzDNpq1xOrLWi3iDWQXHZ0mjK6vFf9kMarIK6qJXs
         dOS1c/QclJzbBtQRcom8LUraUEs4cMQC1xdscoz+mbAn1cHAL3O2Y1PoVLNY1/ZoAjqD
         aFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pZYtxXWNbP+d4adM/9Trie3LS7FZ4KHLhP2T17i9qCo=;
        b=Koca9+MfBVwJZqXVHXW2CQU/qkHAOL8OrtAKOi6WFLQ7DPV9NRffzLgPdbW9ne6+k+
         gBka9lksTJY+3q+SvwNA1NsSalQsluWFNopFFsyh+jd1obcMyTbQnML0SFTI5coTmV9/
         I7q03bhJ7kNL+ONoKNFontcIeW5CoCMjRiXwPTU8q4aYLS1Hd5AeaAc7kkmybTVSMaMK
         30XjxGwg/jZ9sc321IIMx6eOAnY4dnTlsF6IDUFDiLhTzym5MlMtzRpp0vp9QR2hNrtL
         IVbMV+gVRTPQJ5AXwjFVHKbcEpPp2cRK26pKUYxdWr2D1zCmfhaNKpmklCp8cFkG2mIT
         IJcw==
X-Gm-Message-State: AJIora+S2DDlsz3CFDjlXe+bDsQhX4ozi619evUduacfGJdQNsjrX74o
        xImGeuRhtBRXJmDE87gZ9lND6ISvwmrAnNiKF+DRz+FWPgxjzQ==
X-Google-Smtp-Source: AGRyM1vxMzZBFz2D7BWY9/th9eRq1BpxpbRdSPhVoYj/xp97G1KltN9Tp5wnF4Ti1RrXvBRmECK/myUf04rKLlGH2es=
X-Received: by 2002:a05:6638:2491:b0:33d:cb8f:6791 with SMTP id
 x17-20020a056638249100b0033dcb8f6791mr881493jat.90.1657248297989; Thu, 07 Jul
 2022 19:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHFgaav+7MV_SB3J9c92HrQOMF87nCw7LwihZbps03h5yfPzjw@mail.gmail.com>
In-Reply-To: <CAHFgaav+7MV_SB3J9c92HrQOMF87nCw7LwihZbps03h5yfPzjw@mail.gmail.com>
From:   Andrew Tennikoff <andrew@malalta.com>
Date:   Fri, 8 Jul 2022 12:44:22 +1000
Message-ID: <CAHFgaauzSmtFhSe5bd1CEuu3L6pv8MLv05K=-6HyJQvLf8eejA@mail.gmail.com>
Subject: Bug report: git status suggests the old "-a" flag on git add
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
`git status` suggests using `git add -a`

What did you expect to happen? (Expected behavior)
`git status` suggests using `git add -A` as per the documentation of `git add`

What happened instead? (Actual behavior)
The old `git add -a` flag was suggested

What's different between what you expected and what actually happened?
See above

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:29
PDT 2022; root:xnu-8020.121.3~4/RELEASE_ARM64_T8101 arm64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

----

Regards,
Andrew.
