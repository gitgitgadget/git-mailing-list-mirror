Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B309C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLOWzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:55:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59254 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhLOWzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:55:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BFF717249B;
        Wed, 15 Dec 2021 17:55:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gObvP17etGEiq+ULmrL3vk4F2PqTtaR4jel+1A
        nQTfI=; b=ljk3ySC0thg/T0/PE5+69gNKCzJzIlVYYuF8BuAAxVFYJBcRiZgk3a
        m2ewG0b+tsuhFInPXkd6ipG0n1fINAg1o1Xh0ijcn160IT3GYzBdImlscFDrCSIH
        pBMBmOJuhM3CTItvkJzUqZ8kZbktbnsZY3SvRoRrMUo2Livc/n2NY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9402917249A;
        Wed, 15 Dec 2021 17:55:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6EAE172499;
        Wed, 15 Dec 2021 17:55:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1639446906.git.me@ttaylorr.com> <xmqqee6d648n.fsf@gitster.g>
        <YbpgHBcyq/2+nLJB@nand.local> <xmqqv8zp343h.fsf@gitster.g>
Date:   Wed, 15 Dec 2021 14:55:40 -0800
In-Reply-To: <xmqqv8zp343h.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Dec 2021 14:17:38 -0800")
Message-ID: <xmqqczlx32c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20F2CDC4-5DFA-11EC-B2B2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Not so fast.  Let me double check.  My attempt to apply on the tip
> of 'master' (as of yesterday) did not work and because the only
> topic in 'seen' that touched midx.c was that other topic, I tried to
> merge it with 'master' before applying the patches on top and it
> worked.  If the other topic has no relation to this topic, it would
> work as well (but then it does not explain why patches from the list
> did not apply for me).

Interesting.  The posted patches do apply cleanly to the tip of
'master' as of the first batch abe6bb39 (The first batch to start
the current cycle, 2021-11-29), but since then a few topics have
touched Documentation/technical/multi-pack-index.txt and made the
patch application fail to the tip of 'master' as of the second batch
e773545c (The second batch, 2021-12-10).

Even more interestingly, after merging the topic tb/cruft-packs,
which does not even touch the multi-pack-index.txt file, the patches
seemed to apply OK with "-3".  Perhaps I should have tried "am -3"
when I applied them to the 'master' with the second batch of topics.
I dunno.

Thanks for sanity checking.
