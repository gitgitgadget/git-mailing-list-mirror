Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2403CD5492
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjISHrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISHrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 03:47:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C57FC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695109621; x=1695714421; i=l.s.r@web.de;
 bh=ZRtLeY3q4r2Uu9OmlrX5asA+53BtP+9AITUJ0L8zKnk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Bx7thXZ6d4eONA6L6lXeLeEftL5p3nHQ5iAsTY/g+cu62Nx/xJFEP1VsS1OtHkVuojt2/0z2cx/
 VkRoGUYowW8gosOBAwvi+Rn8Jyv7izOIPvbDtvtVsR0v8P9QtV+tcdJjY9FuyiPyNw3tQaESCfAYL
 1woZK/ORC0KtFgW6qjzWdyhR3jVNuLl+Pm1U/qsS76l2GK10BWDe/CvaeuyCiDk5JdDGgyoOYEac4
 eXxQiOOUbazN1g3r1eHrwiE0Obi1f77wD10cUqU7onwy6cFnRTkU2KSP6qj78jpx3/aZhMWMMquHB
 43Jz/6Yqu2vIzRsV8X7qOSxjBxdyV44fKZHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkWQ-1rHJ2B2cne-00dYkk; Tue, 19
 Sep 2023 09:47:01 +0200
Message-ID: <b948f3e5-7d03-4a2f-a719-963d52005291@web.de>
Date:   Tue, 19 Sep 2023 09:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g> <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
 <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KhnlgkERCoQMVY5zbnybG9Wae7Y6JYyfMBggyV3Z7i96eis0gIE
 9fERmRdtOQLo3dNXX7ht03jog7tljcsDZcIRtRlkoqM0DuVs5jc2zoQlgDXwjq5cckUmNzD
 hqaQ7y5np3cvnVyqKx6TPqRGxi1XlX9QfsY6uNP4YL95IAb0OJpocR9tkl43xvOcajRSgp3
 1jCYZdEFaCvJyI2DHGsww==
UI-OutboundReport: notjunk:1;M01:P0:n+ZV/JNUZA8=;aBO0S3EzwhVBSGdFB2hawfw7/Dx
 3LsyWMTNLJK9yhFwccZugiy7MZ//cn7gueWWc4WxcZ2YcR9ZMX4I5yqsYN+jfW7uyu1KBEECZ
 rlvKz5xexy3ANp8yaPzh6ZQrB3R6t0B1R+mofA4aNgLR0y6U2cqG6eTDizUWOw+DI9JfC4UcM
 FV/MFWL526nSiDVM5/F4eKV7yCxAS3Vcd7Mv7Y6EaEB31lhBOCCCO3zO+PQXc7TRnUI0WUuT5
 8A9L04AuwmuiNTPbd5vYzi7lex+ViiqInAVbOzAcqDIuESOs1A8vnFxCvnGCAfUBtjngtQ1tw
 E/c7OcPThA6meTQbKAziCxgfSfRyICnKTC4y83/u3okDEn+C1lJG663dwuSTaGMRlrKnxdmJv
 dWoluUDiC6YpE0Af7ENU/qgr5oLDreJjjfuM/WfiBMRto+D5jEAGCvN/hBVEAPqT8jCNPozXL
 taNEH3YDR6EC/qB6eYITMTxRPfc/IMydybZyqFXwEdKGFKIJdWcDJIfh6+2IuDYaMYyPnxyKv
 1Xzsu18Olow10kan5I446DM+uI6sj+ZLL9FPvAhFuPvP+yXVZTMrkZPmTOiaxe9RfWMAVbHIX
 ufddgcWYnKuyK2DkTRdK2IYfCCFAS8WbBm3SKPSHqsb/5cf8D2ogc/UkQD27NTaB23FhjWXHD
 +Xyz22vMeJbubu9xfCrxxTL+CZuJgQoV1t9nmmFPt5yK1TLAFYz+ff5E6Xkw3SD2xKtQDc1q8
 4v0FiCvZslUPPWvxsyxGU58NmgfXhp2uMpn9YbwZ/W9q172eYCQJJ6sujURs+IYv2F+83rZB8
 begYHNOQ73uFMjrbMyNgPgpNyfzU07vtqD5BMDm6PPxFSJ2LFWevzAIDQT5y4/ozDNhWPwR4E
 /JwLSlymGnTiuN7IosnFJqfEzfcbw/R1bdVjU9HUO/Jlpk61grJVYjgCgfsbfF8WjGfwS5pH3
 qSx97w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.23 um 15:33 schrieb Phillip Wood:
