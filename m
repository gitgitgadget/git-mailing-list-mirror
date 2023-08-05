Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4ACEB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 10:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjHEKkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEKki (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 06:40:38 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030FE10C4
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691232029; x=1691836829; i=l.s.r@web.de;
 bh=27fksUmt5HxWOFJjJASQEaiwy7Ujwn0o/4G+puHOetU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=R8oDzsxiw6gd4cUntAAIrrIQ72asr+H714yyOBWXon5Tj3NQ8hCMiMeyUqyla++FRkKmgAK
 qyLIdkapsJOAKeYb8ICYdz+Cx743YZJNmd/YnN8TXTv8eA7G493PMva7H7fav3QyLy42IyvKy
 fSUu5EARQQRbmETlT2e6jeikjoPfP5QF37C9Qo4eSZR7QgrL6vopMzNpxQlqZcIEX4mpqZPml
 DMP29McjCl5UstkAWzsdpRmFT7eWaQaXBuF9JgJu6gD4+UWMNf2m7fOnQpny0B4mmCnBuA3/N
 532tSU/fvZ+mbYwKHBGc4Lfl/8ivVaP5gpJ2M8oLPdcc94I7qBaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1psLWa0zZN-00aWeg; Sat, 05
 Aug 2023 12:40:29 +0200
Message-ID: <67e28f23-abd7-01d2-a1a7-18befc86a21e@web.de>
Date:   Sat, 5 Aug 2023 12:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g> <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 <xmqqh6ptnies.fsf@gitster.g> <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
 <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
 <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de> <xmqqjzug14jo.fsf@gitster.g>
 <xmqqbkfm3gne.fsf@gitster.g> <a9d51bb4-2897-c4ca-f8b3-85f50902b041@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <a9d51bb4-2897-c4ca-f8b3-85f50902b041@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zv1bUsvszHgi6CLR6VfKDXqa/l2mNunfbJFDHyXx7WO1Ebds3GV
 b/ZMCSzebWBVoZncoWgIFNaTF4++lQVlS1ZjLS4BGTfURTlpJgtSsvOTFiXzQJ0R3VIxS6q
 GkRBvRq+9E0vVZvnwxDrjloaJQ3GyRqTPgSZ6iIrcGeDnEqa9SHFR3OhJvGvs2MAZ89AwUZ
 IhJQOspLUxTuzmdQSmkgw==
UI-OutboundReport: notjunk:1;M01:P0:F3Cp3GG24eM=;isjDzwImXw6L9ESAGMNsWnl/ipj
 G7taC/cnDD9/YaVa88h7gBln2OwkOWGSJ06mtbq5EiyvUPu3lBvED3l9N0PqrNfk1OPSaYvuZ
 Zk1yvAJMtK2DhC/PzjFutpKtuW2d2VuVx18B0oFfIPqfI5Ozj6Rd4vDegPmMmWHLjmzBXEE58
 2yU+61ChpJNscvv8rxT1yVxHehDYLA7u4Edr6YKBxXMTxsDZ7WcI3S1xlyV3oFcIVP2P9CmqF
 vhnDd0kNqDcO3YI6pszCxfUfYyeupfZlkbJX9T4UmyC0f4txA6McIpcpzKDfg9xJHGhqzuG+I
 LqX102oRwD6y50CfiLyUW9ahCff1ABTsuN4P0PhPhioq7SWcWZTHe3twidn9Gp8w1B5HpbyAI
 9tWSYfK/Xq0++n3oUT9cUIljI4+BZe0VPKwCgJpNyheoUWX9mLDbuXLYG8Ene0OspEAGQqzSh
 5usaLmBu2mbC7sWREyuNGCHg7fderYVoIHAILjSZJM72Hid+fI2xzQZ5LkF6RbLSLxeiVCeeu
 MIm8A9BoRQOcVRxLeUBNz1L7UsubIA/hG22iScIuARCMrcI4MPp3ZB+fSGU3YEz6kEhGsEuON
 XtTEQU0xK0WMqigxoWoYatmS9b+VRjeFI0boeWmHVRAPoJcX5t41JuoxQdZDDdnu9EGZA0W5z
 vKQuTG9CxjpyGUOSp6dVUc4+dRu24jsGqiLoplPAhVMsE2HgmsP0f1NZl9RONU2mxbp1DkaS9
 m1vYUdlBoduPeM/eLo6DJRTsKEjCxI/IR69RMbntazVnW/yWCRXa7CU/1Svp15ePGYSnY3/wj
 wryqgbFQdw32lwAvCCD4Ka9Mbix0NVluGW3/2xSS1qECkmVLnKiBQYq3PjHm1Zs74L4KS8jaR
 Dp7tQf3wv0wCIgptFCMBzkJslU8oPVbfvQQGl0MmL8wPqmpIXY3Qji1OF1L3e2ij2hXejTYnJ
 MTOAyw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.08.23 um 21:48 schrieb Phillip Wood:
> On 04/08/2023 17:40, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> A bit more verbose still: Document the negative form on its own line
>>>> with a generated description -- requires no new syntax:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 -v, --invert-match=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 show non-matching lines
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 --no-invert-match=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite of --invert-match, default
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 -I, --no-index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find in contents not managed by=
 git
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 --index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 opposite of --no-index, default
>>>
>>> I would expect _("opposite of %s, default") is acceptable by l10n
>>> folks, and assuming it is, the above would be a good approach.

The ", default" part is not correct in all cases, though, in particular
when the default depends on the output being a terminal, or arguably
when it's dependent on a config setting.  We better drop it from the
generated message.

>> I was seeing what is likely to be in the -rc1 that will happen in
>> next week, and noticed that this discussion is left unconcluded.=C2=A0 =
I
>> am tempted to declare that the latest iteration that shows the
>> negation of "--no-foo" as "--[no-]no-foo" is "good enough" for now,
>> and leave the above improvement as one potential future direction.
>
> While it could certainly be improved in the future I think
> "--[no-]no-foo" is probably good enough. I definitely prefer it over
> "--[[no-]no]-foo"

Generating help lines for the opposite variant of all negatable options
feels quite spammy.  It almost doubles the length of the short help
because we have so many of them.  Doing that only for --no-... options
is much more compatc because most options are positive:

    -v, --[no-]invert-match    show non-matching lines
    -I, --no-index             find in contents not managed by git
    --index                    opposite of --no-index

>> Objections?=C2=A0 Otherwise the 5-patch series will be in 'next'.

Patch 5 has a trivial merge conflict in t/t0040-parse-options.sh due to
448abbba63 (short help: allow multi-line opthelp, 2023-07-18), which is
easily resolved by adding --longhelp, and a silent automatic mismerge of
t/t1502/optionspec.help due to c512643e67 (short help: allow a gap
smaller than USAGE_GAP, 2023-07-18), which requires removing three line
newlines.

How about dropping patch 5 for now?  We don't need to rush this pretty
intrusive change of output.  And the first four patches are worthwhile
in their own right, I think.

Ren=C3=A9
