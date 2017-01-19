Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E42A20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbdASTQq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:16:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50514 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754368AbdASTQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:16:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1B155FAF5;
        Thu, 19 Jan 2017 14:16:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=15QQn2zgaz3l
        HZ7TyNSjNUSk/C4=; b=DOI45LB4u3tySyMWDH3wHPHYfAFn/O5z9/0i29BzOU2f
        t6uxEMj9K7nrJrJW2QV157OvcWFKoAFqEwaqh07slldq36s80UlZOpRmWH4Zm9kD
        0YGex6Uxd2EyeBi4gDzS7kFLQgO8uDGtdb4icBXMS6FReOp3MYWldipUQ2HXIw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C2cWjn
        sPqDZKpSHnF1h3XqgIk6fKQ3Xo4AERAsmwCrVORrFTouxEBnkTQMc3u9DRoH/rFd
        Tm9lGcqxCr9Z0RdwdpSy9/RpMz9EPsYm1B0A+8Tjqx9hS8jXw8JNB38oh3vPvvDz
        6+jBAhw8+cAceXaw46NhJJehpCdgnWVBN02H4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E97B45FAF4;
        Thu, 19 Jan 2017 14:16:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 514385FAF3;
        Thu, 19 Jan 2017 14:16:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich =?utf-8?Q?Sp=C3=B6rlein?= <uqs@freebsd.org>,
        Ed Maste <emaste@freebsd.org>, git@vger.kernel.org
Subject: Re: [PATCH] clear_delta_base_cache(): don't modify hashmap while iterating
References: <20170112082138.GJ4426@acme.spoerlein.net>
        <20170118140117.GK4426@acme.spoerlein.net>
        <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net>
        <20170118200646.6larm2qu32xm73on@sigill.intra.peff.net>
        <CAJ9axoSzZJXD4RKvVx+D60dw4sakMJWgNmOP-cREWA53Ae3C3w@mail.gmail.com>
        <20170118202704.w6pjxfvnge7utk34@sigill.intra.peff.net>
        <20170118215120.6hle2uxgkcvvtlox@sigill.intra.peff.net>
        <CAJ9axoT1pUQc_jTKxO+RMw7emhA4ss1NCAU+hpnyG5LMwGD89w@mail.gmail.com>
        <20170119163350.zsfb33lmigkyljjh@sigill.intra.peff.net>
Date:   Thu, 19 Jan 2017 11:16:42 -0800
In-Reply-To: <20170119163350.zsfb33lmigkyljjh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Jan 2017 11:33:50 -0500")
Message-ID: <xmqqh94u2739.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D001E3C6-DE7B-11E6-AE88-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. Here it is rolled up with a commit message.
>
> -- >8 --
> Subject: clear_delta_base_cache(): don't modify hashmap while iterating
>
> Removing entries while iterating causes fast-import to
> access an already-freed `struct packed_git`, leading to
> various confusing errors.
>
> What happens is that clear_delta_base_cache() drops the
> whole contents of the cache by iterating over the hashmap,
> calling release_delta_base_cache() on each entry. That
> function removes the item from the hashmap. The hashmap code
> may then shrink the table, but the hashmap_iter struct
> retains an offset from the old table.
>
> As a result, the next call to hashmap_iter_next() may claim
> that the iteration is done, even though some items haven't
> been visited.
>
> The only caller of clear_delta_base_cache() is fast-import,
> which wants to clear the cache because it is discarding the
> packed_git struct for its temporary pack. So by failing to
> remove all of the entries, we still have references to the
> freed packed_git.
>
> To make things even more confusing, this doesn't seem to
> trigger with the test suite, because it depends on
> complexities like the size of the hash table, which entries
> got cleared, whether we try to access them before they're
> evicted from the cache, etc.
>
> So I've been able to identify the problem with large
> imports like freebsd's svn import, or a fast-export of
> linux.git. But nothing that would be reasonable to run as
> part of the normal test suite.
>
> We can fix this easily by iterating over the lru linked list
> instead of the hashmap. They both contain the same entries,
> and we can use the "safe" variant of the list iterator,
> which exists for exactly this case.
>
> Let's also add a warning to the hashmap API documentation to
> reduce the chances of getting bit by this again.
>
> Reported-by: Ulrich Sp=C3=B6rlein <uqs@freebsd.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense.  Thanks, both, for reporting, finding and fixing.

Will apply.

>  Documentation/technical/api-hashmap.txt | 4 +++-
>  sha1_file.c                             | 9 ++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/te=
chnical/api-hashmap.txt
> index 28f5a8b71..a3f020cd9 100644
> --- a/Documentation/technical/api-hashmap.txt
> +++ b/Documentation/technical/api-hashmap.txt
> @@ -188,7 +188,9 @@ Returns the removed entry, or NULL if not found.
>  `void *hashmap_iter_next(struct hashmap_iter *iter)`::
>  `void *hashmap_iter_first(struct hashmap *map, struct hashmap_iter *it=
er)`::
> =20
> -	Used to iterate over all entries of a hashmap.
> +	Used to iterate over all entries of a hashmap. Note that it is
> +	not safe to add or remove entries to the hashmap while
> +	iterating.
>  +
>  `hashmap_iter_init` initializes a `hashmap_iter` structure.
>  +
> diff --git a/sha1_file.c b/sha1_file.c
> index 1eb47f611..d20714d6b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2342,11 +2342,10 @@ static inline void release_delta_base_cache(str=
uct delta_base_cache_entry *ent)
> =20
>  void clear_delta_base_cache(void)
>  {
> -	struct hashmap_iter iter;
> -	struct delta_base_cache_entry *entry;
> -	for (entry =3D hashmap_iter_first(&delta_base_cache, &iter);
> -	     entry;
> -	     entry =3D hashmap_iter_next(&iter)) {
> +	struct list_head *lru, *tmp;
> +	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
> +		struct delta_base_cache_entry *entry =3D
> +			list_entry(lru, struct delta_base_cache_entry, lru);
>  		release_delta_base_cache(entry);
>  	}
>  }
