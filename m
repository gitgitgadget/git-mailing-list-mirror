Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74AEE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 21:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbjIIVOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjIIVOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 17:14:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDA1AC
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694294081; x=1694898881; i=l.s.r@web.de;
 bh=MCBqBGN4xVtasaveI5+wqQ4zROAlCnP2ETDGT5k9c+g=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=rL7yyhAl9y6VLp9DVmb5EJeA4yW2KPWINN4TCJ9f3H8nqK61jOJ2xiLpb0KBh2heg/oWRmy
 Zx1ItlRuL4EpL5Fc3cM69lF/MhdBhVBKlTWO5ZY5fF44WcAJ+ciDlz7/yCLqdqLisYqyFRC+H
 WUnyRBpUBi4Mj7rR9tvmPPp/bIjkv/2sfKnaoHTy0RT5/gM8WKxF+qirp9rI0wamCmMe1qUtr
 g9k1cFM9IJxB95jFEuXL/Dun16cO9TQbFlKiLiSoRtPF9pSvO81j7YdLhurOZ+IBMWf1yAuZf
 mwWHCAHIfoUEnsrdQcoL6hR/k/xPHf5idbH8YKj+pr2SV4HC05QQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.6]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjIR-1q9vtf3jOB-00WzQV; Sat, 09
 Sep 2023 23:14:40 +0200
Message-ID: <e09ce805-056c-c3fb-6955-69b6ae0a2cb1@web.de>
Date:   Sat, 9 Sep 2023 23:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
 <20230905072122.GG199565@coredump.intra.peff.net>
 <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
 <20230907204027.GA941945@coredump.intra.peff.net>
 <cec47733-5b15-6ca7-adaf-7f3216ad178b@web.de>
Content-Language: en-US
In-Reply-To: <cec47733-5b15-6ca7-adaf-7f3216ad178b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YLP2PSunbUGAlCS9I1MtA34v5qaYR/WbON/mj45DtyPAyrwKgvT
 guL3dTDiHeVFwTl+ptq/gcce3PTcGA8nhYKCAyWru14DXEZLS6xZZzCj3+daPRXMeHEwP6S
 +hqlAAtWnylAUT6Hd1Pk7nR0UaqcYqsKDWm3dZGzFLEFHmaBzNV2scLmLa/rs9zoia6Uob1
 UOlPo101nbS+02fPoc2oQ==
UI-OutboundReport: notjunk:1;M01:P0:r4FJIZAzXi0=;FouI9zbQvjhhJGpDE4byd9NzulH
 GqatoF9QsnwFUGRG4ZmuxeL4p64/Rc977KzfDpRT58kGFtp4wpOz7Xk2UIylKfSlLDjUGdwpH
 uLfKNUmKqlOqwGORuqvnWNXFMaFUQ826WlsuOm6UDKJ/uGeXDm5Fqc/23omHUEvGJDz/cXR+X
 +4MgvSJ12Ko1gS+VIvs1fX5CC7b6WDGk4FRCRlkdxcv4pSBDHmPhFItgNv0oaRqsf+l1nzGe+
 iskO2J4UtoW0SyYyJ21ODvhYXdWa09z97CuSChu+todvXySU8jjyi0XFwmHQrS4hBAdkOgeJD
 K9vQ6orre3UavxCqRRS1LdMxdAmlregiQrIOcqojzIPCOhJhMhJAmNOhG5n3tJGc8MdpafmVi
 pgEY0Ui6n6uOsijsb4JsnzUmRYAk85DSGVk7GSq7PkkYE9TThcYRcUaMBw6o+pEb/ePNDeD/0
 nKDej0ZnkVkp6oJ/Q3f+TPYbcgWgiQLoaPy7GP7Via6TZGhlqiwXKEkW3G/QHG/1Q7+cpidKZ
 zOCY8gsb1fq+uJLSn//aVcQojASizhcr68K6KNO87jW3qa8DAyszvykKuNraIVzhaIgAoa9T7
 v1oKKS8N4zUYwYjUxdaDkqgnUO3x10fyX3DrR+6Kkco7psXdl1ZqF/pUK/c7TsSQZoRnBj1W9
 moJYovX5BAQVIaKJ80EZDXoY7g+rB7HZrWDdO34Nswo/3wn7Ze5Adbbv5bCSABKt3XhupogzA
 /wqO8etwp0dz385QRXuL2fyY9/GQuaqALAyjP/+cYMzW5EOK9W+9QYPSAUOS78gXi/gCyBlRk
 sM17Sc8HYsOI/NyVaXAeVgXpyLUoKOUNXpuUv21XmfmfxxUF5HbPZ3zdAfAQgMrVYtSfEcItZ
 B25yyv1J6B5uO4vED1+FzHx4yjEm68eK+sGSYhxNdvJ+hpdX7D/RTs0IxGs0VHh1QXrk0FNu5
 97ULkKy0e1E6RxpWnsR2gw/ygDg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.09.23 um 00:28 schrieb Ren=C3=A9 Scharfe:
