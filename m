Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E231F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJBGBt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:01:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62872 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfJBGBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:01:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF4367AFC7;
        Wed,  2 Oct 2019 02:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vgD1pWuVStFNHrjsUDwchpcR4aM=; b=L5W+zb
        B5r+ePHE6XR6q/vdx2Lj9EoixtPhuRDSYRrgKjqPddkiwcz4XfYkblui48/QrIcw
        U5uI6pRokhwnD4PIgdmfDTADTNZFD6wKSx1OfSYoWAzxv1yqv1PiJF5T3TZkF6Gp
        iXoDfx/s9QqUnlaFsjxo52mZCQEezDuiglFPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XauLUkX/zjPQfN2nBByO0/zBlANNfASu
        PJI2swMdkePxatGFxcg2DINyxHH9JSDmxE5wc74VNnQxHYx8bbpwRVTTdNywwVKW
        aYa3sWdo9accEv9aUMF8JDa57S2lQCRMmRaO6fLL+STp14mE/fonwybHiAYKgA5x
        kV4LHV87Lfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC08F7AFC6;
        Wed,  2 Oct 2019 02:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE7BE7AFC2;
        Wed,  2 Oct 2019 02:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ali Utku Selen <auselen@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] shallow.c: Don't free unallocated slabs
References: <20190930233310.19287-1-auselen@gmail.com>
        <20191001150729.GI10875@sigill.intra.peff.net>
Date:   Wed, 02 Oct 2019 15:01:42 +0900
In-Reply-To: <20191001150729.GI10875@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 1 Oct 2019 11:07:29 -0400")
Message-ID: <xmqqftkbfzy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CCB81FA-E4DA-11E9-AF0E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... This is really an internal implementation
> detail of how the slab code works. It would be nice if callers didn't
> have to care about it. Perhaps we ought to have a slab foreach()
> function that encapsulates this, which would let this caller do
> something like:
>
>   commit_depth_foreach(&depths, free_commit_depth);
>   commit_depth_clear(&depths);
>
> But since this is the only place that looks into the slab in this way,
> I'm happy to take your much simpler fix in the meantime.

Likewise.  Thanks, both.
