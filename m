Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E06C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiHJWIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiHJWIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 18:08:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF98FD42
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 15:08:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5BA414D064;
        Wed, 10 Aug 2022 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xo7uXkXd+e++hwZ4VhjtYcK74YLgniIYVCta03
        2kM6Y=; b=q8C2/lZWCGCy+HmqxgxXlByASFUT1Sioa/4gTRUwNOm00t6gISP2Aw
        JtFRh8H6Vyra/cacVAlfM7MHfOfaR22cYqTlF8+tViwddNxkPyYz9pjJIGtqI+Um
        souTLXdetoLSTZJbphRR32WIglLxx4xkjhp2dNJFLCkKE8N04k/KM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDA3F14D063;
        Wed, 10 Aug 2022 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29DC314D062;
        Wed, 10 Aug 2022 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] fsck: downgrade tree badFilemode to "info"
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
        <YvQdR3sDqDMCIjIE@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 15:08:14 -0700
In-Reply-To: <YvQdR3sDqDMCIjIE@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Aug 2022 17:04:07 -0400")
Message-ID: <xmqqo7wriwfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE929412-18F8-11ED-8A47-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... That will generally cause things to be inefficient
> rather than wrong, and is a bug somebody working on a Git implementation
> would want to fix, but probably not worth inconveniencing users by
> refusing to push or fetch.
>
> So let's downgrade this to "info" by default, which is our setting for
> "mention this when fscking, but don't ever reject, even under strict
> mode". If somebody really wants to be paranoid, they can still adjust
> the level using config.

IIRC, I heard that every reimplementation of Git got the tree entry
wrong one way or another at least once.  I think this is prudent.

I was almost sure that before we "unified" the codepath for normal
tree reading and the one used for fsck in a mistaken way, which was
fixed in this series, we were catching these anomalous mode bits,
but the suspected regression is too long ago that it does not make a
practical difference if it was always broken or it was broken long
time ago.  The risk to start complaining on existing projects is the
same either way.

Thanks for working on this series.
