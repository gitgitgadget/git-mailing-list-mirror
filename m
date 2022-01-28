Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE58C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiA1VPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 16:15:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58940 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiA1VPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 16:15:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE39F185745;
        Fri, 28 Jan 2022 16:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hi2Sj9GHou1qLdmxGIFBtU4gdtPwdtEAX42ysu
        /3JPk=; b=SKt4+68AVef0xrVTVFbnxaZEvyXKpkbN7UQj63SWy+LzhFESc8OLtY
        tNxcLnIeCPXXY4aDqlxJfXwEy4hjSNnD0Ut68qv0IJuzZv5ChLoYq+jDZtyk3gJr
        wioOu1x2RUtoeJLc6qYRvAaZN/uHoxR0gmEnYkyjdoi399oH3N9do=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF6C0185743;
        Fri, 28 Jan 2022 16:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2ACA8185741;
        Fri, 28 Jan 2022 16:14:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: ps/avoid-unnecessary-hook-invocation-with-packed-refs
References: <xmqq35lc53e9.fsf@gitster.g> <YfOd7QRK4zjLwJci@ncase>
Date:   Fri, 28 Jan 2022 13:14:57 -0800
In-Reply-To: <YfOd7QRK4zjLwJci@ncase> (Patrick Steinhardt's message of "Fri,
        28 Jan 2022 08:40:29 +0100")
Message-ID: <xmqqilu3woj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58DFDE5A-807F-11EC-9EF2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jan 24, 2022 at 11:39:58AM -0800, Junio C Hamano wrote:
>> * ps/avoid-unnecessary-hook-invocation-with-packed-refs (2022-01-17) 6 commits
>>  - refs: skip hooks when deleting uncovered packed refs
>>  - refs: do not execute reference-transaction hook on packing refs
>>  - refs: demonstrate excessive execution of the reference-transaction hook
>>  - refs: allow skipping the reference-transaction hook
>>  - refs: allow passing flags when beginning transactions
>>  - refs: extract packed_refs_delete_refs() to allow control of transaction
>> 
>>  Because a deletion of ref would need to remove it from both the
>>  loose ref store and the packed ref store, a delete-ref operation
>>  that logically removes one ref may end up invoking ref-transaction
>>  hook twice, which has been corrected.
>> 
>>  Introduces new leaks when merged to 'seen'.
>>  source: <cover.1642406989.git.ps@pks.im>
>
> This leak was fixed in v4 of my series [1], so to the best of my

This topic has been in 'seen' and recent CI runs show there is no
failure due to leak checker.  Will remove the comment.  Thanks.

> knowledge there shouldn't be any more issues my series. The only
> question that remains open is Han-Wen's [2], but as I replied I'm not
> sure we actually need to adjust documentation of the flags given that we
> already do explicitly say how we pass through flags in all cases.

I'll let Han-Wen answer this first.

Thanks.

>
> Patrick
>
> [1]: https://public-inbox.org/git/cover.1642406989.git.ps@pks.im/
> [2]: https://public-inbox.org/git/CAFQ2z_M+2D-5qPXN=0FEveZ36Yq0rps3HxRkgCmiupq1DD7Kig@mail.gmail.com/
