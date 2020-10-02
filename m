Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD84C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06077206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OlHqtFo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgJBUOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:14:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBUOK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:14:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6BEF7A4A3;
        Fri,  2 Oct 2020 16:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YsKJ/FXU1KXcXRmZZUYO67AIu1s=; b=OlHqtF
        o57WrepjkgywwiGhv0RQVDNi/muVudDuqRohridCGjf7gQigm9S7ZhK9zpNN44cV
        18okAcbIX/TdYMGs6xiGhD0g6QZtUsp+TLP7l1KqA0nSGSLMMnR9AoTmEDUOWFkG
        HA21js0s0Hzf4fOVABfwJw6d6iqYBYCfBZZC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=THa6AmjsYUtx6lVq4Pv4Gj80oiTIXtsx
        ecIFdKG5tyQO0hEh70zXaX0CgGQCBKYWF4BnsS8eybspiUVbkEQug2M1u+vW3aUM
        JhCglaXQpaePvnfTY9Sgsqzv7ZQATtWZssYjDBElMQXyFz8s3jgPTASvnSaV1B2i
        VzYI+d/eEI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 972D17A4A2;
        Fri,  2 Oct 2020 16:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2EDB7A4A0;
        Fri,  2 Oct 2020 16:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
        <20201002150710.GA54370@mail.clickyotomy.dev>
        <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
        <20201002193906.GA78209@mail.clickyotomy.dev>
Date:   Fri, 02 Oct 2020 13:14:05 -0700
In-Reply-To: <20201002193906.GA78209@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Sat, 3 Oct 2020 01:09:06 +0530")
Message-ID: <xmqqmu148jxu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D27C8E72-04EB-11EB-A71C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Hi Junio,
>
> On 10/02/2020 09:41, Junio C Hamano wrote:
>> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
>> 
>> >> We should not call `in_merge_bases_many()` repeatedly: there is a much
>> >> better API for that: `get_reachable_subset()`.
>> >
>> > Perfect. I wasn't aware of this.
>> 
>> This is possibly a piece of misinformation.  in_merge_bases_many()
>> is designed to be callable more than once.  get_reachable_subset()
>> may be an overkill as we only are interested in a single "is this
>> one an ancestor of any of these?", not "which ones among these are
>> ancestors of the other set?".
>
> Noted; even though "get_reachable_subset()" and "in_merge_bases_many()"
> (after the commit-graph fix) return the same result, I suppose the
> latter was designed for this specific use-case.

Yes, in_merge_bases_many() was invented first in 4c4b27e8 (commit.c:
add in_merge_bases_many(), 2013-03-04) for this exact use case.  For
use cases where callers have multiple "these may be ancestors"
candidates, instead of having to iterate over them and calling
in_merge_bases_many() multiple times, get_reachable_subset() was
added much later at fcb2c076 (commit-reach: implement
get_reachable_subset, 2018-11-02).

> OK. Shall I update the next set by reverting the "disable commit-graph"
> change, s/list/array/ and leaving the rest as is -- if we decide to go
> forward with "in_merge_bases_many()", that is?

Yes, that would be the ideal endgame.  What I pushed out to 'seen'
has the removal of "disable" bit as a SQUASH??? commit at the tip,
but not s/list/array renaming.

Thanks.
