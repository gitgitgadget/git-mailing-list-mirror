Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC40C433E0
	for <git@archiver.kernel.org>; Fri, 25 Dec 2020 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6274A224B8
	for <git@archiver.kernel.org>; Fri, 25 Dec 2020 21:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgLYV5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Dec 2020 16:57:11 -0500
Received: from mailscanner.iro.umontreal.ca ([132.204.25.50]:49842 "EHLO
        mailscanner.iro.umontreal.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgLYV5L (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Dec 2020 16:57:11 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Dec 2020 16:57:10 EST
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id DC7054405DB;
        Fri, 25 Dec 2020 16:47:03 -0500 (EST)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id E759644044E;
        Fri, 25 Dec 2020 16:47:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1608932821;
        bh=fsyA+VYh5Zb9wM4jP6OBmlCCE2ScIoKA+fYOTjAWhoQ=;
        h=From:To:Subject:Date:From;
        b=Ujgj0j6rgy7Apg6YIcnu6f3qTei0lBw2iO47a3Fs2y16hSYfYcPJuS+3XZy4TluiS
         nvr6ioGat3W4M/qe85fjAKRca6V1/41LgHihqQbqjotpZ4w0WTM6gyqQ9nxd2C1AV+
         XOxcB8afe5rz4V0+Le0+kDvqm//1q4ShQnRBw9omcD6uv8lcqqZ3c1jTzH8fgde+x4
         +PgyNw1xdDcHc4mkR2w3xwer1mKMCethrTA3H27Vh7PJ0bBTUdQpyrcnv2lxmpmPkz
         YefAfz6vWuxs/AjsEyMX5ZKF8phJa2/UJbKEs/GfXX5oTgyyPFLSn2vSePyAVJa+ZW
         hVC9FHrzMDwpg==
Received: from alfajor (unknown [104.247.243.191])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id B4CCF1201B6;
        Fri, 25 Dec 2020 16:47:01 -0500 (EST)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     git@vger.kernel.org
Subject: Read-only access to an "objects/info/alternates" repository
Message-ID: <jwvmty1pnm9.fsf-monnier+emacs@gnu.org>
Date:   Fri, 25 Dec 2020 16:47:00 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I did basically:

    git clone --reference ~otheruser/nongnu
    [ Days passed and I did various things.  ]
    cd nongnu; git gc

Note that `otheruser` is [..wait for it..] another user, so I only have
read access to the referenced repository.

What did you expect to happen? (Expected behavior)

That it would GC the local part of the repository and that it wouldn't
try to modify the referenced repository.

What happened instead? (Actual behavior)

I got warnings indicating that Git was trying to delete files from
the referenced repository:

    Enumerating objects: 35095, done.
    Nothing new to pack.
    warning: unable to unlink '/home/otheruser/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx': Permission denied
    warning: unable to unlink '/home/otheruser/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx': Permission denied

What's different between what you expected and what actually happened?

The warnings.

Anything else you want to add:

The warnings make me wonder if I should worry about other possible
misbehaviors when using such a setup.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


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

