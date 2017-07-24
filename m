Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F7A203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbdGXVn4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:43:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753370AbdGXVnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:43:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9376193E2B;
        Mon, 24 Jul 2017 17:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ga+PkYeHHZqDsNbZuL4nPV7ykeE=; b=hW39hL
        ohrmJgq9b3Y2EwyLL/hZOO9qmy932hfY7wzNL+MNu5J5Ut1bTJHOVZCwb/1GD3Rz
        +pM/nr51Ly2RyHqfiBrCqjOqzwp/ptjYnORuC9RuqsXjJ1D+TMLy3SRwtLJTNgrF
        i0aLheowiVUZL28suK+fAve8Utuwqh5wPiPyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RrPHu5LjAclhcdDZJIiRojrQt2z2nMth
        ok42I6xLnYgaRrkZ+5t1CkVWV8LxT3JGaetfAQY/wZGih733jJB9QWdGyTBzT7Ll
        qlh5Br88YSaebw79JRgB/XunmPOIOKZT9E8HwMMLlb+NeRkWhj4u+ezT1j39bjvX
        M/il8LRByO4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B9F793E2A;
        Mon, 24 Jul 2017 17:43:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0F2993E28;
        Mon, 24 Jul 2017 17:43:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate from the lockfile
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
        <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
        <20170720233051.GB159617@aiede.mtv.corp.google.com>
        <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
        <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
        <20170724170915.GD13924@aiede.mtv.corp.google.com>
        <20170724171046.rcq2vqqzikto4lbi@sigill.intra.peff.net>
Date:   Mon, 24 Jul 2017 14:43:46 -0700
In-Reply-To: <20170724171046.rcq2vqqzikto4lbi@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Jul 2017 13:10:47 -0400")
Message-ID: <xmqqzibtbje5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CBE6F74-70B9-11E7-AC47-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 24, 2017 at 10:09:15AM -0700, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>> 
>> > This seems like the correct path to me. If the existing behavior is to
>> > lock the referring symref, that seems like a violation of the lock
>> > procedure in the first place. Because if "A" points to "B", we take
>> > "A.lock" and then modify "B". But "B" may have any number of "A" links
>> > pointing to it, eliminating the purpose of the lock.
>> >
>> > I thought we already did this, though. And that modifying HEAD (which
>> > might be a symlink) required LOCK_NO_DEREF.
>> 
>> Yes, I believe the lockfile API already does so.  Since this patch
>> creates a ".new" file, not using the lockfile API, it doesn't benefit
>> from that, though.
>
> Ah, I see. This bug makes much more sense, then. And I agree doubly that
> matching the lock-code's behavior is the right thing to do.

OK.  Anybody wants to take a crack at it (it is of lower priority to
me during the -rc freeze to deal with problems in topics on 'next'
or higher)?

Thanks.
