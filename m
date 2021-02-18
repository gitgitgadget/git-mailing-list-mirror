Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE44C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5A460232
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhBRVsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 16:48:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55578 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBRVsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 16:48:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EC48109CD7;
        Thu, 18 Feb 2021 16:47:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R+lDBUVvQnF2iEKq0LDvsfvFZCs=; b=SpZUS3
        58ATvNQEXlZxzq1nCDiy0kNTbLO5oTaVSEL46H5+MlD3MFi4jExRvhakK5aiPV3f
        hSeUp/D4h/z38w5ZjSPdNaXzz8wCa7iBfAzWcZJtIlfi7uiGFd0C88rBwZdhTHLh
        hfx+2vgoDWx/al4ZOJz6StR5SWtcAja2odLJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OGBWmrrcy2PL9CLrtQknz8SlZLKLSyiV
        Zihr+IUz1v5c3lag9/2rdOpYiA8m387vSXS1kFybjAW3apIHAGabpS+VyFRsPVfA
        QLtg+/j6twW9gRr/T7sPpeuQbMbbX11ZDZcCQtUFlESQqhhtSxV0kPgJjFPsbYF7
        zr07z7gYMVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5798E109CD6;
        Thu, 18 Feb 2021 16:47:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C0CF109CD3;
        Thu, 18 Feb 2021 16:47:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 17/17] chunk-format: add technical docs
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
        <84bf6506dc12163b37f46192b3742c8fb234322f.1613657260.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 13:47:51 -0800
In-Reply-To: <84bf6506dc12163b37f46192b3742c8fb234322f.1613657260.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 18 Feb 2021
        14:07:39 +0000")
Message-ID: <xmqqft1tdp4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F43DA780-7232-11EB-A586-D609E328BF65-77302942!pb-smtp21.pobox.com
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

I've read the doc added here to the end; well written and easy to
understand.

I wonder how/if well reftable files fit in the scheme, or if it
doesn't, should the chunk file format API be updated to accomodate
it (or the other way around)?

> +Extract the data information for each chunk using `pair_chunk()` or
> +`read_chunk()`:
> +
> +* `pair_chunk()` assigns a given pointer with the location inside the
> +  memory-mapped file corresponding to that chunk's offset. If the chunk
> +  does not exist, then the pointer is not modified.

I think it is worth adding:

    The caller is expected to know where the returned chunk ends by
    some out-of-band means, as this function only gives the offset
    but not the size, unlike the read_chunk() function.

> +* `read_chunk()` takes a `chunk_read_fn` function pointer and calls it
> +  with the appropriate initial pointer and size information. The function
> +  is not called if the chunk does not exist. Use this method to read chunks
> +  if you need to perform immediate parsing or if you need to execute logic
> +  based on the size of the chunk.
> +
> +After calling these methods, call `free_chunkfile()` to clear the
> +`struct chunkfile` data. This will not close the memory-mapped region.
> +Callers are expected to own that data for the timeframe the pointers into
> +the region are needed.

Thanks.
