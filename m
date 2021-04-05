Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEDC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 18:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004C16124B
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 18:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhDEStF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 14:49:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64546 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhDEStE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 14:49:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCC6DB0039;
        Mon,  5 Apr 2021 14:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S8Sj2rtl6IdLGwCgI+xzKmvbz8s=; b=ha9tIP
        DV1T0mhd8ynCPO8GCTUEKNYys8L61fC+K/wV890/NMH5NwEZNyY8xs/mzFFJDTNi
        A4adGu2oj+/z/hvc4z/QO/xEyzZpApXiHjA4xM+SWkVGRnix1H57tTBoV9uY/rTK
        I43kW3ImRBo8URyQ/kKVz10yP6i9CaMJE+QhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xsn6bk0+zC3uPPoC54GupWRqQ+ilJHwg
        9V32Zom+cvl8DCHvrETRYQ4+Mm+szkTaYpfIVHOVAopSXqAMjfsaJRA6LiHF957Q
        UabLFWvy61e7hCO6Y20q4ZTQyQK144naPkl/bgWcihh2aPpp9+LHdaCfKJiq/xfe
        RJaHF26oiAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B590CB0038;
        Mon,  5 Apr 2021 14:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F40CB0037;
        Mon,  5 Apr 2021 14:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
        <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
        <xmqq8s613gqa.fsf@gitster.g>
        <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
        <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
        <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
        <xmqq1rbs4c6t.fsf@gitster.g>
        <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
        <xmqqft057ijc.fsf@gitster.g>
        <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com>
Date:   Mon, 05 Apr 2021 11:48:56 -0700
In-Reply-To: <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com> (Derrick
        Stolee's message of "Mon, 5 Apr 2021 09:20:41 -0400")
Message-ID: <xmqqr1jo5zzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93DC98D4-963F-11EB-8F53-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> ... but it becomes difficult
> when we intend to make a distinction between "refs/heads/" and
> other sub-areas within "refs/". Finally, I punted on that
> conversion and made the logic in 'prefetch' extremely obvious:
>
> 1. If the refspec's 'dst' starts with "refs/", then replace
>    that prefix with "refs/prefetch/".
>
> 2. If the refspec's 'dst' does not start with "refs/", then
>    concatenate "refs/prefetch/" and 'dst'.
>
> This will keep a roughly-equivalent partition of refs (some
> might have previously collided that will not any more).

Makes sense.  Do we need to add another rule?

3. If the refspec does not have 'dst', ignore it.

> I have posted my patch series [1], so please take a look. It
> builds up the infrastructure to properly test such a refspec
> expansion, if we wish to do so.
>
> [1] https://lore.kernel.org/git/pull.924.git.1617627856.gitgitgadget@gmail.com/
>
> Thanks,
> -Stolee

Thanks.
