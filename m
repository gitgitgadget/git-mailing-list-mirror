Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6968C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 21:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBOVxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 16:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBOVxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 16:53:16 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 13:53:15 PST
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8226252B2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 13:53:15 -0800 (PST)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id SPRqpBdETl2xSSPgmp0UBv; Wed, 15 Feb 2023 21:51:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
        t=1676497904; bh=jiddagA5agCOfKDG05u5vbwkF3ss54wjAhmEC715bJQ=;
        h=From:To:Subject:Date;
        b=byYYvQXzJFILCzi8pihZ3pgj65GfW1mVWM6NNwEBq5DT9D1vn1H6Bf0RF/kqm7DMm
         W7YPh11npgspGJrMLU0uda1w00W9cUd5cHk0UCyIKVOFhju+fHFH+WI4CjHFv/9ssz
         kT/EbSi6p43ekojl0RXikfHiT4+2Goz9HGeLbs5gzFlxy8In8X5jnzdd4LgKSczdHx
         ZqqUIEVKhYFLsa+pm061+9hacfX/8pXXp/LkGxQQXAUX/E/WKXY0KXJIXihxnZG6oe
         jr1xu7s4Z2kfenVJPucY2KdK3BBXNfl09K6uMqNx4j0x8MTYPRonny8M1EDazi4JTU
         /nM3AHwxhu+dw==
Received: from localhost.localdomain ([184.64.102.149])
        by cmsmtp with ESMTP
        id SPglp0hBRyAOeSPglpcJON; Wed, 15 Feb 2023 21:51:44 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=63ed53f0
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=VwQbUJbxAAAA:8
 a=c8w18QBM2t2KRHc8AScA:9 a=rQFNUccIKK0A:10 a=AjGcO6oz07-iQ99wixmX:22
From:   Brian Inglis <Brian.Inglis@Shaw.ca>
To:     git@vger.kernel.org
Subject: manual option --inline --no-attach override required for format.attach
Date:   Wed, 15 Feb 2023 14:51:13 -0700
Message-Id: <20230215215112.62559-1-Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMkfqrVOFnrpR2lhLnA1CBSnOYAF7f/pZOkiiffPiKw68FTQaJc0pP2w+cccuk3V9a8TNYTBChjl5z0VVb7UY/udVukixd1yTaVtqEjdH2+8pdwvdoBa
 oXB3aDyz3L7299Ntwh1G1KHPCNZzS4FfR7sZEzvCeHJgvlru4ndWoAxYRvBaDFews59RjynTYuKYqIXhTX9CHpHlqyx4pkVPomH0pyQ/7KLRVR7bEy30s3fU
 3HI0n+fIGDudfC9fQOc4tA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
git format-patch --inline ... --to=linux-man@vger.kernel.org
git format-patch --no-attach ... --to=linux-man@vger.kernel.org
git send-email ... --to=linux-man@vger.kernel.org

What did you expect to happen? (Expected behavior)
linux-man maintainer would get patches inline not in attachments as expected

What happened instead? (Actual behavior)
linux-man maintainer got patches in MIME attachments which he could not use

What's different between what you expected and what actually happened?
using format-patch either --inline or --no-attach would send patches inline
need to remember to specify format-patch --inline --no-attach for every patch
there is no way to set config format.inline format.attach=no

Anything else you want to add:
initially found format.attach set in /etc/gitconfig and no way to override
would be great if linux-man maintainer could set repo config format.inline format.attach=no


[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: CYGWIN_NT-10.0-19044 3.4.6-1.x86_64 2023-02-14 13:23 UTC x86_64
compiler info: gnuc: 11.3
libc info: newlib 4.3.0
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
