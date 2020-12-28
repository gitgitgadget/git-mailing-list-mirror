Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C94C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6496C22B2A
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgL1Sva (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:51:30 -0500
Received: from ciao.gmane.io ([116.202.254.214]:36576 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgL1Sv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 13:51:29 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1ktxbU-0009ym-Db
        for git@vger.kernel.org; Mon, 28 Dec 2020 19:50:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Stefan Monnier <monnier@iro.umontreal.ca>
Subject: [BUG] Destructive access to an "objects/info/alternates" repository
Date:   Mon, 28 Dec 2020 13:50:43 -0500
Message-ID: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:cBTSF1c5pmZ9d5YA8X+jGR6+wlA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Resending with a subject that clarifies that it's a bug report.  ]

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.

> What did you do before the bug happened? (Steps to reproduce your
> issue)

I did basically:

    git clone --reference ~otheruser/nongnu
    [ Days passed and I did various things.  ]
    cd nongnu; git gc

Note that `otheruser` is [..wait for it..] another user, so I only have
read access to the referenced repository.

> What did you expect to happen? (Expected behavior)

That it would GC the local part of the repository and that it wouldn't
try to modify the referenced repository.

> What happened instead? (Actual behavior)

I got warnings indicating that Git was trying to delete files from
the referenced repository:

    Enumerating objects: 35095, done.
    Nothing new to pack.
    warning: unable to unlink
'/home/otheruser/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx':
Permission denied
    warning: unable to unlink
'/home/otheruser/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx':
Permission denied

> What's different between what you expected and what actually happened?

The warnings.

> Anything else you want to add:

The warnings make me wonder if I should worry about other possible
misbehaviors when using such a setup.

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

This is on a Debian stable system but with Git from Debian testing
(because the version from Debian stable crashed in a `git log` command
I was using in my scripts).

[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.19.0-9-amd64 #1 SMP Debian 4.19.118-2 (2020-04-29) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]



