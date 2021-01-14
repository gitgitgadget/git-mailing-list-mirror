Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6293C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ADF23A6A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbhANTJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:09:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbhANTJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:09:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2525B11294A;
        Thu, 14 Jan 2021 14:08:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsqsgvUz/9SBHDRky4+IKpflfn0=; b=Xl0n6E
        QHYQ69co7+EOql31b/17WbMys1vkDaG/UfNUKhnm0kBE84RZfxl8TJ6NWm+3Gw+r
        xhZHq4VoYVdbH7klF5sUe2MWnHcMu3Y6b7f/2zR9nAXtT6HvhuCb59VWt6bztdIG
        9Asmwoo9XigsyboKeFD/HqZ8uAkbO2fI6WTJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FTFHtDlquYeeXO5ftku+S+jCThYpWkfv
        Q5TQ5L0bP6o25R6t9YZ+mxGgMQBQWB3W3a/QpMc20HF16GK3omijAE2cCLuQ5WdH
        K82Y/2kpg3Mg9us3EcAcwoCNXHYuGrs15Ae0YPgKNlCZ1vVXci+Rr87xaqSWJjPx
        hZdn1y3NiM4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D2DA112949;
        Thu, 14 Jan 2021 14:08:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6798C112948;
        Thu, 14 Jan 2021 14:08:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/1] And so it begins...merge/rename performance work
References: <20210108205111.2197944-1-newren@gmail.com>
        <20210113221158.2869128-1-newren@gmail.com>
Date:   Thu, 14 Jan 2021 11:08:50 -0800
In-Reply-To: <20210113221158.2869128-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 13 Jan 2021 14:11:57 -0800")
Message-ID: <xmqqo8hrxrnh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0C657A8-569B-11EB-B12C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
> and en/ort-directory-rename.

Thanks.

How ready is the foundation to accept this change?  This will depend
on all of the above three topics and I am not sure what the status
of them is---I think that I've read through the diffcore-rename one
and it was a pleasant read, but I do not recall the reviewer
reactions to the other two.

It does not instill a lot of confidence in these topics that nobody
commented on things like [v2 17/17] of en/ort-directory-rename
(which fixes the code introduced in [v2 06/17] instead of fixing it
at the source before 06/17 copies it from elsewhere [*1*]).  It
looks to me like a sign that these collection of series are moving
too fast than any reviewer to catch up.

Thanks.


[Footnote]

*1* I do not particularly think [06/17] that copies and leaves the
    recursive backend behind is necessarily bad.  What I find more
    disturbing is that nobody seems to have a chance to give any
    look to the two iterations of the series (as far as I can see,
    v2 is just in name only---it removed 18/17 in v1 that were not
    meant to be sent), and we are about to build on top of the
    foundation that nobody knows how solid it is.
