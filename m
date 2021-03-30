Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9254C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5251B619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhC3XEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:04:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51530 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhC3XEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:04:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86CB411B785;
        Tue, 30 Mar 2021 19:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9F3Vu5YuEKSyat/No0GoFoHEPlU=; b=iys2Zn
        6VDQgzvuymkhGeVmjqB1WpBpy+ZmGthBTl0gPh8PJDc0eEj8G/yg++OpgDquVG8e
        ngjpU+UQEMbmX2BHX2U2H4IgKpKrzg96yTe5QaPHRMRraqF3IYAAIwCbCJDYk92A
        Fx+VS8ZkcfHEXipAxGO3Y0eWTr/fvdDs+zZpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s550ykYhgWsl6AJawUA6JxGayp6eXQRp
        Kf7y+ntmzcz+LeFvMC4KRZzptV+uC5Tg6/+GGzY5j9/0ey7WYdKwqOgVjSaaVDeR
        kMNxgH4ed/h6zk+Dy+QnKnwE99KU8J41iKzQ4riKO4hPoPa0qUMC+iWvrI3Vd3NJ
        RNvegO0ZedA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F7C811B784;
        Tue, 30 Mar 2021 19:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B447D11B77E;
        Tue, 30 Mar 2021 19:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is
 passed
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
        <YGLNBFJv8NKmrbvz@coredump.intra.peff.net>
        <xmqq35wceae6.fsf@gitster.g>
        <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
        <xmqqa6qkcnqa.fsf@gitster.g>
        <CABPp-BEVFi+EsGMCv=qEhe_OGwmWwXF-mg9rjWYNuF0tDZnASg@mail.gmail.com>
Date:   Tue, 30 Mar 2021 16:04:01 -0700
In-Reply-To: <CABPp-BEVFi+EsGMCv=qEhe_OGwmWwXF-mg9rjWYNuF0tDZnASg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Mar 2021 15:43:32 -0700")
Message-ID: <xmqqlfa4b5we.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3828EDFE-91AC-11EB-A704-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Your "as long as" is I think the assumption that's violated in the
> workflow in question.  You may have the replace ref defined, but
> others don't[1].  Neither party has the actual original deadbeef
> commit[2].  Having deadbeef in refs/heads/foobar leads eventually to
> creating commits with deadbeef as an explicit parent, as we discussed
> above.  While that's internally consistent, as you point out, can you
> push your new commit elsewhere without pushing the replace refs too?

I think the change to "branch --contains" would be an improvement
whether you actually have deadbeef or not, but in any case, defining
(eh, rather, being able to define) a replacement for something you
do not have is the ultimate source of the problem.  And that "bug"
has not very much specific to how "branch --contains" should behave.

> Why does `git branch` (in conjunction with one user deciding to fetch
> replace refs) make it so easy to create a branch that cannot readily
> be shared with others?

In other words, I do not think it is "git branch" or "git checkout -b"
that brought your repository into a broken state.  The "replace"
mechanism may have room for improvement to avoid such a corruption.

IIRC, the original "graft" mechanism did not even have any UI, so it
was pretty much "you can graft any parent to any child, and if you
break the repository you can keep both halves".  Now "replace" has a
dedicated UI component in the form of "git replace" command, we should
be able to teach it how to record replacement more safely.

