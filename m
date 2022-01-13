Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DCC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 12:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiAMMHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiAMMH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 07:07:27 -0500
X-Greylist: delayed 535 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jan 2022 04:07:27 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:65::8:228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21041C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:07:27 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 3F2BA824
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 11:58:29 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=jaapeldering.nl;
        s=soverin; t=1642075108;
        bh=F5g6pH4TZv4smffdpSCFGHYjX2ivS1Rd/VJqAkKAL8E=;
        h=Date:To:From:Subject:From;
        b=WSaWBG3l+5xknhUO4VNEIxSzl17c1GA4b8oQdWF1j3+HP999sU4JMxDmThyANVK33
         aOB0AcLAWDgJDL998iavnuAYDlM4Gm7xuxYYNGzevj4enj0cViwqEZjXvoXDP7seYW
         iQqa2BooN9TvpVZ+R5cGGkAXwXGKsQRdhIyNAwSm2QODqxj92jS+YG7ijdmIDikF+f
         ShrT9YlMQjza3zjSwf6m95TkhW+l2hUb0hyJFKoYpLlqyjfXwmFtd56GdfRxu2ITTX
         PPLvPpQED12rCGoGRTrk80oF0Mc1sNooEhQdLBNxooMvRo2v8QOmW9Le0QwXyWC8PR
         Mn6GP/iZ7RBkw==
Message-ID: <d4bf0749-82f4-2d76-c36c-334a8a19abdf@jaapeldering.nl>
Date:   Thu, 13 Jan 2022 12:58:27 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Jaap Eldering <jaap@jaapeldering.nl>
Subject: bug: git log --follow does not honour --author option
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I ran into this issue, see the output from git bugreport below. I first found it in version 2.30.2 from Debian Bullseye, but was able reproduce it also with a build from the next branch.

Best,
Jaap


What did you do before the bug happened? (Steps to reproduce your issue)

A minimal working example reproducing the bug:

git init test-log-follow-author
cd test-log-follow-author
echo "Some contents." > foo
git add foo
git commit -m "Initial commit." --author "Myself <myself@example.com>"
git mv foo bar
git commit -m "Let's rename this." --author "Random other person <random@example.com>"
git log --follow --author myself -- bar


What did you expect to happen? (Expected behavior)

I expected the last git log command to show the initial commit made
by myself.


What happened instead? (Actual behavior)

No commits show up.


What's different between what you expected and what actually happened?

The --author option doesn't seem to find commits across renames when
using --follow, except for when searching the author who renamed the
file: these are found, and all commits also show up as expected when
no --author argument is used.


Anything else you want to add:

[System Info]
git version:
git version 2.35.0.rc0.227.g00780c9af4
cpu: x86_64
built from commit: 00780c9af44409a68481c82f63a97bd18bb2593e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-10-amd64 #1 SMP Debian 5.10.84-1 (2021-12-08) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
