Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E6FC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F6522955
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLDT6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:58:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51304 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLDT6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:58:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8EE397EBF;
        Fri,  4 Dec 2020 14:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2WhPc0C3TcsNmD/zPNkAY5cvCfs=; b=YysQGD
        zdVW+gYxuBmGWPhTj25FKX9BWsPfJJqB4UdWJDGkDwfdE1jUv1XmpJ+z+guQm0wu
        4QxYadf6B9DrGooaig7nFqeTGqBQ5L7jGY9NCW7bfuoxSyIG4tWRn/aHRQ4vcG4D
        hLPVVCqfOHV8ZclDUgcqs6P62+pQErP5UWWjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJpXLfluHNM1jv/27bTYF2LdHWS/FBBT
        CG2jFItZe025fCswYTVxBD1WGfesxbaS+u2guClPrBRsEY+2Z9rsAPfNclksoTvy
        xVld+aAJDzaLmBW/9vKk7JfG9pHofVQrL6QoRH4fjvJdsgjFzBCXFAos5p86dO0P
        pCMjKJ48vjw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFE4E97EBE;
        Fri,  4 Dec 2020 14:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37AAB97EBD;
        Fri,  4 Dec 2020 14:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Denhartog" <ben@sudoforge.com>
Cc:     "Jeff King" <peff@peff.net>, git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
        <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
        <112958f6-0eca-453d-86f3-52e7054a88f9@www.fastmail.com>
Date:   Fri, 04 Dec 2020 11:57:23 -0800
In-Reply-To: <112958f6-0eca-453d-86f3-52e7054a88f9@www.fastmail.com> (Ben
        Denhartog's message of "Fri, 04 Dec 2020 09:45:17 -0700")
Message-ID: <xmqq360lfios.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED690F34-366A-11EB-A16C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Denhartog" <ben@sudoforge.com> writes:

> To the rest of your message:
>
> I did not understand the behavior of `fetch --all`; what you've
> described makes sense to me (although I would agree that it sounds
> like there's a bug). Between the following steps I'll take, I
> think my fork workflow is "fixed":
>
> * Refactor away from usage of FETCH_HEAD

Yes, "fetch --all" is about updating the remote-tracking branches
and in retrospect, perhaps we might have avoided confusion if we
made it not to touch FETCH_HEAD, but it is not going to change now.

> * Set `remote.pushdefault = origin`
> * Set `push.default = current` (instead of `simple`, and is what
> my global config sets this to)

I have a feeling that simple vs current does not make a difference
if you are pusing main to main, and if so, push.default could be
left to the default settings of 'simple'.  But the key to successful
use of the triangular workflow is to configure so that "fetch/pull"
goes to one place (i.e. your upstream) and "push" goes to another
(i.e. your publishing repository), and "remote.pushdefault" is a
good ingredient to do so.

It is however more common to use 'origin' as the name of your
upstream repository (so that "git fetch" and "git pull" would grab
things from there by default) and set remote.pushdefault to the
remote you push into, though (iow, I found remote.pushdefault
pointing at 'origin' a bit unusual).  Doing so may make your
triangular workflow work smoother.

> I appreciate your insight and the identification of the problem.

Thanks for a concluding comment to report a success.  It's
reassuring to hear a positive feedback.
