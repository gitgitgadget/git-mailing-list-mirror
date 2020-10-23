Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F3C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3F20E65
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgOkIzbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750874AbgJWP1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:27:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59589 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750870AbgJWP1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:27:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0ADE8F0406;
        Fri, 23 Oct 2020 11:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DeOLwJvwyOO2F7xXITHNOpk+a8A=; b=jgOkIz
        bsoGbZH4QPb2fV5GRbTIdp9z0dghZuCJ2RrxDhP+VsOkSDucOqEEQBgNe31u2AiF
        7+qoQu09ISAvP8s32i7gCJgsKvO/Jki0Fef0rB4aHE9VW3x0e/lAMJM1Gr+dy5PC
        00N98tAjj9GGw7RrZvevRWH91TQlwp/6L8+VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FeftpBtZAaXbUHEt37h9UQZnDbhEN33z
        tuWjfjS53OFDfP0lTHu1lXAEaWSF7MWrBgCgwrZQmvV8kCotEUSSHj4FMMdiS18Y
        g2R+xCKOcyjUDiRyLgXfoC01EMMf3Cb/dmx7of2/KTzdNSzLESGxmLocO+h2Yw/9
        pNpCdMtYI48=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 040DBF0403;
        Fri, 23 Oct 2020 11:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43D9DF0400;
        Fri, 23 Oct 2020 11:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
        <20201023080202.GA4012156@coredump.intra.peff.net>
Date:   Fri, 23 Oct 2020 08:27:37 -0700
In-Reply-To: <20201023080202.GA4012156@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 23 Oct 2020 04:02:02 -0400")
Message-ID: <xmqqimb1hsie.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 491419DE-1544-11EB-A804-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 19, 2020 at 11:13:22AM -0700, Junio C Hamano wrote:
>
>> * en/strmap (2020-10-13) 10 commits
>>  - strmap: enable allocations to come from a mem_pool
>>  - strmap: add a strset sub-type
>>  - strmap: add functions facilitating use as a string->int map
>>  - strmap: enable faster clearing and reusing of strmaps
>>  - strmap: add more utility functions
>>  - strmap: new utility functions
>>  - hashmap: introduce a new hashmap_partial_clear()
>>  - hashmap: allow re-use after hashmap_free()
>>  - hashmap: adjust spacing to fix argument alignment
>>  - hashmap: add usage documentation explaining hashmap_free[_entries]()
>> 
>>  A speciailization of hashmap that uses a string as key has been
>>  introduced.  Hopefully it will see wider use over time.
>> 
>>  Will merge to 'next'.
>
> I haven't gotten a chance to look at this carefully yet, but note that
> the strset here sort-of conflicts with the one I added recently in
> builtin/shortlog.c (already in master). I think the compiler won't
> complain because they never show up in the same translation unit, but we
> should avoid having two almost-the-same types in the codebase.
>
> I suspect my "check_and_add" function could be folded into Elijah's
> implementation. The other big difference is that mine uses the
> FLEX_ALLOC approach, and his doesn't. I haven't digested the code and
> discussion around that from Elijah's series yet.

Will take a look at them again.  Thanks.
