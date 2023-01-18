Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D991C38142
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 01:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjARBJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 20:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARBIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 20:08:40 -0500
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3102F784
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 17:03:21 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id HwrFposo3OE6eHwrGpNNjU; Wed, 18 Jan 2023 01:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1674003799; bh=FuAQbnn/KfP9gd4jsAxN/srUmG3VYa0Q4aeinRxh0U0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H6j2XKLuYUo+REJT/SE4DSV/ZsJSLq6CTUD/amAeiQK1OnLZq20DUAQ5dpywQH7bi
         I+uQxR/YE7Khs6797V0kr5we16GFQ6XFsUr2L5KJN57w2WejNVdaPackMLBupJS1Cu
         ymIwgpX9aejHb51hwNAClk0m52UxXewiQxYpIXdhVouG1lslBtGpoHLUkNYGvk8EUe
         NImrkPrH6st0jWgT69ytnM8evi4uwz57Vu88/BRKX57dOqQ0avU6Hyb8tw033lfbs8
         6KvJk7ocsvh6ELc1oljv/nG7HnVQJYA8pSIcrNnLEjPR2vDQcRceaK3yGizrv2xEW0
         MKetY29ZUPVSA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AO+QjUhr c=1 sm=1 tr=0 ts=63c74557
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=98nDmZQ3_Cna-MDeUiMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <bdd4eacb-4883-be16-e0b6-296a27dcd98f@ramsayjones.plus.com>
Date:   Wed, 18 Jan 2023 01:03:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] avoiding deprecated curl options
Content-Language: en-GB
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net> <xmqqilh9kqdy.fsf@gitster.g>
 <xmqqzgakgu0n.fsf@gitster.g> <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8YP+R/hyNr6sEFA@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y8YP+R/hyNr6sEFA@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCAugbUQII6F3GPf72DQR1wRyqvJI1xi6LfRnZgPxkWYK4p7zDXOk/jfnfm1heIspALUmbVMDMrTHJ+QqAIK0DPkEFXQJstTkVQ4GCORwusOYTY7x0HS
 yZosJ5m+zmKX2qCd+QYhS3kE1enaM8kjM1RWFeI7EYVGWnNDfNbQ+v+6CUF82hQ+W96xllwLtqvs0kHSRd9XiMVOrtcHgglEmQs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/01/2023 03:03, Jeff King wrote:
> On Sun, Jan 15, 2023 at 03:09:26PM -0500, Jeff King wrote:
> 
>> So I took a look at just dropping the deprecated bits, and it wasn't
>> _too_ bad. Here's that series. The first two I hope are obviously good.
>> The third one is _ugly_, but at least it punts on the whole "how should
>> we silence this" argument, and it takes us in the direction we'd
>> ultimately want to go.
>>
>>   [1/3]: http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
>>   [2/3]: http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
>>   [3/3]: http: support CURLOPT_PROTOCOLS_STR
> 
> In the interests of wrapping this up, here's a v2 that:
> 
>   - bumps the required curl version to 7.19.5 in patch 2
> 
>   - aims for slightly better readability in the final code of patch 3,
>     versus minimizing the diff
> 

I have a _slight_ preference for your v1 patches, but I don't hate
this version either! :)

Tonight, I have compile tested both v1 and v2 patches (both in 'seen')
on cygwin and linux. I would like to say I have run the tests as well,
but it seems I have disabled all the tests on cygwin (expected) *and*
on linux (most unexpected).

ie. I don't have apache installed. (I used to have apache, svn and cvs
installed to run the tests, but they just took too long to run and
caused *many* test runs to hang and leave server processes all over
the place. On cygwin, even with all of those tests skipped, it still
takes approx 5.5 hours to run the tests).

I thought I was still running the '*http*' tests on linux, but I seem
to have dropped the installation of apache at some point - oops!

I guess I should install apache tomorrow ...

ATB,
Ramsay Jones

