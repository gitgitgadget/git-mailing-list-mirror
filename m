Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5DC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjAJJEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjAJJET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 04:04:19 -0500
Received: from ns6.inleed.net (mailout6.inleed.net [IPv6:2a0b:dc80:cafe:106::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88AC636D
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bakskuru.se
        ; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nLRaUKWCNujfix3K+iIGtV5+/mRrj/f3OAr7MDASxHA=; b=LovaM6mV3hkV5oLrHmoVjrtzE/
        EFcydVIH6KzYhMYY4luaQ/JNudP/bowmXT5f3f7L6zxdwx+6SXDi/5m9oyQXZ+ERC7fsF9tR5Vda9
        Gmz+L3IT6IFqSkHMIg/+n96DOcYHO6+VP5DMxeHnBUwjQgl3ENrO4bl5qTDTrha8a7cYhzKIIG6Tq
        DvU+puwAHDu+nGEBEthHFTuDsRAyG4cprkOBwm1dO/9zLWkQme1DvidjvED6Hliv9+BAE9g8C1+Yv
        xXLiHnrmz7FZFsjYw+3saQwaNQlO0viuuNUMFPqgrfujKLfGvGasRzu4why5cKDg50+vqb8FoL9wL
        ONul02jw==;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
        by ns6.inleed.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <fredrik@bakskuru.se>)
        id 1pFAWp-00CFqF-37
        for git@vger.kernel.org;
        Tue, 10 Jan 2023 10:02:44 +0100
Received: by mail-pl1-f170.google.com with SMTP id d3so12483373plr.10
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:02:41 -0800 (PST)
X-Gm-Message-State: AFqh2kqjMMTq8wNkV471Q+7bSW7MDA1n6AfQwn/6mtKdbf+GHBz7GXHA
        r9LkPA/YBdIP8QwHcqHHsOgPF4EQJldVmNeHY1g=
X-Google-Smtp-Source: AMrXdXuHEIW3Y/nsvyYMu1vGzmJL3IQqCEPbWz/ErOKz6tHwZgV3GehX48d3gWGcMjLLvM1KRpa86GE/fcPOvxQnLo8=
X-Received: by 2002:a17:90b:3948:b0:227:22d3:c03d with SMTP id
 oe8-20020a17090b394800b0022722d3c03dmr356175pjb.94.1673341359933; Tue, 10 Jan
 2023 01:02:39 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Fredrik_=C3=96berg?= <fredrik@bakskuru.se>
Date:   Tue, 10 Jan 2023 10:02:28 +0100
X-Gmail-Original-Message-ID: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
Message-ID: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
Subject: Bugreport: Prefix - is ignored when sorting (on committerdate)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authenticated-Id: fredrik@bakskuru.se
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
- Create a new repository
- Add a new file to the repository and commit
- Create a tag
$ git tag -a TagOne -m ""
- Update the file and commit the change
- Create a tag
$ git tag -a TagTwo -m ""
- List tags by committerdate:
$ git tag -l --sort=committerdate
(oldest tag is listed first)
- List tags by reversed committerdate:
$ git tag -l --sort=-committerdate
(oldest tag it still listed first)

What did you expect to happen? (Expected behavior)
Using the minus-sign as prefix is supposed to reverse the sorting
order, listing the newest item first. I expected the newest tag to be
listed first

What happened instead? (Actual behavior)
The minus-sign was ignored, and the oldest tag was still listed first

What's different between what you expected and what actually happened?
I expected the newest tag to be listed first when the minus-sign was
used as a prefix, but the oldest tag was still listed first.

Anything else you want to add:
The correct behaviour (reversing sort-order by using the minus-prefix)
has been verified in
version 2.11.0, 2.11.1, 2.14.2, 2.19.1, 2.19.2, 2.23.0 on CentOS 7.4
version 2.31.1 and 2.35.1 on CentOS 7.4 contains the error
version 2.34.1.windows.1 contains the error

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.34.1.windows.1
cpu: x86_64
built from commit: 2ca94ab318509b3c271e82889938816bad76dfea
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 11.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
