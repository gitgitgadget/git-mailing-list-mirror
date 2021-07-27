Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0442C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C126C61AFF
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhG0Oss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhG0Osl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 10:48:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC63C061765
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 07:48:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so15898819plr.13
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=ldMdg6zEVOfdFx7Gc9FI0+FiOksVdFrTxnY703/Mt+U=;
        b=r1LbdESNneIhYSp+myEX6zfUra+n5RFcS785+GGiH1mtY+Ya6hl8yoC4RyWJ2jd42s
         wkdm18/Ix0PhlENsKAElEL6q08nCchisdo+YgiThxwKfRyQaseEDv4obW4xgTP9h4m7B
         Ewa6xhkE0qzWvtjvUoIFqPIFv3zXEU3h/xGyM7WuOGczzH77tvaNMPeQUPHlYT5ZtS5r
         MVZDa78Ih8faYCfsySnOB3pFCvjkcwDph9Laqof6NTJjOiM0jVaYPMPsZD8OmBrXSi7G
         9OyudHY3NZMUXmOOr5xp+pbBwr3BLG2YrCU6NDdpfhoK2P+XnJpP1M0ooAo3sjgxOYVY
         4Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=ldMdg6zEVOfdFx7Gc9FI0+FiOksVdFrTxnY703/Mt+U=;
        b=p+A3nbcqaxha/4dqugnaOParB4JwMwOLVsfePBI5MQfTQz7/TSRu8HMKJ6Yw4Cqws2
         RxZSrmFpkFANpl0geLWR3wbUkc3ZdsEntemVrCdQ589vtbFAQIt50QNjcxpQTmKXpyDJ
         AXOhJV4PoHYbyAlFA3jwvvdjiN5wyZtHrkvmuAz09O1m88U4KbgXaSJPxI9ejoTsedCx
         QdmVLyRO+ktcGotZur3UJb3tZmFsXJsJT+HxH8MmMFkHlv2bElob2ew8EQXGY/lnsUlc
         3Z2+zzlOyDPa09L9S+d6Y70QqEwlRc380UDIsHfpDu3Y7lzhqNCwRfS45qddONnLqP1t
         8fKQ==
X-Gm-Message-State: AOAM532JyVyGvXgS07DrKZ8hgh+sBrpFcegB6KIK15LeAeaCZsNrWs1p
        HRyYXfzVlJmT5bOiA78FzOK00NT70RhoWA==
X-Google-Smtp-Source: ABdhPJzin4kKW/4c7L7MXDF59F7Nfd1b0t4ofgdhvip+Yi3smdLuGSe1GrdFJpFYzgELkM/eP8aQew==
X-Received: by 2002:a17:90a:5916:: with SMTP id k22mr4713273pji.139.1627397300816;
        Tue, 27 Jul 2021 07:48:20 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id j12sm3895231pfj.208.2021.07.27.07.48.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 07:48:20 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [BUG] git add is silent when adding submodule with modified content
Message-Id: <CFAB9A5C-6F76-4C91-AD4B-F315C4060FD9@gmail.com>
Date:   Tue, 27 Jul 2021 20:18:17 +0530
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Apologies to those CC'd if you got this multiple times, it looks like
my MUA is messing things up and the list is rejecting it)

Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git init superproj && cd superproj
echo 'hello' > superfile
git add superfile && git commit -m "superproj commit"
git submodule add ../superproj submod
git commit -m "add submodule"
echo "submod content changed, possibly unintended" > submod/new-in-sub
git add submod

What did you expect to happen? (Expected behavior)

Git informs me the add did not happen because of modified content in the
submodule.

What happened instead? (Actual behavior)

Git silently does nothing, and returns success.

What's different between what you expected and what actually happened?

I want Git to either fail or warn me so that I know that the operation
did not match what I expected.

A script I wrote silently carried on and committed everything except the
submodule and pushed it to a remote repository. Even on the command line
it was confusing at first, until I explicitly ran 'git status' and
realised why it was not getting added. Unless someone opens the git man
pages, they might not realise why the add failed.

Anything else you want to add:

I tried looking into it, but I'm not sure where the fix would fit. I
suppose the problem could be at 'diff-lib.c:run_diff_files()' [1] which
makes calls to check for changes in submodules, but does not relay that
information in any useful way, especially when called in
'add.c:add_files_to_cache()' [2].

[1] =
https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/d=
iff-lib.c#L239-L264
[2] =
https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/b=
uiltin/add.c#L120-L141

[System Info]
git version:
git version 2.32.0
cpu: arm64
built from commit: 62a8d224e6203d9d3d2d1d63a01cf5647ec312c9
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.5.0 Darwin Kernel Version 20.5.0: Sat May  8 05:10:31 =
PDT 2021; root:xnu-7195.121.3~9/RELEASE_ARM64_T8101 arm64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

