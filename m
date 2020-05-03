Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BAC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA70F2068E
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QlsyFFM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgECQzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 12:55:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55314 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgECQzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 12:55:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EED2FD24FC;
        Sun,  3 May 2020 12:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rZxW6pN+SCvwoH6DUhPqS7Zv/94=; b=QlsyFF
        M4I+KdBqH5dpTDgqPLsSG5zSWm59kMItQlKT/vEFMwGDOoz/Ss2o33SFWN5PMENJ
        I+5D/Tl5uXDwyhuAX2xj1qH4kDsPvN1V9Zf0iP7lN2bveEWCbKtbUTAhTP276b8q
        3rv9kEi9e+Qa9DsLnjrAMBi9WeIJNW4eF72Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mbs6ZgyA7QAaidD9daftKu3OiKQB8JFh
        3aopy9HDOzH51QOOrwT2xyvdM1BuhF6CWxSQeic5LBQloFu6Qfnqhvt8KNFNVsRs
        LqUh2kCr/mRIRNmdv5JCqgry9AWtNyJoW4mME7HJ/Biz5tzUj/a2RnfTV3ClcupH
        xe9QHmmsTkw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E60C7D24FB;
        Sun,  3 May 2020 12:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29C3CD24FA;
        Sun,  3 May 2020 12:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
References: <cover.1586836700.git.me@ttaylorr.com>
        <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
        <20200415042930.GA11703@syl.local> <20200415043137.GA12136@syl.local>
        <20200422105536.GB3063@szeder.dev> <20200422233930.GB19100@syl.local>
        <20200424105957.GB5925@szeder.dev> <20200501223848.GH41612@syl.local>
        <20200503094005.GD170902@coredump.intra.peff.net>
Date:   Sun, 03 May 2020 09:55:39 -0700
In-Reply-To: <20200503094005.GD170902@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 3 May 2020 05:40:05 -0400")
Message-ID: <xmqq5zddj6us.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBDE6264-8D5E-11EA-A818-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 01, 2020 at 04:38:48PM -0600, Taylor Blau wrote:
> ...
>> So, I propose the following:
>> 
>>   * We drop the idea of '--[no-]{check,verify}-oids', and always
>>     silently ignore non-commit inputs, retaining the existing behavior
>>     of always complaining about things that aren't valid hex OIDs, such
>>     as "HEAD".
>> 
>>   * We always error out on missing or corrupt commit OIDs, including
>>     valid OIDs that don't resolve to any object, or resolve to a tag
>>     that can't be fully peeled.
>> 
>> Does that seem reasonable?
>
> FWIW, I think that is the best direction. If anybody is depending on the
> "commit-graph write will complain about non-commits" behavior, they
> could only be doing so for a few versions; prior to v2.24.0 we did not.

If we had it for the past 180 days or so, that's not like " people
have seen it for only a brief time", but working it around shouldn't
be too difficult---they need to validate the input they feed to the
command themselves (or do they need to do more?).

Thanks.

