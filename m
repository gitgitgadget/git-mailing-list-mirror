Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB8C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4C561153
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhIVS7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:59:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55764 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhIVS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:59:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DAC6E912D;
        Wed, 22 Sep 2021 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OtYeGe5G3BpHsteh4hsnLs0I7s/jpBRscHtU5m
        CycEY=; b=KB5VZCRRw91vtXuvSbnyMfs2MhR0xl0PWvbhywLF55UfqZTIMh7y2P
        ztCY+ePCuR04DLKsmCJzhoLDW+5+J8KJ1FhDzkf5zFQoUNtKQcnr8AUk/YJsItxI
        neA57ie5noEbZW5qVpnALE+J8T5SEs3wfC8i+r4ziYL7Km4tU7dbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05DF9E912C;
        Wed, 22 Sep 2021 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63773E912B;
        Wed, 22 Sep 2021 14:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 0/5] const-correctness in grep.c
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 11:57:57 -0700
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 20 Sep 2021 23:45:42 -0400")
Message-ID: <xmqqlf3o780a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00A29A78-1BD7-11EC-8A1E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> While discussing [1], I noticed that the grep code mostly takes
> non-const buffers, even though it is conceptually a read-only operation
> to search in them. The culprit is a handful of spots that temporarily
> tie off NUL-terminated strings by overwriting a byte of the buffer and
> then restoring it. But I think we no longer need to do so these days,
> now that we have a regexec_buf() that can take a ptr/size pair.

Yes, the haystack has not been read-only exactly because we didn't
have <ptr,size> based regexec variant when the grep machinery was
written, and there is no reason why we want to use the "temporarily
terminate by swapping the byte with a NUL" trick.

It always is a pleasure to read such a concise and to-the-point
summary.  With a clear summary like that, a reader almost does not
have to see the patch to guess how the rest of the story goes ;-)
