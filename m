Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E5C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E6D206A1
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="efM0Ek55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbgJAPsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:48:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61288 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbgJAPsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 11:48:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2171E0899;
        Thu,  1 Oct 2020 11:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DRlgoL2ox4cdrfOPJo+BsjJ9DN4=; b=efM0Ek
        55tvcoajq14IzKyHl490vv8F5Z2j8gdrqsZxYdJAp88BAtF8w1IRE0d5TCCUH8XS
        Eb50lW68ONWNBOVajwsxoJo3os0o78E9i6wUBfKFVXYD36cqaiDMAEVtIS+nrZl3
        /IOZK7e9ZzvyHJsufnZ+w+vtrPeywzld3tKdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jf74zDL3PIiCL7bxam5JbTsEuHbd+Yqj
        rUbnKjs1zPnDLRrN12ADSLFVXjAGTeM/1eLPVwxR4SszZKr5DUWgWrnX8R7TW6UZ
        Cf/q73pij10xhdJIStQ144cSIIxhOjrzE4ow6P+h1yuW59g9dQ/D1HoABKyyXmkX
        DSX3pm5Ki84=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA97CE0898;
        Thu,  1 Oct 2020 11:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23D41E0895;
        Thu,  1 Oct 2020 11:48:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <xmqqlfgqes95.fsf@gitster.c.googlers.com>
        <xmqqtuved70y.fsf@gitster.c.googlers.com>
        <20201001034350.GB2930867@google.com>
Date:   Thu, 01 Oct 2020 08:48:24 -0700
In-Reply-To: <20201001034350.GB2930867@google.com> (Jonathan Nieder's message
        of "Wed, 30 Sep 2020 20:43:50 -0700")
Message-ID: <xmqqh7rec5h3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B2E74CA-03FD-11EB-99FE-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In addition to not having to futz with TZ, I think I like the
> semantics better.  The motivation that started this thread was not so
> much "I want to set a custom timezone to blend in" but rather "why are
> we recording the timezone at all here?"  In that context, it makes
> sense to me to have a setting such as
>
> 	core.recordTimeZone
>
> that I can turn *off* to say that I don't think datestamp() callers
> should consider the timezone to be information worth recording (and
> instead they should write +0000).  To me that seems a little simpler
> to understand than user.hideTimezone since this focuses on turning
> some functionality off (recording of the time zone) instead of turning
> on a new stealth mode.

Hmph.  It is a valid way to look at the issue, I guess.

Thanks for an input.
