Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56AC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C0B613C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhGNRWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:22:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65007 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGNRWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:22:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AADF412EEEA;
        Wed, 14 Jul 2021 13:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kHib6sXMqKVTzPOV6GkMbwtgHSu7aSw4rfy451
        fKjeQ=; b=pkbZk1D1bwq2Bg3Zt2wZL1BzKlZRo88MVqH56J8iVEyiQRkInOsFPU
        9T4rBjjqg9s+2rjYjyhwGOPcB9OXkx146idvbOl7LAFWYBpHD3bnKV4cvW8mYRCb
        bGKtgXHJwyrO1D2Fbk1KfGAyK0DIy3D7Lk6AMs1n/75e3hqCLim1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A462A12EEE9;
        Wed, 14 Jul 2021 13:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28AD612EEE7;
        Wed, 14 Jul 2021 13:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding
 is impossible
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
        <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
        <CABPp-BEqnTuDgC0Bb+feFj=vBB48wdb60thO+Pq3N0jL74jH8Q@mail.gmail.com>
Date:   Wed, 14 Jul 2021 10:19:08 -0700
In-Reply-To: <CABPp-BEqnTuDgC0Bb+feFj=vBB48wdb60thO+Pq3N0jL74jH8Q@mail.gmail.com>
        (Elijah Newren's message of "Wed, 14 Jul 2021 08:22:58 -0700")
Message-ID: <xmqq8s28yfsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A36B706-E4C7-11EB-BDAB-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, since I'm commenting on this and the stat information appears
> to be important to you, note that there are also merge.stat and
> rebase.stat configuration variables for controlling whether those are
> shown at the end of merge and rebase operations.

True.  It is troubling that people try to avoid fast-forward (which
is a very cheap operation) and rebase their work on top of the other
side (which could unnecessarily smudge their object store with
pointless replaying of the commits) only because they want to avoid
the informational messages *and* there is an easy way to squelch
these messages.  There is some gap in documentation?

Thanks.
