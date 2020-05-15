Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A78CC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E92207BB
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hXEpOoJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgEOPBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:01:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56999 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgEOPBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 11:01:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B52CE4C9F7;
        Fri, 15 May 2020 11:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IWNXyVl5YcRxgWY4J1RSgspRb3U=; b=hXEpOo
        JYtH8WhOw36/nqxlONyQsTotADZ7JNdbwEt5Tab3KyhMzm4RsBW59v4ETadAtY66
        B940HgC24BV5q7jMByEziILWpich9+WpxYTtmJl6NTWRT12Gv+LzEu3LGGIPLi4c
        u7Q4rkfp4mkJ+RfT/18Xjx47xauKOJv+EOj8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lvshEje86zDSkQ1jFqOzfoH7K2ZVoldf
        We//23zaDiCzDFpgfqZIdOZVgQ+EKDdag2v/1jM360ABWi5x3segI7OrMc6viSRv
        OOpqsINCZFOE9bbDRFk/eJ3yY6Oyj7qfX/ov9D4vDDrcsjpm2UGN4hvZLw2cHAb3
        2YZr3/1z4Dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A883C4C9F5;
        Fri, 15 May 2020 11:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA1FD4C9F4;
        Fri, 15 May 2020 11:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] unpack-trees: also allow get_progress() to work on a different index
References: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com>
        <xmqq4ksiqnbf.fsf@gitster.c.googlers.com>
        <CABPp-BHM8uS1yxAtjE=Frh_V7JF7-EJ8+47e-cr9TpEMZr4nfw@mail.gmail.com>
        <xmqqimgyp3ft.fsf@gitster.c.googlers.com>
        <CABPp-BFAR=+CxwcZz1v4n3Z53uEas5P6Y7pUT7u9dAL0hULe3w@mail.gmail.com>
Date:   Fri, 15 May 2020 08:01:10 -0700
In-Reply-To: <CABPp-BFAR=+CxwcZz1v4n3Z53uEas5P6Y7pUT7u9dAL0hULe3w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 14 May 2020 16:21:14 -0700")
Message-ID: <xmqq8shtnsy1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9C876B0-96BC-11EA-80AD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, May 14, 2020 at 3:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> >> Do we see these CE_UPDATE|CE_WT_REMOVE bits attached to the cache
>> >> entries in the o->src_index array when get_progress() is fed the
>> >> src_index in the first place?
>> >
>> > Yes, before calling check_updates(o, o->src_index), update_sparsity()
>> > loops over o->src_index and calls apply_sparse_checkout() on each of
>> > the non-conflicted cache entries.  apply_sparse_checkout() will set
>> > either CE_UPDATE or CE_WT_REMOVE whenever items flip from or to having
>> > the SKIP_WORKTREE bit set.
>>
>> Hmph.
>>
>> I thought that the whole point of splitting o->result from
>> o->src_index we did long time ago was to allow us to treat
>> o->src_index constant.  I hope we haven't broken anything by
>> starting to do things like that X-<.
>
> I think we're safe there.  No function started modifying o->src_index
> directly; they just modify the index they are passed in.  The only
> place that passes o->src_index to functions for modification is
> update_sparsity(), which unpack_trees() never calls.

OK.  Thanks for an additional detail.  Let's merge it down by -rc1.

