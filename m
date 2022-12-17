Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055E1C4708D
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLQMqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQMpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:45:55 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FE9595
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281150; bh=G1rwLQNngW5LGCUFr75Pui1xOZbheIfZR1oQqWkz874=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=MLvQW0CW8XRtkm/L8PsdbKmSOKKl517pT2lgS3i1U2TwBvIs7Xqk/cf9YEQ1z8LzV
         iR9Z6JP9gLC1iDNIjD89RZ2qan3qMWwNzP504Lh1iX3vnWq8XqT/iCCqPXfqvYdkmR
         0lrQ3aJ0eRewz3J0iMQt7WHqDg5AZg+pSDr2BRmFeUmTN4q4j7LdQKPWgzbLHIXSA/
         6H+dKGK0+bAMMpkorofmrv1Sued3gDn6pjhJiJxf1G5uzVEpH4kC6D/RD5z610BPwj
         X2GDGD+fqA4nTs4dDAUUQVI0J/SW24ZupHiNgMiSZ6kxjf8R3ranMnAunH1qRsU3bh
         HYd80dpkwPwig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwfK-1pHZAc1MbI-00OeCz; Sat, 17
 Dec 2022 13:45:50 +0100
Message-ID: <e7f8de6e-6448-278b-a47f-cc7e5b813cf6@web.de>
Date:   Sat, 17 Dec 2022 13:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCH 1/5] builtin/annotate.c: simplify for strvec API
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <RFC-patch-1.5-cde038825d0-20221215T090226Z-avarab@gmail.com>
Content-Language: en-US
In-Reply-To: <RFC-patch-1.5-cde038825d0-20221215T090226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gf1P+qOC6ku+3RoUtediflHAtRn50aOUEcCa/Hf+3/OFlOMOu2k
 3j0JyCAWhY6dRMRTmBW53i77+0l4iEtk+P0chN0tNAgxtyLctqdOrq9FCNwTvQo7IXDedP6
 21s38qrOX4ImZUx/fMm47dtdl9rKvaTB9Up7DK0OBppn6OGOfcWenZSksgcQBa8SSbKqxfX
 +v62dXDOH5EHMMrgDlN4g==
UI-OutboundReport: notjunk:1;M01:P0:cTr8Sh7e/o8=;K/QaMXMSToxTqrNdB2nzuevh4Ml
 XXGTf0wzLnKOjYPoAhDulpNpc7Nqko2AG4raE8uFT8fgMBKfh1Hg1O/GIIS+ZsMvdJU/GH0PQ
 ukEe2fpyi3ZKpmxlu8rZag2irlxGw4KBnWwgj817QfQ9fF9Txt8S3Xvd960qnXt9d7XDCK0uY
 znYUPmGcp2ELZPo6nKdfaV64mPOCsn2kqWfCPHJRi8vDl9QwJQGI7rWflRLeRi+iNov3tqPHL
 3YPJKuOLHixfGtcD48wXOsGeVTok+FzkmQ6ukTItdnaomZfdtvlqMG8RHlzFV7encsHMhNGIn
 nOak5Cobvck1AoIuXxTOi62f9t2r+1b/NAnp3mZJTannoTswhhAQYCEjTfwW5GM3/7XtOff/p
 rzL24dym2Unw0PL974rKyvSsCpEQUm5PUufZPo/N4sfYEmt8obkcV+GydIufeLyqJToZf7lzE
 Z00po1HsPJaLAO8/lk+W6b9E58OATFHILoRzw/0i6/7Ta9cM0aHSeSiQq6aTqVfM7htVVsKwB
 5x1Z7UNGwCZT71Kcg0MM1rsc7Q8/dOyI0Z0gSA0uUKG3F0i4WdozKIbsuoFm4kQxSjrJvABaA
 O96TG6gWPB9GpXRwY011QcsQCfHEnRuEpZootuAADTSAtXdByupiFPJg3LtpTRpce7ERWZMcA
 w5pSp6ZqdX9WfFT00lQN9NXVrnBFGy/t+y57i9SalEUS64MP+K5iXzCZ+Yh1uh9X3PffM2ZIH
 pWs8kN8K18HHpt0tEaroABunTjGweUBrWQSk62aKWf+mfnRp16I90LsfezJDbRcXsSp8wafiw
 KT2LihDtPEfjeR+CdpoF+6NWA8Gv6gwXirTwPVOmFd11aKJdvobjMj1bACHBuYUqd3c5lbi3m
 3PwtTmrsmVxkSgIFNDuwEpkUuVS2pfYXp3pLdTTwWowKNt77LSVHAHeHYE/YLdmMLdzpu2OBB
 D6g3pg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.12.22 um 10:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> When this code was migrated to "struct strvec" (or rather, its
> predecessor API) in 8c2cfa55446 (annotate: use argv_array, 2014-07-16)
> it didn't take full advantage of what we were given:
>
> * We are always passed the name "annotate" as argv[0] here, so we
>   don't need to re-hardcode it. We've already declared it in "struct
>   cmd_struct commands" in git.c.

This change has nothing to do with strvec; it could have been done by
e68989a739 (annotate: fix for cvsserver., 2007-02-06) already.  I don't
see much of a benefit to it because the string is already there, but if
it's needed then I think it deserves its own patch.

> * We are guaranteed to get at least one argument, so rather than
>   looping here ourselves let's have strvec_pushv() handle that. If we
>   only have one argument we'll pass the terminating NULL to it, making
>   it a NOOP.

85b343245b (argv-array: implement argv_array_pushv(), 2015-06-14) added
the _pushv() function, so 8c2cfa55446 could not have used it.

> This change helps to make the subsequent commit smaller, and as a
> bonus removes the type discrepancy between "int" and "size_t".

This type mismatch is benign as long as we get a valid argc value,
as positive int fit into size_t.  Getting rid of the loop is nice,
though.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/annotate.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/annotate.c b/builtin/annotate.c
> index 58ff977a231..e37b269196f 100644
> --- a/builtin/annotate.c
> +++ b/builtin/annotate.c
> @@ -7,16 +7,12 @@
>  #include "builtin.h"
>  #include "strvec.h"
>
> -int cmd_annotate(int argc, const char **argv, const char *prefix)
> +int cmd_annotate(int argc UNUSED, const char **argv, const char *prefix=
)
>  {
>  	struct strvec args =3D STRVEC_INIT;
> -	int i;
>
> -	strvec_pushl(&args, "annotate", "-c", NULL);
> -
> -	for (i =3D 1; i < argc; i++) {
> -		strvec_push(&args, argv[i]);
> -	}
> +	strvec_pushl(&args, argv[0], "-c", NULL);
> +	strvec_pushv(&args, &argv[1]);
                            ^^^^^^^^
"argv + 1" would be easier to read.

>
>  	return cmd_blame(args.nr, args.v, prefix);
>  }
