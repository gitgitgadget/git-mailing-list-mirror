Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3AC001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjG1Qby (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1Qbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 12:31:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCA3AB4
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 09:31:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75DF81A716E;
        Fri, 28 Jul 2023 12:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uKrt6Tn90729lJn/gheJLYFrZ2+//vH32/hAi9
        L45Lw=; b=dEztP4fZxuPvPBOOmg8CCq+9Rzzaz7Ih8QMMp5B/Gr1j3zCWYmGzmh
        ChA5bvIp18/3F6K8JpbRczTZSLSwCS/Ti8lW1YXDds7PaCBoEoLka7cDzSBN/Dmz
        VJaZYhqj/i3yIZu/da1X/jZaJrdyLTrCyvOqWJnqiZXiO3wF3QHKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CF891A716D;
        Fri, 28 Jul 2023 12:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE2E11A716C;
        Fri, 28 Jul 2023 12:31:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Linus Arver <linusa@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
        <ZGSlqAPwaLhgWm6v@ugly>
        <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
        <ZGUIqBU0+Vr5LSBF@ugly>
        <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
        <xmqqmt21txid.fsf@gitster.g> <owly7cqkfvyu.fsf@fine.c.googlers.com>
        <ZMOOQTMk2wFwtSfa@ugly> <xmqqpm4c5ax9.fsf@gitster.g>
        <ZMPgn1QQltyE7koe@ugly>
Date:   Fri, 28 Jul 2023 09:31:49 -0700
In-Reply-To: <ZMPgn1QQltyE7koe@ugly> (Oswald Buddenhagen's message of "Fri, 28
        Jul 2023 17:37:03 +0200")
Message-ID: <xmqqwmyk3slm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 412EFA64-2D64-11EE-9892-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> also, the "no more than two words" is sort of arbitrary - one can make
> a pretty convincing argument for just one word as well.

I doubt it.  If you squash "revert revert revert" into "revert", it
means "revert" no longer means "singly reverted", so you destroy the
goal (3) completely.  Using two at least lets you differentiate
"ended up rejecting after reverted multiple times" and "reverted
just once".

> finally, just dropping that info would typically result in multiple
> (non-trivial) commits with the same summary, which i don't really
> like.  leaving the uglier long variant (and the user hopefully
> amending it) avoids it.

Actually, I am fine with your 

> ... it falls into the "you
> should get creative when that happens" category (which is codified in
> the manual by my reworked patches).

and leave this whole discussion behind it.

If we were doing something, we should make sure what we are doing is
reasonable, and moving away from evaluation criteria like "beautify"
and "too nerdy" and steping back to see what we are trying to
achieve was an attempt to refocus the discussion.  From that point
of view, allowing arbitrary number of "Reapply" repeated, optionally
prefixed by a single "Revert", does not sound like it is much better
compared to the current one---is it worth this much time to discuss,
only to halve the length of long runs of "Revert"?
