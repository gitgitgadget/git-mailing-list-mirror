Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A84C20986
	for <e@80x24.org>; Sat, 22 Oct 2016 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964783AbcJVQZc (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 12:25:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934425AbcJVQZb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 12:25:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC1E46743;
        Sat, 22 Oct 2016 12:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8AQCpz/BTOevO9eqx0Y+UYaMpJk=; b=q8W1j6
        ms5xVs4/nNvBxkjioTl1MadleUFJQ8rDED9wlUNP4XJvpccxcHYf5sbk2ww4GTEN
        pC9pE8DsZWTijgmALgmBClWmWv+oMQ93c4W33mefrj2EOmC+iwwJttO6L7O4J9kt
        +RZNSIxkgoRkilALEnNxnfIHgQnQ0cCv3zDIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ozxcyKc7ng2uliY+sPwsYpLzlM/rHSvg
        UO3ukMIY/GFc9STRbmDqLmrCOHURCJzbB420w80LG7Ls5e6/A6MWGFHQQjMzwSGc
        CnEtJd1Etn33Gf53a95ExwSK1wMeLBpmMOm70x7QhVPBUFro89Gzd0/rIqWds1x+
        1A2aMkfwmAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 729DF46742;
        Sat, 22 Oct 2016 12:25:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C124346741;
        Sat, 22 Oct 2016 12:25:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport: allow summary-width to be computed dynamically
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
        <20161021223927.26364-1-gitster@pobox.com>
        <20161021223927.26364-4-gitster@pobox.com>
        <xmqqoa2d9eum.fsf@gitster.mtv.corp.google.com>
        <20161022050426.t2fifjqrldc6mebc@sigill.intra.peff.net>
Date:   Sat, 22 Oct 2016 09:25:27 -0700
In-Reply-To: <20161022050426.t2fifjqrldc6mebc@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 22 Oct 2016 01:04:26 -0400")
Message-ID: <xmqq4m449wqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25BB66FA-9874-11E6-8D41-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 21, 2016 at 09:39:45PM -0700, Junio C Hamano wrote:
>
>> And this is the final one.
>> 
>> -- >8 --
>> From: Junio C Hamano <gitster@pobox.com>
>> Date: Fri, 21 Oct 2016 21:33:06 -0700
>> Subject: [PATCH] transport: compute summary-width dynamically
>> 
>> Now all that is left to do is to actually iterate over the refs
>> and measure the display width needed to show their abbreviation.
>
> I think we crossed emails. :) This is obviously correct, if we don't
> mind paying the find_unique_abbrev cost twice for each sha1.

Indeed we did.  I do not think the cost matters that much in the
codepath to produce the final summary output.

> This is a minor style nit, but I think it's better to avoid mixing
> unrelated bits between the initialization, condition, and iteration bits
> of a for loop.

Yeah, you're right.
