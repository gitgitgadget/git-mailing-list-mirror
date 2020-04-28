Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13237C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34D620730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rpvHOA/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD1VF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:05:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52752 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1VF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:05:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF89BCFFC4;
        Tue, 28 Apr 2020 17:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qGPeaitdv+TUL5BVpQOmLQ1zFnY=; b=rpvHOA
        /7Rb61Te5EGs38JOawhPeN4KzVb7agbmYI7seIu2XcfGb1O5lcorcAocc3TfndOo
        Jzl0gOwIGhwwXy1+TIUWSKaVKemkVeT3UyE1OwsRwvgtOh0bdu3hvoJl1wA6EMEs
        Xc+xdG6AYJIGim/4iohCtDZrbq0aVEEk4TpI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ucav2P/AU8RIRaA4S5iK2oS3vU1EOF/F
        TyCMLkP/ksYC2TdkIos92EUbmpx4t9ksUrE7n7LSNhrGTsClEJgf7BKgYZkmhfwz
        voq+20N66TmwTiqf9YHpHOdtbUo3JdkIUaufHLx9TH3XDA+Ato5EkjlpRlhWtgh6
        t+szHEdh3y0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E70C1CFFC3;
        Tue, 28 Apr 2020 17:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38B7BCFFC2;
        Tue, 28 Apr 2020 17:05:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <cover.1588004647.git.me@ttaylorr.com>
        <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
        <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
        <20200427235935.GA14984@syl.local>
        <20200428033438.GA2369457@coredump.intra.peff.net>
        <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
        <20200428205913.GC4000@coredump.intra.peff.net>
Date:   Tue, 28 Apr 2020 14:05:21 -0700
In-Reply-To: <20200428205913.GC4000@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Apr 2020 16:59:13 -0400")
Message-ID: <xmqqd07r1fu6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9CE7E3C-8993-11EA-8928-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 28, 2020 at 09:50:02AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If we're just doing this for a single test, perhaps it would be better
>> > to set the umask in that test (perhaps even in a subshell to avoid
>> > touching other tests). I guess that's a little awkward here because the
>> > write and the mode-check happen in separate snippets.
>> 
>> Yes, and we cannot afford to place the writing side under POSIXPERM
>> prerequisite.
>
> Do we need POSIXPERM just to call umask?

I checked "git grep umask t/" hits, and I thought everybody was
using it inside POSIXPERM.

> We call it unconditionally in t1304, for example. I could certainly
> believe it doesn't do anything useful or predictable on other systems,
> but it would not surprise me if it is a silent noop. It might return
> non-zero, though (the call in t1304 is not inside a test snippet).

That is sloppy, but it might be deliberate that it does not check
the result?

> I don't think we do any actual filesystem tests for POSIXPERM. It's
> purely based on "uname -s", and we could check it much earlier. So
> unless actually probing the filesystem is worth doing, we could just
> punt on that part easily.

Yup.

> That said, I think this does get complicated when interacting with
> t1304, for example, which explicitly creates an 077 umask for the trash
> directory.
>
> This is looking like a much deeper rabbit hole than it's worth going
> down. I think the pragmatic thing is to just stick a "umask 022" near
> the new test (or possibly "test_might_fail umask 022" inside the
> commit-graph writing test).

I think the most pragmatic would be to just squash in what is
already there ;-)

