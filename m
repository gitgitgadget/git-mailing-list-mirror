Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0783CC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD30611C8
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348428AbhIXUYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:24:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55982 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348413AbhIXUYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:24:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28FDBE10E6;
        Fri, 24 Sep 2021 16:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3l/6HNhm4TULJk440DTwmxQtsxiEHpTevkG55
        9TiLA=; b=JZgxm58RvmovNFQ3B+430HDwPqy1ASxIFjr66tre6wOs/+JP8Hfewj
        jBraTK88vQLJvaPmcBsyh+GB86llbOEZqJ8wwU9ahexzvVGz8idRvpo8k0cO3/+S
        3DY3PrJnnBHOBpWFQnRVaB5O+Ave1gsnPkQ5RyX6M6bMRzb5Ql/Lw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD81E10E5;
        Fri, 24 Sep 2021 16:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 832BEE10E4;
        Fri, 24 Sep 2021 16:22:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/16] enabling GIT_REF_PARANOIA by default
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Date:   Fri, 24 Sep 2021 13:22:43 -0700
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Sep 2021 14:30:16 -0400")
Message-ID: <xmqqk0j5soz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D08728C-1D75-11EC-AA4F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I recently ran into a situation where dealing with a corrupted
> repository was more confusing than necessary, because Git by default
> ignores corrupted refs in many commands.
>
> A while ago we introduced GIT_REF_PARANOIA, which works by including
> broken refs in iteration, which then typically causes later operations
> to fail (e.g., during repacking, you'd prefer to barf loudly when trying
> to access the missing object rather than incorrectly assume the objects
> from the broken ref aren't reachable).
>
> I think this is a better default for Git to have in general, not just
> for a few select operations (we turn it on by default for pruning and
> some repacks). We shouldn't see corruptions in general, and complaining
> loudly when we do is the safest option. The reason we held back when the
> knob was introduced was mostly out of deference to the historical
> behavior.

Yeah, having an escape hatch to serve as a tool to deal with and
repair a corrupt repository might be worth considering, but I tend
to agree that it is a better default to notice and loudly report a
corruption.

The series was a quite pleasant read.

Thanks.
