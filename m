Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521EBC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F452072D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 16:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pVx4ymk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHXQGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:06:54 -0400
Received: from mout.web.de ([212.227.17.12]:39189 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgHXQGu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598285202;
        bh=XPgJ1Q7rl8B6ouj/1WTWLh5LMWz3gx0QT6nK6Rrsx90=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pVx4ymk/2OrV9lUPdWetlY27MBQOyRVoT9/l1uKzYKMo/aCj1lnybG5ok4k6IlGuR
         vcyOOnVQsGVned8moK5bnYTyZvPDopXt2ngXP0jgaPWpJgkJI2YpuxJTzbU77r+RKP
         ASmaNy55Pf6lNVEJYJGiRZ5Ie+MeNjLl7IRXcayg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjFg-1kXi7k1W5i-00y2Sq; Mon, 24
 Aug 2020 18:06:42 +0200
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
To:     Ori Bernstein <ori@eigenstate.org>
Cc:     git@vger.kernel.org
References: <20200823005236.10386-1-ori@eigenstate.org>
 <20200823031151.10985-1-ori@eigenstate.org>
 <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
 <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ef92391d-09ef-4c27-e6dd-ec7b907174fa@web.de>
Date:   Mon, 24 Aug 2020 18:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+mxtYzaFR5qu2qiDdiasYuW59yiQOV00z/7hrRLR5FDyxwzH2E
 S4sYEn0IOA9jJverHMON+dtSI47iFrbwEytnqq+KLRXCvD9tUzP7Btf+Zbssq/tFbpVHuHy
 2AVd45t4NpZgNNThjnXmfs5rYrNvEJ27UgGF7ItljfcGcp9n9peHgLTDqk692eXbnszMnHy
 PLhEpWx9txlnGj4tMbk0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WoqJYZ7RE4=:J6aUnT8/f2uSp92Bz7/Kwg
 grBFBuDPbypcsd8zq1SLfBtV1wNQ+PyroQ0AXZiHSdKPTUTpnyWeA06OTanc7Zwag7gP5zzK3
 R1bBzc3dwKAZuSdVuRAJJ1fZD3nNeQqBLS+B5qBmk+N7tS49KVqvDfPzIhP6j0C8iPLEu0FRq
 MFy1s904bjLZiUMmF3XVGZ3rncFMsxSkfABLMXX9YaeXlccHFHoYGAnwk08N++RRqlGrSBEw8
 MoDQBB9481xphIFgPGuboCKNT43VblGnjNahIN5nQX6yVmwQRWprHs/GNPQaaa3rcCSRXzTzm
 /T1RqFDBzkp4SlFmvQaVTeNVl6GTQ8m491Lq5Y4KrGYmunLOGc/qyiCY3ZDe9Y0EyvpdTMLVs
 PTHCjkMD8fxLLbdmIHcSFm83Ew3vX/iVN6bMdZGBA1rEqNyoP4uptAA8vd/+KvMkqmDcoGm31
 sHTp7CD9p8YfnepmHMnjVHA0unwD09r9ZhhLfahFtmk95PkiBuuDz+BkIcW8Kk0PP5sSE29Pf
 RLHiq9FvOgOuMjJvDaUNYLwqCZ02X0QnCjsi6RDsd41e2ckW5Jzk4TFLmTiz2EGBOlvIyWXCq
 ajLLP5uudk6/RIG6gl9rASFWPuTd7OZFltllHFy8MtzN/SCgjozwQV1GaVKnlNFo+YfRalakM
 OlnCw/Zt24qKqJsZ9JV0/TMxaOqxSPpi3QnUfpyBtUUGgqfeNBL1T/KwjcuPQOPZDd1kBtEk/
 prIK7YYpIcZ8yEwDFuzCznTEdX57rH3CIJsRt03FsWiET7E/MNHyHcIfuwaH3Bl1aGBCjcNcb
 4qbMwOYMpCP78W4oojcdwB0Rnc41gAo70NkfV4X0bhv8uuGwGqq4IgF+tgoQDrT3yCIJ6W/h4
 DAEWRZfk6gjvUhveG3FxC/xiH6EiVX5XBl0HvZrBohoSoO6bVQNBu/SKOHcyma3a88OpzIoLH
 wGJQw0tMy4IxvZYkHlxs9OVzVR4pmFdOXNmgLOqwEK0qatGSY44rVrCvsisAOhw8ykqsQvOsV
 59chfzcQIQayP8nQCoqMYtRFCTGrT5YZUlM8XodHz5gLI01rw5qG1M2BB8OhCmr9/eXIUIEfG
 DIsIkvcsuJRt7lpMRXG86y28GG+YJ+5wu/EmXH6Tl82GPKsEvh7vzf41FTuNXOigbKO0I6SjJ
 9nffQZ0nlN0AS97FGqQrk+Ud00Uwr0EEPq0BFL+Hd/s+2gPkuW8Kvudc65lMfIUjERQ5T9cCO
 FVsW0miRhk4HDCVHZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.08.20 um 22:41 schrieb Ori Bernstein:
> On Sun, 23 Aug 2020 08:26:14 +0200, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
>> Am 23.08.20 um 05:11 schrieb Ori Bernstein:
>>> In packfile.c:1680, there's an infinite loop that tries to get
>>> to the base of a packfile. With offset deltas, the offset needs
>>> to be greater than 0, so it's always walking backwards, and the
>>> search is guaranteed to terminate.
>>>
>>> With reference deltas, there's no check for a cycle in the
>>> references, so a cyclic reference will cause git to loop
>>> infinitely, growing the delta_stack infinitely, which will
>>> cause it to consume all available memory as as a full CPU
>>> core.
>>
>> "as as"?  Perhaps "and"?
>
> I think I meant 'As well as' -- will fix.
>
>>
>> b5c0cbd8083 (pack-objects: use bitfield for object_entry::depth,
>> 2018-04-14) limited the delta depth for new packs to 4095, so 10000
>> seems reasonable.  Users with unreasonable packs would need to repack
>> them with an older version of Git, though.  Not sure if that would
>> affect anyone in practice.

> Is there anything you'd like me to do in this patch, other than fixing
> the typo?

Please explain in the commit message why 10000 is a good choice for that
new limit, and what users who happen to exceed it can do to regain
access to their packed data.

Ren=C3=A9
