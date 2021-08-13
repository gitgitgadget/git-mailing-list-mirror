Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D1C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 04:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FD560C40
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 04:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhHMEfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 00:35:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52335 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhHMEfP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 00:35:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8318EE12EB;
        Fri, 13 Aug 2021 00:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tbS05SpJu3B9VpyALzQcczDXGB7BaILtvDf9oN0OKAs=; b=Krre
        QUWVRPjRjs5uLlM90NPcQyIXauQkFipgggfxa6eOwhoUDr3c6SLLvzYOgLOZgjTI
        IEF7ljpigCuFcKYlh7nwMYfaVsAPBbylj1OpeC15QlUjMEjvob/3RlaVgW3/qHK0
        CJm2h4ezBBx9nPiva4eKLWWgadX8LQ6Z8Kx9Zvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B3EDE12EA;
        Fri, 13 Aug 2021 00:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05275E12E9;
        Fri, 13 Aug 2021 00:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
Date:   Thu, 12 Aug 2021 21:34:47 -0700
Message-ID: <xmqqpmuiynbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAA398B6-FBEF-11EB-98F6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It seems surprising to me that a user would want to clone with all the
> submodules fetched *without* intending to then use
> superproject-plus-submodules together recursively. I would like to hear
> more about the use case you have in mind, Junio.

You may need full forest of submodules with the superproject to
build your ware (i.e. you'd probably want to clone and fetch-update
them), but you may only be working on the sources in a small subset
of submodules and do not need your recursive grep or diff to go
outside that subset, for example.  You'd need to ask the people who
recursively clone and not set submodule.recurse to true (I am not
among them).

> One scenario that did come to mind when I discussed this with Mahi is
> that a user may provide a pathspec to --recurse-submodules (that is,
> "yes, this repo has submodules a/ and b/, but I only care about the
> contents of submodule a/") - and in that case, --recurse-submodules
> seems to do the right thing with or without Mahi's change.

Please be a bit more specific about "the right thing".  Do you mean
"the submodules that matched the pathspec gets recursed into by
later operations"?

If so, "git clone --resurse-submodules=. $from_there" may perhaps be
the "there is no way to we make this opt-in?" I have been asking
about (not "asking for")?

> It seemed to me that trying out this change on feature.experimental flag
> was the right approach, because users with that flag have already
> volunteered to be testers for upcoming behavior changes

Yes, if we already have a consensus that a proposed change is
something we hope to be desirable, then feature.experimental is a
good way to see if early adopters can find problems in their real
world use, as these volunteers may include audiences with different
use pattern from the original advocates of a particular feature, who
might have dogfooded the new feature to gain consensus that it may
want to become the default.

By the way, I am not fundamentally opposed to the feature being
proposed.  I would imagine that such a feature would be liked by
those who want to keep things simpler.  I however am hesitant to see
it pushed too hastily without considering if it harms existing users
with different preferences.

IOW, I was primarily reacting to the apparent wrong order in which
things are being done, first throwing this into feature.experimental
before we have gathered enough confidence that it may be a good
thing to do by having it in shipped version as an opt-in feature.

Thanks.
