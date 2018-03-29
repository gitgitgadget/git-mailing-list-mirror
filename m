Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87131F404
	for <e@80x24.org>; Thu, 29 Mar 2018 13:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeC2NrP (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 09:47:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:37702 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbeC2NrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 09:47:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E5C083F4141;
        Thu, 29 Mar 2018 09:47:12 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A285D3F4140;
        Thu, 29 Mar 2018 09:47:12 -0400 (EDT)
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled
 by config
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
 <xmqqo9j77sub.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <16479282-4241-7bf2-5f7c-b7889eb0e906@jeffhostetler.com>
Date:   Thu, 29 Mar 2018 09:47:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9j77sub.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/28/2018 6:12 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
>> 2017-12-08), it was guarded by the uploadpack.allowFilter config item
>> to allow server operators to control when they start supporting it.
>>
>> That config item didn't go far enough, though: it controls whether the
>> 'filter' capability is advertised, but if a (custom) client ignores
>> the capability advertisement and passes a filter specification anyway,
>> the server would handle that despite allowFilter being false.
>>
>> This is particularly significant if a security bug is discovered in
>> this new experimental partial clone code.  Installations without
>> uploadpack.allowFilter ought not to be affected since they don't
>> intend to support partial clone, but they would be swept up into being
>> vulnerable.
>>
>> Simplify and limit the attack surface by making uploadpack.allowFilter
>> disable the feature, not just the advertisement of it.
>>
>> NEEDSWORK: tests
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Noticed while reviewing the corresponding JGit code.
>>
>> If this change seems like a good idea, I can add tests and re-send it
>> for real.
> 
> Yup.  The names of the static variables tell almost the whole story
> to convince me why this is a good change ;-).  It is not about
> advertising a feature alone, but if the feature is actually enabled,
> so advertisement and handling of the feature should be either both
> enabled or disabled.
> 
> Thanks.
> 

I agree.  Thanks.
