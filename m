Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0F27472
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053179; cv=none; b=elTkKTGwWAPIZAtlxVFnjsFIa28+T6gtTpV5S4MoOZ+iwlaeOpcTOKlQJt00ahrgJLkR/dyT6+t0z8henvslvhQhiWDa82YvnYNZOsDnPhvhmO/RDmtzAaBeuCO+uKv5GNIbaSzBwn/ejA9s7BrvIbOUJ2LeabS/lTBx+eyHrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053179; c=relaxed/simple;
	bh=pSLqYkRmJdD/PCGNRycLwxlTPlCYPa2ZE5TbQRWLX/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DceIfGUkLcPSrQ0sSrRUDpCBnuk3ksne9oiw2E5qKlwJ1TCfQRWFvjtHBhaaQEYrw/v6UcytcFnmqcut8qAeUdJSYMY/CIIltoIhLTprZjz1njV8f/saqJMlSQBLOn0c1Az4KHxj/YPxeRDzzQfAXLqj8PWO+erq16S4+z2KsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OmDuZYS7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OmDuZYS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756053168; x=1756657968; i=l.s.r@web.de;
	bh=h/xvrkwq1+Hf97k99OjwiKuOr9DqJocjqnUklpCxWN8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OmDuZYS7ulUL54wBeqaS6UFfYssQ4SvqQvcIokc22kPjXJYoush5gtuTkgekXvzx
	 H9yLDpciROL3nm9m9WNaiTp8Noi4HR1YiBYNJP3z9xcq7rQybREoi+PNXOmLiUoDq
	 ++Qm3dbl+Cf9H3csHTzv0+JtLbvqRmJnjr4O5o4uhvW0voLgZOKtVHGEZS/BKNRg6
	 NZIScsoK2qxemCthHhEW8ui/HzO2/xXv4/ausNR4/fPlI7ha75TntX6qlqxdR7443
	 6VkhIlwHVNFtXeWMM6r768I6U4K/O8BB4Q75mQ1H2/vgpD9cXYtFJqT1vy2fggQjM
	 fOS6Xych8mBV8+sSGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6K1b-1uRtOL25f7-00sw7k; Sun, 24
 Aug 2025 18:32:48 +0200
Message-ID: <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
Date: Sun, 24 Aug 2025 18:32:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250824103117.GA250458@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xG7WZvi7CLeq4++yC+Njzvb95gnQXQaJwC9PgcHLrWL7KDbf/IV
 r7fsSw0kvnB64t9k2TpeehSZumC7+TwFMoGCZPN/HJ8b78Y4irnhVn+207yPgvXiV+XzthM
 cYnXsR7EMPrsVhRnydroAnCmhf6xyveHukZ9gHefiJGLw/wQGkn8WB9bAvdRu2L2uUdJ4hs
 Buong2A7cIkscN7UVUiiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TWQ7uM8V3SA=;hhTz9JET9G6dP19td71/zvOs/0O
 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

On 8/24/25 12:31 PM, Jeff King wrote:
> On Sun, Aug 24, 2025 at 10:37:28AM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> We could dedicate an object flag to track queue membership, but that
>> would leave less for candidate tags, affecting the results.  So use a
>> hash table, specifically a khash set of commit pointers, to track that.
>> This avoids quadratic behaviour in all cases and provides a nice
>> performance boost over the previous commit, 08bb69d70f (describe: use
>> prio_queue_replace(), 2025-08-03):
>>
>> Benchmark 1: ./git_08bb69d70f describe $(git rev-list v2.41.0..v2.47.0)
>>   Time (mean =C2=B1 =CF=83):     851.7 ms =C2=B1   1.1 ms    [User: 788=
.7 ms, System: 49.2 ms]
>>   Range (min =E2=80=A6 max):   849.4 ms =E2=80=A6 852.8 ms    10 runs
>>
>> Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
>>   Time (mean =C2=B1 =CF=83):     607.1 ms =C2=B1   0.9 ms    [User: 544=
.6 ms, System: 48.6 ms]
>>   Range (min =E2=80=A6 max):   606.1 ms =E2=80=A6 608.3 ms    10 runs
>>
>> Summary
>>   ./git describe $(git rev-list v2.41.0..v2.47.0) ran
>>     1.40 =C2=B1 0.00 times faster than ./git_08bb69d70f describe $(git =
rev-list v2.41.0..v2.47.0)
>>
>> Use the commit index value as a hash because it is unique, has the
>> right size and needs no computation.  We could also derive the hash
>> directly from the pointer value, but that requires slightly more effort=
.
>=20
> Interesting. This is exactly what commit-slabs were created for (and are
> why the convenient index value is there in the first place!).

