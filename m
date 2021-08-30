Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DF0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED36160F12
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhH3Toe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:44:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57474 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhH3Toe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 15:44:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A74CE61FF;
        Mon, 30 Aug 2021 15:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iNJUmc0g/PpXuYeT/D93TKt4QgUTbfLpizhywV
        nULFM=; b=GkWv6lYnNXvKTVUN7FdQzL+gzr54WyDr/iOdpIHQo08aQ4ifAiDDfs
        w2BXMmQ9S9xfMvNCGfZiPaUY8ZR+u9ebz1KAJw5FRgbwFRmsOJLLVQFnMLC2wPLk
        030U9kobFVsD89H9r0+H0XsmnHRJrQgJ00zIipu6vDW7Ahx9JcKV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91BCEE61FE;
        Mon, 30 Aug 2021 15:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C671E61FD;
        Mon, 30 Aug 2021 15:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stef Bon <stefbon@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
        <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
Date:   Mon, 30 Aug 2021 12:43:38 -0700
In-Reply-To: <YS0tNoAa/0VQe1OW@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 30 Aug 2021 15:10:46 -0400")
Message-ID: <xmqq35qq4t1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92B9AF06-09CA-11EC-816B-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There is no operation to list the tree contents, for example, nor really
> even a good way to fetch a single object. The protocol is geared around
> efficiently transferring slices of history, so it is looking at sets of
> reachable objects (what the client is asking for, and what it claims to
> have).
>
> You might be able to cobble something together with shallow and partial
> fetches. E.g., something like:
>
>   git clone --depth 1 --filter=blob:none --single-branch -b $branch

I was hoping that our support for fetching a single object (not
necessarily a commit) at the protocol level was good enough, so that
Stef's fuse/nfs daemon can fetch the tree object it is interested
in.

There also is an effort, slowly moving to add verbs like object-info
to the protocol to help the vfs usecase, but primitives at too low a
level would be killed by latency, so it is somewhat unknown how
effective it would be.


