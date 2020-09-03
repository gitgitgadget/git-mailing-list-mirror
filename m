Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92267C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213CF20639
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqXHAWAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgICVp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:45:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58747 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICVp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:45:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EEF6ED8A8;
        Thu,  3 Sep 2020 17:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1T35oJZFxQi/TiQV+zt7JW9PpHM=; b=GqXHAW
        Ag97i3mRwZdoFfnMZ2mHFd0odPUno/R5uRl2hYegXYqRF6YjW8CaV+TrcdBxbpjm
        K0ZP/HdMwyYByfD7Q9iiKrKdwPnOgtMgNS4ctQXoGks1RA+8jb0wmTL0q6wmZXTa
        MAst2/c+6VmCw0u5NdzO97LxGF+Aq9slgfnlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i/qWDAQQ8Zi1P9MinS/oWzhiXxmOJc2y
        0kpXbW/zur8qDY/roWgJbdrx/AAYC2FOvADdgso1N8WECceJyCB2bNc31dzLqoM/
        u2E4MrBreQ0Hk4lUUISECf3J3Omn4A8b2o26H+kM7Er2r0V7UQjUH4PE7WsFXBmb
        9lHIEs60TlU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07687ED8A7;
        Thu,  3 Sep 2020 17:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 299A9ED8A6;
        Thu,  3 Sep 2020 17:45:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/14] more miscellaneous Bloom filter improvements
References: <cover.1596480582.git.me@ttaylorr.com>
        <cover.1597178914.git.me@ttaylorr.com>
Date:   Thu, 03 Sep 2020 14:45:50 -0700
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 11 Aug 2020 16:51:13 -0400")
Message-ID: <xmqq8sdq8rg1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D67108C4-EE2E-11EA-8669-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here's a(nother) re-roll of mine and Stolee's series to introduce the
> new BFXL commit-graph chunk, along with the '--max-new-filters' option
> to 'git commit-graph write'.
>
> Not really much has changed since v2, other than a rebase onto the
> latest from master (the fifth 2.29 batch, at the time of writing), and
> to squash in a few fixups that I sent in response to my v2 series.

It seems we've seen more than enough comments and enthusiasm on this
round to make another round of update worthwhile, but it seems it
may take a bit more time (e.g. <20200903184920.GA8946@nand.local>)
to get issues resolved?  Just pinging, no rush.


 

 
