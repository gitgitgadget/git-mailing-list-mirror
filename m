Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F95ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 08:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiIHI75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHI7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 04:59:55 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC424357EF
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662627587;
        bh=Qd6+5a8EgXoIvQuIpRIqSgzLCjqH0N8+vMsNSES+l10=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nmgYeFSiXxcx9M3rfXwtx+Wf1sCVFLTZiS6IswRdWYdynzAN+ZixLxfiMpX1BdGF7
         BI/y4V0PjJEGyURNcE8u1xIcHCfoSUhH/gp5IXmeIUASo8rC8cdUkNV5BOC/jlLh22
         o03Dup+cNZqzVOfGT+33rT4RboSVDuPFJbQIn96o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.25.52]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6bD0-1pQlGX24zu-018LfN; Thu, 08
 Sep 2022 10:59:47 +0200
Message-ID: <2d839209-21e2-b05c-125b-57a9c1dad1ea@web.de>
Date:   Thu, 8 Sep 2022 10:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <xmqqwnbv7trp.fsf@gitster.g> <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
 <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de> <xmqq7d2fywvr.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7d2fywvr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Be+Eqw1nSqL8LahEa2KT0HyfW0U6qwRy4VWMVYsFCjismsNfvW
 ydBWbzWAP9SAc7E5yUUoEGw7MVx56omgCFOJjUSDHZqVI9l1RoeGXriiHQEoPxsn5JvlOSs
 zWdP4SsHT2a0cQp9+PA1TxyFChyuT+WJJzkHy5/WOOYrZcPo1g22+Y/WhsfFDUD3fmJDoZ6
 VPtH7MfK0fVNr67pRy1/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XI+xv4qeq+E=:vgZ5Uz7nsNTz+uLmTTgajh
 YQQDUbA201/LJJnlRQA1NM793cxNcI+HYZUQnFyFz3LFFi2hxuAszvX+EM7Pj11TltHCxHLbd
 4Mp9wSRTGwaWIV6sAqvl/6Yd+fUo0E3C99Y4hDZ0KQPYgp2iQUBgwcyWjeE78NjX/xgC4C00M
 MUN+Sm3BGRs+aatFg/wYrIGuS6tv6L/ilHF5eDOWjVKB4SF4cIESXbZyE9Ex/B7rf52Vtmmc+
 gc8Dkc7O6GNooa7EBrJPwn/qII8b97gvL4bdQFrEL3/CoUkvzVFOB2hFVE5D0CEZt20+bfzvE
 pt5+rTfslrKfaTpqmtrqdruFkt33RgLdfizgQMQMX7I+TCzZ5jIbquUveExLuionLPeAAXXh3
 LWe/JvPLGJXSg42PPzNVeARTIUZC8KZjWnWlwRtNLBjT5OWVFicJyDugqSRb72YgAdM4LeNqW
 LLaDZ0fNP3X9Ig8+vR25fg/5axdZRZlIciV6KbFvM9yboYxCwozJs1sIQ9vAufjldcneP7Uff
 2/bypg26Y75jKHw9+UWKerxkoHMddR7scwWXgcYpqDciNcSxM7yZRP8K6Rn8TEu4jGjk467Wa
 IjRz8pVdVamcD2G8V+Fsk7vG6Ge7dxZR12CndGPUIKdXdk93XHCsTX+E1K6L96uTo6S8im55s
 KBTK1k41WVBh/gvinTTM8Xqyv69Ered8Cd+iGPC68b/J3xxSsEURa8ajHh2m1nUKVJQ0sBAx4
 j9L27DMwZC4/BCE7mfwKgdvSrbJiOCbxSBevCpUSugseeqafgBMKwPvf+iiCcSfS060EK63BW
 fY61ETLAfzvA2wPXJCdqeZ5O+U9kLiDhFwGnoMmcIyU7BhHqrVyH8lp/eMQb73n8TETjs11Ot
 sd8tAEBEyOUi7Or4aMdMoX0YJi2TpZYOJdAK79kKrWrua8xVVtyqOJ7gma6FbAAWtjro4qX+b
 wi3QbQVfZz2W/CTA04E162SPCMUaam8sgF7/1R7WwZ3cgbBGqhRhqsJmQ8ZQrCzY/qO/n8X8S
 H9jtDICSMUEGETYfgUAk2ds/S0ZwoE1vNY1y8qtazjy8mnUir/7J8W9pyrD9/W0Q6Rbpw5Z5t
 WaCee0Lwqy8ekLhtEOXh6usuR/wpxb4z0zdJLDdbV5pVEqOY7JV2AyCLxOq/vKdM456pIke+s
 j6nMk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.22 um 18:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>> But otherwise the idea is sound.  We compare them line by line,
>>>> using strbuf_getline() to ignore differences in CRLF and LF that
>>>> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
>>>> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
>>>> input different, we use "git diff --no-index" to make the difference
>>>> (and unfortunately more, as it does not ignore CRLF <> LF
>>>> differences) visible.
>>
>> Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even need
>> to wrap it?
>
> Hmph.  That surely sounds sensible if it works, and I offhand do not
> see why it shouldn't work.

Using git diff in test_cmp and using test_cmp to check if git diff works
would become a cyclical dependency.  Only doing that on one platform
limits the potential blind spot to platform-specific bugs, though.
Enough to go wrapper-less?  Not sure.

Ren=C3=A9
