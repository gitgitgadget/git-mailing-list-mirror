Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D379C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiLATnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLATnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:43:20 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09785BC90
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669923785; bh=KtLd6FayAyT2dQD3hQL1BIDdfar347YTLHxwTMoHMbw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=t1U+M/drgkFLm4rPFfZJ36Y6kKGUuz3A9sW6GxVqChROLaXOAhnenVkCOSbP/02h6
         JtDpYsIzQkucF52oVAfyO75dVpGN3yn3mb/V7zk2tkFFCVelBXsua4MJU1Yi8+3ynE
         WCtcOZYxGY5g0fGkGrN06QFZQ8kVuNthE0LcMwHa89eaoCIyiKUx5k6BzCilvzyGbe
         nOgyMI8CulyKYF4q5nmvdAluRFiKrtJ2QovhI1JLFOrIi0m3JmfTMX2jdXVfDmgncP
         sFQtVSeoRSZQvDq38SeWx5Bi/aay4xLBlgYpMaobB4846RNlCKmTygSwqYYIbCKUWJ
         s2mVv6tYvz5AA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1pDntw1QS9-00DeIW; Thu, 01
 Dec 2022 20:43:05 +0100
Message-ID: <3d9ccbda-201b-fdaf-5fa3-224ba10b8c40@web.de>
Date:   Thu, 1 Dec 2022 20:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/3] diff: build parseopts array on demand
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
 <221201.86r0xjgicc.gmgdl@evledraar.gmail.com>
 <572e29a2-3f19-e946-d152-009999651084@web.de>
 <CAPig+cTdSNfWwN-c7R3-MF6ipAD6-7aVjxRK9f9XaKzg4yhhyg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cTdSNfWwN-c7R3-MF6ipAD6-7aVjxRK9f9XaKzg4yhhyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJCnMZVRatu9m8W9x/ZSrFfAvEGEAtswPrKTk0tU5MWC0CWwLCT
 yxUQVSUN89zwM1PzGgJYBomyXzCeUscUE7nXPB409qx1Lr16SBpUjt5w5jEjbGTZ4xg7IR4
 8bLHJkhMUSZp4tjbpgnX6bPAvZeJ5dwZPAn8Ntj4SonWlycQwoS4u4VgU2QRWl9cSYpsS4I
 WM4z0teSm2965tedlg/TA==
UI-OutboundReport: notjunk:1;M01:P0:ZtOVfyuvu5k=;nu9RYhW+6oow/5EO391sDYyKKux
 vjxMjyL8lXSfo00dOwBVm37kaS0ZxQJUBpSRCVuWc1rdlw274YsB717Wf2wlQHbW35kZ8aKWJ
 7UTldD0WZmUVnvIoNKpyfwqK2sv1z5u6d3lvFSjmawZnfFnDGTFdXHe+lXjzQRnMNzG6Lrkoo
 WHOI+ktWqABauXKs+fD0IgGjI42h2flwi9NutM0qaa4bw7MnBTPj8lKF/BibUl5tIF3xUEiIi
 BJ6X8oMvHSeOYlpSrZdck4YRwFYfK5DejtyIYBzm/OwgRgumSUC7LyT+0AZYJ/YJdaEZ21TWI
 OjmkWyaiLeyNsYlxllYk7zHg8UieIS+9PEN+aRRIesleRuxduHZtN8DQDrr9qoazeQ+Y3kVoH
 Gbqwg1XRf10aim/2g/oLr6h3bdZBDlnll4q5ZOmK/anddJdvu6kLwPXOTdpljQo0c8MMorqZL
 xSKDUENEWfdTeYEoohj6dAgFJJx1KMfusrHXWkXBJ73apuks4EF7GCKNe+juMKjA0NJBNfYb1
 bRwUYWstoGty3sycyQd1J9NcHJ/bnPCab9hp7HcUh2NWl0YiNp2opi8otH0esdcxpvC12JcYi
 pJWs7XXlo05AVhpiIbvGkMhlKR9xfWnMHQzEyIEpMmhyzXWDpcuTEzjozzW4DZXI0XMuWBo9W
 lYvAbkX3F8z3gThJoj/Nhlx6cDajB/vm2cpSk3ga9DNpj9W/4mkricApc5mJzcpm6jqqvQ08+
 ULO1Jaf706tmKcdioClw84BmM4Rd7Bz2Ba1iUqx3GQdmIQXPVE3gJJyIcPprdiZDFDeuSVDqy
 I0vyN7qObdYPldq7jScR1HJSZDi4PA9GHJhLc65TcONTHoCN20oMeZhmT6ADVsP+AWJKLjkwW
 WTBVD/TP195DISRcL/z0jROzPgJfM2+HLP0nbOzUS8KbgvWg345ZH322Ma9q4GBLPWvJoMnsF
 uLJ/QA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2022 um 20:19 schrieb Eric Sunshine:
> On Thu, Dec 1, 2022 at 2:11 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> t4205-log-pretty-formats.sh                      (Wstat: 256 Tests: 21 =
Failed: 0)
>>   Non-zero exit status: 1
>>   Parse errors: No plan found in TAP output
>>
>> The TAP error in t4205-log-pretty-formats.sh is fixed by the following
>> patch, but I can't explain it:
>>
>> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
.sh
>> @@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog =
--pretty=3Doneline' '
>>         for r in $revs
>>         do
>>                 git show -s --pretty=3Doneline "$r" >raw &&
>> -               cat raw | lf_to_nul || exit 1
>> +               cat raw | lf_to_nul || return 1
>>         done >expect &&
>
> Makes sense. The `exit 1` undesirably causes the entire script to
> abort, which means test_done() is never invoked, whereas `return 1`
> makes only the test fail. `exit 1` would be appropriate inside a
> subshell but there is no subshell here.

Right.  Here's how I got confused:

What's failing?  "cat raw" works in the trash directory.  lf_to_nul is
not found.  Of course, it's defined in test-lib-functions.sh.  So source
that.  Then "cat raw | lf_to_nul" can be started and fails as expected.
And it reports: "-bash: 4: Bad file descriptor".  What?!

lf_to_nul calls perl, and test-lib-functions.sh defines "perl" as a
function that redirects to &4.  Which is not open in my shell.

But the confusion was at the beginning: Of course it's "git show" that's
failing and triggering the exit from the test, not cat or lf_to_nul.
Didn't even get to that point because I somehow thought the redirection
magic was somehow broken.

So the lesson is to start searching at the beginning, I guess..

Ren=C3=A9
