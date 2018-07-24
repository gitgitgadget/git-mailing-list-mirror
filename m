Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD7B1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeGXRyx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:54:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33878 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:54:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so12737806wme.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=07zdSEg/Fn7lA4TcKOtJXj+HsHCQj7DPsu4E77/Wyfk=;
        b=TlBPgJLnCfjg4YKaLA4S3OW+EjBy2HkDPEZsbExIo9aQs6uFGqmVbZoN4YiUB/C9zy
         2fqYFg+fJ8fqWfzKDEnhPBrSrVD2be6DeRYF/ilMiYKfRKzRjTxaxWPAmjc+dSXkgPY9
         OkLcA6xnhbKcGMfU7r/pW6ABG42vb3NAZkgaJBBfec+cf1mb5uVzmzBsurY+c4BRY/LL
         yEYZJ+DXwjeuqo7txdLyz9cutEGSzrNm8fBsoZYqiV2Ere0SRjzuvlTnPoaOUTHdoWSM
         zKENdRRxvJvYPARaZHiMJ9NegeWlo9BQ/UVQ2MGdjMphf+TiBuzSiE4NofG4HrnzdYsE
         XcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=07zdSEg/Fn7lA4TcKOtJXj+HsHCQj7DPsu4E77/Wyfk=;
        b=HLbZGR097H7qrykV1T+KxY/hg2NIvnncUTV9M4V7ceVHbWjD+9g/YbPtQlaEM5PaiS
         Ndw3U2xvrBrMVbu/USTrzYXiP1KD70Jk0zPK6ySpW34aCAJAeuPDUj9B8SR+NHs1LtTO
         qFiAAJKZQDtxvIeelviCIgrjTYbbbIUkm71T2s2Bf37Eb9PrT/e+qYa1sARKiqjHeduK
         HKrp3d8bCpeTqdZYY8ncYaEWEepAM/eMnbCy9rLnYF888AaEb84Msv7I2KAaGi5ICSqg
         wHsQL5FgcRqbHcKXAR8fPqujrryrkah/LK0ct6HCIvaEBCJW0b3i3KFxt65ie8lTZFlp
         d07w==
X-Gm-Message-State: AOUpUlGusFF2rez60blWJ7uXUZjejVuxdX7SDDficDTw6bc2ZVT9yHMg
        gbDwHxFuxioMWBfEuq0oSjO4UwB1
X-Google-Smtp-Source: AAOMgpcGpAj5fZIP9141sBZ08zGCkPE1n53AkJT5i4XGV+g8ajPAOeBwKTNMLnWIWG9i9dg3AKwXjQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr2428667wme.148.1532450850600;
        Tue, 24 Jul 2018 09:47:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f3-v6sm1310573wmb.22.2018.07.24.09.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:47:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
        <20180722054836.28935-3-chriscool@tuxfamily.org>
Date:   Tue, 24 Jul 2018 09:47:29 -0700
In-Reply-To: <20180722054836.28935-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 22 Jul 2018 07:48:33 +0200")
Message-ID: <xmqqpnzczila.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Hosting providers that allow users to "fork" existing
> repos want as much as possible those forks to use a
> small amount of disk space.

"... want those forks to consume as little amount of disk space as
possible?"  Or perhaps "... want those forks to share as much disk
space as possible"?

> Using alternates to keep all the objects from all the forks into a
> unique central repo is way to do that, but ...

s/is way to/is a way to/, I guess, but that makes it sound as if the
series invented a way to share objects without using alternates.

> it can have some
> drawbacks. Especially when packing the central repo, deltas will
> be created between objects from different forks.
>
> This can make cloning or fetching a fork much slower and much more
> CPU intensive as Git might have to compute new deltas for many
> objects to avoid sending objects from a different fork.
>
> Delta islands is a way to store objects from different forks in
> the same repo and packfile without having deltas between objects
> from different forks.

I think another paragraph between the above two is needed to briefly
outline the central idea (which would make it clear why that is
called "delta islands") is called for.  Perhaps

	Because the inefficiency primarily arises when an object is
	delitified against another object that does not exist in the
	same fork, we partion objects into sets that appear in the
	same fork, and define "delta islands".  When finding delta
	base, we do not allow an object outside the same island to
	be considered as its base.

