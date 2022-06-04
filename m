Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31186C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiFDUiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiFDUiB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 16:38:01 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F42250B
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654375057;
        bh=yUo7aswYBnM0RI9jZ9EG02xVRTgpSQeijJy1scXKFVE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kUInxlm+3aXFqcs7z7nUv/FJCvVLl3XfplY/MBMx1ppRNiIFyEjgXK2mY1NF4tjHn
         EvEZ96Lvmj/9Tps8/I5eNDMkFJYPlAEaP0uTctiuGz7EKlSb3b7xeu7kvfih6CpWLG
         q0KHtDueCVAiiiC9VoF5g5vnSOeCcAUlRgZFem34=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZnj-1nMtKe2aXF-00cbpF; Sat, 04
 Jun 2022 22:37:37 +0200
Message-ID: <8a5cdd7a-13bf-b091-e947-657aeb094c38@web.de>
Date:   Sat, 4 Jun 2022 22:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
 <870925774.539833.1654346793623@apps.talktalk.co.uk>
 <220604.86czfowg81.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220604.86czfowg81.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sPobZ5f6H5KbnxyTyuUBuM8Nf/fQZT3VH2sFVJ2DR859LVydY1y
 Rg6QmSlpELRL7xsnJ8QxrFz7Gh2t9jjoXfhC/q+AFxTauTWH9N05o8k9WeGTRVEYj5XgHxp
 OsXy3JLqed+gXAVFZlu7uYt0kEyn7YTszTLX6S4Vl3h8T3r9H6pOu8ZONzBEdpgQSUg05cO
 5H7s9MtAFci4CktKy7/pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pRcisiUeJ5Q=:AnlT7b7/octP4Fnk7KGQ5X
 kQs+qcKWOAe34Ejvp1Oko/pugYDtxoaVMnOSb/1U7eWUXkdvuB6/HJWIvUdOgFokqxieTU/QG
 b9P2W//tsjU59j/33zIEMG1uYxvg/BLhX4gN8htVX295NUa2anJLdYGNfnVGw4vEI4R5V8z8a
 moq2ITbkz/8h+sw9+IwH6OVJsOQh5izmzjFz08gQZLoiOWIO03RhI7OZ/SE4otfx8fZzx8rty
 g0IMtOULmYEOAiCfRod1k83Mf8UhfA0AeHCQgUCVO+ETHeOh8AVzuNOkw6BEEmnRtMyu2H3Fz
 nftsoF3TAOqQ2QR77kPuEBr4K787mNRgdvQqRzJEliRDwGsSem2fMAkbUbR8OHR88Cc3tdSH8
 SJioKijlmfzVWbvEoeleAgkMblcuz3i4mC1szzITNEbzJc3/yYmM1e8uEk/TJ0fTOoMyPg57M
 dySe5uVrvlawREuZgnx++b9AFXxNh4uIY9NODNy9K8A0p3g7tj8KJFsTKZ2jB65I54PtMAbol
 nO97PsieB7oeqZN7QLi79nVfk4V4rNVuW2KiPKDN/luBd3nw/Z67j8tMO67OEh68EWlvqjIkh
 NoRv/KWYnWPswEc4fb6+N9++lCcacHrrDQfYa6HY9a/iI0xQ6+MSDWfCUwyKLn64FfxVgwtit
 lAQb3CyyHFrZuVzDwTIAg/JG5VIQlUEtg+1qvweTgkM/9Fm/PpvANZlzOArt+RNvuy7pcyaIk
 UXSVBweSg6Xc16hi+kz95rTEcOOTI0B6X1Dlw5TromweBZVaE1lLCxOoFiB1ixXGMkSzIxaaR
 UYYa71ztGJgdyKtZuZSj1J2UR8MGfCD587Lhw4HQAmBucZEGdVEA0rajuhTauaMNzCTZfKone
 CQBNcdsXdRb5mBq+0+uYg5ypXWUwxP82tuqiB7geSv1XP8eaSZ6cnUjqTFHbblTdiq7BkXIE4
 GR6+zDAH9/FTNMGEpLhEtAb1kPJ5QVgWyb0VrkdMHmdPPrtmZXg6XdywsnRZ481QXGhgqGmGQ
 3mNglAu5Q0y0dVmnhNzsaIWiMFitzC1aWlZcdWrY/K3Jhx/tPON4JT0ERPqvTyqosxh+jo4M4
 Cyoio9O5r7rD9pDGt3vVky2H+0X2bLK1gJm
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.22 um 18:21 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jun 04 2022, Phillip Wood wrote:
>
>> Hi =C3=86var
>>
>> [This is an old address that I only have webmail access to, please use
>> phillip.wood@dunelm.org.uk when cc'ing me]
>
> Hrm, I just grabbed it from an old commit of yours I found. Consider
> sending in a patch to update .mailmap :)
>
>>> On 03 June 2022 at 19:37 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>>>
>>>
>>> Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
>>> yell at us about sb->buf[0] dereferencing NULL, this also makes this
>>> code easier to follow.
>>>
>>> This BUG() should be unreachable since the state of our "sb->buf" and
>>> "sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
>>> know that, and adding the BUG() also makes it clearer to human readers
>>> that that's what happens here.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>>> ---
>>>  strbuf.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/strbuf.c b/strbuf.c
>>> index dd9eb85527a..61c4630aeeb 100644
>>> --- a/strbuf.c
>>> +++ b/strbuf.c
>>> @@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>>>  	if (new_buf)
>>>  		sb->buf =3D NULL;
>>>  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>>> +	if (new_buf && !sb->buf)
>>> +		BUG("for a new buffer ALLOC_GROW() should always do work!");
>>
>> This is a bit ugly, have you tried adding
>> __attribute__((malloc (free), returns_nonnull))
>> to xmalloc() and xrealloc() ?
>>
>
> Will try to experiment with that, perhaps GCC can be massaged to grok
> this somehow.
>
> I do vaguely remember (but couldn't track down where it was) that we
> have some config for coverity for this function, due to it also having
> trouble with it.

Good idea, but this attribute doesn't seem to help here.

The following helps, but I don't know why it would be needed -- if alloc
is 0 then any strbuf_grow() call will give a nr of at least 1 (for the
NUL character):


diff --git a/cache.h b/cache.h
index 595582becc..fe10789959 100644
=2D-- a/cache.h
+++ b/cache.h
@@ -707,7 +707,7 @@ int daemonize(void);
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-		if ((nr) > alloc) { \
+		if (!alloc || (nr) > alloc) { \
 			if (alloc_nr(alloc) < (nr)) \
 				alloc =3D (nr); \
 			else \
