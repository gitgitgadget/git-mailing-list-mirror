Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676FC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE03C2072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpG1T7T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgC3SKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:10:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63104 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgC3SKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:10:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C4D3CF939;
        Mon, 30 Mar 2020 14:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1hbP1YTABNBozpcHxA0+8XYuSGw=; b=TpG1T7
        T3KjhjKPqwDpmgFL4tFfurboMBAUS4/mnRIjt9RqmdUIgC+HHMntYDZakOBCXwIk
        aJe2pkbSNG7lKrvu1/NfEPagyGUKPGfbvTELvahdu1Gbx6ondz8PO+IVEleWstu9
        IWLdDGLHt9X82N9ZfEvM52SfuRfD1PJwqlYgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rjJD01D92qnvinR/2nXXpZDq0mx3cVb2
        dN6XkgpKkmxcs2Xv2/XLnvMzj2iwLbxN99BRCK2YKduf6BKa68swdv7Dimo+SzA3
        P1DFg1fUiZnIOcrMY1XyLwwXdInw6iF0LOgEAYTJh6NdinL6NrlduWCeB9CuWeE6
        /JAoKy8SOLE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 639CECF936;
        Mon, 30 Mar 2020 14:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9FE3CF932;
        Mon, 30 Mar 2020 14:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, steadmon@google.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] connected: always use partial clone optimization
References: <xmqqd08ua0jo.fsf@gitster.c.googlers.com>
        <20200330160412.120614-1-jonathantanmy@google.com>
Date:   Mon, 30 Mar 2020 11:09:55 -0700
In-Reply-To: <20200330160412.120614-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 30 Mar 2020 09:04:12 -0700")
Message-ID: <xmqqa73x90jw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A985903A-72B1-11EA-9783-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> >> Sounds good.  Jonathan?  I've squashed Josh'es Reviewed-by, but I
>> >> will refrain from merging it to 'next' just yet to see if you too
>> >> like the proposed code structure.
>> >
>> > I think that this is a local enough concern that going either way won't
>> > paint us into a corner, so if what's in
>> > jt/connectivity-check-optim-in-partial-clone is OK, I prefer using that
>> > to reduce churn.
>> 
>> If you do not think their improvement is not much of improvement,
>> then please say so.
>
> Yes, I don't think that their improvement is much of an improvement. If
> we were to split up the logic into functions, one of the functions would
> need to be documented as "Return true if all objects returned by 'fn'
> exist in promisor packs.

So we have a stronger basis to reject the different code structure,
and I think it makes sense.  Which is a better reason to give than
"it is a local enough concern and we can do so later if we wanted
to".  We probably do not want to anyway, right?

Thanks.  Let's mark the topic as ready for 'next'.

