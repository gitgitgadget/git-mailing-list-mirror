Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E7361155
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhINCG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 22:06:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhINCGz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 22:06:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 614B1141F8D;
        Mon, 13 Sep 2021 22:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K12lkDHx3RWXpoNMZZrgjQeBb8qDU/WyLyRWTR
        MfonA=; b=GC6Wl/X9eDNIj41sw14jqYwotI0CCcHD1BdQtPv7byk32ypwvpfuHP
        VUWTj1Iplsm5dJGvoRExS7tkv+OyVo3Y8IjrWaGmR588vLo0OqdExq4W+JfGJw2O
        5Of3NAdyaZn0EchZLFBcWzfxWWJoogC5Qt91vCl41lJCrlCfuqAR8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59416141F8C;
        Mon, 13 Sep 2021 22:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52F2F141F8B;
        Mon, 13 Sep 2021 22:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
References: <cover.1631049462.git.me@ttaylorr.com>
        <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
        <xmqqa6khi9ph.fsf@gitster.g> <YT/3BuDa7KfUN/38@nand.local>
Date:   Mon, 13 Sep 2021 19:05:32 -0700
In-Reply-To: <YT/3BuDa7KfUN/38@nand.local> (Taylor Blau's message of "Mon, 13
        Sep 2021 21:12:38 -0400")
Message-ID: <xmqqpmtbc3o3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F0B9F22-1500-11EC-B821-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Alas, there they are. They are basically no different than having the
> name-hash for single pack bitmaps, it's just now we don't throw them
> away when generating a MIDX bitmap from a state where the repository
> already has a single-pack bitmap.

I actually wasn't expecting any CPU/time difference.

I hope that we are talking about the same name-hash, which is used
to sort the blobs so that when pack-objects try to find a good delta
base, the blobs from the same path will sit close to each other and
hopefully fit in the pack window.

The effect I was hoping to see by not discarding the information was
that we find better delta base hence smaller deltas in the resulting
packfiles.

Thanks.
