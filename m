Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3EE1F453
	for <e@80x24.org>; Thu,  2 May 2019 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBUaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 16:30:07 -0400
Received: from mout.web.de ([212.227.15.4]:33119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBUaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 16:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556828996;
        bh=tHqEk7bVBbD3z4eql4X/i7qlnHqs2fpdwry23/O83DU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aq2En1sMxlL8STJv9OJrgSjH9dfj5+IyqYlAXV1BiYwe7Bf2fk1TMelASXPCYyA1J
         1L3JiIEVcl0kuaIA+OVVhOhevnSp2+O+5OySW03nYjsfsf83ugQdAcf3lprqxLybfp
         vLGHpDIT1GauX8a6dcOvbFiograp9Fas8/jc4d/g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.19.151]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MddXQ-1h7vFw1eyy-00PQzt; Thu, 02
 May 2019 22:29:56 +0200
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
 <20190413013451.GB2040@sigill.intra.peff.net>
 <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
 <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
 <20190501180936.GB4109@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <be339f04-33e0-ede1-dbc2-340d7fb6694f@web.de>
Date:   Thu, 2 May 2019 22:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501180936.GB4109@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RbJFsg+zcOIhV+pwzTgBLSow6bSU4CwgVjV3BdCWUfNwBYPYO9y
 ZZF9AXT4MrpWB2LYZ897OMfmKXszBrOLMQuaalWCNVcQhLHCsBs9T2jjFoO+d+lPjXGEd1y
 xlQ1JVkgYtL08vNBpq69QRKIxlz3cBVYPG8gX70MOecDwOJh8j4D2keUYq8OJkxbizMPRsm
 xbBFHZ7zN20uHRYhRVFmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Nce2nEHrDk=:Ago4Bcc9OnF6697MoCdJka
 hSc3wbMrnMXzLj0+cp/BWFJw5lYAmewStCoTG+LBKqDL1+iNmq+rP33MoJWORIUg0zWv6KC47
 giS8Rny6Dn3O7eeCB641WHPFzreIDhBU/R1gK/6X7YqKlbhtnN7dYfGmuUPBYrybbnS+OMTHl
 7soafXCqakuDo6LFAWaV9bhf4Ea5vItx4Ey5TCG/Gvcqz3hqCG8W00H9xFJZSD9qaMx8qH6a7
 Qmi1DZ87XClj0dCFEq8GzSrDEfY1NnnojG8arRguMXDuhyTDUxZI0IaOsN2CppZOa10HWsZem
 miG03OYAhrR+efimyJ4sTYdz+YUxFxcKHRvjfIRJ3rudqIrxnTAzWjNl+dr7Gc2VSkj4i8b/z
 asIHrhbsh7pUMUf1YO8GpnpKHUxpDRayLaUNLLFj3ary0kHVOtIeBx8EgZTE932QN/ANuGzYY
 M5mTx4QPkwa66R2EJgUzfIr3qXvMW1K3CJjF4ka71zatN/zsqYOG82r5AjabAnrRciAXO6b6a
 FvZvRvunzDmyHXhAI0Rb+LzE0f61ec36mGcViTlGunk8eWTYEMmPEMsJlvDRcsWU6q+O/B7OY
 D/MAhjmoH+2g31LWn3z+t519/NHjcgja6T6KI6lQeTda3xQPb77z1abVy7WsiivbjFzyQryFT
 u8DuD5oObAej0+iJ4MMPYVU77ntuMgh8wzlfDcDzLwG/nZsRldNMjf3FWe3MgtJQLYyhAIU+Z
 ov+NAYIFgBR96eK2h4GDow/d0YAqBJg+A4w2VFlHieDGRY+ZqVRebr9DDd1LqXzOwegLO+uJt
 fzaEBn75ANiTIc5WrLR1goGnQIJqN5awhk8cMDq4QtEaLc2Pay+73tXxc8M5EF/SzCHdwAj2A
 uM3XPDNREbQ0Zvn3b2sw7X60+g9QXZsPnzkKnGPlemLpXfL/zTFPWL3Ijy2n55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.19 um 20:09 schrieb Jeff King:
> On Mon, Apr 29, 2019 at 05:32:50PM -0400, Johannes Schindelin wrote:
>
>>> Another is that I am not sure how your "fixed format" argument
>>> meshes with the "-b blocksize" parameter to affect the tar/pax
>>> output.  The format may be fixed, but it is parameterized.  If
>>> we ever need to grow the ability to take "-b", having the knowledge
>>> that our current code is limited to the fixed BLOCKSIZE in a single
>>> function (i.e. the caller of this function , not the callee) would
>>> be less error prone.
>>
>> This argument would hold a lot more water if the following lines were n=
ot
>> part of archive-tar.c:
>>
>> 	#define RECORDSIZE      (512)
>> 	#define BLOCKSIZE       (RECORDSIZE * 20)
>>
>> 	static char block[BLOCKSIZE];
>>
>> If you can tell me how the `-b` (run-time) parameter can affect the
>> (compile-time) `BLOCKSIZE` constant, maybe I can start to understand yo=
ur
>> concern.
>
> FWIW, I agree with you here. These patches are not making anything worse
> (and may even make them better, since we'd probably need to swap out the
> BLOCKSIZE constant for a run-time "blocksize" variable in fewer places).

The block size is mostly relevant for writing tar archives to magnetic
tapes.  You can do that with git archive and a tape drive that supports
the blocking factor 20, which is the default for GNU tar and thus should
be quite common.  You may get higher performance with a higher blocking
factor, if supported.

But so far this didn't come up on the mailing list, and I'd be surprised
if people really wrote snapshots of git archives directly to tape.  So
I'm not too worried about this define ever becoming a user-settable
option.  Sealing the constant into a function a bit feels dirty, though.
Mixing code and data makes the code more brittle.

Another example of that is the hard-coded file descriptor in the same
function, by the way.  It's a lot of busywork to undo in order to gain
the ability to write to some other fd, for the questionable convenience
of not having to pass that parameter along the call chain.  My bad.

But anyway, I worry more about the fact that blocking is not needed when
gzip'ing; gzwrite can be fed pieces of any size, not just 20 KB chunks.
The tar writer just needs to round up the archive size to a multiple of
20 KB and pad with NUL bytes at the end, in order to produce the same
uncompressed output as non-compressing tar.

If we'd wanted to be tape-friendly, then we'd have to block the gzip'ed
output instead of the uncompressed tar file, but I'm not suggesting
doing that.

Note to self: I wonder if moving the blocking part out into an
asynchronous function could simplify the code.

Ren=C3=A9
