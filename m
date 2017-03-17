Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F330920323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdCQFWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:22:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63505 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdCQFWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:22:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A55B6D756;
        Fri, 17 Mar 2017 01:22:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vzdJEAScZNvRE6wqtwureNsVzoY=; b=L29dIX
        mmQjFJ5L5ugc0tG0HYNqs/Ty4O61iuvV2JqLNL6scaU43zs4zusDCKw+39H3cg/a
        qGTnl5qYm65jSS0+p97CxhMd0pagdi/CWTfWVRCZAD4WvOl684ZN9SbjPHi92jm1
        QtPgtmj9yhaFtrsvJFGd8O01GT9Jphq5BrjLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wX414EP7eirHxkiTBdYQzWvx5cOoV+MM
        QIP2KjCYtYkd1upLvTe6knd3shPmYl7nlcort4X9kIwXV0E70dJik8gJEGsTb2Om
        lGuMB2ZRgpoVnFAe+6BqJrxF+JA+lqzSEKbal7AiOpWuGeW+MVKHvUM5DZebGX3W
        Ed0gxRZmW48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833606D755;
        Fri, 17 Mar 2017 01:22:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4FE26D753;
        Fri, 17 Mar 2017 01:22:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
        <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
        <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net>
        <xmqq37ecc134.fsf@gitster.mtv.corp.google.com>
        <20170317001416.bthqvjbf554zhrj5@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 22:22:12 -0700
In-Reply-To: <20170317001416.bthqvjbf554zhrj5@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 20:14:16 -0400")
Message-ID: <xmqqlgs4a35n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADDD42EA-0AD1-11E7-86F1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 16, 2017 at 03:23:59PM -0700, Junio C Hamano wrote:
>
>> I am wondering if we should queue another one for .travis.yml on top
>> to force use of USE_SHA1DC=YesPlease during the tests.  I expect
>> that we'd be encouraging its use for ordinary users without any
>> specific needs in the release notes in 2.13 release.
>
> I don't think it would buy us much. There's not really any way for this
> build to interact with the rest of the code in any interesting way, so
> either it works as a SHA-1 implementation or it doesn't. If you just
> want it exercised, I'll say that it's powering all of github.com right
> now.
>
> I did wonder if we should ship with it as the default (instead of
> openssl). It's definitely slower, but maybe widespread safety is a good
> thing. OTOH, I think we have a fair bit of time before we see any
> real-life collisions, just given the time and expense of generating
> them.

My .travis.yml suggestion was about testing with SHA1DC in
preparation for making it the default.  That would give us another
incentive to keep an eye on its performance, too, before we make it
the default in Makefile, at which time the forced selection in the
travis configuration can be removed.

Thanks.


