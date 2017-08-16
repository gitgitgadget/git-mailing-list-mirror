Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FAE1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdHPVFb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:05:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50240 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752233AbdHPVFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:05:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2A9BB2A52;
        Wed, 16 Aug 2017 17:05:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5HXRyMb9+N2aJnMlbFlwHVXKCU=; b=t8o8hn
        uzgvnKTsy+Wq6tmF/qL+Sl62qLJesn+uF5LxBaP4QWEc46NMQoaQbO+LB2OzJDTX
        dHVsQl3wIgOsiYRHteQZIgkm7BzESjtjO0ld/Xh5r6yKAbbosTzfs/fi/KZyf1AM
        RNzuOlPHiTpmQnAY1RfK2f18D0rkOTXH7ne70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uPcbP4EWH3mfI7UOT9WeCtSU6BQ5CAdM
        z914fZXAW+59/MKaOoi6/hKSG5M1Gfn2rOXMtvbzJxDyT2mgKNPV8rOl4xLyMw6j
        R2FQeWPL8xL/Rz3dtZs443JlUQ+Y5UGDf61GsDXtvUAmZv9rjR3vBCMyJfY/GQUb
        w2FPMhSM4bc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A5BB2A51;
        Wed, 16 Aug 2017 17:05:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 074A9B2A50;
        Wed, 16 Aug 2017 17:05:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: reftable [v7]: new ref storage format
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
Date:   Wed, 16 Aug 2017 14:05:27 -0700
In-Reply-To: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
        (Shawn Pearce's message of "Tue, 15 Aug 2017 19:48:54 -0700")
Message-ID: <xmqq60dnjka0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1FFF87E-82C6-11E7-AF9B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> 7th iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Changes from v6:
> - Blocks are variable sized, and alignment is optional.
> - ref index is required on variable sized multi-block files.
>
> - restart_count/offsets are again at the end of the block.
> - value_type = 0x3 is only for symbolic references.
> - "other" files cannot be stored in reftable.
>
> - object blocks are explicitly optional.
> - object blocks use position (offset in bytes), not block id.
> - removed complex log_chained format for log blocks
>
> - Layout uses log, ref file extensions
> - Described reader algorithm to obtain a snapshot

I read this version through pretending that I never read the
previous iterations, and it still made sense to me, which is a good
indication that the document is well self contained.  

I think I agree with all the simplication from v6.

I found it a slightly odd that we do not insist that update_indices
that appear in a single reftable file are consecutive, yet we
require that min_update_index of a reftable file must be one greater
than the max_update_index of a previous one.  That is not a new
issue in v7, though.

Thanks.
