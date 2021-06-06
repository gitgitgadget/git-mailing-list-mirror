Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA5C47082
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BE1610C9
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFFBDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 21:03:41 -0400
Received: from mout.web.de ([212.227.17.12]:52381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFFBDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622941307;
        bh=9RpB9cymhqnJYnaPGX+ce855SYbxLsQJyg8MamFL+Uw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rE+oUBgVjB7QWzfxwTu6HuC2LB0JSuqRKAFeOZNxgJwxr6Y+6BlhEc27XDPFuhmY/
         ysxWCH+VkWKVFT6mdUbwcb9mg1vPWCWgyP7j2ycwmqURDlLVIxJ3DX7rOL5twvTWSO
         r+C/+iFGB6Jy7DNE4Kbz4ty7WYtuHPFKRk3Tb2eE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M09hY-1lUzSR19NU-00uFOx; Sun, 06 Jun 2021 03:01:47 +0200
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
 <20210605190910.GJ2947267@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6a111a2e-ed65-9c22-1f0d-cdd54b144692@web.de>
Date:   Sun, 6 Jun 2021 03:01:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605190910.GJ2947267@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iy1CFzFcgqk55azvaw6PhcYs1rqDtwQjzK0Q/7nr0lD2H1XOGJq
 Jjr+y9N9yMiYWvG1c3j9qsYeS62P1NOKzGkPg8URV/5FOckFxJe8sEC9WR9SpCgVQb/96a/
 ZW1aE1I2IU1Yy6p4fZRNn0pCEsxPunxq2mWsgD8k1aqE/QszhaiHMdZT93/tACmOaq+Rlfc
 hbxY16xtP1KEhvpxCJUFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3YyvMJ7F7aQ=:0LgODgvqXPD9+cXCQGK24a
 RlF+W912YdGyoBzckPjIwta2JNCGUTHDFzMsfNH4iZUXqou3/zsSG7Bj51y3GvOvn/+APreh5
 HTbUDDUXgohVC5R/8k7GzfgGZxPDbwTIgQzaoE5Yp99tLlNFS3q99gFYgR1nS2VDRZjZwSkt4
 U5ZwZIKE3atlZ5R9i/asVucmMJ35v9U+irUyREZBDam4fuoNxVXBLvqsaXkPfcviqYaVSnDHH
 0totQgXksEheYTsi8HS2fY87FgwwDrBQPPVxBCp1HUrZV4dKXXjWQBkUdJopqFgmnX45KJGaP
 UabgZ43CPbkjtqzvE1WGrS6GyfXGrJWF2jcDu+Cm3LIQKVriUXar711Y92LFT6wiNvm6nriA2
 2AWDSXheB1QVI1xevMsQdBg6ePOBCtRGF/hIb6/+negm+batSauOh2Mr8H9H6a6gEkulq2Ufp
 UUSfyjBkbpZqlEZ3Qt7y3Htqv92Tj4mCOjCJMeN6HIu+Qmthb2P2h+7663XIrrFFbDVHfMGmX
 CTCbBeI8jPHiwTjFOaNiochPFDtQuiyVFfAyKlcvGDrb8/OaM/t2nP/Qb82oX+hCKyWJsMJWR
 dvlPcwUKlKFS4XqsGfLlEEaEyfMWnNEHkgSyAsHkUnX99Uq4vg14E/QKBNak7vBr7KIhvyO/3
 LD2ZJ0ZGECqg4oRrqe2bapihNztQqlaPkSPFM4UmfaqogAY9SW7dqL7De7jmo8MaWS/3wejtt
 dUUxLAm84Ioi/SxZXT3Smc4id5boZndl5N20ecAREMegejXjhtp0a9vRlaWmCXx7OFBD5bUVV
 cYVgUfwPZKWQS3qZPsLgXXbb6AhUWQ1eYMaY6yavgVTPAZjGgBOZzYUksLKibsdYmZBXrvhL6
 k0duD/ddxRUruvlHokGeTH61Hl5U/VfY0sjnnMX+GD/Vx6V9Ar6Tx7crxfrZiBBva2JlDDBYj
 dJkn55zrIcaH8tF+9vqG50+sbAOiTv+APwLuNbnmUwHpALVaXW//rtkAYyKqnkp9R2wZ160Ej
 SIqQm/7DffAJ9oj9/M8Uxn5oMCBEiTKra/ziF4FHjCEg6xi055u9YM8ERvfHohcLUIYirpGEk
 DX4AcEKlJz1R9Z1o2TbiuXZ4AVGK2VwfQpD
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.21 um 21:09 schrieb SZEDER G=C3=A1bor:
> On Sat, Jun 05, 2021 at 08:11:24PM +0200, Ren=C3=A9 Scharfe wrote:
>> The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
>> reporting the following error:
>>
>>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
>>
>> That's because wc's output contains leading spaces and this version of
>> dash erroneously expands the variable declaration as "local workers=3D =
0",
>> i.e. it tries to set the "workers" variable to the empty string and als=
o
>> declare a variable named "0", which not a valid name.  This is a known
>> dash bug (https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097).
>
> Perhaps a more accurate wording for this bug would be:
>
>   ... and even fairly recent versions of dash erroneously perform
>   field splitting on the expansion of the command substitution before
>   assigning it to a local variable.

OK.

>
> I think the relevant part of POSIX is section 2.9.1 Simple Commands:
>
>   4. Each variable assignment shall be expanded for tilde expansion,
>      parameter expansion, command substitution, arithmetic expansion,
>      and quote removal prior to assigning the value.
>
>   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_09_01
>
> Note that it didn't mention field splitting; though POSIX doesn't
> specifies local variables in the first place, so...
>
> Anyway, this bug has been fixed in v0.5.11 (2020-06-01).
> This is an old bug, it was already present in v0.5.5 (2009-01-13); I
> didn't check earlier versions.
>
>> Work around it by passing the command output directly to test instead o=
f
>> storing it in a variable first.  While at it, let grep count the number
>> of lines instead of piping its output to wc, which is a bit shorter and
>> more efficient.
>
> A more debug-friendly alternative would be to save 'grep's output to a
> temporary file and use 'test_line_count =3D $expected_workers'.

Yes, but that would cement the use of grep and wc -l and I still can't
let go of the idea that grep -c would be slightly quicker.  And it would
add file I/O.

Something like this would be more efficient in the expected case:

	if test $expected_count -ne $(grep -c -e "$pattern" "$file")
	then
		echo "Expected $expected_count lines matching $patter, but got:"
		grep -e "$pattern" "$file"
		return 1
	fi

I have no performance numbers to show, just the vague feeling that the
test suite takes way too long already.

Anyway, for now a minimal fix should do.  Debug features can be added to
this case and several similar ones later.

>
>> Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Changes since v1:
>> - Explain the root cause.
>> - Get rid of the local variable "workers".
>> - Adjust title accordingly.
>> - Still use grep -c, though.
>> - Remove input redirection.
>>
>>  t/lib-parallel-checkout.sh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
>> index 21f5759732..66350d5207 100644
>> --- a/t/lib-parallel-checkout.sh
>> +++ b/t/lib-parallel-checkout.sh
>> @@ -27,8 +27,7 @@ test_checkout_workers () {
>>  	rm -f "$trace_file" &&
>>  	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>>
>> -	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$tr=
ace_file" | wc -l) &&
>> -	test $workers -eq $expected_workers &&
>> +	test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_file=
") -eq $expected_workers &&
>>  	rm "$trace_file"
>>  } 8>&2 2>&4
>>
>> --
>> 2.31.1
>>
