Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D3C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99C66162A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGDJFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:05:15 -0400
Received: from mout.web.de ([217.72.192.78]:41771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDJFO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625389350;
        bh=mITpdGdeEGnz55oXV8rTkTf9ZlbgGcjADbBoCH1j/lk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fMq5Rm+zfGMN/xz7RMQlL5S/hLr0pe0o3iV2PiLmlV8TqCtjbIgg/u5f1dYxUCxBn
         zk5iEizgDYNCcDaGNp0Eh0G2nT56G51yl5C8Rrk1MpO93RkTYEuZm+Ix01EAtEdZNO
         Qoh7U0/9GqwtUDMdbZPr3Oc9dWqRKydai/B6LWw0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MbhFJ-1lj7zP2F4X-00J0kw; Sun, 04 Jul 2021 11:02:30 +0200
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ab757bce-3b51-afac-312c-ea2e883cf0bf@web.de>
Date:   Sun, 4 Jul 2021 11:02:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629205305.7100-6-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v79hT2qzbQs5zJuG9CEII+eSRt5mrSP4XQ2I1zSMBzD6gkRzOXk
 PqQbE6gytyZxBVsBmPqjehLrCA4btTLtqw0D7jef1Dd/d/FlWIIaG+SX3MkDyJR36om8DPP
 ffpWYHaM9ejjO48LFsQ3/y2N1o7+f0O06QrGq4LDG2hznzJ1SvpK16vQ5zzFCKVgbtuyw1H
 O7Y/BGe0YOLJXGnvrwjcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4AgYocwB7f0=:iBvv3ioi/d6QlBVafy6WyK
 hlwr7vS2dnRj/ppenk3hQojSX+X61QIBgnVsIHBXgNWpjsI5L6IH+uHc9ICOkxB1dMGBvuLzi
 Lg7rf5iE23t1gIYZwo2w5V8KBlKg+Eo5FXtj1mi38tP1VbgXaeLdwG3myho1n4CqyRPwoWrG+
 WYX7T6JXmxSSLCcmI/IrrdSsb/gxI/Z4zHoAxjtTLbiuvyovaMEJQn5PhZ9jpk3+6mUwUBCn0
 y3B/dj32aNjXiV0ueKra5yAzfLHiaLDZjYKVH/59Vn8MnDNrBCRo5j5Urqij09TuIckdPoZSW
 rh7Pg8it3oH8UMYosjDTfSwL7XMw/BmTLR4gfGZquseJOz5ViG3imysTEo0pBhR9rcwMZfGXq
 98YMY9mJCF2+FHYbDHda6C8JBsGvq08Rc+WzVjikfqh2PbYwzRUzUBhNHYeyd89/+AW8coo9p
 FRWHZRkyL+Z9Nm76kypjcj044nXOwFH65cK0u03k1o/nV4wyCvP2Q82DLFAZxf++mMalyZtU9
 sWOidtfmYEudu+sJyGZibsDe86BpwXwqrA5qVPIo0+ofT4PKqynAfZVXY0OuLlaPVOhSRF7QV
 r+6zpm46bIsgCaTpHy1U78nMLHHL9A4ytDNad4Yy7cLqZHuoX6MUTKGjmQGiUO8G1wQUvPjNm
 tj9gU+r4cgyy5wqNRg15Tq7exC7KXutNTFWNEOY8BTzbHYy+86HS9Y0rU9Ecen1/Ngxt4cTPG
 XGrKzCrYiAyZmJO17osuKUA91HGKEjig5neOxpNq4UjKiDgm2ZvQv15vAHggtoznf1bggIg18
 Sw7PSf1fJFQp/tJ59+dX3TQg9aS6zAHbuc4vvUCVgkM9LshkY1rChvY7c0ZpN0/TGis+SD8Fo
 t+KTZCX45TgIv9rvosxBreKUr18Lfw8WyTV9mHa1eK+Nv7QA3sjQkkVBSEO0RhXnRbk03nIK7
 SvI9Ca9LLtam+D3QOa2ZVIRInatxQ+2OLYMXmD5K3BhDndFKC3K+fkQ/cCIvNiWZcfNEeS/mr
 QT49BWVeFDFfil8E5zVdLfn/yQfvy2/W2RGFz4/JXVJM2+3wlWndtPacrVLZ2eSUCyg98thYs
 Iizx8EbUJoWNJv3DgPGkQn0P6IUgG7vHQW0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.21 um 22:53 schrieb Eric Wong:
> This saves 8K per `struct object_directory', meaning it saves
> around 800MB in my case involving 100K alternates (half or more
> of those alternates are unlikely to hold loose objects).
>
> This is implemented in two parts: a generic, allocation-free
> `cbtree' and the `oidtree' wrapper on top of it.  The latter
> provides allocation using alloc_state as a memory pool to
> improve locality and reduce free(3) overhead.
>
> Unlike oid-array, the crit-bit tree does not require sorting.
> Performance is bound by the key length, for oidtree that is
> fixed at sizeof(struct object_id).  There's no need to have
> 256 oidtrees to mitigate the O(n log n) overhead like we did
> with oid-array.
>
> Being a prefix trie, it is natively suited for expanding short
> object IDs via prefix-limited iteration in
> `find_short_object_filename'.

Sounds like a good match.

>
> On my busy workstation, p4205 performance seems to be roughly
> unchanged (+/-8%).  Startup with 100K total alternates with no
> loose objects seems around 10-20% faster on a hot cache.
> (800MB in memory savings means more memory for the kernel FS
> cache).
>
> The generic cbtree implementation does impose some extra
> overhead for oidtree in that it uses memcmp(3) on
> "struct object_id" so it wastes cycles comparing 12 extra bytes
> on SHA-1 repositories.  I've not yet explored reducing this
> overhead, but I expect there are many places in our code base
> where we'd want to investigate this.
>
> More information on crit-bit trees: https://cr.yp.to/critbit.html
>
> v2: make oidtree test hash-agnostic
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  Makefile                |   3 +
>  alloc.c                 |   6 ++
>  alloc.h                 |   1 +
>  cbtree.c                | 167 ++++++++++++++++++++++++++++++++++++++++
>  cbtree.h                |  56 ++++++++++++++
>  object-file.c           |  17 ++--
>  object-name.c           |  28 +++----
>  object-store.h          |   5 +-
>  oidtree.c               |  94 ++++++++++++++++++++++
>  oidtree.h               |  29 +++++++
>  t/helper/test-oidtree.c |  47 +++++++++++
>  t/helper/test-tool.c    |   1 +
>  t/helper/test-tool.h    |   1 +
>  t/t0069-oidtree.sh      |  52 +++++++++++++
>  14 files changed, 478 insertions(+), 29 deletions(-)
>  create mode 100644 cbtree.c
>  create mode 100644 cbtree.h
>  create mode 100644 oidtree.c
>  create mode 100644 oidtree.h
>  create mode 100644 t/helper/test-oidtree.c
>  create mode 100755 t/t0069-oidtree.sh
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..a1525978fb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS +=3D test-mergesort.o
>  TEST_BUILTINS_OBJS +=3D test-mktemp.o
>  TEST_BUILTINS_OBJS +=3D test-oid-array.o
>  TEST_BUILTINS_OBJS +=3D test-oidmap.o
> +TEST_BUILTINS_OBJS +=3D test-oidtree.o
>  TEST_BUILTINS_OBJS +=3D test-online-cpus.o
>  TEST_BUILTINS_OBJS +=3D test-parse-options.o
>  TEST_BUILTINS_OBJS +=3D test-parse-pathspec-file.o
> @@ -845,6 +846,7 @@ LIB_OBJS +=3D branch.o
>  LIB_OBJS +=3D bulk-checkin.o
>  LIB_OBJS +=3D bundle.o
>  LIB_OBJS +=3D cache-tree.o
> +LIB_OBJS +=3D cbtree.o
>  LIB_OBJS +=3D chdir-notify.o
>  LIB_OBJS +=3D checkout.o
>  LIB_OBJS +=3D chunk-format.o
> @@ -940,6 +942,7 @@ LIB_OBJS +=3D object.o
>  LIB_OBJS +=3D oid-array.o
>  LIB_OBJS +=3D oidmap.o
>  LIB_OBJS +=3D oidset.o
> +LIB_OBJS +=3D oidtree.o
>  LIB_OBJS +=3D pack-bitmap-write.o
>  LIB_OBJS +=3D pack-bitmap.o
>  LIB_OBJS +=3D pack-check.o
> diff --git a/alloc.c b/alloc.c
> index 957a0af362..ca1e178c5a 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -14,6 +14,7 @@
>  #include "tree.h"
>  #include "commit.h"
>  #include "tag.h"
> +#include "oidtree.h"
>  #include "alloc.h"
>
>  #define BLOCKING 1024
> @@ -123,6 +124,11 @@ void *alloc_commit_node(struct repository *r)
>  	return c;
>  }
>
> +void *alloc_from_state(struct alloc_state *alloc_state, size_t n)
> +{
> +	return alloc_node(alloc_state, n);
> +}
> +

Why extend alloc.c instead of using mem-pool.c?  (I don't know which fits
better, but when you say "memory pool" and not use mem-pool.c I just have
to ask..)

> diff --git a/oidtree.c b/oidtree.c
> new file mode 100644
> index 0000000000..c1188d8f48
> --- /dev/null
> +++ b/oidtree.c
> @@ -0,0 +1,94 @@
> +/*
> + * A wrapper around cbtree which stores oids
> + * May be used to replace oid-array for prefix (abbreviation) matches
> + */
> +#include "oidtree.h"
> +#include "alloc.h"
> +#include "hash.h"
> +
> +struct oidtree_node {
> +	/* n.k[] is used to store "struct object_id" */
> +	struct cb_node n;
> +};
> +
> +struct oidtree_iter_data {
> +	oidtree_iter fn;
> +	void *arg;
> +	size_t *last_nibble_at;
> +	int algo;
> +	uint8_t last_byte;
> +};
> +
> +void oidtree_destroy(struct oidtree *ot)
> +{
> +	if (ot->mempool) {
> +		clear_alloc_state(ot->mempool);
> +		FREE_AND_NULL(ot->mempool);
> +	}
> +	oidtree_init(ot);
> +}
> +
> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
> +{
> +	struct oidtree_node *on;
> +
> +	if (!ot->mempool)
> +		ot->mempool =3D allocate_alloc_state();
> +	if (!oid->algo)
> +		BUG("oidtree_insert requires oid->algo");
> +
> +	on =3D alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
> +	oidcpy_with_padding((struct object_id *)on->n.k, oid);
> +
> +	/*
> +	 * n.b. we shouldn't get duplicates, here, but we'll have
> +	 * a small leak that won't be freed until oidtree_destroy
> +	 */

Why shouldn't we get duplicates?  That depends on the usage of oidtree,
right?  The current user is fine because we avoid reading the same loose
object directory twice using the loose_objects_subdir_seen bitmap.

The leak comes from the allocation above, which is not used in case we
already have the key in the oidtree.  So we need memory for all
candidates, not just the inserted candidates.  That's probably
acceptable in most use cases.

We can do better by keeping track of the unnecessary allocation in
struct oidtree and recycling it at the next insert attempt, however.
That way we'd only waste at most one slot.

> +	cb_insert(&ot->t, &on->n, sizeof(*oid));
> +}
> +
> +int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
> +{
> +	struct object_id k =3D { 0 };
> +	size_t klen =3D sizeof(k);
> +	oidcpy_with_padding(&k, oid);

Why initialize k; isn't oidcpy_with_padding() supposed to overwrite it
completely?

> +
> +	if (oid->algo =3D=3D GIT_HASH_UNKNOWN) {
> +		k.algo =3D hash_algo_by_ptr(the_hash_algo);
> +		klen -=3D sizeof(oid->algo);
> +	}

This relies on the order of the members hash and algo in struct
object_id to find a matching hash if we don't actually know algo.  It
also relies on the absence of padding after algo.  Would something like
this make sense?

   BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, algo) + sizeof(k.algo) =
=3D=3D sizeof(k));

And why set k.algo to some arbitrary value if we ignore it anyway?  I.e.
why not keep it GIT_HASH_UNKNOWN, as set by oidcpy_with_padding()?

> +
> +	return cb_lookup(&ot->t, (const uint8_t *)&k, klen) ? 1 : 0;
> +}
> +
> +static enum cb_next iter(struct cb_node *n, void *arg)
> +{
> +	struct oidtree_iter_data *x =3D arg;
> +	const struct object_id *oid =3D (const struct object_id *)n->k;
> +
> +	if (x->algo !=3D GIT_HASH_UNKNOWN && x->algo !=3D oid->algo)
> +		return CB_CONTINUE;
> +
> +	if (x->last_nibble_at) {
> +		if ((oid->hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
> +			return CB_CONTINUE;
> +	}
> +
> +	return x->fn(oid, x->arg);
> +}
> +
> +void oidtree_each(struct oidtree *ot, const struct object_id *oid,
> +			size_t oidhexlen, oidtree_iter fn, void *arg)
> +{
> +	size_t klen =3D oidhexlen / 2;
> +	struct oidtree_iter_data x =3D { 0 };
> +
> +	x.fn =3D fn;
> +	x.arg =3D arg;
> +	x.algo =3D oid->algo;
> +	if (oidhexlen & 1) {
> +		x.last_byte =3D oid->hash[klen];
> +		x.last_nibble_at =3D &klen;
> +	}
> +	cb_each(&ot->t, (const uint8_t *)oid, klen, iter, &x);
> +}

Clamp oidhexlen at GIT_MAX_HEXSZ?  Or die?

Ren=C3=A9
