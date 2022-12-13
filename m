Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABBC4167B
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiLMSbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 13:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiLMSbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 13:31:22 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93E24976
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670956274; bh=43DNmH6D8wga/RfUk6SvLLVcrYR7zbZVnkSPVlDupFA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S0XwhaJEhB8s6kj50nUKpH584kdwLFfGAqsL/B/+p3M3n8SVxaZ2ymxSFdQrtHLGQ
         /4R/PUfzsHX+zQ3jRla/pu9nF6IwjEJAxP1glAD1YU8bDddgNkhFdvGvB0oE//jOWj
         7kGb+ajeFtzqt7NmRd+hiK9wsqtnT9LQoH/mCaFzCaHa+5Xj76s8E0LU1H+EmSWjzy
         i2NdiUvsVsSau1s/PcMpQir86V0AbSxFaPyaMbLGtBPixb35EZG6BboOULJp8QuSQW
         VCh+rPJ64eFnR9nP4ZRlgRH5OIkZ077KZkVZL7sc8hszurbsWWOSG5lm1ZM+jX5byk
         i0sPLEkLOx15A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1oe7ES0YoA-00mJwA; Tue, 13
 Dec 2022 19:31:14 +0100
Message-ID: <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
Date:   Tue, 13 Dec 2022 19:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NELr/WH5pe3893fcu2uH71NI04pd60G8C5PKezdPfrd1BTjzu85
 u26abdvA9Pavjxq+Gq9ajCCxN0THaEB8Qy86vAEzCSDrjxWVgEYNQbqtD3edWcBOWlJPUOP
 6EKbdCIm9x8dnLZab/FAVmC0ddceaiHql4pHw2/gbDKv4QPggEBkhDnBAMC64Qjx7El2uLI
 Yis9I/0DXre7fxoomD4KQ==
UI-OutboundReport: notjunk:1;M01:P0:j/1b+lNiDZw=;PWQUkEJJVW3DnusGo0jROATKaPF
 0pkVlcIIEWkIDJY2oLeKflHNqiA0Vo8bNTJ23snHgQ91KsTMZx8uVGNDdBtGnc8alZFbAenOf
 VHIOED/muxqFpaLVAZU7dSGDeDmOZgzJkBdxO/l1UlIbWAqb4wBIUkN3CIFzBAFIaa0C+z0iX
 xNcS270ca6zgjRhVicneVps+kK8ywGwTBm3UeDfiSAdCRMk/NTm8kR9Ady+W3ykvQSAIDNl8M
 Z/eCh001KZFAVHX48lvrTxPjd2GXAxqktb0Aj0olSu7F9tHt0iCvzPT86JJvfniSbklqe9rZC
 k6EdGZaukAp2vRxp2+mPIZljOsWQLT5rTTmnlI8Nwf3Ds7oEDJvko3IesLdEyFGhesSSez7zX
 1uM3Gr9kjgqPXL/i0ZNxfpZoxLZzTsh+pAeMbBlzU2buZYNcHe0OXV+EX6dHG/LIk/ScXnUpd
 LmYkD3Ndqfq4hVAkymQI6qtq5nqz1B92FOwsATGMZB53J+pRuV/ZsjafLjFIN9GO/lnkInw4v
 OkLhF6sraMG7aLqHhv2bRLW76WqsaNH2F3F9yVvW3LpF9vR62Y6SPkbj+uArHlOw0/uW4+yAo
 Y8Ikh+DEzHg3wS7IyYKSvo3tf8goC9BQRr49L8VT6MoOEWlC+IF3TK+dzaCaCzEUSCe9EgPul
 Bslfz4CH6vzZZ5M38sualYQmj7+gi2mNsfmEHBnI2Yo4Camy1Gdjf+Jv4UUjO0vRdDmy1uQPU
 YSBrPtJDaHt1yfoc9Eh0fCumEGXZzQtyI3LV1ecXCZCby+YhO9T467LN0sb6NJD/sv/GM11aw
 BSu2PT/8HWcc+BNGgUfdVECgrIQAflIgXCVulXLL8L71Tavc/Lm6RYr8G7AiEdkAZ0/RkpqEW
 iRNHQ5fvXx1mlxP3Sw8k+hTRRWgzZTrfWcBCqnqb73vWsTP9FBD9r6VTkjX2pdWrFOP9LT/Du
 d5dxBg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.22 um 09:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:
>
>> apply_parse_options() passes the array of argument strings to
>> parse_options(), which removes recognized options.  The removed strings
>> are not freed, though.
>>
>> Make a copy of the strvec to pass to the function to retain the pointer=
s
>> of its strings, so we release them all at the end.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/am.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 30c9b3a9cd..dddf1b9af0 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *state=
, const char *index_file)
>>  	int res, opts_left;
>>  	int force_apply =3D 0;
>>  	int options =3D 0;
>> +	const char **apply_argv;
>>
>>  	if (init_apply_state(&apply_state, the_repository, NULL))
>>  		BUG("init_apply_state() failed");
>> @@ -1483,7 +1484,15 @@ static int run_apply(const struct am_state *stat=
e, const char *index_file)
>>  	strvec_push(&apply_opts, "apply");
>>  	strvec_pushv(&apply_opts, state->git_apply_opts.v);
>>
>> -	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
>> +	/*
>> +	 * Build a copy that apply_parse_options() can rearrange.
>> +	 * apply_opts.v keeps referencing the allocated strings for
>> +	 * strvec_clear() to release.
>> +	 */
>> +	ALLOC_ARRAY(apply_argv, apply_opts.nr);
>> +	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
>> +
>> +	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
>>  					&apply_state, &force_apply, &options,
>>  					NULL);
>>
>> @@ -1513,6 +1522,7 @@ static int run_apply(const struct am_state *state=
, const char *index_file)
>>  	strvec_clear(&apply_paths);
>>  	strvec_clear(&apply_opts);
>>  	clear_apply_state(&apply_state);
>> +	free(apply_argv);
>>
>>  	if (res)
>>  		return res;
>
> I don't mind this going in, but it really feels like a bit of a dirty
> hack.
>
> We have widespread leaks all over the place due to this
> idiom. I.e. parse_options() and a couple of other APIs expect that they
> can munge the "argv", which is fine if it arrives via main(), but not if
> we're editing our own strvecs.

Where?  A quick "git grep 'parse_options.*nr'" turns up only this place
as one that passes a strvec to parse_options.

> I think less of a hack is to teach the eventual parse_options() that
> when it munges it it should free() it. I did that for the revisions API
> in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
> need free()-ing, 2022-08-02).
>
> What do you think?

Generating string lists and then parsing them is weird.  When calls have
to cross a process boundary then we have no choice, but in-process we
shouldn't have to lower our request to an intermediate text format.  git
am does it anyway because it writes its options to a file and reads them
back when it resumes with --continue, IIUC.

I hope that is and will be the only place that uses parse_options() with
a strvec -- and then we don't have to change that function.

If this pattern is used more widely then we could package the copying
done by this patch somehow, e.g. by adding a strvec_parse_options()
that wraps the real thing.

If we have to change parse_options() at all then I'd prefer it to not
free() anything (to keep it usable with main()'s parameters), but to
reorder in a non-destructive way.  That would mean keeping the NULL
sentinel where it is, and making sure all callers use only the returned
argc to determine which arguments parse_options() didn't recognize.

Ren=C3=A9
