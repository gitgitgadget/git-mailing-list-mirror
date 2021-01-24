Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341B9C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D2522C7E
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAXGS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:18:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61707 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbhAXGS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:18:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F0AA9383E;
        Sun, 24 Jan 2021 01:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sp933IzA+urG9w7L4t3jfU6QHhc=; b=nowJMC
        FU7DaDQ82qBDhZiqmdeX+x0goqKXhUPt9Mt/krpqqOmuEdZW2zSNlK4sTaf8t+ec
        9U22iai7UVRweI+IlEYDt2rKfWvrb7gAVkNcqRfkXkn3/Gqo1jODj5W/YEBnyBjF
        KB4tkXprIuH6wRP6xaifMo6sbpb0LWJYmysNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qWUR8AL7non9aEaisSPqmCovQmqu0oZB
        HLmYFZES1uI7hIRC50aPu4DXl86hAcBvfZzKk2Qh+OQFhAbMbnp9ihH788tR/7Va
        hlNrgV9ZW2wSSip71qB6do8bro+ntezFnqXMWG3y0l9nJn7KeqSd0s0S9rLPyn6Y
        Bz5JyJFrYcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 391A79383C;
        Sun, 24 Jan 2021 01:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC0F293839;
        Sun, 24 Jan 2021 01:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sunshine@sunshineco.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
        <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
        <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
Date:   Sat, 23 Jan 2021 22:18:13 -0800
In-Reply-To: <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com> (Philippe
        Blain's message of "Sat, 23 Jan 2021 21:41:29 -0500")
Message-ID: <xmqqeeia26ze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F11478A8-5E0B-11EB-BF4C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Yes, a quick Google search pointed me to a blog post [1]
> that mentions using 'fail-fast: false' in the test matrix so that
> one failing job does not automatically cancel the rest of the jobs
> in the matrix (the default is 'true') [2].
>
> If we apply that to all four matrices in the workflow file,
> (windows-test, vs-test, regular and dockerized), it would be
> something like this:

I am assuming that "failure of build stops tests from running",
which is done on the windows/vs-build side, is still kept with
this change.  If that is the case, it sounds quite sensible.

> I've CC-ed Dscho regarding if we also want this for the Windows tests,
> (I don't see why not) and if we feel it's a good idea I can
> send a proper patch.

I often see windows/vs-test #4 fail first and take other 9 with it.
We may see some interesting patterns to emerge, when we run all of
them (and let all of them fail X-<).

Thanks for working on this.
