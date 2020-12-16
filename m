Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB9FC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA14B22D02
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 13:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLPNcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:32:53 -0500
Received: from mout.web.de ([212.227.15.14]:57903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgLPNcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 08:32:52 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 08:32:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1608125454;
        bh=aRfLgT5d90zlI6xicfRO+9faB/+FogeLXydTe3MW0/8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LnIJ5AXXcwXNpy7Om6gfh95PNqQ6jy9JDLKymLI7SJoCwdoWMmKttg9OYSPPkZ8xT
         KB89sab94EK27uTMNYTzozMBp+w5KS+JYaR1qbETEgEbrdKjlcj1HsnCBKrwaUx707
         xwxD5ZkymxdejWie4mSNqjlyCxwaPWmcNIN3Cq2E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.160.138.39] ([217.6.33.237]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoYFm-1k9KBu1Jt4-00gUtW; Wed, 16
 Dec 2020 14:22:56 +0100
Subject: Re: bug report: "git pack-redundant --all" crash in minimize()
To:     Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org
References: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
 <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
From:   Daniel Klauer <daniel.c.klauer@web.de>
Message-ID: <a46660c3-630c-5573-9ef4-75d273d37767@web.de>
Date:   Wed, 16 Dec 2020 14:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ENFNrWo6I3G7Ov+/ylGR3OqXGOnmdi6zMuk+2bamyS/Med8pv7S
 uAUFl44N3xrARRvjdPKrQ6xumWVn7BI06kztKJYiE4jC5vzVeAZ+0x3c9QsfDdgMaIGKqsZ
 5dnesOflW22PzFt7HffpqLwi0iq3CmCNlKu4FEkl+G77h/cm2ENdxsSV6E/vYvPRIG2lhnf
 QapR2jeG+cyoqUCwcXC5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eHJp/AF0wWI=:RNbtmiVnf820ZfP438t3uN
 /isut+Q0vcnXB4DKtjZg8iHhBwAwBS9xROjO2fosFWqhM+3S1SN4V/YTPMYs/+D/Yovbtocgx
 +EF8BTpkk9VOJFF/L1TGc/+I7HEtlaPpvubp0tKpEw4vsPAZXcdWa+KXMhjLpz/wPaJguAH60
 LKqSPPG8qQTVC8FIW6Ak2+UoUpnECXAr2rZpKqUN+hdmSKLmaC0/7Khm+UDPK4D3aENGtd38e
 WpfwV0gwCoyz2y+Tqevs2HG+bk328ys4Ejw31iJwUjE3OwR58drRxfz+E9Xowb05e2k/2NN9T
 +MMkh4K908fpGAFSzX5yHo6PO3VPdQNOVwfsLgY0Skv0L02m7RqQ/jKkrvy55TYdBue8ElaTo
 EWHtPxPUkBEGQ/M7deP2tbeuzwdBQzq/VI28Afmh4hrKipxP2WbR5vcmZWQ1VDYb8J1IvL8HD
 BhYs3ymLnb1iv8zHaJZsR9m8nr7FF2qodguI15VKvKbLNjqe97LKQUUywIJ8N9+pONdLJelTo
 IlMokiOUgWhWPIqyPN7wGE/zGAxGCTKZG91YacLEKcFEDMpbFA+vYkqYTZ+ovSjKhuZIIlmkl
 kMS2RhicUkz87ymcRYLDNl8PEQFieNy1RRHTVnyaqJJGgYoII35ZFXO6WQV3NpU5mRco9ecTL
 jr2nVeMvg4hZAfpab3qnMN+gme9H90AgDxCMl/WC6WgyWTufOTzTadAUzDK5MjKgYBg/TGxfW
 kKreNtxHQwGzRJ8ZO+jIC3iMVgHdn8eTV6beCgTNUtnbOapED5Gd2Hl5ir3HUcykwJNcwma6W
 cKzStAiOb21GSYClVOIZMsIbHANrafqJNKGxx1P+jD/phv8bELJJcJFLlHW2exBVhTWkZ3DJ3
 4oGZVhV9wbJwWvQ8djnw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.12.20 19:21, Jeff King wrote:
> On Tue, Dec 15, 2020 at 06:34:53PM +0100, Daniel C. Klauer wrote:
>> The reason this showed up is that Yocto's build tool, bitbake, sometime=
s
>> invokes this git command on some of the repositories it downloaded. Thi=
s
>> issue was apparently also reported here:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1803506
>
> We had a discussion not too long ago[1] about whether we should
> deprecate and remove pack-redundant, as it's not generally useful. I'm
> curious if you have any more context on why it's used in that tool.

Background: bitbake downloads git repositories during a build process
and supports caching them locally (in form of bare repos in some
user-defined directory). This prevents having to re-download them during
the next build, and also it is a convenient mirroring/backup system in
case the original URLs stop working.

As far as I can tell (since I'm not a bitbake developer) the git
pack-redundant invocation is one of multiple calls meant to improve
storage (probably minimize disk usage) of the locally cached git repos.
For reference, please take a look at the other git commands it's
invoking [1], and at the commit messages of the commits that added these
invocations [2] [3] [4].

If doing it that way seems wrong, I'll report the issue to bitbake
upstream too. Maybe there is a better way to do whatever bitbake wants
to do here?

Thanks!

[1]
http://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py?h=3D1.48.1#n=
364
[2]
http://git.openembedded.org/bitbake/commit?id=3Dd5d958744fff66cf5286022d78=
cbec1839fca2e2
[3]
http://git.openembedded.org/bitbake/commit?id=3Df8126aaf774186a6eaf0bd4067=
b89c074594886c
[4]
http://git.openembedded.org/bitbake/commit?id=3D7d55491f88ff90a4c16ad87b14=
83d55b1824acfc
