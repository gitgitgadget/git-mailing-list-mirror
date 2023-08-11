Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FF4EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjHKPrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjHKPrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:47:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11527270F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:47:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB006324D3;
        Fri, 11 Aug 2023 11:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gK90lOkq/1QIRzXiVllHxoM2KR3R2v0QzHKINj
        uJl8s=; b=nIMzH4Q7EXJ0z7CSs4jrwXsg6mK82S2nTQRf2bkvS0mvkSM3HTAwaZ
        6tfqMWNDE9f55VWtR3OpncAvM6ABU6r754etk4rTjtvW/zWe+5xBzer0b4wfXMiD
        VbK5ifzzWTM6P7g2HRxR1JqGbRynMvK1/1r68XIGK4PDrU2K5pLs0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2C5F324D2;
        Fri, 11 Aug 2023 11:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43BFA324D1;
        Fri, 11 Aug 2023 11:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t4053: avoid race when killing background processes
References: <pull.1571.git.1691677993195.gitgitgadget@gmail.com>
        <xmqqedkassng.fsf@gitster.g>
        <2d9e9b59-bf78-8470-0731-3cd7fe15a727@gmail.com>
Date:   Fri, 11 Aug 2023 08:47:27 -0700
In-Reply-To: <2d9e9b59-bf78-8470-0731-3cd7fe15a727@gmail.com> (Phillip Wood's
        message of "Fri, 11 Aug 2023 10:56:40 +0100")
Message-ID: <xmqqsf8poa28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FF35526-385E-11EE-8224-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/08/2023 18:40, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> While I can see that "kill" in the when-finished handler may or may
>> not find the backgrounded process by the time it is run, and
>> ignoring its exit status (hence keeping test_when_finished happy)
>> would be a reasonable thing to do.  I can understand if this patch
>> is to fix a different symptom, namely, when-finished handler
>> sometimes fails and makes the test fail.
>> But I am not sure how this causes the test to "hang", 
>
>
> This is only a fix for the test failure that Peff saw when running
> with --stress.

Ah, OK.  I obviously misread the proposed commit log message.  And
as a race-fix, this would be good.

Thanks.
