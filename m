Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D276C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8EB64E3D
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhBERqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 12:46:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhBERoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 12:44:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72BC4104EB5;
        Fri,  5 Feb 2021 14:25:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oczrz47nlHt9jyDrQkmF0HK0lcE=; b=iUODxI
        FFOlaSKV4a8VRxqITQmUx4D4warK2Aemw7A1cXT6N1pLjjdabxr60uYSsDqkWNGc
        jaC70+qdEYwjf303AXHU0cTwH9u/KgyAdUM7XVjISO34WFNtu14Phds7Lcau2lUU
        ktCAmebLXqR4S/kAKyufu9VzeJe7Vqi+9l8Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uR8l//IhBCgxobhdHrov1dGCU8xT8/2t
        JWVUqNx8H82m3VUvsbnS0aBbpI3lenNwTaSJbYMMOpGTU6FpOR778F4SZtTy62/n
        eofD5n50AFq3BFpkdKyuED2vMYDxDJcxeCHkb9qgo4wWmn4jS5e+tcaKyvw7NmSf
        ae2vN0XacNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AC10104EB3;
        Fri,  5 Feb 2021 14:25:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B15AF104EB2;
        Fri,  5 Feb 2021 14:25:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 02/17] chunk-format: create chunk format write API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <814512f216719d89f41822753d5c71df5e49385d.1611759716.git.gitgitgadget@gmail.com>
        <xmqq5z375xxf.fsf@gitster.c.googlers.com>
        <d5097b51-e096-16b3-5b7b-2c7dd1cbe918@gmail.com>
Date:   Fri, 05 Feb 2021 11:25:44 -0800
In-Reply-To: <d5097b51-e096-16b3-5b7b-2c7dd1cbe918@gmail.com> (Derrick
        Stolee's message of "Fri, 5 Feb 2021 06:37:48 -0500")
Message-ID: <xmqqim761flz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F26F30A4-67E7-11EB-A87E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> But a silent type casting from size_t to uint64_t done silently by
>> assignment bothers me. 
>
> Does this bother you only because its part of the external interface?
> If I understand correctly, uint64_t will always be at least as big
> as size_t, so this doesn't need any protections for overflow or
> anything. Is there something I should be doing before casting?

I am OK to use uint64_t on the caller-facing side, as long as we
explicitly declare that uint64_t ought to be large enough for
everybody.  Struct members and variables that are closer to the
on-disk data need to be of sized type to avoid repeating the pain
caused by our early "unsigned long ought to be large enough for
everybody" attitude, but it is nicer to be working with more
abstract types in the layer higher up.  And if there is a risk of
truncation in either direction, we should be defensive.  That's all.

>>> +int write_chunkfile(struct chunkfile *cf, void *data)
>>> +{
>>> +	int i;
>>> +	size_t cur_offset = cf->f->offset + cf->f->total;
>> 
>> That ought to be off_t, as it is a seek position inside a file
>> (struct hashfile.total is already off_t).
>
> I can use off_t for the other offsets in this computation, but
> cur_offset will be used in hashwrite_be64(), so maybe it is best
> to use uint64_t here?

As I discovered in the later parts, I think off_t makes less sense
than size_t in the context of this design, so size_t is fine, as
long as we keep the "users of chunkfile API work on a mmapped region
of contiguous memory" (which I think is OK).  uint64_t is also fine,
as long as this one is an internal implementation detail; iow,
callers of the API do not have to be responsible for casting their
more abstract and platform neutral types down to these fixed-sized
types even if we choose to use uint64_t here.

> The current chunk format API makes the same assumption (ToC comes
> first) but could be adjusted later to let this part of the method
> dynamically compute the chunk sizes and fill a ToC at the end. The
> way to modify this API would be to add a 'flags' parameter.
>
> So far, this has not been necessary, but might be in the future.

Yup, and I am happy with the current design for now.  Thanks for
clarifying the thinking behind it.
