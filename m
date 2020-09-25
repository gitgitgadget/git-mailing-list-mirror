Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F268C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A93721D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w+EqIrj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgIYQy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:54:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53492 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgIYQy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 12:54:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2439F281C;
        Fri, 25 Sep 2020 12:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FyamVsts2sqZINqe3uEys+hHF6M=; b=w+EqIr
        j9a3JZ94dsofCs21lmN+fLgqas3NsPwt3pwDsOMsT0FI3wlYfGySdV1XS7xjuBzK
        vyHWCKH5ZQQMxqAzR8TFf3u/OaIcWz+wUIOBuYmc8UOQWjH2Vf2Z+wdY9+/rk9yJ
        HKiRYpoa8+KUf7ZtJhS29EHeKvL1ZRH+tmwjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iqYwIBBUqe+6lGNhS4q+CJI+XgJ3lMpP
        Uu/f8JNEXj4jqS9hIqs6Tl1nFHHvALT4rb/RbkB6ZGR6LZV7k5YsKIdwFjCYWzT+
        OHVkLMtoIwu2nHfIlj1LsvUab74GfAeAafaaT1Da2MNu8IEoRQSYJGek1h51TOyH
        8xa1cQPV1UM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A4D4F281A;
        Fri, 25 Sep 2020 12:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC652F2818;
        Fri, 25 Sep 2020 12:54:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
        <xmqqa6xgi363.fsf@gitster.c.googlers.com>
        <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet>
        <xmqqo8lvgmdw.fsf@gitster.c.googlers.com>
        <xmqqwo0jm356.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009250910200.5061@tvgsbejvaqbjf.bet>
Date:   Fri, 25 Sep 2020 09:54:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009250910200.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 25 Sep 2020 09:13:44 +0200
        (CEST)")
Message-ID: <xmqqwo0hlrus.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2845F46-FF4F-11EA-AC6A-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A slightly bigger question is whether `git_oid_committish()` would be okay
> enough, or whether we do need `get_oidf(&oid, "%s^{commit}", arg)` (as
> your `SQUASH???` does).
>
> I'm not quite sure: aren't those two calls idempotent, with the latter
> going through some unnecessary string processing dances?

I tend to agree that get_oidf() is not quite satisfactory but it is
a handy short-hand that is readily available to us to parse a string
into the name of the object of type commit the string peels into.

While get_oid_X_ish() makes sure the result can be peeled to type X,
it gives the outer object back to the caller to allow it to behave
differently and it is up to the caller to peel the tag down to
commit.

I audited all uses of get_oid_X_ish(), in the hope that perhaps we
have enough callers that want to get peeled object back, and more
importantly, no caller that wants the original.  Then we could
change these to peel for the callers, and we may be able to lose a
few lines from the callers.

But unfortunately that was not the case.  A new helper

	int oid_of_type(struct object_id *result_oid,
			const char *name_text,
			enum object_type peel_to);

is a possibility, but I have a suspicion that the API in question
encourages to manipulate and swap objects at their hash level for
too long with little upside.  If we were considering to clean the
callers up, we would want to encourage them to work with in-core
objects longer.

IOW, repo_peel_to_type() might be a better fit for some callers that
use get_oid_X_ish() and then peel the result to obtain an object of
desired type.

Thanks.
