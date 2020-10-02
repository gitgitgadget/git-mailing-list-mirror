Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE52C4363C
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0CF20795
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxElodiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbgJBRJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:09:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBRJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 13:09:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98C0EE1D82;
        Fri,  2 Oct 2020 13:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4rdgAjcKoqc7UEywzb0N8yg7lIs=; b=hxElod
        iqeBxNZFzPAk7i266E3RNuVYm7sA0qY8O4R/mUKiveKHtT/SrigZ0QDW7slX8ReZ
        mmyxemdUlQGn2BfJadfy609As9RMejr/GOdR63FeA8x7qi/GHS0iMrgigd7lHl/c
        MOTt1c9fT3FXC/UalBwiBv7jnsbMzKdvfZAGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZIX3YEY0fVfyznyYkVheeaocKap2yc+b
        bSNbyHqgumaiqwL4PANAXGNAhzsV++JnSogX5yxxYJ0dos2X8b3AfZeMD/LUI11A
        TadMvXzVjxmoQTDEGYTKlbFoAreM2Tg/m4i76kYJ57+UEX/f/y/C0PMjvRs/ffxH
        DGoYBZVSMhM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 916B9E1D80;
        Fri,  2 Oct 2020 13:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9933E1D7B;
        Fri,  2 Oct 2020 13:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 12/13] reftable: rest of library
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <4e38db7f48295c4e6d729880f5f1a63b0f90274e.1601568664.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Oct 2020 10:08:58 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 2 Oct 2020 15:57:45 +0200 (CEST)")
Message-ID: <xmqqzh548sid.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6BB1E30-04D1-11EB-B2D1-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Subject: [PATCH 1/3] fixup??? reftable: rest of library

This is unambiguously good.

> Subject: [PATCH 2/3] fixup??? reftable: rest of library
>
> 0-sized arrays are actually not portable.
> ...
>  static void test_sizes_to_segments_empty(void)
>  {
> -	uint64_t sizes[0];
> +	uint64_t sizes[1];
>
>  	int seglen = 0;
>  	struct segment *segs =
> -		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
> +		sizes_to_segments(&seglen, sizes, 0);
>  	assert(seglen == 0);
>  	reftable_free(segs);

Question to Han-Wen.

It is unclear what this test wants to test.  Do we even need sizes[]
array if we know we are passing a hardcoded 0?  IOW, I would
understand if the test were

	sizes_to_segments(&seglen, NULL, 0);

to ensure that sizes_to_segments do not even attempt to look at sizes[]
array when the number of elements is 0.

> Subject: [PATCH 3/3] fixup??? reftable: rest of library
>
> Avoid using `getopt()`: it might be POSIX, but Git's audience is much
> larger than POSIX. MSVC, for example, does not support `getopt()`.

Either that, or we could use parse-options().  I do not care either
way, as this seems to be purely for debugging?

