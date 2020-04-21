Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE73C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D44206D4
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NzEk4oso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgDUS7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:59:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57498 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUS7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 14:59:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F40B618B3;
        Tue, 21 Apr 2020 14:59:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WA0wgd7BLwGlipcefn9ERRt8tAg=; b=NzEk4o
        soWUa/rnzH8wwmqC6xHnrUvonzGyf97acVJCzCGyvhHXAMkbW41e5j0dNd0qPlzB
        Esb30g3OKDpgXf1gmt6Hc9eMXpQk9xeItQbhjFxvXc7Ab8GZRJKE4yZCA87xEP12
        N6jmt8j48dJ09+6cQH3k/29T0GFwkSb4k0Bt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LR8ncCwA3XzbqzykelkkziELrjqW/S93
        S2zVJ3GLxHR5I1n2TT0T9gaLC2oyD2MINoc1mTf/8VwdN5Vsx/0xNwkZgFvR+GW5
        B06V9qEcOVjVsk5Sn6F+vvN52pxAVojOosNQDTxT0qppjlFzkfX6OshYickecUsm
        1pm1sY0DB5o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9725D618B2;
        Tue, 21 Apr 2020 14:59:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26425618B1;
        Tue, 21 Apr 2020 14:59:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH 0/3] commit-graph: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
        <20200420233907.GA97996@syl.local>
        <xmqqlfmpprhq.fsf@gitster.c.googlers.com>
        <20200421070135.GA2906244@coredump.intra.peff.net>
Date:   Tue, 21 Apr 2020 11:59:18 -0700
In-Reply-To: <20200421070135.GA2906244@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 21 Apr 2020 03:01:35 -0400")
Message-ID: <xmqqk128oebd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 345FC732-8402-11EA-AF66-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Yes, I would say "always 0444" is wrong.
>
> I'm not sure. That's what we do for loose objects, packs, etc. The mode
> we feed to git_mkstemp_mode(), etc, is not the true mode we expect to
> end up with. We know that it will be modified by the umask, and then
> perhaps by adjust_shared_perm().
>
> If you are arguing that there are only two interesting modes: 0444 and
> 0666, and those could be represented by a read-only/read-write enum, I'd
> agree with that.

Yup, that is what I meant.  I am aware that these 0444/0666 are
limited with umask at open(O_CREAT) time, and then we later call
adjust_shared_perm().  I thought Taylor meant to always make it
readable by everybody, which was the only point I was objecting to.

> Right. I think adjust_shared_perm() should already be doing what we
> want, and we should continue to call it. But it should not be
> responsible for this "read-only versus read-write" decision. That
> happens much earlier, and it adjusts as appropriate.

Yes.
