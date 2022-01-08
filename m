Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77319C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiAHAEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:04:30 -0500
Received: from mout.web.de ([212.227.15.3]:44501 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbiAHAEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641600264;
        bh=lflL/HoT7YdO59ckSKbYqpOgnvFnJDfByNNVxLQ16qE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I5IXOBxyigZaMpF92OBA+JY4Qehb6Aq7Foe9kRR2wau9Eg+NSGPFUxMZ5r7Ubpkiz
         SuNy+5xvZ1sUPjpmw60CHZCDxKgEOiXrzCwRg3a2ks9cl7GLsOYMsMrCJHXVU+4t3V
         Oswk4QwPyFhIdkNCzKPI4M5fAXtSIHFyL29gqGhc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMp8K-1mpPm00ZmO-00J6i6; Sat, 08
 Jan 2022 01:04:24 +0100
Message-ID: <4f05f434-7bd1-d563-94bd-607858deb1f8@web.de>
Date:   Sat, 8 Jan 2022 01:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <xmqqczl4bhmo.fsf@gitster.g> <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
 <xmqq35lz9vxl.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq35lz9vxl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AcwehP2CP/zSBSSjkT20mmnzBIkNqrC+69OTdxXHWn5UV6NBBSz
 rAUrvG3w2lDq5zJVkXqS/OJ0MRWDswBqzgVwu4LRXwUhrjqCB45kD08jDx6bOuCFAtk38Zd
 Q7QM4A/YpE8cvcuho7wyi69omzC+P8d9oOCaPZCDugNfXVPf26R1v4Meito9et8MpvxwgQm
 KZK6WU6tYWvDb0CKszWbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:if5GX0RdR18=:7tzTdmPMVJxHxnFmt0HjkE
 l4pMtna1wwyQ9TXd7L1PWx+X82QiRtvNnivecrml/B8O9JkJEfTcaZF3cVb0NfDnPxgyrum7M
 kq8Ix7febNpt2aEI2fugKHpiin9S3E/DFoLCwcLRlLPwUPlgJiWuoutrJt/mnZjptsyHjGbK5
 mQRTD3fwFXvHD2eX4pdy+CB5VaaM3pDGUFEuJAiZiR5om04JJK+oXBElXIDkzAfD71PEAbQGY
 ZXkBysBwST06z0mpej9kQK7LJZuyZmzqvFybuHDXvzFhpKqebZ0T0OO3MLoOMgZliPuO00Cx+
 FMHLjaE0AzYnlIRT5w1Ppon8Tcr2Wy6hBmES1/iRlyl/bX0K5dhDywWntEklP23byrnIxvSa1
 7CsV2rd61UslK2+ZF2AmBjSK2qCYb0nmgkK7jY7prqTmuBLs5fp4EG3DQyGC4ZZVsVdRkRey/
 yLazEOuivT5pnPVspjmH8qkAZ5He7GwpJYMGZ/GU4mO0XGXUD9ik3Yu6p+cQRD1CNVfXdSvh1
 WKZAqgBGKasFmmSth1HPZ1Rkvr6lhlaP+szVue9Nvv/vaBAUi184ReZBcWvZz/22PklpyPqBd
 AZoFPppuWzXmAq8p/S4Si/ExR0cJiQuqRiGix0kazhPRrIKfLeBztsfZweBzWN7H9xCv9c0H7
 oDh6aAW6HmGSZ/UoNoboFZIQbJ3xrKhLVMy4ISOKjhM/mK6hmYsjbT/NKYO/FD9/tdBGgVjmu
 0mtye6AbP5VgtwzGYRQMDm4qHTWjVDxhxBs9dQEgxfiVJ4gIcU+OEg5BLoaLjoCJqoHr0Z8/R
 dXmhn96l/hf9rrqzfpX3Kg+aOPG4RYIVCKTUdmhiOXEmvAeoJONt3Go3r5RushBKO2NbqWJaj
 NMes2FnWBVRGc/pp7N69FH4nID99En6T/+Rz3xKfDafbovdB/63MUDO6wLSqGu02UmtLVunz1
 d2oje7+rrgIDSQ/k1O5ig4ycXPKIIQHpfO7Y4gQsh1pzzaiTe1Ce7ZHcARdlTb/tzoSVFyVp2
 een9UL6hcsUB26W6pA3Ne49M/5ERDCCVOQf6FJnMLxOGyXyehiwqwN7js5U9e0jO+5BgqeQaV
 fz6x0ERbnDZsPI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.22 um 20:40 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> I actually wonder if it results in code that is much easier to
>>> follow if we did:
>>>
>>>  * Introduce an "enum apply_symlink_treatment" that has
>>>    APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>>>    possible values;
>>>
>>>  * Make register_symlink_changes() and check_symlink_changes()
>>>    work with "enum apply_symlink_treatment";
>>>
>>>  * (optional) stop using string_list() to store the symlink_changes;
>>>    use strintmap and use strintmap_set() and strintmap_get() to
>>>    access its entries, so that the ugly implementation detail
>>>    (i.e. "the container type we use only has a (void *) field to
>>>    store caller-supplied data, so we cast an integer and a pointer
>>>    back and forth") can be safely hidden.
>>>
>> Or strsets -- we only need two.
>
> True.
>
> When we check a path, we make a single look-up of two bit in a
> single hashtable but now we need two look-ups, but addition, removal
> and renaming of a symlink would be rare enough to matter either way.

Hmm, symlinks changes are rare, but this only affects the register phase
(which should be noticeably slow for the string_list based code with its
O(n*log(n)) lookup per registered symlink if there were a lot of them).
But the final lookups are done for each path _component_, of any file
type.

I suspect that two lookups in (sparsely populated) hash tables are still
fast enough.  (At least I couldn't measure any difference with git apply
and a patch between v2.33.0 and v2.34.0.)

Ren=C3=A9
