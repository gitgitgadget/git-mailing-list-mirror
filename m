Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A0C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CB464FAE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 00:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhBEAP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 19:15:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54797 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBEAP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 19:15:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10376B6195;
        Thu,  4 Feb 2021 19:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MxSQaZd5YresdDyLLSVso9o2Tl8=; b=VGL1aV
        74/sxQqyrfFEKKby3Y0Cdwx/pOL9aR/3TCWvVHcd0S+PaChAHS61qmvd8U8om0e2
        IbhKI+47F3CJqxW94TH0cJMFLbBDnvK4IUkhEQs6NipJqE1FOXCD2DqaB+7GDT7b
        5wN/lmESh3Gl1jsvS8K0+qBbOhmdxrRqPZfYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xXj5Cwm64S06vny4spslHre2/cCxS1cT
        pUvCGac/WxFc4dXwpxWyDloE6lV6JZLYITUIyVnocoBNjNwuToi8gPaRBklUNizM
        JsUtQOiFBqVvzTIxLJ61iEDVFm+bNTowqOYG/yfewwLkigpdLiHW5DLk9ccRzBla
        hy2IFBjkZ64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07501B6194;
        Thu,  4 Feb 2021 19:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B99EB6193;
        Thu,  4 Feb 2021 19:15:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 17/17] chunk-format: add technical docs
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <8f3985ab5df3e4abc6de6db7f71f1adcbc16b4a8.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 16:15:12 -0800
In-Reply-To: <8f3985ab5df3e4abc6de6db7f71f1adcbc16b4a8.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:56 +0000")
Message-ID: <xmqqy2g32wvj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 375A2F30-6747-11EB-987F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Chunk-based file formats
> +========================
> +
> +Some file formats in Git use a common concept of "chunks" to describe
> +sections of the file. This allows structured access to a large file by
> +scanning a small "table of contents" for the remaining data. This common
> +format is used by the `commit-graph` and `multi-pack-index` files. See
> +link:technical/pack-format.html[the `multi-pack-index` format] and
> +link:technical/commit-graph-format.html[the `commit-graph` format] for
> +how they use the chunks to describe structured data.
> +
> +A chunk-based file format begins with some header information custom to
> +that format. That header should include enough information to identify
> +the file type, format version, and number of chunks in the file. From this
> +information, that file can determine the start of the chunk-based region.
> +
> +The chunk-based region starts with a table of contents describing where
> +each chunk starts and ends. This consists of (C+1) rows of 12 bytes each,
> +where C is the number of chunks. Consider the following table:
> +
> +  | Chunk ID (4 bytes) | Chunk Offset (8 bytes) |
> +  |--------------------|------------------------|
> +  | ID[0]              | OFFSET[0]              |
> +  | ...                | ...                    |
> +  | ID[C]              | OFFSET[C]              |
> +  | 0x0000             | OFFSET[C+1]            |
> +
> +Each row consists of a 4-byte chunk identifier (ID) and an 8-byte offset.
> +Each integer is stored in network-byte order.
> +
> +The chunk identifier `ID[i]` is a label for the data stored within this
> +fill from `OFFSET[i]` (inclusive) to `OFFSET[i+1]` (exclusive). Thus, the
> +size of the `i`th chunk is equal to the difference between `OFFSET[i+1]`
> +and `OFFSET[i]`. This requires that the chunk data appears contiguously
> +in the same order as the table of contents.
> +
> +The final entry in the table of contents must be four zero bytes. This
> +confirms that the table of contents is ending and provides the offset for
> +the end of the chunk-based data.
> +
> +Note: The chunk-based format expects that the file contains _at least_ a
> +trailing hash after `OFFSET[C+1]`.

I think the above describes what I saw in the writing side of the
code quite clearly and very well.  I misread that the OFFSET[C+1]
was pointing elsewhere in my review of [2/17] somehow, but the code
is clear that it points at the end of the last chunk from the code,
and the above documents it well.

My comments on the need to document the reading side API, on what
the read_chunk callback should be able to assume (namely, the whole
thing stays in memory until the caller that decided to use chunkfile
API decides to discard it), still stands, I would think.

Thanks.

