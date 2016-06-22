Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16AB1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 05:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbcFVFqg (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 01:46:36 -0400
Received: from mout.web.de ([217.72.192.78]:59381 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcFVFqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 01:46:35 -0400
Received: from [192.168.178.36] ([79.237.51.220]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LxfGh-1bQW863Q2l-017Hss; Wed, 22 Jun 2016 07:46:21
 +0200
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes >=
 8GB
To:	Jeff King <peff@peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net> <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net> <5769A6CC.9030001@web.de>
 <20160621210234.GB4747@sigill.intra.peff.net>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <576A2625.8010706@web.de>
Date:	Wed, 22 Jun 2016 07:46:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160621210234.GB4747@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:N0O6i6GU2L1lZYy2ffFmlA+/wBG+cbrJSPIGdBgn2C0sbNhkKrc
 IXEn6VuCGFgW2AFUjT//RrJiSA790MIt067Nq7Pnx7YViWSYbb3NgqcaeX5E7fBHKD2ESbJ
 EuW4AN2GjTyN05mkqjTT1WDdqpgmiqD4I2yYgnzQa/1vj6oDrX9JOkiAtlgevVlX2LvxarR
 rQiH19UdvjLusbVBe1kew==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EVRaAwght+Y=:upm66ZDqbPBnLlWE8jdUpc
 7kLsUWrd9LSa+HzWEap1Axszd5FlzhY0O+WovY9JQcdaSk8MqJP0EQPPlTriv2To5pE8ffxV6
 X/7Q0B4XumkEWCGePiZFtplTuJDQq/LEDvNsFJgEkezoH1Rv4yf5DEMRgnOx0FkrzviaITYgz
 k+oUR9Nb9tIiBsEHs9J/m867XUt8GltrWec3DMNRe4hnvrzPRrNelAXri6I4F2Yh2H1rNN275
 thrHVCQH7rAKcWSMuywyW+UvLJs0MZPHB1IYq0CR59FDXWRgPilMj5IVA+P8e46h9X0M1/nMB
 dosQjYTBgzKHWZkOSlAR+aRy8Jri0AqlBh7vWPpyloydSuhDEBSg+whPIvsyiSYzEjcDVlnr+
 IrJW9v4DlR2ZowBPaVcqcy7S5Q8r2SfVbKhwclGdBirtUCDBJO1KOqkNLzYkBtt/yH9n2QqR2
 dEppQ7uYR3bdwZ6Wj2ZMuPCJq6SIXgL0AHcOdNPhdUuHoK9K/l//IXy7/gaQTA0vU7L3evhxU
 445Vov1sls+Ekw69QwyfH6pv0YhDOM7SmgyrZ6nXPMc6+lXAX81nJFjiiFdmMKXuySNQk0f0w
 y5q/JkmmJV8OrLU1xwcpbdPjWwNYw+CB6TKj5/fHiTcEiNT2Cw+vsud1oIfIB2sRMQIB4ACKv
 xkWrPn4c+OBh2o/nkNJqU/qzyjNAWBkMAl1d5NJeUw0vXCRwjDnLw5dHemNYt8RLUQyp9fMJe
 ngKHyRblS1QqJoxU0FvqafSKEHsUeId3SgaeNX/BIR3pvXkZ+jJvm+AKmKDzllJepZTFjsWvu
 T5WCKO3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.06.2016 um 23:02 schrieb Jeff King:
> On Tue, Jun 21, 2016 at 10:42:52PM +0200, René Scharfe wrote:
>
>>>> If we could set the limit to a lower value than 8GB for testing then we
>>>> could at least check if the extended header is written, e.g. if ustar_size()
>>>> could be convinced to return 0 every time using a hidden command line
>>>> parameter or an environment variable or something better.
>>>
>>> Yes, we could do that, though I think it loses most of the value of the
>>> test. We can check that if we hit an arbitrary value we generate the pax
>>> header, but I think what we _really_ care about is: did we generate an
>>> output that somebody else's tar implementation can handle.
>>
>> I agree with the last point, but don't see how that diminishes the
>> value of such a test.  If we provide file sizes only through extended
>> headers (the normal header field being set to 0) and we can extract
>> files with correct sizes then tar must have interpreted those header
>> as intended, right?
>
> The diminished value is:
>
>    1. This is a situation that doesn't actually happen in real life.
>
>    2. Now we're carrying extra code inside git only for the sake of
>       testing (which can have its own bugs, etc).
>
> Still, it may be better than nothing.
>
>> -- >8 --
>> Subject: archive-tar: test creation of pax extended size headers
>>
>> ---
>> The value 120 is magic; we need it to pass the tests.  That's
>> because prepare_header() is used for building extended header
>> records as well and we don't create extended headers for extended
>> headers (not sure if that would work anyway), so they simply
>> vanish when they're over the limit as their size field is set to
>> zero.
>
> Right, so this is sort of what I meant in (2). Now we have a
> tar.ustarsizemax setting shipped in git that is totally broken if you
> set it to "1".
>
> I can live with it as a tradeoff, but it is definitely a negative IMHO.

Yes, it's only useful as a debug flag, but the fact that it breaks 
highlights a (admittedly mostly theoretical) shortcoming: The code 
doesn't handle extended headers that are over the size limit as nicely 
as it could.  So the test was already worth it, even if won't land in 
master. :)

René

