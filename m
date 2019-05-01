Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9F11F453
	for <e@80x24.org>; Wed,  1 May 2019 17:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfEARpm (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 13:45:42 -0400
Received: from mout.web.de ([212.227.15.14]:33163 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEARpm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 13:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556732727;
        bh=MjzSObHEwzU6qqrdswoKefVegxaLUWvayrIx7/hAueY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A0COL42UylI0FRsO94aJ3EuJMVZEbLMG3nIckqBohEMRrEsocj0cVgfoTSHLlS8lO
         WJ6qi9aRn2unCqcSdtxJprZINEvESLQl3eA8MaMTPHHE4nh7HhJiiaXpwFlLpdReVg
         CpC3+BBa5uUkF39O+rkim+3S8zGULgo6At4mr9KM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.19.151]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8Ow-1gktaO3jOU-00c8GS; Wed, 01
 May 2019 19:45:26 +0200
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
 <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
 <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
 <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <05e97774-5dd1-7224-940f-e50558118d93@web.de>
Date:   Wed, 1 May 2019 19:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X6jDW9qpnDvLURtGxGbotsLWcMOnQ/4eNvRoDTjJZS7CixoSNNW
 y2zmIAnQ4WKAd0h8PLn/+9su53qC3aG05NVH7Aii9NamZ+sT18zfJmox6K1WZpK1K1BFzk7
 /YtRxYRRHDu842W0IkNYcfufLUa/0DElK6nrPWc7M2eiAB4dt5bPTmZvBVmjBzQQLDpuLNq
 nlS7S2luPbw318RnoXOjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MwMqdIMoGPo=:/8YaV3VSBiubZsQBAU4jjm
 0/JQiBT1IhSz7BpfLcHzIljqolrX1r7MDpmKqLVC2nloBm8EloQS82udKCGmwAP0uQ6uZw04D
 7BzSz955XCC2hYmlyJ2MvMsYEisGSx0wlSZvzxRGv5oNd5CH6LPn5a69OegkyvBv/46bBHSQL
 a+VEav6GFE2ED0vAf5qrel2RzGkl0gt5wOF6MHBDQT+nfT+B8yNIpyuCZZ+p8l9WjWsATEcaR
 /oSyFvCf+5JGbE3p8c7Llag1rW7iyQtGehdvTJf27wY/tXuJrB5CwRXdzGiaBy4dPRS7FBiQZ
 1mPQ78QQ5KnkYl1bBNjrJtj4/q+m8XEalAZO2BtRZhQnYyRTuEhft4keRXpufMT/zoYKpD9qx
 33hwM9dpNY5GYtnLJIST9y8dqhrL2U9rKmL7iDC8ZNCfxacJ6TQ09u68B/7eaB4FIpDqsOhv+
 fOkw9n6ClurMkA0YgcHPha2YnxfW3ftvWkZTtIrk+woVenlEv2N86AwaSeZMbpmFrTigo/Mj7
 ed4sSzzO+zffiM0kZxh9qkutIvIneeM8spSa1sixwBicxpW100ZpZ0V5prOv5AiG3+3fGO/gb
 4K4cy8ULdC5fZaWewk5+8mZ5GsRGKaANb9h/6aBLVksUcbECXBugT1hCVwW09DS3NOU1CL7D2
 3N3tmjf/bDItZe0eaRWgM1y0nCyawXSz5o/lTZuzNCvDsmclPhEPP858Tqm8Om5XzTSCegCVy
 7Aw1kL9PXaMOQgxZNfnCm/nrjuKREyN3w84KHOkNjW4o+QEi17Fqpl7bzgivDd8wqrBOpjOgG
 QjGfdBG0X9ubrTN49sx21crE00Egt3ZRw+T3lPRkHKjS2eB9OXsXOXGlbIVZhikS2LsK/wHzU
 jXNVjqykP+Fl9gVwFgryTQzM2AeJhh91MU5PLp3JERDhHcfRlvCSsc3AHxewHM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dscho,

Am 29.04.19 um 23:25 schrieb Johannes Schindelin:
> On Sat, 27 Apr 2019, Ren=C3=A9 Scharfe wrote:
>> The simplest solution is of course to not touch the archive code.
>
> We could do that, of course, and we could avoid adding a new command tha=
t
> we have to support for eternity by introducing a command mode for `git
> archive` instead (think: `git archive --gzip -9`), and marking that
> command mode clearly as an internal implementation detail.

adding gzip as the 142nd git command and 18th pure helper *would* be a
bit embarrassing, in particular for a command that's not directly
related to version control and readily available on all platforms.
Exposing it as a (hidden?) archive sub-command might be better.

> But since the performance is still not quite on par with `gzip`, I would
> actually rather not, and really, just punt on that one, stating that
> people interested in higher performance should use `pigz`.

Here are my performance numbers for generating .tar.gz files again:

master, using gzip(1):
  Time (mean =C2=B1 =CF=83):     16.683 s =C2=B1  0.451 s    [User: 20.230=
 s, System: 0.375 s]
  Range (min =E2=80=A6 max):   16.308 s =E2=80=A6 17.852 s    10 runs

using zlib sequentially:
  Time (mean =C2=B1 =CF=83):     19.898 s =C2=B1  0.228 s    [User: 19.825=
 s, System: 0.073 s]
  Range (min =E2=80=A6 max):   19.627 s =E2=80=A6 20.355 s    10 runs

using zlib asynchronously:
  Time (mean =C2=B1 =CF=83):     17.300 s =C2=B1  0.198 s    [User: 20.825=
 s, System: 0.356 s]
  Range (min =E2=80=A6 max):   17.042 s =E2=80=A6 17.638 s    10 runs

using a gzip-lookalike:
  Time (mean =C2=B1 =CF=83):     17.256 s =C2=B1  0.299 s    [User: 20.380=
 s, System: 0.294 s]
  Range (min =E2=80=A6 max):   16.940 s =E2=80=A6 17.804 s    10 runs

The last two have comparable system time, ca. 1% more user time and
ca. 5% longer duration.  The second one has much better system time
and 2% less user time and 19% longer duration.  Hmm.

> And who knows, maybe nobody will complain at all about the performance?

Probably.  And popular tarballs would be cached anyway, I guess.

So I'll send comments on your series later this week.

Ren=C3=A9
