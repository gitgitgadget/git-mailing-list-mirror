Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A4C1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeAQVw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:52:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63727 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeAQVwy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:52:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B9F7CA114;
        Wed, 17 Jan 2018 16:52:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0nYnLdsy7gMoH35T67cbXaIvKM=; b=dEyZCW
        ovJSSM7XwT3d0Rf2viROq6LNNz19ONiMkiTlcLI/bH4PQBR+hjaRzscnEzdXozsL
        RAahFWutrlTyIGZkdZubtUz4pT5f2xM19tg3DeUejzFHRUa3uV7NWvKXDgARFHLf
        JOs7W+Yid3iX1aS6jYRwlcHxfaYsKJtsTupJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AWcWZIyVYZ1V2KLnEMX1M+AujjormRoc
        N61hKS7+bm1m8r+M9TQOgpBkcCth6NK1lXgt4yM78wf9fUkrzDy4QAUoLlZU4Cho
        5Xg9SykyLPe3T0hcOSQVKqj/bgV6jYzBIG8isrjKXZBJdSciM/sAKAuCQyN/QUZp
        yycRrrnSpzw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73F06CA113;
        Wed, 17 Jan 2018 16:52:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E275CCA112;
        Wed, 17 Jan 2018 16:52:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] Supplements to "packed_ref_cache: don't use mmap() for small files"
References: <20180114191416.2368-1-kgybels@infogroep.be>
        <cover.1516017331.git.mhagger@alum.mit.edu>
Date:   Wed, 17 Jan 2018 13:52:51 -0800
In-Reply-To: <cover.1516017331.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Mon, 15 Jan 2018 13:17:32 +0100")
Message-ID: <xmqqvag0qhjg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4AB4E36-FBD0-11E7-8226-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So I will follow up this email with three patches:
>
> 1. Mention that `snapshot::buf` can be NULL for empty files
>
>    I suggest squashing this into your patch, to make it clear that
>    `snapshot::buf` and `snapshot::eof` can also be NULL if the
>    `packed-refs` file is empty.
>
> 2. create_snapshot(): exit early if the file was empty
>
>    Avoid undefined behavior by returning early if `snapshot->buf` is
>    NULL.
>
> 3. find_reference_location(): don't invoke if `snapshot->buf` is NULL
>
>    Avoid undefined behavior and confusing semantics by not calling
>    `find_reference_location()` when `snapshot->buf` is NULL.

These look all sensible with today's code and with v2 from this
thread.

With the v3, i.e. "do the xmalloc() even for size==0", however,
snapshot->buf would never be NULL, so I'd shelve them for now,
though.

Thanks.