> Am 07.09.23 um 22:40 schrieb Jeff King:
>
> I was thinking more about something like the solutions discussed at
> https://stackoverflow.com/questions/47674663/variable-arguments-inside-a=
-macro.
> It allows selecting variants based on argument count.
>
> That could look like this (untested except on https://godbolt.org/; the
> EVALs are needed for MSVC for some reason):
>
> #define OPT_INTEGER_FULL(s, l, v, h, f, d) { \
> 	.type =3D OPTION_INTEGER, \
> 	.short_name =3D (s), \
> 	.long_name =3D (l), \
> 	.value =3D (v), \
> 	.argh =3D N_("n"), \
> 	.help =3D (h), \
> 	.flags =3D (f), \
> 	.defval =3D (d), \
> }
> #define OPT_INTEGER_4(s, l, v, h) \
> 	OPT_INTEGER_FULL(s, l, v, h, 0, 0)
> #define OPT_INTEGER_5(s, l, v, h, f) \
> 	OPT_INTEGER_FULL(s, l, v, h, f, 0)
> #define OPT_INTEGER_6(s, l, v, h, f, d) \
> 	OPT_INTEGER_FULL(s, l, v, h, (f) | PARSE_OPT_OPTARG, d)
> #define EVAL(x) x
> #define SEVENTH(_1, _2, _3, _4, _5, _6, x, ...) x
> #define OPT_INTEGER(...) \
> 	EVAL(EVAL(SEVENTH(__VA_ARGS__, OPT_INTEGER_6, OPT_INTEGER_5, OPT_INTEGE=
R_4, 0))(__VA_ARGS__))
>
> So OPT_INTEGER(s, l, v, h) would be the same as before.  Add an argument
> and it becomes current OPT_INTEGER_F, add another one and it acts as
> your _OPTARG_F variant.

Should we actually do something like that?  Probably not.  At least it
doesn't help with my goals of simplicity and safety.  (I get sidetracked
so easily..)

>> So yeah, I think you'd really want a separate macro. The combinations
>> start to add up (or multiply up, if you prefer ;) ). They _could_ be
>> generated mechanically, I think, as they can all be implemented in term=
s
>> of a master macro that knows about all features:
>>
>>    #define OPT_BOOL_F(s, l, v, h, f) OPT_BOOL_ALL(s, l, v, h, f, 0)
>>    #define OPT_BOOL(s, l, v, h, f) OPT_BOOL_F(s, l, v, h, 0)
>
> The "f" arg needs to go...
>
>>    #define OPT_BOOL_OPTARG_F(s, l, v, h, arg) OPT_BOOL_ALL(s, l, v, h, =
f | PARSE_OPT_OPTARG, arg)
>
> ... here, possibly.
>
>>    #define OPT_BOOL_OPTARG(s, l, v, h, arg) OPT_BOOL_OPTARG_F(s, l, v, =
h, 0, arg)

Or we could use designated initializers directly.  It would improve
readability at the cost of some verbosity.  We could make it a bit
less verbose by by setting some flags implicitly based on type (e.g.
set PARSE_OPT_OPTARG if defval is set for an OPTION_INTEGER option).

Ren=C3=A9
