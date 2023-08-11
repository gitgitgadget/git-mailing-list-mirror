Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDDC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjHKT24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKT2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 15:28:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E330F0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 12:28:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52D3C33BE6;
        Fri, 11 Aug 2023 15:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WrwwrRj5cKlg6Jnzst4Sar1pta2hgQG1O5tkSM
        bgURQ=; b=oO9aRM3AGv/eqFKWiTePw1onEpFW66kotcms3u8cUytuHCQlLpcvFT
        1mPJXKsISiq+gV3K4o+8vKevcwOuxEXut49L4G12tgx9hTrjiaY793oJonN79q8j
        PJ7Kf+of3oIasGZ1odwHoGvjuRr6bk9hlhVnWm/LII4X8l/woyIwI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 491FE33BE5;
        Fri, 11 Aug 2023 15:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F15CD33BA5;
        Fri, 11 Aug 2023 15:28:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] commit-graph: fsck zero/non-zero generation
 number fixes
References: <ZNUiEXF5CP6WMk9A@nand.local>
        <cover.1691773533.git.me@ttaylorr.com>
        <20230811175854.GA2816191@coredump.intra.peff.net>
Date:   Fri, 11 Aug 2023 12:28:49 -0700
In-Reply-To: <20230811175854.GA2816191@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 11 Aug 2023 13:58:54 -0400")
Message-ID: <xmqqr0o9s7im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D102E56-387D-11EE-99AA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This applies on top of yours, but probably would replace patches 2, 4,
> and 5 (the flip-flop case isn't even really worth testing after this,
> since the message can obviously only be shown once).
>
>  commit-graph.c          | 42 +++++++++--------------------------
>  t/t5318-commit-graph.sh | 18 ++-------------
>  2 files changed, 13 insertions(+), 47 deletions(-)

Quite an impressive amount of code reduction.  I obviously like it.

One very minor thing is that how much value are we getting by
reporting the object names of one example from each camp, instead of
just reporting a single bit "we have commits not counted and also
counted their generations, which is an anomaly".

Obviously it does not matter.  Even if we stopped doing so, the code
would not become much simpler.  We'd just use a word with two bits
instead of two pointers to existing in-core objects, which does not
have meaningful performance implications either way.

Thanks.
