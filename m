Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D301F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFTUwr (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:52:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53707 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:52:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7140262BDB;
        Thu, 20 Jun 2019 16:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wlLpzdAOFwpi/xvpnIkqV5ylSD8=; b=C8XJYN
        fnuvBBTtjLOZ0Rp6ChhYXwRrH5GOnyRd3XE6aRwDOUC0ytOqbtxrUhnuWu2wdCKk
        4mScdvpWmJ2afzfJwJmK2jdT2+qXSuk9SioDLyjooOCXVi+/5CQjI7qMPRPsDcf6
        SIAKjPIzTLWTk6uOn3rciWPSa8R2efePKyOdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WyxtPfLsneH+BzDX2p01mmmyhefZGXfl
        aCor3U5PhS6BsXPhDCCLS7y+2woE17qyo+hmPreamWp7Nkm3U4wcKcYARWwSTd0Z
        NMo6vK+f2GayVC6sqENOu5yRCvtGvDj1Op+oAbpMM6TGvV57+tRl1Nq9eLQ26NEI
        dDcknhqLSKM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68EBF62BDA;
        Thu, 20 Jun 2019 16:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9743762BD6;
        Thu, 20 Jun 2019 16:52:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/2] Add OBJECT_INFO_NO_FETCH_IF_MISSING flag
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
Date:   Thu, 20 Jun 2019 13:52:39 -0700
In-Reply-To: <20190620083026.14524-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 20 Jun 2019 10:30:24 +0200")
Message-ID: <xmqq36k4m12g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 588D1EE4-939D-11E9-A2FE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In a review[1] of my "many promisor remotes" patch series[2] and in
> the following thread, it was suggested that a flag should be passed to
> tell oid_object_info_extended() that it should not fetch objects from
> promisor remotes if they are missing, instead of using the ugly
> fetch_if_missing global.
>
> It looks like the OBJECT_INFO_FOR_PREFETCH flag already exists but
> unfortunately conflates 2 separate things.
>
> This patch series introduces OBJECT_INFO_NO_FETCH_IF_MISSING to
> disambiguate the different meanings and then uses it instead of
> OBJECT_INFO_FOR_PREFETCH where it makes sense.
>
> 1: https://public-inbox.org/git/b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com/
> 2: https://public-inbox.org/git/20190409161116.30256-1-chriscool@tuxfamily.org/

What commit did you base these two patches on?

>
> Christian Couder (2):
>   object-store: introduce OBJECT_INFO_NO_FETCH_IF_MISSING
>   sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
>
>  object-store.h | 9 +++++++--
>  sha1-file.c    | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)