or something along that line.  Perhaps that would even make the last
paragraph unnecessary.

> +struct island_bitmap {
> +	uint32_t refcount;
> +	uint32_t bits[];
> +};
> +
> +static uint32_t island_bitmap_size;
> +
> +/*
> + * Allocate a new bitmap; if "old" is not NULL, the new bitmap will be a copy
> + * of "old". Otherwise, the new bitmap is empty.
> + */
> +static struct island_bitmap *island_bitmap_new(const struct island_bitmap *old)
> +{
> +	size_t size = sizeof(struct island_bitmap) + (island_bitmap_size * 4);
> +	struct island_bitmap *b = xcalloc(1, size);

Is one of the variants of flex array macros applicable here?

> +	if (old)
> +		memcpy(b, old, size);
> +
> +	b->refcount = 1;
> +	return b;
> +}
> +
> +static void island_bitmap_or(struct island_bitmap *a, const struct island_bitmap *b)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < island_bitmap_size; ++i)
> +		a->bits[i] |= b->bits[i];
> +}
> +
> +static int island_bitmap_is_subset(struct island_bitmap *self,
> +		struct island_bitmap *super)
> +{
> +	uint32_t i;
> +
> +	if (self == super)
> +		return 1;
> +
> +	for (i = 0; i < island_bitmap_size; ++i) {
> +		if ((self->bits[i] & super->bits[i]) != self->bits[i])
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +#define ISLAND_BITMAP_BLOCK(x) (x / 32)
> +#define ISLAND_BITMAP_MASK(x) (1 << (x % 32))
> +
> +static void island_bitmap_set(struct island_bitmap *self, uint32_t i)
> +{
> +	self->bits[ISLAND_BITMAP_BLOCK(i)] |= ISLAND_BITMAP_MASK(i);
> +}
> +
> +static int island_bitmap_get(struct island_bitmap *self, uint32_t i)
> +{
> +	return (self->bits[ISLAND_BITMAP_BLOCK(i)] & ISLAND_BITMAP_MASK(i)) != 0;
> +}
> +

Not necessarily a complaint, but do we need another implementation
of bitmap here, or the compressed bitmap used for the pack bitmap is
unsuited for the purpose of this thing (e.g. perhaps it is overkill,
as we won't be shooting for saving disk footprint of a bitmap that
we are not going to save on disk anyway)?

> +static int cmp_tree_depth(const void *va, const void *vb)
> +{
> +	struct object_entry *a = *(struct object_entry **)va;
> +	struct object_entry *b = *(struct object_entry **)vb;
> +	return a->tree_depth - b->tree_depth;
> +}
> +
> +void resolve_tree_islands(int progress, struct packing_data *to_pack)
> +{
> +	struct progress *progress_state = NULL;
> +	struct object_entry **todo;
> +	int nr = 0;
> +	int i;
> +
> +	if (!island_marks)
> +		return;
> +
> +	/*
> +	 * We process only trees, as commits and tags have already been handled
> +	 * (and passed their marks on to root trees, as well. We must make sure
> +	 * to process them in descending tree-depth order so that marks
> +	 * propagate down the tree properly, even if a sub-tree is found in
> +	 * multiple parent trees.
> +	 */
> +	todo = xmalloc(to_pack->nr_objects * sizeof(*todo));
> +	for (i = 0; i < to_pack->nr_objects; i++) {
> +		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
> +			todo[nr++] = &to_pack->objects[i];
> +	}
> +	qsort(todo, nr, sizeof(*todo), cmp_tree_depth);

Hmph, at this stage nobody actually seems to set tree_depth; I am
wondering how a tree that is at the root in one commit but appears
as a subdirectory in another commit is handled by this code.

> +static regex_t *island_regexes;
> +static unsigned int island_regexes_alloc, island_regexes_nr;
> +static const char *core_island_name;

Are these (and the bitmap & hashtable) something that "everything in
the_repository" folks would come in and nuke as global variables?  I
haven't thought deeply about it, but these smell like that there
would be one set of such in-core variables per one in-core object
store plus refs (i.e. repository instance).

