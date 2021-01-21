Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D57FC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBB2238E8
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbhAUDuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:50:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbhAUDtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:49:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66E1A101A65;
        Wed, 20 Jan 2021 22:45:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MSf6uENHfxgvil38xdfDVmeQHQ=; b=fzXjmE
        fRwp9JStRpeQAf54TO7/mTzOOgU7iW7nSk88xpPOGRqAjdMujFew/fhGx10/E19j
        z9HXXRsPcEMsjtioBh+pw79fYvcmoDN64nLTeFmFJo50S4WeP0YAC070PeV31EZT
        svRa+4K9QZzT82ggZZ9A6C535uTpqvB6Ikerg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ezbrLneLM2G82MD3aCAd1VUP+K/yIkfL
        2xuQE49ET+17paSHQoEYNkO87h0FeScO+lhSjvFPnSxcWnGMtXz/dic8NMBrPa9U
        ePi9Qp33i01zZHUxXSnNIMcMCvd7BA1kEHWUQNNNMp8mzGc8h394mI1JU4wP2llY
        laJTbxYM1HE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FE04101A64;
        Wed, 20 Jan 2021 22:45:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8DDA101A62;
        Wed, 20 Jan 2021 22:45:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 09/10] builtin/repack.c: extract loose object handling
References: <cover.1611098616.git.me@ttaylorr.com>
        <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
        <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com>
Date:   Wed, 20 Jan 2021 19:45:17 -0800
In-Reply-To: <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com> (Derrick
        Stolee's message of "Wed, 20 Jan 2021 08:59:48 -0500")
Message-ID: <xmqqk0s7c5rm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 151AE002-5B9B-11EB-8578-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/19/2021 6:24 PM, Taylor Blau wrote:
>> 'git repack -g' will have to learn about unreachable loose objects that
>
> This reference to the '-g' option is one patch too early. Perhaps
> say
>
>   An upcoming patch will introduce geometric repacking. This will
>   require removing unreachable loose objects in a separate path
>   from the existing checks.
>
> or similar?

Yeah, sounds like a trivially obvious improvement to me.  

It does not matter to reviewers who are very well aware that the
series is about adding "repack -g", but it may end up being
confusing when somebody tries to see what commit the feature was
added later when the help from the cover letter is not available.
