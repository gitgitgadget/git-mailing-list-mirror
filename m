Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89680C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1A23EF4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391495AbgLKLXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:23:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53606 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbgLKLXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:23:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C054210F533;
        Fri, 11 Dec 2020 06:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=k+jABQPm48H8IHwC+rqe8K0piVM=; b=o6SrlHu8aa9y+uZ0LH9P
        KHBvkm5qutMNQ5Asf/UCunFWfVXk4S6J2iMQvZP+h06Dg/UEvwZ9BlU7DlzMGfUh
        SAnQfo4plAvsKbx8w+FdxN1b080LgbXPEACsHc9tna7x52dHAaOIwxaQ4QOpulag
        1f7I+36e11V8lhKJbQbpESA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=FeEfSqNTDGHa9/WKYTrsueV/P7wck/lmDD7pYF1dyocM1Z
        JCFj98bGo8XtjvRL9Y9F30LVKwI95zonOQ5v9P5dg27kSqyhHTeRCNqd6ktTZRfJ
        Z4t7JWtuODZK4dS8vVdUhqUJQvNHDCKJRNXSUyQGaDuGk1WDf3FFXqpy0YY/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8C4110F532;
        Fri, 11 Dec 2020 06:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10E3410F531;
        Fri, 11 Dec 2020 06:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
Date:   Thu, 10 Dec 2020 23:17:13 -0800
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
Message-ID: <xmqqo8j0io39.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 350F782C-3BA3-11EB-9924-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The discussion about making fast-forward-only pulls the default is
> stuck on mud, and there's no agreement about what we should even
> be warning our users about.

The above perception of yours is mostly due to misunderstanding, I
would have to say.  We are in agreement on what we should be warning
about at least, assuming that you are expressing what you want
clearly in the latest round of responses and I understood them
correctly [*1*].

I do not know if others on the list agree, though.

I do agree that there is no agreement on the behaviour in the
endgame.  In principle, I am in favor of disabling the more
dangerous half of the "git pull" command for those who haven't
configured anything.  But I can understand those who do not want
that behaviour, as the fallout would be quite big.

> Even my straightforward patches about improving documentation, and
> the consistency of the UI with --merge and other obvious fixes
> lost traction.

It may be obvious to you, but may not be to others on the list who
spoke in the thread and who didn't speak but read the discussion.

I did see potential goodness in the documentation update and that
was why I offered polishment on top of your patches in a v3 round,
but seeing the suggestions dismissed without convincing arguments
before v4 was sent out would have discouraged even the most patient
reviewers among us.  If you meant by "lost traction" the lack of
comments on v4, that was my reason for not commenting.

In any case, these three patches in this round looked quite sensible
to me, except for the tests in 3/3, and minor details of 2/3, both
of which I gave a more detailed review and suggestion.

Thanks.


[Footnote]

*1* The only difference between us is whether it is sensible to
allow explicitly ask to see the same behaviour as an unconfigured
user except for the help text---I do not think it is, and I do want
to avoid introducing pull.mode, but I've shown a way or two to get
the behaviour without adding pull.mode in the mix.
