Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B353C38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E42176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3I+1E/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXUlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:41:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64260 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:41:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FD1B4813A;
        Mon, 24 Feb 2020 15:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQC1L6gNWhthD89K1mjt1cUrG44=; b=k3I+1E
        /xu5KjjrEc0AQD2q8tOn4fwtokSBUm5btgh3kCFxbBMVgkJCM7dIlyaPd8iWxndK
        MY6o+sRzqNcH5L0U5ePJjDZj2Eqyo98jg6UiX+1M2gW/nMrRm9fXdyuySrEEf3CL
        e5N2D8Kz6SSnuTCvvSiVWkDNFA5Q2XBJW0pH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DllW04COCJirFPG6Ma37dNp8lpNBT+dW
        2rlIqyfBrSHvnjNPKnVXv1hO5oHiIOZ6M17zej8CA4r3RSZ3IJDFBxpGeoBa1B5F
        yNJ/4+aSuKzIOnhJJkOi15V4yQuOSJpPnPQpM3udcxQ8XQSlDex2aQiqAmqv02eO
        3D3PTvWHPbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0737148139;
        Mon, 24 Feb 2020 15:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3604148138;
        Mon, 24 Feb 2020 15:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 07/24] t6300: abstract away SHA-1-specific constants
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-8-sandals@crustytoothpaste.net>
        <xmqqsgizrhjv.fsf@gitster-ct.c.googlers.com>
        <20200224181204.GA2130083@coredump.intra.peff.net>
Date:   Mon, 24 Feb 2020 12:41:50 -0800
In-Reply-To: <20200224181204.GA2130083@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Feb 2020 13:12:04 -0500")
Message-ID: <xmqqd0a3pvjl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 165735B0-5746-11EA-BB03-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Feb 24, 2020 at 10:01:08AM -0800, Junio C Hamano wrote:
>
>> > -test_atom head objectsize 171
>> > -test_atom head objectsize:disk 138
>> > -test_atom head deltabase 0000000000000000000000000000000000000000
>> > +test_atom head objectsize $((131 + hexlen))
>> 
>> 171 == 131 + 40 and that is because we are looking at the initial
>> commit, whose contents has a single object name (i.e. its tree).
>
> I wonder if it would be more readable to just pipe "cat-file" through
> "wc -c", rather than hard-coding. Then there's no magic number at all.

After seeing nearby tests use output from $(git rev-parse) as the
expected output, I had a similar thought.

>> > +test_atom head objectsize:disk $disklen
>
> Likewise for $disklen, if it's a loose object we could just get the
> information from the filesystem. That would stop us caring about the
> hash, _and_ it would make us robust to random changes in the zlib
> compression.
>
> I'm not sure if we also check packed objects. If so, you can compute the
> size from the output of show-index, which gives the offsets of each
> object. That's also how Git does it internally, though, so I'm not sure
> if that is getting too close to just testing nothing (but IMHO the thing
> we're really covering here is the format routines).

Somebody may find it tempting to use "cat-file --batch-check=<format>"
and at that point it would really become fuzzy what we are checking ;-)