> Hi Ren=C3=A9
>
> On 18/09/2023 10:28, Ren=C3=A9 Scharfe wrote:
>> Here's a version that preserves the enums by using additional int
>> variables just for the parsing phase.=C2=A0 No tricks.=C2=A0 The diff i=
s long, but
>> most changes aren't particularly complicated and the resulting code is
>> not that ugly.=C2=A0 Except for builtin/am.c perhaps, which changes the
>> command mode value using a callback as well.
>>
>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 202040b62e..00930e2152 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -2270,13 +2270,14 @@ enum resume_type {
>>
>> =C2=A0 struct resume_mode {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum resume_type mode;
>> +=C2=A0=C2=A0=C2=A0 int mode_int;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum show_patch_type sub_mode;
>> =C2=A0 };
>>
>> =C2=A0 static int parse_opt_show_current_patch(const struct option *opt=
, const char *arg, int unset)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *opt_value =3D opt->value;
>> -=C2=A0=C2=A0=C2=A0 struct resume_mode *resume =3D container_of(opt_val=
ue, struct resume_mode, mode);
>> +=C2=A0=C2=A0=C2=A0 struct resume_mode *resume =3D container_of(opt_val=
ue, struct resume_mode, mode_int);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Please update $__git_showcurrent=
patch in git-completion.bash
>> @@ -2300,12 +2301,12 @@ static int parse_opt_show_current_patch(const s=
truct option *opt, const char *ar
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--show-cu=
rrent-patch", arg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 if (resume->mode =3D=3D RESUME_SHOW_PATCH && new_va=
lue !=3D resume->sub_mode)
>> +=C2=A0=C2=A0=C2=A0 if (resume->mode_int =3D=3D RESUME_SHOW_PATCH && ne=
w_value !=3D resume->sub_mode)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error(_("=
options '%s=3D%s' and '%s=3D%s' "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "cannot be used together"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--show-cu=
rrent-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
>>
>> -=C2=A0=C2=A0=C2=A0 resume->mode =3D RESUME_SHOW_PATCH;
>> +=C2=A0=C2=A0=C2=A0 resume->mode_int =3D RESUME_SHOW_PATCH;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resume->sub_mode =3D new_value;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>
> Having "mode" and "mode_int" feels a bit fragile as only "mode_int"
> is valid while parsing the options but then we want to use "mode".

True.  It feels a bit worse here than for the others because there the
variable is on the stack and here it's in a struct that is passed
around.

> I wonder if we could get Oswald's idea of using callbacks working in
> a reasonably ergonomic way with a couple of macros. We could add an
> new OPTION_SET_ENUM member to "enum parse_opt_type" that would take
> a setter function as well as the usual void *value. To set the value
> it would pass the value pointer and an integer value to the setter
> function. We could change OPT_CMDMODE to use OPTION_SET_ENUM and
> take the name of the enum as well as the integer value we want to set
> for that option. The name of the enum would be used to generate the
> name of the setter callback which would be defined with another
> macro. The macro to generate the setter would look like
>
> #define MAKE_CMDMODE_SETTER(name) \
> =C2=A0=C2=A0=C2=A0=C2=A0static void parse_cmdmode_ ## name (void * var, =
int value) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum name *p =3D var;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *p =3D value;
> =C2=A0=C2=A0=C2=A0=C2=A0}
>
> then OPT_CMDMODE would look like
>
> #define OPT_CMDMODE_F(s, l, v, h, n, i, f) { \
> =C2=A0=C2=A0=C2=A0=C2=A0.type =3D OPTION_SET_ENUM, \
> =C2=A0=C2=A0=C2=A0=C2=A0.short_name =3D (s), \
> =C2=A0=C2=A0=C2=A0=C2=A0.long_name =3D (l), \
> =C2=A0=C2=A0=C2=A0=C2=A0.value =3D (v), \
> =C2=A0=C2=A0=C2=A0=C2=A0.help =3D (h), \
> =C2=A0=C2=A0=C2=A0=C2=A0.flags =3D PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PAR=
SE_OPT_NONEG | (f), \
> =C2=A0=C2=A0=C2=A0=C2=A0.defval =3D (i), \
> =C2=A0=C2=A0=C2=A0=C2=A0.enum_setter =3D parse_cmdmode_ ## n,
> }
> #define OPT_CMDMODE(s, l, v, h, n, i)=C2=A0 OPT_CMDMODE_F(s, l, v, h, n,=
 i, 0)
>
>
> Then in builtin/am.c at the top level we'd add
>
> MAKE_CMDMODE_SETTER(resume_type)
>
> and change the option definitions to look like
>
> OPT_CMDMODE(0, "continue", resume_type, &resume.mode, ...)

About half of the OPT_CMDMODE users use int, not enum.  They'd have to
be converted.  On the flipside the direct and indirect uses of
OPT_SET_INT_F with enums could be converted to an OPT_SET_ENUM_F based
on the above to avoid their use of incompatible pointers as well (e.g.
OPT_IPVERSION).

For uses of OPT_BIT and OPT_NEGBIT with enums a getter would be needed
as well, though (e.g. git ls-tree -d/-r/-t).

At this point I wonder if the existing callback mechanism would suffice.
Which brings me full circle to the topic of typed callbacks.  Perhaps I
should introduce them first and come back to solving the int/enum issue
at the end of that journey.

Ren=C3=A9
