Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F9C77B75
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjDSPX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjDSPXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:23:53 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CC19AF
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:23:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 33JFL7aK275022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 15:21:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Samuel Ferencik'" <sferencik@gmail.com>,
        "'Philip Oakley'" <philipoakley@iee.email>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com> <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com> <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email> <xmqqk03jcwxz.fsf@gitster.g> <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com> <xmqq7cuamjmu.fsf@gitster.g> <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
In-Reply-To: <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
Subject: RE: [PATCH v2] config: introduce an Operating System-specific `includeIf` condition
Date:   Wed, 19 Apr 2023 11:21:58 -0400
Organization: Nexbridge Inc.
Message-ID: <009c01d972d2$b2bd7680$18386380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIVy0sc+25D1Di5IaerUAOw5H2ySAM7O0uqATR9TiEBK1fNUAMig8B0AjZZdZsBEPH/g65Z5qPw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, April 19, 2023 8:23 AM, Johannes Schindelin wrote:
>On Mon, 17 Apr 2023, Junio C Hamano wrote:
>
>> Samuel Ferencik <sferencik@gmail.com> writes:
>>
>> >>>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>`
>> >>>> is the system name, i.e. the output of `uname -s`.
>> >
>> > The discussion about https://github.com/gitgitgadget/git/pull/1429
>> > seems to have stalled on several points. I'll try to summarise;
>> > let's see if we can move forward.
>> >
>> > (I am the reporter of
>> > https://github.com/git-for-windows/git/issues/4125, which led to
>> > this PR. I am vested in making progress here.)
>> >
>> > 1. name of the setting (`os` vs `uname-s` vs `sysname`)
>>
>> I do not think it is a good idea to squat on too generic a name like
>> 'os', especially when there are multiple layers people will care
>> about.  But I think the original thread discussed this to death, and I
>> do not see a point bringing it up again as the first bullet point.
>
>Given what you said about "Operating System", i.e. that both "Ubuntu" and
"Linux"
>should be able to match at the same time, I kind of concur, but in the
other direction:
>rather than forcing the current patch series to use a less intuitive (i.e.
user-
>unfriendlier) name than `os`, I would want to modify the patch series so
that it _can_
>match "Ubuntu" and "Linux".
>
>> > 2. casing (use of `/i`)
>>
>> My preference is to do this case sensitively (in other words, start
>> stupid) and if somebody wants to use "/i", add it later after the dust
>> settles.
>
>I strongly disagree with this. This feature is meant for Git users, who I
must assume
>based on my experience would expect the value to be case-insensitive. I.e.
they
>would expect both `linux` and `Linux` to match. Let's not make this feature
harder to
>use than necessary!
>
>> > 3. handling Windows (MinGW, WSL)
>>
>> This comes back to the reason why "os" is a horrible choice.  Is WSL a
>> Windows?  Is WSL a Linux?  The same question can be asked for Cygwin.
>
>These questions actually have pretty obvious answers, with the exception of
WSL1
>(which nobody should use anymore): WSL is a Linux, Cygwin is not an
Operating
>System by itself but runs on Windows. But of course that's not helpful to
help
>configure Git specifically in a Cygwin setup.
>
>> The answer depends on which layer you care about.
>
>Yes, this is the crucial bit.
>
>> The underlying kernel and system may be Windows, and some
>> characteristics of the underlying system may seep through the
>> abstraction, but these systems aim to give user experience of
>> something like GNU/Linux.
>>
>> And this is not limited to Windows.  There may be similar issue for
>> systems like PacBSD.  Is it a Linux?  Is it a BSD?
>>
>> > 6. what's the use-case?
>>
>> I think that this is the most important question to ask, and from
>> here, we'd see how #3 above should be resolved (I suspect that you may
>> want to have at least two layers to allow WSL to be grouped together
>> with MinGW and Cygwin at one level, and at the same time allow it to
>> be grouped together with Ubuntu at a different level).
>> And after we figure that out, we'll have a clear and intuitive answer
>> to #1.
>
>This is probably the most valuable feedback in this entire thread: What is
the problem
>we're trying to solve here?
>
>The original report (which this patch tries to address) asks for a way to
have a user-
>wide ("global") Git configuration that can be shared across machines and
that allows
>for adapting to the various environments. The rationale is motivated well
e.g. in
>https://medium.com/doing-things-right/platform-specific-gitconfigs-and-the-
>wonderful-includeif-7376cd44994d
>where platform-specific credential managers, editors, diff highlighters
that work only
>in certain setups, and work vs personal environments are mentioned.
>
>So as long as Git offers ways to discern between the mentioned environments
by
>including environment-specific configuration files, we solve the problem.

I would suggest using match of uname arguments. But there are variants. The
OS release should also be included here as something like NONSTOP_KERNEL is
not a sufficient answer. We should have at the very least, or encode the
includeif string accordingly:

uname -r = the release n (e.g., J06)
uname -n = the node name (e.g., hpitug)
uname -s = the OS (e.g., NONSTOP_KERNEL

We use these in config.mak.uname (except for -n).

Regards,
Randall

