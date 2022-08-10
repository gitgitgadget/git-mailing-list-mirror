Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C12C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 22:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiHJWf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiHJWfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 18:35:22 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75790EE24
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660170910;
        bh=mLblaZ3gb5H6UQByt8iWpmyrf1CxJnK3tXQ096ZWr2c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bKtAgQ9hDBWW4pPJbvbGalJakQlx+VbuMfbA7aI0fKFAx0zo0CobhKFfT1GmoSCXM
         NQovi9JGiH606a4iX7cMF7mIN2FChbsTSzlluJfW9hQl5xeLWtuDL8JjAAo589aQr0
         iAeZ9bUEqDxDAk6yK7NKnSV0eOZ4b5kGiFtu11tg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.34] ([79.203.28.61]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1nItDB3Ja7-0150Zh; Thu, 11
 Aug 2022 00:35:10 +0200
Message-ID: <dee6cce5-6f95-ecbe-1dd3-dd54f9746c67@web.de>
Date:   Thu, 11 Aug 2022 00:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <0e1b8066-3f67-cec6-675a-05d2cf54c119@web.de>
 <YvQMsMv3EhiI/rTb@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YvQMsMv3EhiI/rTb@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tt7G1ij2g3pqgSGumJ15O/45Qd6xHuveEftOVAEOLjxq49vXLpS
 37IxoQapa35LNPCpAH5s01Z/SHvUCpU6irQUenrCdtSIOe+NWnow79Z58A4yo0j9mxlDWAR
 U1mqwZNtNbmEvHpu/s7vHSp6tBbnOwdVqtt2GlMEln9Jx6502k8h+jCAzYkTL5a0GweIm/k
 mokEzi1rphkdAmr0WRlZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+7MbeYFSqzU=:uvZtP9gc9rTrfYXDhUWhd0
 x3WnFLCOw0m3P6wG9EFxWd1q9/7XCH/oEQKX2WThhfa9Xr3Aa5ENN0LOtMWfWnyytsitbdP/5
 CTT6yw00Uv40C9tw8iBf/OdZrZw8LS7oQKXCMt8/WpvVpUeXhxD3+oere2owdEs8rWHIg+nKV
 xsLE6kSvzHptD4/ch65RUTu2S09gYd9xUnXAtDjFZmVLhsN9BkJXXg43EwqFbzMkfwUcb7ZBc
 xk3hl9F2SIb54TegXmnMxmMm63MKcgEIPJmrqVzn5R5r1CYSX/idf/jdnLbhtV6mCmXAQFB+p
 vcxVHxa1zJ6Ulg1sydKHuqFxvEJoOBedrUnpu+fPL94eg+PHyWmfy0R09wY7Nn5J/s2yl8+wM
 Dey1M/dk/JHWFXk/P3yTopxq0RByEYAQn5uiOhNEMl86xhcnLHaFqFZKV9eYHuMk2SudP+z9t
 Fk+CVmCT+ZStL+CAK4hNxbsNNcLSP0s1eC3yECd7D/H1lwFgvCDyPmGhRqLhVzcBcEM9vUO8H
 gRyVozZbGEoGYb9ZECUDYMWigB7dPXQcKzNFTlC5TAbRVEiGOadgbfESJ2HomnG/jJDcQDv/B
 rF3MFzzbwpXKiWqfddfZMQZF1J9pC+Nq8e32EpMLVsBOOP4P0nCG2KoX+afuVC2gkf+8YFSTY
 B63ZC7/nlMsaMbbxJi6ki3vTTLOnWaclZT+aawqdpe4AVZ08MegofyTzQyzEKP95H/Wuijx73
 GQA7YXp3GQxAAvhexYzMQorr8tML7gdk1RWgCqUbHhROAq2Czx9QaqqzGZn7vCO9IJ8bt84RB
 K0v0bDuQ1dfaiUIWIipX96Y9NfCPJq4UvgkS7ewbQPSUykVMqAeCEURUBntls7gWcDiSviNOE
 8SsylRcWp3x+EHOm9r25O1zfDr10HCgvBwwJ8iln3Sh5Nz853Rb2XYvypGKeSxGckdFOluOUs
 AB9PyryFClCeRg/pQ/g5IBjLHsty4RH740s/5f1O0wzXMGgBIVglFRQvVZc5rOR2PVeVBYv6g
 kxj8cGfjvzNrNjIeq8G/TfWvL2lE1LnBxfTri8o0iT1aChCqPXtqYJvXDL60OuOnBsmrtpWlc
 DHjIoesK4rn/r8dPHr7cN69lhF8u5pIORhZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2022 um 21:53 schrieb Jeff King:
> On Wed, Aug 10, 2022 at 07:39:34AM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> So it's weird that you'd see EAGAIN in this instance. Either the
>>> underlying write() is refusing to do a partial write (and just returni=
ng
>>> an error with EAGAIN in the first place), or the poll emulation is wro=
ng
>>> (telling us the descriptor is ready for writing when it isn't).
>>
>> You're right, Windows' write needs two corrections.  The helper below
>> reports what happens when we feed a pipe with writes of different sizes=
.
>> On Debian on WSL 2 (Windows Subsystem for Linux) it says:
>> [...]
>
> Thanks for digging into this further. What you found makes sense to me
> and explains what we're seeing.
>
>> The two corrections mentioned above together with the enable_nonblock()
>> implementation for Windows (and the removal of "false") suffice to let
>> t3701 pass when started directly, but it still hangs when running the
>> whole test suite using prove.
>
> Interesting. I wish there was an easy way for me to poke at this, too. I
> tried installing the Git for Windows SDK under wine, but unsurprisingly
> it did not get very far.
>
> Possibly I could try connecting to a running CI instance, but the test
> did not seem to fail there! (Plus I'd have to figure out how to do
> that... ;) ).
>
>> I don't have time to investigate right now, but I still don't
>> understand how xwrite() can possibly work against a non-blocking pipe.
>> It loops on EAGAIN, which is bad if the only way forward is to read
>> from a different fd to allow the other process to drain the pipe
>> buffer so that xwrite() can write again.  I suspect pump_io_round()
>> must not use xwrite() and should instead handle EAGAIN by skipping to
>> the next fd.
>
> Right, it's susceptible to looping forever in such a case. _But_ a
> blocking write is likewise susceptible to blocking forever. In either
> case, we're relying on the reading side to pull some bytes out of the
> pipe so we can make forward progress.
>
> The key thing is that pump_io() is careful never to initiate a write()
> unless poll() has just told us that the descriptor is ready for writing.

Right, and Windows breaks it by refusing to write data bigger than the
buffer even if it's empty.

What does "ready for writing" mean?  PIPE_BUF bytes are free, right?

> If something unexpected happens there (i.e., the descriptor is not
> really ready), a blocking descriptor is going to be stuck. And with
> xwrite(), we're similarly stuck (just looping instead of blocking).
> Without xwrite(), a non-blocking one _could_ be better off, because that
> EAGAIN would make it up to pump_io(). But what is it supposed to do? I
> guess it could go back into its main loop and hope that whatever bug
> caused the mismatch between poll() and write() goes away.

It should check other fds to let the other side make some progress on
them, so that it eventually gets to drain the pipe we want to write to.

> But even that would not have fixed the problem here on Windows. From my
> understanding, mingw_write() in this case would never write _any_ bytes.
> So we'd never make forward progress, and just loop writing 0 bytes and
> returning EAGAIN over and over.

Right, we need to teach it to break up large writes.  It must make at
least some progress, if possible.

> So I dunno. We could try to be a bit more defensive about non-blocking
> descriptors by avoiding xwrite() in this instance, but it only helps for
> a particular class of weird OS behavior/bugs. I'd prefer to see a real
> case that it would help before moving in that direction.

Makes sense.

Ren=C3=A9

