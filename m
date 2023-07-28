Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5107C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 06:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjG1GMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjG1GMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 02:12:51 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E49128
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 23:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690524760; x=1691129560; i=l.s.r@web.de;
 bh=Uw+YwaupCcX3BnszOQsisnOikVea4BYx6Ww+eNUO4+8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ssn/pDdngLOqG10proCvLQ5ncxAE2V/RVFZpvxVTB0F1HzkCTXNvLEqN7GJn+pyD1rcZZT9
 dt69ceRlGWvM6KLk7MS/jGKDsBNfzvF7oPdO/tdbA4SCf56qOiBMyaNJdpZltpSG79ZRr0Td8
 vjs+mrheed1SNV5FZLIeqYYz0kAVBG8ui1PY5b6SjEUkUo1KeNHIAN5kfCLgjIrPQAXqhwCv/
 1oJl2zzL5L/vZf9ihqRA2b2TOn58a43VFjG266/n3ZgUZfqNUdGz+BDuT8dKBvhlKajLl03Lr
 l2acK9Ss/njM5kfyb1b5XmMOp7ruWFeiOOGomy5nqrWEM5URxImA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1qBR3N3v2A-00More; Fri, 28
 Jul 2023 08:12:39 +0200
Message-ID: <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
Date:   Fri, 28 Jul 2023 08:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g> <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 <xmqqh6ptnies.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh6ptnies.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P56WAw+urmIBpvb75n0ZsxrH5xDfSJ/RKJfEGATOq39i/tYTL1N
 R7bNGqbfWkyHuV7cLRE2JiC9r2qBZvSMaELp2oHWfUpsN1cCLhBFv2szenORaw91gpIaRBo
 PuUrbqeWfO0MNjSCv8BcBIX8EQEkYfLE0U9uImL/ARfaD00zTUBLWAR8ZGBPo8HW4ETcotZ
 muN4Ygv+8qqI1BNMc23hw==
UI-OutboundReport: notjunk:1;M01:P0:nlm/ASAbCfc=;NInRMl11CKefueSS/tw6qd/25wQ
 vrmCwAMhaCFB7yGFISMHUfcZv+mWeNBT6cfcQB8nOYuw1oxIPWbvfuCwbxcAvLQK2PFrQ9VtY
 kZKrypsFS6zFOnI087aZyCI8yOqDHoNIIRbk9q1BgeEZ3j6g2XBWpnwaYs0+Yl3CzQR9/uNdq
 W234yFnTMANNkdO4FUYq8/C2eFWgOn/jkRFBi5VmwpXQBM5Kjb9l8L0Gzkcwc1NutK3c9Ny9c
 1Qk8CRS2X/yjg/VpQLZE2m5I5NrPkfq3b+TTsb22NYLoyDVxWmCAT4pbpSxJLb4SQ/pj5JTvV
 Zu6UDCKLka+JGHrv5JhqELOH+mqpoELTvaWO8UuU5H+lYbHSdOpXJ+OpdMkGJWbCaVtYphpyj
 AwYV9Juj8OlYB/mbvfcVx/QyJ/enNQ1hqiQVMa5dxcO7WXrdphFDu5llxVJ4FsRJQK+Oa0vQw
 kmObM54YsXEQULiC0AjMqxa3V74Ngx9OHXw4Ef6ZmjZm788bCUKyfaOiyTUVyY3XjjIISvH02
 ZnqelYhJUrnxl/dWwriNy/3n17v2mum6O/C4xhUB053s/fp6UU256FuJee6895GWFcbUqTH9C
 WpQ6V+Y0WoV8Wqdl8sKSkLePxcrdILTvE3fFAIx/iFbkpM+1yCWyFzW/CzKLQDfgkgZss+La3
 YRisfio/jC3iOm/E+F+wYNgwCPe3vpvNuemVF+xm9EdIw4dv1UN1lb1O3v8Ci6Lo3QK+J7IUt
 psBnY6NX+pnS+dZUrOVmG52OqSYhRzwINYT+VHw0Hb+2LuN8GbIM4zr5/L5cKacUkCrcMIrxD
 o+pIaZoOby1A8gB/j4KbZLR3HzqMOtZ8gve5NSe5STQi7E1LUafHUsDdexC6nX5B9K081Va0l
 wPq3gzq2BeZiLWC5EBeLjleWRGpdXbSs1vg+NcNPTjC1JmneW2dx7sdKmO5+e93uG+JmymbJG
 kwJKiyJ1iCZzplmn9ChaTZtoeo0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.07.23 um 22:50 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 24.07.23 um 20:51 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> Am 21.07.23 um 22:09 schrieb Junio C Hamano:
>>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>>
>>>>>> -    -D, --no-doubt        begins with 'no-'
>>>>>> +    -D, --[no-]no-doubt   begins with 'no-'
>>>>>
>>>>> Hmph, I really really loved the neat trick to allow "no-doubt"
>>>>> option to be "positivised" by _dropping_ the leading "no-" at around
>>>>> 0f1930c5 (parse-options: allow positivation of options starting,
>>>>> with no-, 2012-02-25).
>>>>
>>>> Yeah, if there is a better way to document A) that the "no-" is optio=
nal
>>>> and B) whether it's present by default, I'm all ears.
>>>
>>> Some options take "no-" prefix while some others do not, so
>>> indicating that "this can take negative forms" vs "this do not take
>>> negative forms" by "--[no-]xyzzy" and "--frotz" makes sense.
>>>
>>> Yikes.  There are tons of options whose names begin with "no-" and
>>> marked PARSE_OPT_NONEG, so "an option '--no-nitfol' that does not
>>> have the 'no-' part in [brackets] can drop 'no-' to make it
>>> positive" would not fly as a rule/convention.
>>>
>>> If we do not mind getting longer, we could say
>>>
>>> 	-D, --no-doubt, --doubt
>>>
>>> and explain in the description that --no-doubt is the same as -D and
>>> --doubt is the default.  It is making the developers responsible for
>>> clarify, which is not very satisfying.
>>
>> Adjusting all explanations manually seems quite tedious.
>>
>>> We may not reject "--no-no-doubt" but with the positivization
>>> support, double negation is not something we'd encourage without
>>> feeling embarrassed.
>>
>> Right.  Perhaps --[[no-]no-]doubt?  Looks a bit silly with its nested
>> brackets, but it's more correct, because it documents all three accepte=
d
>> forms, including the no-less one.
>
> It may look a bit silly but looks very tempting.  Also it is not
> much longer than "--[no-]no-doubt".

Yes, it's quite compact.  But is it they still legible?

    --no-index            find in contents not managed by git
    --[no-]no-index       find in contents not managed by git
    --[[no-]no-]index     find in contents not managed by git
    --[no-[no-]]index     find in contents not managed by git

The last two document all three variants, but is it still obvious that
the help text is supposed to be about the one with a single "no-"?
That's something that has to be learned, I suspect.  No good making the
short help too cryptic.  Hmm, how about:

    --no-index, --[no-[no-]]index
                          find in contents not managed by git

Somewhat redundant, but highlights the documented variant.

Ren=C3=A9
