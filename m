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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DFC4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A8560234
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFFBDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 21:03:34 -0400
Received: from mout.web.de ([212.227.17.12]:56577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFFBDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622941300;
        bh=Q7HP1JHgi4VLL7iv8PbAXnQ1ENpldADTxrsWJ7Kn7ao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qad5w7oix6EUQrvuMNGfaXVfBe5fEjG2j/vGQGvwWNU8hsIyZNeDc3NfhVOciuTYr
         j0DoNDMd/RxVS1yALqgi5ZFHDMUYEj4r8+j0YLR1KogoFT9T1eWzolYKhQyWID9jm9
         3xRMemtDd4ZVObgdknaUVENMJzCY8bj3Ki171itg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M0hbG-1lVXQI0QQQ-00usEP; Sun, 06 Jun 2021 03:01:40 +0200
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
 <87fsxw5bav.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5ed77a50-3b34-4f3d-8348-a11d3930872b@web.de>
Date:   Sun, 6 Jun 2021 03:01:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fsxw5bav.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0b1s+k004V/DzgCaUn9Gt7eQ3MUKaL+nrMMa2wdUBNlF2nbMDnG
 ohXwwYu3/pHMbLWjb5gEH/vCp/6y0M7LFPF8wA0Z4PxiNjzVGO0nitRNUO7EAPCXad+EWWA
 QjWwQ+jK8poHe7+46VXc/AyA6V5hRD3sYXgNvLboi0FxR1QyeA+gkNX4DOJT2AIwnoXs92P
 4GGpRYAjZLsMnL8Via6cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzhP9H2l1iA=:HnC9lvAC70MvsQSJADdsKB
 QzP+hMuFKZav9GAsDfGHbFmCtffXjNKVaJX5gYHPUpXOoEseH7cZUiNifpuoVQRUxw8IMX1lv
 glKAHbm0roRHkUx4+5y8dYDTdqqs+1KXi69ro3NDxWuf/P0jnMGMsKrXMzi6K/tcDbeSFupH+
 ifcgJjw1KANHYevLxSEFBFzkF1SDO39XB437XYqUU/+lLUVvOfwf9PYEvmWl9CGJ8BKES8SVp
 QWPH7q0tpCnJ6d6oyV+ZfQFU7zi7psY7a4LE/epXHWBF63hnBlc6kJx+g1SfQkVBcwwPUsXw5
 sIGCkcChjxadEE2Apzi1QFDnNUVdfIMezd1qwI84B8DCXyxHnjRpD9Suy7m5zZYm4tmSmdB0L
 ClNe3cboESdPtUEQqzAJyhJDihWRmnSSQnVPmIhEMWGqxn9smstoFHcc4eji1GtO1hkoFzU6d
 iJKJMm2AlatjoBdONEgfFCEskrV/pb8EW/BZpDb4ngd90DmMYQkkwdRO7ul9KwXkjOAlM3tjj
 tliKPIiavPThT4uP+FA7R6QsGkjFPbdjcrRGky1/0oZoS2ipgEVNwZngR/RzFEywuw3jbIGaa
 oRzV/T//XR/vdRoSfHHPBJfTAyU3/YzeJsiPAp0bxfwbIBQNQ22h7cK8e969IG7QsjGdbd6Rk
 RuB6u/gMxrjv3EaVLP48MEx5OFn/BqKmgZmgtxeCsLwbzCzUlsGaWT0SqCSgwm0AjT90Q3Wew
 RJVghGph07521rhc7wfqSkvVxGQRWVULVoSZqYW0IWxBFsV5jiYDoN5q9TofRa4DbpMcrRPw3
 pGPuz4YvK9tXcRmtdLS2iwj/LWwapVmZvxHRT7yw9NE25CL+ZWqqM0BYmKuDJUNaonGWXt/S+
 N3qP/2b8QExdKeIjBCTjaHR53MVYJrZdTaKAFVCunHGXw2Ep5NWH8KzR0IHw++p6MPwUe4IEX
 cuudrx8q/NGZJqxMne+wS1A2SzH2SGY/dfsMzFIS0eDefEDrhg9ANJUUqy3y66cA0lCVx0K8v
 SDiKgmKhMcyKt1XtYaP1rxZ6heUrb8fvtjqQOWTs5DIPW6hL1+fdZwIKFYUByMUpyenN916PI
 3UlQlMYSM8inYB8eu/RpI6v1A6iGdezkRsR
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.21 um 21:56 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jun 05 2021, Ren=C3=A9 Scharfe wrote:
>
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
>>
>> Work around it by passing the command output directly to test instead o=
f
>> storing it in a variable first.  While at it, let grep count the number
>> of lines instead of piping its output to wc, which is a bit shorter and
>> more efficient.
>>
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
>
> I'd find this thing much clearer if the v2 just narrowly focused on
> avoiding the "local", and thus demonstrated the non-portable shell
> issue,

I was not aiming for a minimal fix and I don't think the patch above is
too complex, but you're right that at this point in the release cycle a
duct-tape-style patch would be better.

> and perhaps with something like:
>
> 	diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
.pl
> 	index fd3303552be..aad6f3e2bf1 100755
> 	--- a/t/check-non-portable-shell.pl
> 	+++ b/t/check-non-portable-shell.pl
> 	@@ -48,6 +48,7 @@ sub err {
> 	 	/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not port=
able (use FOO=3Dbar && export FOO)';
> 	 	/^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4})=
 and
> 	 		err '"FOO=3Dbar shell_func" assignment extends beyond "shell_func"';
> 	+	/\blocal\b \S+=3D\$\(.*?\|\s*\bwc -l\)/ and err 'whitespace handling =
in local=3D$(... | wc -l) differs in some dash versions';

Any command can output whitespace, it's not limited to wc -l.  So a
better rule might be to always quote command substitutions in local
variable declarations (local foo=3D"$(...)").  Or to disallow assignments
with local altogether, like we already do for export, but that might be
a bit much.

> 	 	$line =3D '';
> 	 	# this resets our $. for each file
> 	 	close ARGV if eof;
>
>
> The let's do grep -c while we're at it part of this IMO just adds
> confusion while skimming future portability issues with --grep=3Ddash or
> --grep=3DPOSIX in the future, and looking at the history in v1 it's just
> there because in v1 the root cause wasn't fully understood.

True, I was still gripping the "use grep -c instead of grep | wc -l"
hammer.  I better rewatch https://www.youtube.com/watch?v=3DYv4tI6939q0

>
> If we're doing a general cleanup of that pattern it would seem to be
> better to search-replace this with the rest of them in another commit:
>
>     $ git grep '\$\(grep.*\| wc -l' -- t | wc -l
>     27
>
