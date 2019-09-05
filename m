Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579261F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfIERNb (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:13:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62914 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfIERNb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:13:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CFFB83D97;
        Thu,  5 Sep 2019 13:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+tYmvUK90jBk+U5Njiyl9eYiHpI=; b=dW28WZ
        UTF9TxPK5rW9885hUfeGe8AZfexx5nfu6FSuxBPoHZ034q6jKyXfiINdVDDqPTns
        va3sa46+wB9zU2Q/jDBoluBxq+8w9NvIy+bIx+nklbCLK5fL+aSsUWJL5O8XBjBa
        FqIPFqpmoH1jz9d2YSUY+b8et5USgmi7R8rcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mbx0tErm7MdmkhlsrQ9/w5/p51XzlgsA
        QVMIO0I4rTiDi1C2Say2OOXn0vdEtBW7w1vytUzkhxJZdjJ4+fa0N93w5VAMXfkr
        c2P1QpN1Vhn2yhXHMb8WITShWUUe/bY6MWLufAxcf7YM3g5ffiZuIaAQiRUe0l9T
        3zHI3L0MZZk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55CAE83D95;
        Thu,  5 Sep 2019 13:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EB2983D92;
        Thu,  5 Sep 2019 13:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
References: <20190826214737.164132-1-jonathantanmy@google.com>
        <20190905070153.GE21450@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 10:13:24 -0700
In-Reply-To: <20190905070153.GE21450@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Sep 2019 03:01:53 -0400")
Message-ID: <xmqqpnker7ij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 794F7EAC-D000-11E9-A2CC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I wonder if it would make sense to keep a cache of these "cut
> points" in the partial clone. That's potentially smaller than the
> complete set of objects (especially for tree-based partial cloning), and
> it seems clear we're willing to store it in memory anyway.

That sounds in line with how "shallow" gives us cut points in the
history, but then would we end up listing a handful of cut-point
objects for each and every commit in the history?  That still may be
a lot cheaper than computing the same set of cut-point objects every
time, though.

> And if we do that, would the .promisor file for a pack be a good place
> to store it?
>
> -Peff
