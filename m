Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52505C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B10022CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xuAaVUlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHEWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:21:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58279 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:21:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7AE1776A8;
        Wed,  5 Aug 2020 18:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sInYcQzTLU84T7n2Zp2NYvWBXe8=; b=xuAaVU
        lOyvVhGUnrUdSBa/e9E13TRWlESgDUFGhS/X7yOyKKJjW9GOlcLVW76lhEQRBSbU
        JChm5cwobY0b5Ok5yWB6UbTWp6zqvoboS8S0jC3OPFiGuxgDUZnW7sptOvrLYqOv
        kIy84qbsAVELb9qd5s7MeMeUAVsc9NgdWvK40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hLfZzRtqeojlkSWk3+h2m7EckZHOP53c
        7jb26uxZM7MP6seoQfPntgYZ+jtyqtS8TphDfU1s41OxYz6dGnx5oHpPUUTXplGR
        dwAyCSwN4Z4FfwZNIZadWH3g9b5Xi/nrr9bD/yP7zKOzksaUytIZpy1UEf9PTkSB
        3qHN+njBNUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0E9D776A6;
        Wed,  5 Aug 2020 18:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58A8C776A5;
        Wed,  5 Aug 2020 18:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
References: <cover.1596480582.git.me@ttaylorr.com>
        <cover.1596646576.git.me@ttaylorr.com>
        <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
        <xmqqbljoolhy.fsf@gitster.c.googlers.com>
        <20200805211730.GJ9546@syl.lan>
Date:   Wed, 05 Aug 2020 15:21:39 -0700
In-Reply-To: <20200805211730.GJ9546@syl.lan> (Taylor Blau's message of "Wed, 5
        Aug 2020 17:17:30 -0400")
Message-ID: <xmqqh7tgn37w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08E3478A-D76A-11EA-BC5B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Aug 05, 2020 at 02:01:29PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > @@ -71,6 +72,10 @@ struct commit_graph {
>> >  	const unsigned char *chunk_base_graphs;
>> >  	const unsigned char *chunk_bloom_indexes;
>> >  	const unsigned char *chunk_bloom_data;
>> > +	const unsigned char *chunk_bloom_large_filters;
>> > +
>> > +	size_t bloom_large_to_alloc;
>> > +	struct bitmap bloom_large;
>>
>> Hmph, is the API rich enough to allow users to release the resource
>> used by such an embedded bitmap?  I ask becuase...
>>
>> > @@ -2503,6 +2577,7 @@ void free_commit_graph(struct commit_graph *g)
>> >  	}
>> >  	free(g->filename);
>> >  	free(g->bloom_filter_settings);
>> > +	bitmap_free(g->bloom_large);
>> >  	free(g);
>> >  }
>>
>> ... this hunk cannot be possibly correct as-is, and cannot be made
>> correct without changing g->bloom_large to a pointer into a heap
>> allocated bitmap, because bitmap_free() wants to not just release
>> the resource held by the bitmap but the bitmap itself.
>
> Yuck, that's definitely wrong. Serves me right for sneaking this in
> after I had run `git rebase -x 'make -j40 DEVELOPER=1 test'
> upstream/master` ;-).
>
> Below the scissors line should do the trick. It should apply cleanly at
> this point in the series, but it'll produce a compilation failure on the
> very last patch (fixing it is straightforward and looks like the
> following diff):
>
> diff --git a/bloom.c b/bloom.c
> index d0c0fd049d..8d07209c6b 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -52,7 +52,7 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>                 start_index = 0;
>
>         if ((start_index == end_index) &&
> -           (g->bloom_large.word_alloc && !bitmap_get(&g->bloom_large, lex_pos))) {
> +           (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
>                 /*
>                  * If the filter is zero-length, either (1) the filter has no
>                  * changes, (2) the filter has too many changes, or (3) it
>
> In either case, this will fix the bad free():
>
> --- >8 ---
>
> Subject: [PATCH] fixup! commit-graph: add large-filters bitmap chunk
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c | 18 ++++++++++--------
>  commit-graph.h |  2 +-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> ...
> @@ -2360,6 +2361,7 @@ int write_commit_graph(struct object_directory *odb,
>  	free(ctx->graph_name);
>  	free(ctx->commits.list);
>  	free(ctx->oids.list);
> +	free(ctx->bloom_large);

Is this correct, or shouldn't it be bitmap_free() instead?
