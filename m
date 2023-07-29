Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE5C001DC
	for <git@archiver.kernel.org>; Sat, 29 Jul 2023 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjG2Ukc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2Ukb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 16:40:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860B272A
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690663221; x=1691268021; i=l.s.r@web.de;
 bh=FTRslYJNtM8CxxDXxBVK6GQVwDmQYvDbuMwk4lOVf40=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CUEjqyLtFk4ggV5A3i3Axv64/IPmjYTXzSWUmvBWNlOBxUktpR7+7ykg372gI7uE7zGNYIw
 xC+HCD4Ugxb2mFZzz+76SEd5hmIazc6gTj9BcpW+iOF3NJZQ04fC0nVwKlIsD07yNit2cexGY
 FsXF6ijVYpRdjznDKIOs08NB849hS8piztBXUTZifaD1Kf/ng0qudPOmTj+t4x22NqdIW/289
 RWV7gR/2ZGcbxaUjS3jVntjcl2NXscP3Zm8Pt3N5CepTfmb4WmHVpQlGDeuKNDGxY1CW/ffYc
 dYLOvmbPi14xv9mqAHCfA+eKY2H/KmYNSkOYktoc8MlKVF/Q89jQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1q0eO90Qsm-00lRAq; Sat, 29
 Jul 2023 22:40:21 +0200
Message-ID: <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de>
Date:   Sat, 29 Jul 2023 22:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g> <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 <xmqqh6ptnies.fsf@gitster.g> <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
 <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nNEAdbycipdYU8p17ZDcfa9ufhopLwfWoK8vMReGlprsvvavlvm
 tnLxEbYIcX3b7NhgGIQUG+9GNJMXcPbEFXc31z365Sor+12D9+kJGcjkt/K2kU1rvcveBli
 UBexV0OzoqV/uya/vnvw0o4XqZLuc/3XWJmv9a1X9aVTznOyMxBs1ovRXwgsZkk6Ewjf8E0
 MCbAAIFx+GDcw9QJPPScA==
UI-OutboundReport: notjunk:1;M01:P0:Aum9VcH4Zf8=;ldpo+GWE8tJvh8DK8iyks+ZeAtK
 jzuyqp5E2CTSG6Wd5FeFdRhHL5Pkjs796C1L6XJoc8wOBLx8t8kcsjnI7fWKdfnQ4/kpNSVb7
 SR88YsboUjQ21a7yUbRtiHxEKSbtMa5sEs6uT4oKRQNiLgga93cUflEg2s8gZd5tQXo1cRIUH
 eO/yGRMK+sYupWApA+3ugBo51eLyqpl85EVaLxoJvPLhHW/Sr4iGQzxXL+ApXiJJYkCRdLp8N
 R8wC2RWL40KuFKoOM8W8YVztrwB1n7+wobz6rqhmVlQMtCtOPwA35H+7Pk/FHdbV9H1OQ0ZKL
 9xjpuO/gFscd8nUepdlVnewN8565iKfHXTkclciUIegHjRnBUp2Be9md7cikUzMVBwK4VRYpH
 65afU9hdsiOPrZN7QqLRS52zPiH29mEDPmtX8fsRZwx5OOCzGLhVqM+iMKnUZx+gvXijVH33S
 LQ1CTvuv3psFOULefgsQRbVILuQ+uXRWADu8HaozdDzI0FgDUg66RAO4h6X2A408RW7l4XYhv
 vVk4qzRGU6eEGljSJSdO5ZX94XflWy/vovx7ipYkNcxG96ws/xwDVudVLDpXJzVUWvkoVwFbB
 ndkdOVdj52TjEdjT16g37VpbdFw9Sl67el/NSOC1XrsJAuXxwEkewGK7Yb7DTrGPVFuaCfe3g
 VhgsXwdCkl0pUedy5p/IiMHdBVLy4Lf/yxhM1/2icMUMd4oVgUC9asZ0fhdqKza0EbIfWbysr
 msBxtgJEPiDM0Z6u9oVR3qKSDJ3gZq16Vg4B1N9R2VMY52un6nTf2z1NNI1uRWrAzvMju+Ad4
 Ar8Db8pnSTxvkPNo3gdLCiRof7742bTTrwwv+/XqP6KatSIjQKGgk3aPZzf3IRDRgbu3itqp3
 fTJRgVwqf3Eb2Jz5uPL6yH0lqrSxJDkLb8QlBiPGWxyiTbYAAWBLdjXtf1UuihsLF+wKUlxi0
 EHsXsZJpr7/OAB2jQhG6M8L8E7w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.07.23 um 11:45 schrieb Phillip Wood:
> On 28/07/2023 07:12, Ren=C3=A9 Scharfe wrote:
>>>> Right.=C2=A0 Perhaps --[[no-]no-]doubt?=C2=A0 Looks a bit silly with =
its nested
>>>> brackets, but it's more correct, because it documents all three accep=
ted
>>>> forms, including the no-less one.
>>>
>>> It may look a bit silly but looks very tempting.=C2=A0 Also it is not
>>> much longer than "--[no-]no-doubt".
>>
>> Yes, it's quite compact.=C2=A0 But is it they still legible?
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 --no-index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find in contents not managed by git
>> =C2=A0=C2=A0=C2=A0=C2=A0 --[no-]no-index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 find in contents not managed by git
>> =C2=A0=C2=A0=C2=A0=C2=A0 --[[no-]no-]index=C2=A0=C2=A0=C2=A0=C2=A0 find=
 in contents not managed by git
>> =C2=A0=C2=A0=C2=A0=C2=A0 --[no-[no-]]index=C2=A0=C2=A0=C2=A0=C2=A0 find=
 in contents not managed by git
>>
>> The last two document all three variants, but is it still obvious that
>> the help text is supposed to be about the one with a single "no-"?
>> That's something that has to be learned, I suspect.=C2=A0 No good makin=
g the
>> short help too cryptic.=C2=A0 Hmm, how about:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 --no-index, --[no-[no-]]index
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 find in contents not managed by git
>
> I think spelling out the positive and negative options separately
> makes it much clearer, but in that case I think we'd be better just
> to show
>
> =C2=A0=C2=A0=C2=A0=C2=A0--no-index, --index
>
> adding "[no-[no]]" is just going to confuse users. If we had a
> convention of "[<short>, ]<positive long>; <negative long>" then I
> think it should be clear to users how to negate a given option
>
> =C2=A0=C2=A0=C2=A0 -v, --invert-match; --no-invert-match
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 show non-matching lines
> =C2=A0=C2=A0=C2=A0 -I, --no-index; --index=C2=A0=C2=A0=C2=A0 find in con=
tents not managed by git
>
> Spelling out both versions is a bit verbose but I think it is worth
> it to avoid "--[no-]no-index"

I kinda like it, even though it is quite verbose and adds a new syntax
element.

A bit more verbose still: Document the negative form on its own line
with a generated description -- requires no new syntax:

    -v, --invert-match         show non-matching lines
    --no-invert-match          opposite of --invert-match, default
    -I, --no-index             find in contents not managed by git
    --index                    opposite of --no-index, default

> One other thought is to mark options that can be negated with a
> symbol like '*' and add a footnote saying those options can be
> negated.

Sure, adding a layer of indirection would work.

All these imperfect solutions make me wish we could get rid of the
problem, e.g. by converting all "no-" options to their positive variants
and mentioning that they are the default.  Won't fly, though, because
some of them have short forms, and we don't follow the convention of
uppercase short options negating lowercase ones, so we have to document
them anyway.

Ren=C3=A9

