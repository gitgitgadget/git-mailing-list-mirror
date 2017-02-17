Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98922013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbdBQIAP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:00:15 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61508 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754459AbdBQIAO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 03:00:14 -0500
X-AuditID: 12074413-f4fff700000077e1-74-58a6ad8caea0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 28.99.30689.C8DA6A85; Fri, 17 Feb 2017 03:00:13 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1H80ArY019338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 03:00:11 -0500
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
To:     Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
 <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
 <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
Date:   Fri, 17 Feb 2017 09:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqNu7dlmEQfN0HouuK91MFg29V5gt
        1l5fymzxo6WH2aJ/aQebA6vHzll32T0OHe5g9HjWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mr5fOsVe0CJVMbPhAmMD41SRLkZODgkBE4lbq/YwdzFycQgJ7GCS2Lepgx3COc8k0XBl
        JStIlbCAjcS6c5/ZQWwRAVeJKet+MkEUPWSROPKylRHEYRboZJRoWnGGGaSKTUBXYlFPMxOI
        zStgL3H1/E02EJtFQFXi+6cWMFtUIERizsIHjBA1ghInZz5hAbE5BVwkrr69DLaNWUBd4s+8
        S8wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+Vm
        luilppRuYoSEs/AOxl0n5Q4xCnAwKvHwZmxfGiHEmlhWXJl7iFGSg0lJlHfRtGURQnxJ+SmV
        GYnFGfFFpTmpxYcYJTiYlUR4lVcB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KL
        YLIyHBxKErxL1wA1ChalpqdWpGXmlCCkmTg4QYbzAA3nXwsyvLggMbc4Mx0if4pRUUqcNxmk
        WQAkkVGaB9cLSzevGMWBXhHmdQKp4gGmKrjuV0CDmYAGd0YsBRlckoiQkmpgXCSm8X3jnW3V
        p64cT3J6PZUl06Ys7p3/1gexLHPv3+pNumv9vjNJ3CHyCvf55zXiS/ctk6n9LHC39Kiyg5a1
        GjdX8CHZoj1ilhdzXgrUf85oX3uXs6CoP/nUjsnJN+YciddOF2iTuhLJll4QpNUmXrx3naRz
        ZKqUrLHCc7mK5mVP1zHsdnZUYinOSDTUYi4qTgQANDl0fBIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/16/2017 10:31 PM, Jeff King wrote:
> On Thu, Feb 16, 2017 at 11:43:59AM -0500, Jeff King wrote:
> 
>> On Thu, Feb 16, 2017 at 11:10:18AM +0100, Andreas Schwab wrote:
>>
>>>>> 	int xfclose(FILE *fp)
>>>>> 	{
>>>>> 		return ferror(fp) | fclose(fp);
>>>>> 	}
>>>>
>>>> Yes, that's exactly what I had in mind (might be worth calling out the
>>>> bitwise-OR, though, just to make it clear it's not a typo).
>>>
>>> Since the order of evaluation is unspecified, it would be better to
>>> force sequencing ferror before fclose.
>>
>> Good point. Arguably the call in tempfile.c is buggy.
> 
> Here's a fix.
> 
> I think close_tempfile() suffers from the same errno problem discussed
> earlier in this thread (i.e., that after calling it, you may get an
> error return with a random, unrelated errno value if ferror() failed but
> fclose() did not).
> 
> -- >8 --
> Subject: [PATCH] tempfile: avoid "ferror | fclose" trick
> 
> The current code wants to record an error condition from
> either ferror() or fclose(), but makes sure that we always
> call both functions. So it can't use logical-OR "||", which
> would short-circuit when ferror() is true. Instead, it uses
> bitwise-OR "|" to evaluate both functions and set one or
> more bits in the "err" flag if they reported a failure.
> 
> Unlike logical-OR, though, bitwise-OR does not introduce a
> sequence point, and the order of evaluation for its operands
> is unspecified. So a compiler would be free to generate code
> which calls fclose() first, and then ferror() on the
> now-freed filehandle.
> 
> There's no indication that this has happened in practice,
> but let's write it out in a way that follows the standard.
> 
> Noticed-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  tempfile.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tempfile.c b/tempfile.c
> index 2990c9242..ffcc27237 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -247,12 +247,8 @@ int close_tempfile(struct tempfile *tempfile)
>  	tempfile->fd = -1;
>  	if (fp) {
>  		tempfile->fp = NULL;
> -
> -		/*
> -		 * Note: no short-circuiting here; we want to fclose()
> -		 * in any case!
> -		 */
> -		err = ferror(fp) | fclose(fp);
> +		err = ferror(fp);
> +		err |= fclose(fp);
>  	} else {
>  		err = close(fd);
>  	}
> 

Thanks for fixing this; the old code was definitely wrong.

As you pointed out, if ferror() fails, it doesn't set errno properly. At
least one caller tries to strerror(errno), so it would probably be good
to store *something* in there, probably EIO.

To be really pedantic, there's also the question of what errno the
caller would want if *both* ferror() and fclose() fail. Normally I would
say "the first error that occurred", but in this case we don't know the
correct errno from the error reported by ferror(), so maybe the fclose()
errno is more likely to hint at the underlying reason for the failure.

So I (reluctantly) propose

	if (ferror(fp)) {
		if (!fclose(fp)) {
			/*
			 * ferror() doesn't set errno, so we have to
			 * set one. (By contrast, when fclose() fails
			 * too, we leave *its* errno in place.)
			 */
			errno = EIO;
		}
		return -1;
	}
	return fclose();

Michael

