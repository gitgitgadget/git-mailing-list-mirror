Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1171F462
	for <e@80x24.org>; Thu, 30 May 2019 14:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE3O7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 10:59:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:58000 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfE3O7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 10:59:12 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id WMWGhxcs0mVenWMWHhDtJ4; Thu, 30 May 2019 15:59:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1559228351; bh=ELRYK+ZDT5OGtdbvfFhr7jYT/dFG2r8fq+mSItdgxpI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oJ6JtMwEDRIjZdQfmDtL9zpiGK72tGD0U/up6b+dUpFn2OwxnnSdfYQSK6sCzqDae
         MV5fYExOBqITsc1xb3w9ul6SAUeMEDtDXhL5JPc8xl0zoaTinN8LP5PvKDpaKrQ/jK
         YiVAsVTjy0HOLu+GLIaD7r+GswcuhU1SxiVs++cKE0tk+cWkgT7EAmDTbr1rWY4Gke
         56wyjQ7SVVz5W3WTpkAkOhsXR9adgAHYMnxGiwRVQRm1pfJH+2oPoFBI1Zwz1Jokcg
         xcHL7y6lW1aaxxufyZZ6qj4R5OS8ZflnWzXc7nrOsROLyw20PaoeNuUviymXct2MBO
         Vho8DjvTaAUNA==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=I5Ubu+og c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=l5TglQF3YJ2S1DbDJiQA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
To:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
 <0f1c5a49-f971-848d-700e-9c124ae8e617@kdbg.org>
 <20190530120441.GD31607@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dce88509-f4d5-1e7b-26f1-eff5cdccf1d0@ramsayjones.plus.com>
Date:   Thu, 30 May 2019 15:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530120441.GD31607@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFNJlpc25/wPbSaoCPQyfeoIepvpoW6HCBXW42KtkgPSdapA7L+FSIBiD4acl/w0XQgC178u6O+UWrc0U8tVRp7tIye0aK/QIfmTwHoV3FOhZVTMVc0v
 2wtU92YmzTeKDT+A/dqjD3YE1wTQ8XtBj5MWVMyhEEpKdl2crFDAtMfc6SljOdB1BhgZlOfl8vXabg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/05/2019 13:04, Jeff King wrote:
> On Thu, May 30, 2019 at 10:47:37AM +0200, Johannes Sixt wrote:
> 
>> I had a brief look at the series. IMO, it is a mistake to appease
>> -Wmissing-field-initializer.
>>
>> We have two sorts of initializers:
>>
>>  - zero initializers: they just want to null out every field,
>>    like CHILD_PROCESS_INIT and ad-hoc initializers of structs
>>    such as xpparam_t pp = { 0 }; in range-diff.c
>>
>>  - value initializers are always macros, such as STRING_LIST_INIT_DUP
>>    and the OPT_* family.
>>
>> I am strongly against forcing zero initializers to write down a value
>> for every field. It is much more preferable to depend on that the
>> compiler does the right thing with them. -Wmissing-field-initializer
>> would provide guidance in the wrong direction. A zero initializer looks
>> like this: = { 0 }; and nothing else.
> 
> I had a similar impression while perusing the commits. I don't mind
> forcing some extra work on programmers to appease a warning if
> disregarding it is a common source of errors. But I didn't see any real
> bug-fixes in the series, so it doesn't seem like that good a tradeoff to
> me.
> 
> Contrast that with the -Wunused-parameters warning. I found a dozen or
> so actual bugs by sifting through the results, and another couple dozen
> spots where the code could be cleaned up or simplified. If we want to
> shut up the warning completely (so we can pay attention to it), we'll
> then have to annotate probably a couple hundred spots, and keep those
> annotations up to date. But I feel better doing that knowing that it's
> shown real-world value.

OK, I will drop this branch then.

Thanks all.

ATB,
Ramsay Jones


