Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C6C63777
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE020776
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jH0CTwtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKVWBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:01:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56469 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKVWB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 17:01:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D1AD100EF4;
        Sun, 22 Nov 2020 17:01:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QfvZf65JkT3eM2ql1ZNSc78wGp8=; b=jH0CTw
        tVbJJmDSucTTEcoUeWyaRbs9PSmbs0Mv8q/Zps7lZE6XG40eK7hxy8ouAVgRq1wN
        kkJLNu9k9hqVknQDCIc+6nHSZzmTxCgwad4oDOabUeSY2ffMtvGZ1xk76gsDqvFB
        hn00HVJFl/pjh969jqoFmRw2PrRKjbc9Vocb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hZVTrr1aT1Wn+GsMSITkSUhe/JJgbMd6
        j1LaZsH4m36RUmVXIIFFWZgWMn5IQD0a4eOMtGyOd6bhRU9+K9f0dEcwe2ABfwQc
        te/DzYbylASwmcMkdVP2RGOCZU8Xnh9nOyTTFLPOYRBV+CAKbx8/rcBy/3yKogIZ
        UqOUebThFH0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25600100EF3;
        Sun, 22 Nov 2020 17:01:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6188C100EF2;
        Sun, 22 Nov 2020 17:01:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 13/24] bitmap: add bitmap_diff_nonzero()
References: <cover.1605123652.git.me@ttaylorr.com>
        <cover.1605649533.git.me@ttaylorr.com>
        <4840c64c51d65ea7bf1ebe03cad4588267db0207.1605649533.git.me@ttaylorr.com>
Date:   Sun, 22 Nov 2020 14:01:21 -0800
In-Reply-To: <4840c64c51d65ea7bf1ebe03cad4588267db0207.1605649533.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 17 Nov 2020 16:47:29 -0500")
Message-ID: <xmqqtuthoxu6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 428B4A4C-2D0E-11EB-A2D9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The bitmap_diff_nonzero() checks if the 'self' bitmap contains any bits
> that are not on in the 'other' bitmap.

In other words, it yields false if and only if self is a subset of
other?  I have to say that "diff_nonzero" is much less helpful than
words like "subset" or "superset" when I try to imagine what the
function would compute.

If this were widely used helper function, I may insist on flipping
the polarity and call it bitmap_is_subset(), but I dunno...

> Also, delete the declaration of bitmap_is_subset() as it is not used or
> implemented.

;-)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ewah/bitmap.c | 24 ++++++++++++++++++++++++
>  ewah/ewok.h   |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index eb7e2539be..e2ebeac0e5 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -200,6 +200,30 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
>  	return 1;
>  }
>  
> +int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other)
> +{
> +	struct bitmap *small;

It is not wrong per-se, but s/small/smaller/ would be more natural?

I actually think it would be easier to follow the logic to replace
this pointer with

	size_t common_size;

Then the code becomes

	if (self->word_alloc < other->word_alloc)
		common_size = self->word_alloc;
	else {
		common_size = other->word_alloc;
		for (i = common_size; i < self->word_alloc; i++)
			if (self->words[i])
				... self is *not* subset ...
	}

	for (i = 0; i < common_size; i++)
		if (self->words[i] & ~other->words[i]))
			... self is *not* subset ...


> +	size_t i;
> +
> +	if (self->word_alloc < other->word_alloc) {
> +		small = self;
> +	} else {
> +		small = other;
> +
> +		for (i = other->word_alloc; i < self->word_alloc; i++) {
> +			if (self->words[i] != 0)
> +				return 1;
> +		}
> +	}
> +
> +	for (i = 0; i < small->word_alloc; i++) {
> +		if ((self->words[i] & ~other->words[i]))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  void bitmap_reset(struct bitmap *bitmap)
>  {
>  	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 1fc555e672..156c71d06d 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -180,7 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
>  void bitmap_reset(struct bitmap *self);
>  void bitmap_free(struct bitmap *self);
>  int bitmap_equals(struct bitmap *self, struct bitmap *other);
> -int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
> +int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other);
>  
>  struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
>  struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
