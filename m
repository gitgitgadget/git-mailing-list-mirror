Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4DC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7343619A0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCVSm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:42:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50420 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCVSly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:41:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97B5C123C63;
        Mon, 22 Mar 2021 14:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brGHHEzJ+yqc6+Q30R2BtsS+uro=; b=eA43GG
        2bWey4h/i5ewLHNTmcReeKY7gayhPPHBfr1Qu8mBkdsdxBYX7LssyI44p4KUibdO
        XvMmnZ3FlOU7HUAFF+F3+FhgrAz8Cx4Fp6rjA18XpbWpar00WjTZaaVft/D5+A64
        mRChtToklSlRdzGsp9YuTkysKWyAXo6pXbfps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=osqgcpdBxyQqHjL1TxXv2rlYD4vDrq8x
        h0DZLo9YdsidW7qn9uWRDHcC4t3m85av5Ls67CzZ7r7IMcGRbb4PebrUDysprs06
        pRrDA61MQfeKxTSxHIJ2IV6evX5bVCTTTJjY46W7UV/tHQDO3EdLWcr081ay8R0W
        k9H1K+uNMQ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91666123C62;
        Mon, 22 Mar 2021 14:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8407123C60;
        Mon, 22 Mar 2021 14:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2021, #06; Sat, 20)
References: <xmqqzgyxijy6.fsf@gitster.g>
        <CAHd-oW7zuRR2=2tU3J9NGeNCprE2p52aVK_RC0QSjsdzHLnZ=w@mail.gmail.com>
Date:   Mon, 22 Mar 2021 11:41:49 -0700
In-Reply-To: <CAHd-oW7zuRR2=2tU3J9NGeNCprE2p52aVK_RC0QSjsdzHLnZ=w@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Mon, 22 Mar 2021 10:52:39
        -0300")
Message-ID: <xmqqa6qv6nf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43F04FE8-8B3E-11EB-81EC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, Junio
>
> On Sat, Mar 20, 2021 at 6:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * mt/parallel-checkout-part-1 (2021-03-18) 9 commits
>>   (merged to 'next' on 2021-03-19 at a1bc83ad8e)
>>  + entry: add checkout_entry_ca() taking preloaded conv_attrs
>>  + entry: move conv_attrs lookup up to checkout_entry()
>>  + entry: extract update_ce_after_write() from write_entry()
>>  + entry: make fstat_output() and read_blob_entry() public
>>  + entry: extract a header file for entry.c functions
>>  + convert: add classification for conv_attrs struct
>>  + convert: add get_stream_filter_ca() variant
>>  + convert: add [async_]convert_to_working_tree_ca() variants
>>  + convert: make convert_attrs() and convert structs public
>>  (this branch is used by mt/parallel-checkout-part-2.)
>>
>>  Preparatory API changes for parallel checkout.
>>
>>  Will merge to 'master'.
>
> Sorry for my confusion, but are you going to squash the `#include
> "entry.h"` fix [1] or do you want me to re-roll this series with it?

I was planning to merge that down to 'master' as-is, with exactly
the same merge-fix to deal with the entry.h fallout that we have
been successfully using while merging the topic to 'seen' and
'next', without any need to have an explicit "oops, entry.h needs to
be included these days", but I think you are right---it would be
cleaner to keep the rebased series build by itself.

As we'll be rewinding and rebuilding 'next' soonish, let's kick the
topic out of 'next' when it happens, so that we can replace it (and
the part-2 topic that depends on it) with a reroll.

Thanks.