Kinda -- they have a payload value, while a khash set only stores keys.
A commit slab with an int payload would still be smaller than a khash
set with 64-bit pointers as keys -- IF we were to add all commits.  Here
we typically add just a few, but a pathological history could add a lot;
not sure if there's a boundary.  Hmm.  So you might be able to find
examples where commit-slabs win.

> The idea of commit-slab was to have a zero-cost lookup, which is done by
> indexing into an array (well, really an array-of-arrays). The biggest
> downside of commit-slabs is that they allocate one element per commit.
> So for a sparse set you end up over-allocating and possibly suffering
> cache woes due to requests being far apart.

Right, and it doesn't support removal.

> Whereas in your technique we are trading a little bit of computation
> (indexing a bucket and then probing for the match) to get a table that
> scales with the number of elements actually added to it.
>=20
> It should be easy to convert between the two and time it. On top of your
> patch, I think this works:
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c
> index edb4dec79d..f1d1ce8c8e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -287,36 +287,38 @@ static void lazy_queue_clear(struct lazy_queue *qu=
eue)
>  	queue->get_pending =3D false;
>  }
> =20
> -static inline unsigned int commit_index(const struct commit *commit)
> -{
> -	return commit->index;
> -}
> -
> -static inline int ptr_eq(const void *a, const void *b)
> -{
> -	return a =3D=3D b;
> -}
> +define_commit_slab(commit_counter, int);

We only need one bit, so a uint8_t or char would suffice.

