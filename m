Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D3C0015E
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 00:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGTANG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 20:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTANE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 20:13:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F56B3
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 17:13:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27FEC32DD7;
        Wed, 19 Jul 2023 20:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q0FvkWcph8Y/2JOSduKiHYUj2uAWI1LZ/zQTqQ
        7tNWE=; b=V2XrOJVn+FMU9v8lyq2Ug7V/JZhkrtmb142BYULyIubDk7eqa6m9x8
        EJMWWr5B7kZYF0lej9i+Jvzy5Em/wQM0zd9AoNTFjESRZrxksDr4WpVLF9m894xe
        ALZ4o04zUP1V3P08RzRkF+u+N45IzPtFV8qhTQjm6YmqMMASmjYDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2098432DD6;
        Wed, 19 Jul 2023 20:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98ECD32DD3;
        Wed, 19 Jul 2023 20:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] wrapper: use trace2 counters to collect fsync stats
References: <20230719232444.555838-1-dev+git@drbeat.li>
        <20230719232444.555838-2-dev+git@drbeat.li>
Date:   Wed, 19 Jul 2023 17:12:57 -0700
In-Reply-To: <20230719232444.555838-2-dev+git@drbeat.li> (Beat Bolli's message
        of "Thu, 20 Jul 2023 01:24:44 +0200")
Message-ID: <xmqqbkg75tkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EBEA81C-2692-11EE-A03E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> As mentioned in the subthread starting at [1], trace2 counters should be
> used to count events instead of ad-hoc static variables.
>
> Convert the static variables that count fsync calls to trace2 counters,
> reducing the coupling between wrapper.c and the trace2 subsystem.
>
> The counters are not per-thread because the ones being replaced also
> were not.
>
> [1] https://lore.kernel.org/git/20230627195251.1973421-2-calvinwan@google.com/
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> I have based this series on master, so this patch will create a trivial
> merge conflict with c489f47a649d (refs/packed-backend.c: add trace2
> counters for jump list, 2023-07-10) on next, which also adds a new
> counter.

Thanks for leaving a note.  This one was trivial enough to resolve,
but it is a good discipline to always make trial merges to 'next'
and with other topics in flight.

Did t5351 pass for you with this patch?  Any other test breakages
that the patch needs to also adjust?

Thanks.
