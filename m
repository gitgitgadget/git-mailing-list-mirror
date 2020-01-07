Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B90C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA571206DB
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kip/97ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgAGVuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:50:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62279 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgAGVuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:50:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D57034A2F;
        Tue,  7 Jan 2020 16:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DJ+5GQe7DQ2KKiiOcjCq/sbvLE=; b=kip/97
        qlAAHsaRIaVfhohjcTKBOgECayrlosSg8eND5RRLCnhRUbnBEICL2vy+8OYC6cuc
        fz48xWNdNXtq32CJg6/8SScFy/otNE1gQzPmUCp/WSmvzi7czhUmbjIxS/3z17s9
        e9ZMkn8HcD7v+F+mi5rq/rWnqmH0mUnZy/cLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bPEoU6Uwog+M4zLzYS1/tact2NeEHWMt
        60yyrcYjEntvEIzhrF2iBa89seuroSbocJ6owe+9ctR2HmVrDw6031qBydFlim2R
        bA4oD69jFWO2LJjpVBv3YGeMq4yYC+1eJ6EzyAPpVSrAm69SEsIt6eMB8wXj/BY+
        HwWiAHGwsiw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72C7434A2E;
        Tue,  7 Jan 2020 16:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97EC834A2D;
        Tue,  7 Jan 2020 16:50:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] graph: fix case that hit assert()
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
        <c05fe2c37a87b254157eec1c8a0f8ca206e1cd31.1578432422.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 13:50:08 -0800
In-Reply-To: <c05fe2c37a87b254157eec1c8a0f8ca206e1cd31.1578432422.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 07 Jan 2020
        21:27:01 +0000")
Message-ID: <xmqqd0bv3pin.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACC304D6-3197-11EA-9A60-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> Subject: Re: [PATCH v2 1/2] graph: fix case that hit assert()
>
> A failure was reported in "git log --graph --all" with the new
> graph-rendering logic. The code fails an assert() statement when
> collapsing multiple edges from a merge.
>
> The assert was introduced by eaf158f8 (graph API: Use horizontal
> lines for more compact graphs, 2009-04-21), which is quite old.
> This assert is trying to say that when we complete a horizontal
> line with a single slash, it is because we have reached our target.
>
> This assertion is hit when we have two collapsing lines from the
> same merge commit, as follows:
>
>     | | | | *
>     | |_|_|/|
>     |/| | |/
>     | | |/|
>     | |/| |
>     | * | |
>     * | | |

I was sort-of expecting to see

    graph: drop assert() for merge with two collapsing parents

    When "git log --graph" shows a merge commit that has two collapsing
    lines, like:

        | | | | *
        | |_|_|/|
        |/| | |/
        | | |/|
        | |/| |
        | * | |
        * | | |

    we trigger an assert():

            graph.c:1228: graph_output_collapsing_line: Assertion
                          `graph->mapping[i - 3] == target' failed.

    The assert was introduced by eaf158f8 ("graph API: Use horizontal
    lines for more compact graphs", 2009-04-21), which is quite old.
    ...

near the beginning of this commit, though.

> In a larger example, the current code will output a collapse
> as follows:
>
> 	| | | | | | *
> 	| |_|_|_|_|/|\
> 	|/| | | | |/ /
> 	| | | | |/| /
> 	| | | |/| |/
> 	| | |/| |/|
> 	| |/| |/| |
> 	| | |/| | |
> 	| | * | | |
>
> However, the intended collapse should allow multiple horizontal lines
> as follows:
>
> 	| | | | | | *
> 	| |_|_|_|_|/|\
> 	|/| | | | |/ /
> 	| | |_|_|/| /
> 	| |/| | | |/
> 	| | | |_|/|
> 	| | |/| | |
> 	| | * | | |
>
> This behavior is not corrected by this change, but is noted for a later
> update.

This part is new and looks like a good thing to mention.

