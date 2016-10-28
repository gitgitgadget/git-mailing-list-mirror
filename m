Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E406C2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034257AbcJ1RVM (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:21:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034082AbcJ1RVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:21:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0000E4A72F;
        Fri, 28 Oct 2016 13:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ll7e3I1bxyY2blJdH5oZCTKpMo=; b=Mmn3Dz
        YnVaUwLt5XMQDyZZurpS7CwTCNFBwb+/hL0pwa77hcGtJEr8Oc2npTLMcXAstTso
        F6ZhtnUOwxZBB7Y7sq7EzZXt1z7/PxIpFs4rHxly0Jq7YbzZirBj5K880WxorISD
        /vlQHCLPSgHY/OB8q9EXTgXIFpI6cfQMCTM14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QALOzPCs5WrUv+2GtyV0WUSREwKR7BAy
        00m6di0X307/SPzJVFiLGpM+nsyPwY0x0fhTNdkiy+gO5z2HrH2oRTkWoozgH29H
        Id5noaE/ZaWa+jBieBn0ToOKckyIJ3S0dr6VfRqjJml4yznPmgBI8/TWNukKNx8Q
        1IzdG3V9feE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB6B44A72E;
        Fri, 28 Oct 2016 13:21:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62AF94A72D;
        Fri, 28 Oct 2016 13:21:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
References: <20161027223834.35312-1-bmwill@google.com>
        <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
        <20161028170213.GA72114@google.com>
Date:   Fri, 28 Oct 2016 10:21:07 -0700
In-Reply-To: <20161028170213.GA72114@google.com> (Brandon Williams's message
        of "Fri, 28 Oct 2016 10:02:13 -0700")
Message-ID: <xmqqeg301jb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAC6F15E-9D32-11E6-B461-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> Just a few brief comments, before reading the patches carefully.
>> 
>>  * It is somewhat surprising that [1/5] is even needed (in other
>>    words, I would have expected something like this to be already
>>    there, and my knee-jerk reaction was "Heh, how does 'git status'
>>    know how to show submodules that are and are not initialized
>>    differently without this?"  
>
> Yeah I was also surprised to find that this kind of functionality didn't
> already exist.  Though I guess there are still many builtin's that don't
> play nice with submodules so maybe this kind of functionality just
> wasn't needed until now.
>
>>  * It is somewhat surprising that [4/5] does not even use the
>>    previous ls-files to find out the paths.
>
> The first attempt I made at this series used ls-files to produce a list
> of files which was then fed to the grep machinery.  The problem I found
> with this approach was when I started moving to work on grepping
> history, at that point it seemed to make more sense to have a process
> for each submodule.

Yup, that makes sense to me.

