Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E80C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B978423131
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbhASHsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:48:15 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:46756 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbhASHpC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:02 -0500
Received: from [10.42.0.115] (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10J7i22F011495
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 19 Jan 2021 02:44:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10J7i22F011495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611042244; bh=8HfdA+UROvoQHQvR7USUSP8SaroV0yxbPg7gJqum4NU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bvm6AYwuqvV2hTl175J6zve+VmicHChMx1pDbfrWRl+mb2j+dK4VyQVyb8U9AdIJT
         27YR0Pfu0b/e8O2dacmxmkdBpUsjxpP2DDBaX7wVs68HhbKOXg1N0Ut0VgR2Ae08pQ
         ys6F3rkhyTgBeIAznsNM05dxvOnoyBPr4SYGaZ92zrWrmWIarEzRFxO6XxJNBtpQ9q
         KOt/45GTOZgDEvDFjIG9XhCAULNgG1QKmKiuMn5EigB+/5K2fdlB5W4SZknOBu+BJk
         DzSJMLfleKfg/o8NN2MWH1vVP/DTKVG0QoqdQWwdRs+FSLV26xrdjWuJLEy8JukmiG
         UBrX2gO64hWzw==
Subject: Re: [PATCH 2/2] revision: implement --show-linear-break for --graph
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
 <20210117110337.429994-3-kmarek@pdinc.us>
 <xmqqsg6zkwa8.fsf@gitster.c.googlers.com>
 <xmqq35yzknbr.fsf@gitster.c.googlers.com>
 <04c81462-3181-37d7-0109-4292040b84e9@pdinc.us>
 <xmqqmtx6j6wt.fsf@gitster.c.googlers.com>
From:   Kyle Marek <kmarek@pdinc.us>
Message-ID: <04380a95-b8cf-f246-e496-dc469f617eb5@pdinc.us>
Date:   Tue, 19 Jan 2021 02:44:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtx6j6wt.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/21 4:01 PM, Junio C Hamano wrote:
> Kyle Marek <kmarek@pdinc.us> writes:
>
>> Me too, but I think a user-defined mark needs to be a string to
>> support Unicode characters.
> Ahh, I didn't even consider making it user-defined.
>
> As it seems a lot safer to make this an optional feature, it does
> sort-of make sense to let the letters used for root & left-root be
> customizable, and it does make sense to take a multi-byte character,
> but I am not sure what implications it has if we allowed any string
> without ensuring that it occupies one display column.

Does git, or a dependency library, have the ability to interpret TERM 
and locale to determine on-screen character count/size?

If not, maybe let users use multi-character strings, but call it misuse 
of the option that will mess offset that row of the --graph output until 
we have something to determine on-screen size.

-- 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Kyle Marek                        PD Inc. http://www.pdinc.us -
- Jr. Developer                     10 West 24th Street #100    -
- +1 (443) 269-1555 x361            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

