Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B074C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BE120732
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wQnvwgN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633422AbgDOTc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:32:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406837AbgDOTcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 15:32:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59EC4C6019;
        Wed, 15 Apr 2020 15:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gh1ZAeQKJ3gW8DTksu/MA0Z/FbY=; b=wQnvwg
        N0Z3tlc8bQv9I/Sjz006xTeYMNds/VL5epIswl+MV1jcPyWn39ojF8ThZZbrss18
        wFi/OXnape5vWY21mU7sg5AR+c9i/rQiiW3N3s3fLANg1CJQ4LRCfizTBWobgNjR
        iVKBPbSdNyNFyG8PaVdlPhfqpi5OsaQQaguQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FTPEEGT+5oUBzmfYyR/afCbX93lRhBdy
        ar3PyA0fmx9uq4DdTxWJoQ8OZQXKqoKVjeJBTrHwextaiHlr2LoA5MLvccAOVICu
        AWn5GBgsnDe4ZxqClNDYJU8LqoXvSsVwUoSBtlkOIU7TLfdpnaZY1BnxjomEpCnd
        XNVGGrPVSdg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A7F3C6018;
        Wed, 15 Apr 2020 15:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82201C6016;
        Wed, 15 Apr 2020 15:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <xmqqeesthfbf.fsf@gitster.c.googlers.com>
        <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
        <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
        <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
        <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
Date:   Wed, 15 Apr 2020 12:32:42 -0700
In-Reply-To: <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com> (Derrick
        Stolee's message of "Wed, 15 Apr 2020 14:37:40 -0400")
Message-ID: <xmqqr1wo5yud.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E131686A-7F4F-11EA-82BD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> diff --git a/bloom.c b/bloom.c
> index dd9bab9bbd..c919c60f12 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -130,8 +130,20 @@ void fill_bloom_key(const char *data,
>  	int i;
>  	const uint32_t seed0 = 0x293ae76f;
>  	const uint32_t seed1 = 0x7e646e2c;
> -	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
> -	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
> +	uint32_t hash0, hash1;
> +	static struct strbuf icase_data = STRBUF_INIT;
> +	char *cur;
> +
> +	strbuf_setlen(&icase_data, 0);
> +	strbuf_addstr(&icase_data, data);

Perhaps 

	strbuf_reset(&icase_data);
	strbuf_add(&icase_data, data, len);

Or do we know bloom keys are always NUL-terminated string?

I am not sure how reusable bloom.c::fill_bloom_key() is designed to
be.  If it is for the sole use of the changed-paths, then it is OK
to assume that our data is NUL-terminated string and that keys wants
to be always computed after downcasing (assuming that icase search
is something we want to optimize for, which I find is a bit iffy).

If not, obviously we would want these two things done on the
caller's side (or perhaps a new helper function whose callers can
make these assumption, fill_bloom_path(), may want to be inserted
between fill_bloom_key() and its callers).

> +	for (cur = icase_data.buf; cur && *cur; cur++) {
> +		if (isupper(*cur))
> +			*cur = tolower(*cur);
> +	}
> +
> +	hash0 = murmur3_seeded(seed0, icase_data.buf, len);
> +	hash1 = murmur3_seeded(seed1, icase_data.buf, len);
>  
>  	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
>  	for (i = 0; i < settings->num_hashes; i++)

In any case, the update to the above function seems fairly isolated.
Nicely done.

> diff --git a/revision.c b/revision.c
> index f78c636e4d..a02be25feb 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -652,13 +652,14 @@ static void trace2_bloom_filter_statistics_atexit(void)
>  
>  static int forbid_bloom_filters(struct pathspec *spec)
>  {
> +	int allowed_flags = PATHSPEC_LITERAL | PATHSPEC_ICASE;
>  	if (spec->has_wildcard)
>  		return 1;
>  	if (spec->nr > 1)
>  		return 1;
> -	if (spec->magic & ~PATHSPEC_LITERAL)
> +	if (spec->magic & ~allowed_flags)
>  		return 1;
> -	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
> +	if (spec->nr && (spec->items[0].magic & ~allowed_flags))
>  		return 1;
>  
>  	return 0;

And thanks to the refactoring done to invent this helper function,
the side that uses the Bloom data is quite straight-forward.

As you are, I am on the fence.  

I do not think :(icase) pathspec is something we want to optimize
for, but I still like this new hash function primarily because I
suspect that it will increase the number of paths that you can cram
into the filter without getting their hashes collided (hence getting
false positive), under the assumption that real projects won't try
to store too many pair of paths that are only different in their
case, and if that is the case, it would help performance.  So if we
were to benchmark, we'd also pay attention to that side, in addition
to the obvious downside of having to allocate and downcase.

Thanks.