> =20
> -KHASH_INIT(commit_set, struct commit *, int, 0, commit_index, ptr_eq)
> +struct commit_set {
> +	int nr;
> +	struct commit_counter present;
> +};
> =20
> -static void commit_set_insert(kh_commit_set_t *set, struct commit *comm=
it)
> +static void commit_set_insert(struct commit_set *set, struct commit *co=
mmit)
>  {
> -	int added;
> -	kh_put_commit_set(set, commit, &added);
> +	int *v =3D commit_counter_at(&set->present, commit);
> +	if (!*v) {
> +		set->nr++;
> +		*v =3D 1;
> +	}
>  }
> =20
> -static void commit_set_remove(kh_commit_set_t *set, struct commit *comm=
it)
> +static void commit_set_remove(struct commit_set *set, struct commit *co=
mmit)
>  {
> -	khiter_t pos =3D kh_get_commit_set(set, commit);
> -	if (pos !=3D kh_end(set))
> -		kh_del_commit_set(set, pos);
> +	int *v =3D commit_counter_peek(&set->present, commit);
> +	if (*v) {
> +		set->nr--;
> +		*v =3D 0;
> +	}
>  }
> =20
>  static unsigned long finish_depth_computation(struct lazy_queue *queue,
>  					      struct possible_tag *best)
>  {
>  	unsigned long seen_commits =3D 0;
> -	kh_commit_set_t unflagged =3D { 0 };
> +	struct commit_set unflagged =3D { 0 };
> +
> +	init_commit_counter(&unflagged.present);
> =20
>  	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++=
) {
>  		struct commit *commit =3D queue->queue.array[i].data;
> @@ -330,7 +332,7 @@ static unsigned long finish_depth_computation(struct=
 lazy_queue *queue,
> =20
>  		seen_commits++;
>  		if (c->object.flags & best->flag_within) {
> -			if (!kh_size(&unflagged))
> +			if (!unflagged.nr)
>  				break;
>  		} else {
>  			commit_set_remove(&unflagged, c);
> @@ -354,7 +356,7 @@ static unsigned long finish_depth_computation(struct=
 lazy_queue *queue,
>  			parents =3D parents->next;
>  		}
>  	}
> -	kh_release_commit_set(&unflagged);
> +	clear_commit_counter(&unflagged.present);
>  	return seen_commits;
>  }
> =20
>=20
> Here's what I get for timing:
>=20
>   Benchmark 1: ./git.orig describe $(git rev-list v2.41.0..v2.47.0)
>     Time (mean =C2=B1 =CF=83):      1.195 s =C2=B1  0.012 s    [User: 1.=
152 s, System: 0.045 s]
>     Range (min =E2=80=A6 max):    1.175 s =E2=80=A6  1.220 s    10 runs
>  =20
>   Benchmark 2: ./git.khash describe $(git rev-list v2.41.0..v2.47.0)
>     Time (mean =C2=B1 =CF=83):     912.4 ms =C2=B1   5.7 ms    [User: 86=
7.7 ms, System: 46.3 ms]
>     Range (min =E2=80=A6 max):   901.1 ms =E2=80=A6 921.2 ms    10 runs
>  =20
>   Benchmark 3: ./git.slab describe $(git rev-list v2.41.0..v2.47.0)
>     Time (mean =C2=B1 =CF=83):     937.9 ms =C2=B1   7.6 ms    [User: 89=
6.1 ms, System: 43.5 ms]
>     Range (min =E2=80=A6 max):   924.8 ms =E2=80=A6 947.9 ms    10 runs
>  =20
>   Summary
>     ./git.khash describe $(git rev-list v2.41.0..v2.47.0) ran
>       1.03 =C2=B1 0.01 times faster than ./git.slab describe $(git rev-l=
ist v2.41.0..v2.47.0)
>       1.31 =C2=B1 0.02 times faster than ./git.orig describe $(git rev-l=
ist v2.41.0..v2.47.0)
>=20

I didn't even consider them a contender due to the memory overhead.  The
difference is surprisingly small.  I also got 3%:

Benchmark 1: ./git_khash describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     608.4 ms =C2=B1   0.6 ms    [User: 544.6 =
ms, System: 49.2 ms]
  Range (min =E2=80=A6 max):   607.5 ms =E2=80=A6 609.3 ms    10 runs

Benchmark 2: ./git_slab describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     624.4 ms =C2=B1   1.0 ms    [User: 560.6 =
ms, System: 49.3 ms]
  Range (min =E2=80=A6 max):   623.3 ms =E2=80=A6 626.5 ms    10 runs

Summary
  ./git_khash describe $(git rev-list v2.41.0..v2.47.0) ran
    1.03 =C2=B1 0.00 times faster than ./git_slab describe $(git rev-list =
v2.41.0..v2.47.0)

I guess hash tables are just fast, even the slower ones.  Provided they
fit into memory.

> So I see similar speedups vs stock Git using your patch, but the
> commit-slab version is just slightly slower. That of course makes me
> wonder if we could or should replace the guts of commit-slab with a hash
> more like this. Some obvious questions:
>=20
>   1. Does the hash always perform better? For a dense set, might the
>      commit-slab do better (probably something like topo-sort would be a
>      good test there).

With dense you mean that most commits get some data value assigned that
is kept for longer?  That's when commit-slabs should shine.

>   2. Can the hash version handle strides of different sizes? One of the
>      points of commit-slab is that the fixed size of the value type can
>      be set at runtime (so you could have a slab of 32 bits per commit,
>      or 132, depending on your traversal needs).

Dynamic value sizes require an indirection via a pointer, or at least I
don't see any other way.  What would be a possible use case?  (Don't see
any in-tree.)

>   3. How does it perform if we swap the commit->index field for using
>      the pointer? If it's similar or faster, we could get rid of the
>      commit->index field entirely. Besides saving a few bytes and being
>      simpler, that would also mean that we could start to use the same
>      slab techniques for non-commit objects. There are several cases
>      where we use a few custom bits in object.flags because we need to
>      cover both commits and other objects. But those are error prone if
>      two sub-systems of Git use the same bits and happen to run at the
>      same time without clearing in between. It would be great if each
>      algorithm could declare its own unique flag space (and discard them
>      in one action without iterating yet again to clear the bits).
With "commit" being the pointer, returning "(uintptr_t)commit / 8" in the
hash function for the khash set gets me the same performance.  This
assumes an eight-byte alignment and that pointer values are flat indexes
into memory, which might be too much.  A portable solution would probably
have to mix and spread out all bits evenly?

The nice thing about commit-slabs is the lack of required maintenance.
They just allocate as needed and never give anything back, never need to
rehash.  And they don't need to store the keys anywhere.  They should be
good alternatives to object flags used during full history traversal
without flagging non-commits.

Off-the-shelf hash tables like khash might be slower in these cases,
though not far off, I expect.

Ren=C3=A9

