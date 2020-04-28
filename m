Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E3C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DC52072A
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/8qGGUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD1AZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:25:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgD1AZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 20:25:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AB2F44C67;
        Mon, 27 Apr 2020 20:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=45fYEbr3xVB4nBMm8jyZsuxMODU=; b=P/8qGG
        UXmJh/YFEg6K24O/twspyIL6X9GysU21Mv1kW64nGTTqdR7u3tAuHlDqnv93Pf3a
        UW9Y+cFM+WUPOlP3NS/ub1KcPf+AiyKEIwo1gj6prUCuHC33Qzgbq/Im0bNgoZmQ
        icn1E7OR4XBB5BPoIbHnV8Nv9Qjl80Q3u8/Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xgL3RBI40BqxBwTg2bZHyWXtG3QhYQYZ
        oTaHpZgy3pMfkn3URjsBNQLTEiwIqc19voKSX8kWkRGOC9TAQQBhvpNyFSMwcm7V
        Qw7UWtRm3uJRZaU8DZHfQVwxR8vIcduVk+wBbuiWxQZyB1JVrbbk3znMYiINU+vh
        e61YrA/G1tM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2135144C65;
        Mon, 27 Apr 2020 20:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A92E544C64;
        Mon, 27 Apr 2020 20:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <cover.1588004647.git.me@ttaylorr.com>
        <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
        <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
        <20200427235935.GA14984@syl.local>
Date:   Mon, 27 Apr 2020 17:25:50 -0700
In-Reply-To: <20200427235935.GA14984@syl.local> (Taylor Blau's message of
        "Mon, 27 Apr 2020 17:59:35 -0600")
Message-ID: <xmqqd07s5ucx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D051CCCE-88E6-11EA-923D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Looks good to me; this is definitely necessary. For what it's worth, it
> passes for me, but my system may not have as restrictive a umask as
> others.

Note that umask is not a system thing, but personal.  When I was
with smaller company, I used to have 002 as my umask, but these days
I use 077.

> I'd be happy to re-send this patch, but alternatively if you want to
> just squash this in, I'd be just as happy.

I'll keep it queued, until we need to replace it with an undated
series.

Thanks.
