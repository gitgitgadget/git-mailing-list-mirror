Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04245EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFTQ0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFTQ0O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 12:26:14 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163D172B
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687278331; x=1687883131; i=l.s.r@web.de;
 bh=WeaTuqF0hemvjtZlzTPD6XXp1m7GXBlFv29DYAXvIeo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZEh+0+Q2pArtBCK6bXASMAvv9ZiNHKeap1PRJxA/nh1oiPULXNcqFm6OFup3qBJeMNnPdh2
 ccaBUWiaHi+Q248tXsoo8vgY3e3z9qqBErmINDiBs3DQJChpVds41Bghafk8WsoxzjikybZzV
 aGNPVpS36aEdwUdKXii33NwNZ3RPkN5/FHXjODAH3E9X+RSmOOSS5oW9MDRaN8LBTFJiQZ3JZ
 oGj2WEPzO8/9PB5kiKRXq83DsDHn5cl5eSStR0mKh0V/iNPamDAC4lf5HCYZ4NgIwMlaU09Yc
 4iRQzb0gUyNBGTHkwaTMNE5PrHlmZYsvIeR8wkpsjw5p7DLpYthg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1qdf8W3lFW-00ST4G; Tue, 20
 Jun 2023 18:25:30 +0200
Message-ID: <fe0db8cc-4d1b-3108-1d36-939b01a95244@web.de>
Date:   Tue, 20 Jun 2023 18:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de> <ZJB98Q6NHbK6D1uB@nand.local>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZJB98Q6NHbK6D1uB@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qEvmwbVv1sF4stsAnE59pSkEOoDIv+jsr/yA0aXe4Dsf3W16QS
 2SQU2Q6rLDsWe1WX4bVi+JyqZ3K96739tBai0ZFtB5umTVZJjiz4X8+vdf2xNKP4EixgAsQ
 YM3TnR10gNzrsxzNre/3eNvZVkxq3s04s7Hd1+smyUtbjRBSQys36RayoehWGebdZdw4OOp
 O5HvLQV2DjnhhQx6w8gTA==
UI-OutboundReport: notjunk:1;M01:P0:yh7+j2EAndE=;9HFgNVhvtDoYErR897xfDXPJD14
 B21ujkpsjni1m31P17OcAiyWNBj4XrER1YTQlTl+9rz4T1Nwav9l7W/dfGIKIv9SnMmRMATrd
 LRDm46HTJdzuCgfs0nUEQ2LeQJhDLVhOBnuo3F2fdnMXNjc2Z0PIfAxIA7DQTgqZFhnjMVDxn
 VbzdxVbw/tBR07kWUR5HlP71NzFtD59jbYsEnS+H59n880R8YqVVJyRNEr4eATkKzweVeggmQ
 d9mtjMh2y8YseWDXQACMlkAfsFaVaKHIDOVS69EHEPXdChRG6bnYXarm6DqtXT8KLSwSM/5EY
 VuVw0m+IzP3zWozAhjZt2hbypV/1qwH5acAUGbEepORpPkU1QwV0RaILmJVrasN6mH1X2gZ3q
 HBnoKJBJ48zUkNCTdgxgXtxpksk75+h0hWylAPyw8RvqC1PJL0q9A0eeR7DYnmes+9pp3Q4H5
 BOT7IlJRNwrpiVqns0zWtGcdebzlgKp1vu41CGzVvKdp0wQDaZEPEmJ4JDph8klqI5ltsBW67
 hwfLnr0pnvC/IIMQV5ki/X+Fs1wwtSE07qBINpqL8GeeXdrUjwE5Z2Cbp59ujTHFx28XnP08r
 SB3zjLdJUn7PmY9SMYKpRTXX9D4RSqvpvwQh8jLG0uRN7IbXeffYz0Pe7i4Xg7NP1GCxxQ957
 tpryDoCqJFFmgqosjO0YzATKZtDT2ec/BcwuJwX0PAf33Uy3ygLLh2Jkpiju/qprMuWA/QaIY
 VeHy/PdXXKow7XZINIaV0WXpf+XaX37+sHl8IT6pFw36V9nCHVFo3AEjQeAoOBJTW1BcgEobO
 fNSXLb/6j/cDgw9qR0vv8p3+MZNHAgJeB1nz3TB8z0mkhn4I0rghTz/aDzlY94eFDUPw3qGdn
 syU4g6NQmweSzDI7iCx6ripr93wKqEyEdGECiseZVUXOiyXafcsyTijHtNjtSAYPWyyScdGGl
 DN7iJRWDaH6X9/uANQicYgqmgD8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.23 um 18:10 schrieb Taylor Blau:
> On Sat, Jun 17, 2023 at 10:41:44PM +0200, Ren=C3=A9 Scharfe wrote:
>> diff --git a/strbuf.c b/strbuf.c
>> index 08eec8f1d8..a90b597da1 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -415,19 +415,24 @@ void strbuf_vaddf(struct strbuf *sb, const char *=
fmt, va_list ap)
>>  	strbuf_setlen(sb, sb->len + len);
>>  }
>>
>> +int strbuf_expand_step(struct strbuf *sb, const char **formatp)
>> +{
>> +	const char *format =3D *formatp;
>> +	const char *percent =3D strchrnul(format, '%');
>
> Can format be NULL here? Obviously formatp is never NULL since it is
> `&s`, but we guarded the while loop in the pre-image with `while (*s)`
> and I am not sure that **formatp is always non-NULL here.

The "*s" in builtin/branch.c::quote_literal_for_format() that you quote
dereferences "s", so we'd get a segfault if it was NULL.  A NULL (and
NUL) check would look like "while (s && *s)".  The old code in strbuf.c
passes the format to strchrnul(), which can't handle NULL either.  So
no, format must not be NULL here, and this is not a new requirement.

But now I noticed that builtin/branch.c::quote_literal_for_format()
only ever gets called with "" or "remotes/", none of which needs
quoting.  We could drop this function entirely, and add it back when
needed, if ever.  But that's out of the scope of this series.

Ren=C3=A9
