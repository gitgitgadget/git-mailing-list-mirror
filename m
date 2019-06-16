Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA2C1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFPIYY (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:24:24 -0400
Received: from mout.web.de ([212.227.15.14]:45111 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfFPIYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560673458;
        bh=4YQ0JMQDxXADrSHVift5s/W74BFJy7vDwXsFTiPSY3g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dBo1BDWbJClx8c0pNRSneZQHkjBX3KVoQ7Npqv49R1+iXpAwbi30dZ3/GQsKij0o1
         jDvjl+sOZwEImf0MJbWuedNhm6Ud/A8PS3+6CTTL6SzzbgHkC9udQY1x6cjjsAVrtr
         KpPajXVRZccrXz34uoW9Z+9auBsqFasOhc20doZY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBp3P-1hkMfm4B4Z-00Aivg; Sun, 16
 Jun 2019 10:24:18 +0200
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f22599d4-148f-212c-282c-790f5bde1706@web.de>
Date:   Sun, 16 Jun 2019 10:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <03a68560-8058-7436-6edb-38e276a37190@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VOIl6kKGV5TauU5CiH5kS++jnaY5LTTauAj3Xjjq2kcnZ9BF7f0
 5M7l4Y4qXodkkpB1Lq9ZUFIIVKGdwpmR1qiRd2OnJkaA4Qu+lwwwVffYWkCni3ODYLkQvb1
 SyFoSqrRjuoqvjfSw0Yx6QChFWdAStphFtKpYuwK39QFzSm5MfLX6TlbUNCE4ssjpd9coCG
 GRwU6zhGFNxCEEA8l11pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+7csZqOdyWc=:yvl2RrcJW80FsQ2m100M8g
 uyUzQ/2u0NH3uenqUDnYyBsa6yte4FYcDAaCH8yRrRqrcloFoiM+45rXooOggqhY9gWUS/HQm
 Eiy22S5Q/aPSMgAv6z8kaq4XELWW49nT3aonv248UXE7nXD+DE/nuWrMv+ghgm7qAtk2SBW2L
 6XoBXm+7uMLKNsi+D/xjQ7W4fcPGEGxIYC4I1XcXueHD7o82KIXMXfGGbgujmgouOoA+frdZY
 pY+y3/E81onSFw7mP8avIpelPeE1QjevNmM29b/Ncn8Sp9PMy91rBk/CbJRdFdS3Wmf3Wf2Ie
 WgJRxEP3/qJgYijPqiY1hV9O8gq2G3tg5bUvOXuMkUe1ozSmgKGtXiru2LSzR7KqujVu9qeRA
 tQCFU6ogErnuYrNN/QVeJ0+F3EsIfAhs5L78sERpJnd328hmy/fkO3W/61jRdpYO5YeZ71TfZ
 3/Bdza2GMxZamYrqQsjN14jGhDa95jxurhuRYMhyCEoyQ+DCo3zzGglwFNWxr3+Mk2HVr2Hi5
 U0GCFHELo52o6zypEhHWLTjnqlLvIxmjBuZYp3aXmIZ1UfzUYjYtnGzir40D0q+CfUGlWgEpm
 G8TpnXPSt7POhS50DsSnm/Fg18ccl8nVpwGqRFvr1DcxNXIG7BOTlemb5HvtOk9np+A5jQxTM
 knP6w/GVSvJuOrlbbwkNMtEJh6iQYqVSmuG8Nn5f1gunmhawgdeUzbVySPox7xx2NUXVvQGp/
 mzPSd4UwPzpBlbnGD0DLdNN/q6suxNeGXEK91otto5J53iEOawMlK9ZXu3Az+Izvjo9Cwg4UE
 VNq3Pz0Sk4wqLvDFceFW/DxRuRqiaUE2p4XwkQnQsUaeU6l4MmcaT+p0jOyssswrtVHhFcVaB
 ShysRk+blg1EFrUvC26KMRLN01Ab/iY2yWghp9UWA2FZSEaeW+VYsWYL8NIXwQK5qjjJ2Zsn8
 iYUi7OlB/UNWwgGtI7wvutS4MDEYAax0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.06.19 um 08:48 schrieb Ren=C3=A9 Scharfe:
> Am 13.06.19 um 13:49 schrieb Johannes Schindelin via GitGitGadget:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> The `labs()` function operates, as the initial `l` suggests, on `long`
>> parameters. However, in `config.c` we tried to use it on values of type
>> `intmax_t`.
>>
>> This problem was found by GCC v9.x.
>>
>> To fix it, let's just "unroll" the function (i.e. negate the value if i=
t
>> is negative).
>
> There's also imaxabs(3).
>
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  config.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 296a6d9cc4..01c6e9df23 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -869,9 +869,9 @@ static int git_parse_signed(const char *value, intm=
ax_t *ret, intmax_t max)
>>  			errno =3D EINVAL;
>>  			return 0;
>>  		}
>> -		uval =3D labs(val);
>> +		uval =3D val < 0 ? -val : val;
>>  		uval *=3D factor;
>> -		if (uval > max || labs(val) > uval) {
>> +		if (uval > max || (val < 0 ? -val : val) > uval) {
>>  			errno =3D ERANGE;
>>  			return 0;
>>  		}
>
> So this check uses unsigned arithmetic to find out if the multiplication
> overflows, right?  Let's say value is "4G", then val will be 4 and
> factor will be 2^30.  Multiplying the two yields 2^32.  On a 32-bit
> system this will wrap around to 0, so that's what we get for uval there.
> The range check will then pass unless max is negative, which is wrong.

No, this example is wrong.  (I need to remember to take baby steps while
carrying numbers. o_O)

So value =3D "5G", then val =3D 5 and factor =3D 2^30.  After multiplicati=
on
uval =3D 2^32 + 2^30, on 32-bit machines this is 2^30 due to wrap-around.
Correct so far?

If uval is 2^30, then it's smaller than 2^31, so will pass a check
against INT_MAX.  val is 5, which is smaller than 2^30, so will pass the
second check as well.  Makes sense?

That would mean "5G" will overflow on a 32-bit machine, but we won't
detect it.

Ren=C3=A9
