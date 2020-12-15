Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0CFC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECCA2084D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgLOCXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:23:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57758 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgLOCXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:23:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAE1F9651F;
        Mon, 14 Dec 2020 21:22:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GcPxHIyUd85Q
        1S2yaoQ5UNUCpbQ=; b=g26WudLaHN6dUtJglS9lngVwH3U7UqKQqQYpkRKVPL0q
        63jkYt1EdWD7zVh4Ax04htKZTLNUS12P6EFBvjao63g0UO8QFQ3Y0Cyi0ZxXPGmy
        bPrgzmgwYA8lMoBdlJHgtbZc3g6CDAEcuUZ6G6dCirwR83J3bVE1WIQL4g1JWuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S2evZA
        di9fZotGaezYdqu+vtD2finiyIwDRfUn3kfKGnbg15OkYfSNGGgPGQbGCIb3LHJu
        sQHs3pybDD5KZ1uf8C9fJVO7zz2Jwk8le3PMAdhGn88+wUygisIx0/VzCI6z6VvK
        47vcjHL6Rlbhb0nRHL3SLKBfs+P0I/+gCjW8M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A20EF9651E;
        Mon, 14 Dec 2020 21:22:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C7999651D;
        Mon, 14 Dec 2020 21:22:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
        <87blewwoil.fsf@evledraar.gmail.com>
        <xmqqim94e4et.fsf@gitster.c.googlers.com>
        <878s9zx2ul.fsf@evledraar.gmail.com>
Date:   Mon, 14 Dec 2020 18:22:17 -0800
In-Reply-To: <878s9zx2ul.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 15 Dec 2020 02:41:38 +0100")
Message-ID: <xmqqim93ajvq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A9C30AE-3E7C-11EB-BC20-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. this feature seems like a candidate to be exposed by something lik=
e
> by a ls-remote flag if you'd like to do an init/config/fetch. AFAIK the
> only way to do it is to mock a "clone" with GIT_TRACE_PACKET or get the
> information out-of-bounds.

Yes, I think the updated protocol should be able to help adding a
new feature usable by script writers, and I agree that ls-remote may
be the ideal home for such a feature.

> To borrow from Felipe Contreras's reply in the side-thread "I expect th=
e
> branch name to be chosen by the person who created that repository".

I expect a bit differently.  My expectation is that "git clone"
tries to help you inter-operate well with the project you clone.
You may be creating your local repository by cloning theirs, but
because I do not expect "who created" matters more than how well
end-users' workflows would work in the resulting repository, I
do not expect local init.defaultBranch should matter here.

If the project you would eventually push back to designates one
branch as its primary branch everybody is expected to work off of
(which is what it means to point it with their HEAD), it is
convenient if your local clone names your primary branch to match.
The push.default settings like 'simple' and 'current' are designed
to work well when your local branch namespace matches what they
have.

> I suppose this comes down to a mental model of what it means to have
> "created a repository". When I click "create repo" on those popular
> hosting sites (e.g. github & gitlab) and clone it I was expecting it to
> just be a shorthand init + a URL in my config (and refspecs...).

So, no, I do not think "who created a repository" has much to do
with the objective of the patch in question.  It's really "what's
the upstream's view of the primary branch".

> That's also what happens with this patch if you "git init --bare
> /tmp/my.git", then edit the HEAD symref to point to "foobar" and clone
> it with file:///, it'll be "master" in your clone (or whatever
> init.defaultBranch is). Isn't that discrepancy a bug then?

Yes, I view it as the same bug to be fixed; JTan's protocol update
patch only deals with the transport based on the git protocol and
does not (yet?) address the --local short-cut.  In principle, it
should be a lot easier than the protocol update.  Any takers?

> On both of those big hosting sites (didn't test others) whatever their
> preferred default name is they'll go with your idea and update HEAD's
> pointer on the first such push. So this notion that the default unborn
> symref isn't transported & it's up to the client to set it on-push (or
> manually afterwards) has been reinforced by in-the-wild use.

I think it would be great if somebody comes up with a protocol
update for that "other" direction to push into an unborn HEAD.  I
haven't thought things through, but you may be right to point out
that the "clone learns and prepares local to match the other side"
we are discussing may not be complete with such a corresponding fix
in the opposite direction.

Thanks.
