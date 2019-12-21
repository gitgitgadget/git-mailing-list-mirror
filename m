Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6DEC2D0C0
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1D72070C
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 12:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLUMAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 07:00:45 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:52890 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726768AbfLUMAo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 07:00:44 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Dec 2019 07:00:43 EST
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1iidHh-0005DY-F3
        for git@vger.kernel.org; Sat, 21 Dec 2019 12:51:03 +0100
Received: from [10.20.10.230] (port=10754 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1iidHg-008lhG-7t; Sat, 21 Dec 2019 12:51:00 +0100
Subject: Re: Cygwin git with schannel ("native Windows Secure Channel
 library")
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keith Thompson <Keith.S.Thompson@gmail.com>,
        git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <CAAHpriOh=9Mh7_moxWCzXBHYTtNi9TOQQPBxa4CX=uLgOnpNtw@mail.gmail.com>
 <20191220231840.GD163225@camp.crustytoothpaste.net>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <236e2b6b-d1ce-b0f2-ff56-4ca5e0dfb8e8@drbeat.li>
Date:   Sat, 21 Dec 2019 12:50:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191220231840.GD163225@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20191221115059.vDMuMR4Wwt1hra_PxWtIn8HgZ7E6rprv883DUsu8iWc@z>

On 21.12.19 00:18, brian m. carlson wrote:
> On 2019-12-20 at 01:52:04, Keith Thompson wrote:
>> I've posted this on Stack Overflow
>> https://stackoverflow.com/q/59381061/827263
>> but I haven't gotten any responses yet.
>>
>> When I install "Git for Windows" on Windows 10, the installation
>> wizard offers the choice of using either the OpenSSL library or the
>> "native Windows Secure Channel library".  (Whether that's offered
>> seems to depend on what's available on the Windows 10 system.)
>> I believe this is referred to in the git sources as "schannel".
>>
>> Is there a way to configure git under Cygwin to use the native
>> Windows Secure Channel library?  An ideal solution would be a
>> modification to my .gitconfig, but something that lets me build git
>> (and possibly curl) from source would also be good.  See my Stack
>> Overflow question for more details, including some things that I
>> tried that didn't work.
>>
>> The problem I'm trying to solve: In my work environment, I can
>> use Cygwin git for local operations, but I have to use Windows git
>> for anything that talks to a remote (push, pull).I'd prefer to use
>> Cygwin git exclusively.
> 
> I'm not 100% certain here, but I believe the answer is no.  In order to
> use SChannel, you'll need to link against MSVCRT or a compatible
> runtime, but it's not possible to link against both that and Cygwin at
> the same time (probably because they both provide the same symbols).
> 
> If your constraint is that you need to interact with the Windows
> certificate store or such, you could see if there's an OpenSSL or GnuTLS
> plugin that will do that for you and then build against that library or
> plugin.

There is the OpenSSL "CAPI" engine which interfaces with the Windows
CryptoAPI. However, I don't know if the Cygwin OpenSSL build includes
this engine.

Cheers, Beat
