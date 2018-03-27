Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E311A1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 03:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC0D0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 23:26:17 -0400
Received: from avasout04.plus.net ([212.159.14.19]:57010 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0D0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 23:26:17 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 0fFWfqUAFsD7b0fFXfDfiP; Tue, 27 Mar 2018 04:26:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=gsn_jT7NtKzQPLLWNU0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
 <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
 <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
 <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9512a1eb-2b9d-fda5-f2a5-c9f59dff972c@ramsayjones.plus.com>
Date:   Tue, 27 Mar 2018 04:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB5kHlA+9s35igwF00cgdR4KMC3q5qJxmO5cN9y4sMab80L7pvVbCan1VjhewPUuR4Yej6gMuZ1TVhUqpK48CbOsVkdz63ymrqDfskVR4E4XYNU1bKBU
 ZictlEfH9cOmJ4x0JtTw1rpqfRosDpbZ+Cfjvi2cCpBRn7qirS5Y6pthuZKBOVySEl3IwBrJJLwetA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/03/18 18:04, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>>> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>>>>  	maybe_add_comma(jw);
>>>>  
>>>>  	append_quoted_string(&jw->json, key);
>>>> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>>>> +	strbuf_addf(&jw->json, ":%"PRIu64, value);
>>>
>>> In this code-base, that would normally be written as:
>>>
>>> 	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t) value);
>>
>> heh, I should learn not to reply in a hurry, just before
>> going out ...
>>
>> I had not noticed that 'value' was declared with an 'sized type'
>> of uint64_t, so using PRIu64 should be fine.
> 
> But why is this codepath using a sized type in the first place?  It
> is not like it wants to read/write a fixed binary file format---it
> just wants to use an integer type that is wide enough to handle any
> inttype the platform uses, for which uintmax_t would be a more
> appropriate type, no?

I must confess to not having given any thought to the wider
implications of the code. I don't really know what this code
is going to be used for. [Although I did shudder when I read
some mention of a 'universal interchange format' - I still
have nightmares about XML :-D ]

ATB,
Ramsay Jones


