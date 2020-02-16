Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C60C2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FF920857
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfD3GTuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBPQtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:49:36 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37825 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBPQtg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 11:49:36 -0500
Received: by mail-lf1-f47.google.com with SMTP id b15so10128196lfc.4
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QDU79KtHxtI8LoQleLkWO0yzrL+z+TtP67eqFP+Sd5M=;
        b=OfD3GTuRgpavCRGE2r9b5iF8kUyyCtMtei4RpPgslcQzqNmEi+W4Wp9XGnSPXmosFK
         /5pnHfQorYXGvaDkYonDKJHaTbj/iG0Rdwofr0ih/nhDXQLayn1nxRM4x81WZkGmBk3t
         euXYUJIRqcsw/hfc14i14nYFaBXLv2dfUDurStLSBxfehuZJAvQYlYaNDNS8ZQs1QXbe
         idyPpO27PcJiJO4xu3jR8KBNl5ux1t85qyhH2mcPdn+5NSL+4aAkeLcWXLtixLIH8WJ+
         3mczQ6CR9YbO160b+vKO/LzCyVuF8gC8aj6PvhkNlPJFvTXeZ0HFY2aZ2rqo1R/KaekL
         7kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QDU79KtHxtI8LoQleLkWO0yzrL+z+TtP67eqFP+Sd5M=;
        b=MxxWhsa0O5RMd3Tt1vDabqz+C+Z92CgonIZTD5POlkdNnsEuY8dwLm22+YkF3cGWXV
         cQDQCKz5LH++2toNiEFH7q6t/lzogiTEofpMH9Af9fzvQyW00W6X4hGyy21Ivj+wqitE
         zeYqx/GkJNO/qNfRP0VJsWp1bz0os3XiXY4uLNB6eQlZyHeMcofWPyd4+j1srRhnq8Wz
         wvOluBR8mGbaAOSob+B5S6ZoonqBzGsSlSNwvknxXXwhYrem41QdGEKDRzRdgZjP3/ll
         +ThDraMoSS8LgYTMlYRC9XyhaJquBa3IBzSKxQ68rewze5/Y4U3Yc7fwjCMYrPkgA4TS
         o4VA==
X-Gm-Message-State: APjAAAUglGFySdib/HMS1o/6LnDbt73AWvhQiO2zahdYJOyfFwG8Io/L
        UU0w3IYn3vbda9GcuUYcT54=
X-Google-Smtp-Source: APXvYqyI5I3rVtm3UIFrEc018n7SB3wJAmfk76aMs4P3/hG0tJIRyprCD2xJN0Vx2+0H60lEsJiajA==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr6098466lfc.111.1581871769989;
        Sun, 16 Feb 2020 08:49:29 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id t9sm6021188lfl.51.2020.02.16.08.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2020 08:49:29 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 02/11] bloom: core Bloom filter implementation for changed paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
Date:   Sun, 16 Feb 2020 17:49:20 +0100
Message-ID: <86tv3qqxyn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I'm sorry for accidentally sending unfinished version of this email]

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Add the core Bloom filter logic for computing the paths changed between a
> commit and its first parent. For details on what Bloom filters are and ho=
w they
> work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a c=
oncise
> explaination of the adoption of Bloom filters as described in [2] and [3].
                                                                           =
^^- to add
>
> 1. We currently use 7 and 10 for the number of hashes and the size of each
>    entry respectively. They served as great starting values, the mathemat=
ical
>    details behind this choice are described in [1] and [4]. The implement=
ation,
                                                                           =
     ^^- to add
>    while not completely open to it at the moment, is flexible enough to a=
llow
>    for tweaking these settings in the future.

I don't know if it is worth it, but I think it should be size of each
entry, or in other words number of bits per element in the set, as first
value, and number of hashes as second.

About where those values come from.  The idea is that you decide on the
acceptable number of false positives, for example 1% (or 0.8% given that
the values must be integers); that gives you number of bits per element
i.e. 10, and from there you can find optimal number of hashes i.e. 7.
The references mentioned (and Wikipedia article) have those equations.

>
>    Note: The performance gains we have observed with these values are
>    significant enough that we did not need to tweak these settings.
>    The performance numbers are included in the cover letter of this series
>    and in the message of a subsequent commit where we use Bloom filters in
>    to speed up `git log -- <path>`.

All right.

>
> 2. As described in the blog and in [3], we do not need 7 independent hash=
ing
>    functions. We use the Murmur3 hashing scheme. Seed it twice and then
>    combine those to procure an arbitrary number of hash values.

The technique from [3] is called "double hashing" (Algorithm 1 and
equation (4) on page 10).  Note that in this paper there is also
presented "enhanced double hashing" scheme (Algorithm 2 and equation
(6)) -- more about it later.

This is a standard technique from the hashing literature, called open
addressing with double hashing in hash tables.

This "enhanced double hashing" technique is further analyzed in [6].

[6] Adam Kirsch, Michael Mitzenmacher
    "Less Hashing, Same Performance: Building a Better Bloom Filter"
    https://www.eecs.harvard.edu/~michaelm/postscripts/esa2006a.pdf
    https://doi.org/10.5555/1400123.1400125

>
> 3. The filters are sized according to the number of changes in the each c=
ommit,
>    with minimum size of one 64 bit word.

If I understand it correctly (but which might not be entirely clear),
the filter size in bits is the number of changes^* times 10, rounded up
to the nearest multiple of 64.

[*] where the number of changes is the number of changed files (new blob
objects) _and_ the number of changed directories (new tree objects,
excluding root tree object change).


The interesting corner case, which might be worth specifying explicitly,
is what happens in the case there are _no changes_ with respect to first
parent (which can happen with either commit created with `git commit
--allow-empty`, or merge created e.g. with `git merge --strategy=3Dours`).
Is this case represented as Bloom filter of length 0, or as a Bloom
filter of length  of one 64-bit word which is minimal length composed of
all 0's (0x0000000000000000)?

>
> 4. We fill the Bloom filters as (const char *data, int len) pairs as
>    "struct bloom_filter"s in a commit slab.

All right.

>
> 5. The seed_murmur3 method is implemented as described in [5]. It hashes =
the
>    given data using a given seed and produces a uniformly distributed hash
>    value.

Actually there are two variants of Murmur3 hash, and we should specify
which one we are using.  There is Murmur3_32 which returns 32-bit value,
and Murmur3_128 which returns 128-bit value (which is different for x86
and x64 versions).  We use Murmur3_32.

Also, seed_murmur3 is the name given the function, not the name of the
method i.e. of a non-cryptographic hash function.


One question that one might as is why use Murmur3 hash instead for
example already implemented FNV hash from hashmap implementation (FNV
hash i.e. Fowler=E2=80=93Noll=E2=80=93Vo hash function is another non-crypt=
ographic hash
function).  The answer is of course performance while maintaining good
enough quality (and for Bloom filter there is no problem of "hash
flooding" denial-of-service like for there is for a hash table -- no
need for SipHash or similar).

>
> [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-g=
raph-iv-Bloom-filters/

I would write it in full, similar to subsequent bibliographical entries,
that is:

  [1] Derrick Stolee
      "Supercharging the Git Commit Graph IV: Bloom Filters"
      https://devblogs.microsoft.com/devops/super-charging-the-git-commit-g=
raph-iv-Bloom-filters/

But that is just a matter of style.

>
> [2] Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, Ge=
orge Varghese
>     "An Improved Construction for Counting Bloom Filters"
>     http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
>     https://doi.org/10.1007/11841036_61
>
> [3] Peter C. Dillinger and Panagiotis Manolios
>     "Bloom Filters in Probabilistic Verification"
>     http://www.ccs.neu.edu/home/pete/pub/Bloom-filters-verification.pdf
>     https://doi.org/10.1007/978-3-540-30494-4_26

Good, we should be able to find them even if the URL with PDF stops
working for some reason.

>
> [4] Thomas Mueller Graf, Daniel Lemire
>     "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
>     https://arxiv.org/abs/1912.08258
>
> [5] https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Makefile              |   2 +
>  bloom.c               | 228 ++++++++++++++++++++++++++++++++++++++++++
>  bloom.h               |  56 +++++++++++
>  t/helper/test-bloom.c |  84 ++++++++++++++++
>  t/helper/test-tool.c  |   1 +
>  t/helper/test-tool.h  |   1 +
>  t/t0095-bloom.sh      | 113 +++++++++++++++++++++
>  7 files changed, 485 insertions(+)
>  create mode 100644 bloom.c
>  create mode 100644 bloom.h
>  create mode 100644 t/helper/test-bloom.c
>  create mode 100755 t/t0095-bloom.sh

As I wrote earlier, In my opinion this patch could be split into three
individual single-functionality pieces, to make it easier to review and
aid in bisectability if needed.

1. Add implementation of MurmurHash v3 (32-bit result)
=20=20
Include tests based on test-tool (creating file similar to the
t/helper/test-hash.c, or enhancing to that file) that the implementation
is correct, for example that 'The quick brown fox jumps over the lazy
dog' or 'Hello world!' with a given seed (for example the default seed
of 0) hashes to the same value as other implementations, including the
reference implementation in https://github.com/aappleby/smhasher


2. Add implementation of [variant of] Bloom filter

Include generic Bloom filter tests i.e. that it correctly answers "yes"
and "maybe" (create filter, save it or print it, then use stored
filter), and tests specific to our implementation, namely that the size
of the filter behaves as it should.


3. Bloom filter implementation for changed paths

Here include tests that use 'test-tool bloom get_filter_for_commit',
that filter for commit with no changes and for commit with more than 512
changes works correctly, that directories are added along the files,
etc.


This split would make it easier to distinguish if the problems with
tests failing on big-endian architectures is caused by different output
from our implementation of Murmur3 hash, different bit sequence in the
Bloom filter, or just different printed output of Bloom filter data.

>
> diff --git a/Makefile b/Makefile
> index 6134104ae6..afba81f4a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -695,6 +695,7 @@ X =3D
>=20=20
>  PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>=20=20
> +TEST_BUILTINS_OBJS +=3D test-bloom.o
>  TEST_BUILTINS_OBJS +=3D test-chmtime.o
>  TEST_BUILTINS_OBJS +=3D test-config.o
>  TEST_BUILTINS_OBJS +=3D test-ctype.o
> @@ -840,6 +841,7 @@ LIB_OBJS +=3D base85.o
>  LIB_OBJS +=3D bisect.o
>  LIB_OBJS +=3D blame.o
>  LIB_OBJS +=3D blob.o
> +LIB_OBJS +=3D bloom.o
>  LIB_OBJS +=3D branch.o
>  LIB_OBJS +=3D bulk-checkin.o
>  LIB_OBJS +=3D bundle.o

All right.

> diff --git a/bloom.c b/bloom.c
> new file mode 100644
> index 0000000000..6082193a75
> --- /dev/null
> +++ b/bloom.c
> @@ -0,0 +1,228 @@
> +#include "git-compat-util.h"
> +#include "bloom.h"
> +#include "commit-graph.h"
> +#include "object-store.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "revision.h"
> +#include "hashmap.h"
> +
> +define_commit_slab(bloom_filter_slab, struct bloom_filter);
> +
> +struct bloom_filter_slab bloom_filters;

All right, this is needed to store per-commit Bloom filter data
(inside-out object style, or in other jargon stored on slab).

> +
> +struct pathmap_hash_entry {
> +    struct hashmap_entry entry;
> +    const char path[FLEX_ARRAY];
> +};

O.K. this is used to add gather paths to add them all as elements to the
Bloom filter.

> +
> +static uint32_t rotate_right(uint32_t value, int32_t count)
> +{
> +	uint32_t mask =3D 8 * sizeof(uint32_t) - 1;
> +	count &=3D mask;
> +	return ((value >> count) | (value << ((-count) & mask)));
> +}

Hmmm... both the algoritm on Wikipedia, and reference implementation use
rotate *left*, not rotate *right* in the implementation of Murmur3 hash,
see

  https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp#L23


inline uint32_t rotl32 ( uint32_t x, int8_t r )
{
  return (x << r) | (x >> (32 - r));
}

> +
> +/*
> + * Calculate a hash value for the given data using the given seed.
> + * Produces a uniformly distributed hash value.
> + * Not considered to be cryptographically secure.
> + * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#=
Algorithm
> + **/
    ^^-- why two _trailing_ asterisks?

Perhaps it would be worth it to add that this hash function is intended
to be fast while being reasonably good (it is distributed randomly
enough, and it doesn't have too many hash collisions on typical inputs).
But this might be too much for a comment.

> +static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)

A few things: name of the function, type of parameters and ordering of
parameters.


About the name: when I first saw seed_murmur3() used, I thought it was
_setting_ the seed, not that it was returning the 32-bit hash value.
Other implementations use either murmur3_32, MurmurHash3_x86_32, or
something similar like hashmurmur3_32.  If we were to specify that
'seed' is one of parameters, then using this word as part of suffix
would be better than using seed_ prefix; if we need it at all.

Because there is 32-bit and 128-bit variants of Murmur3, I think the _32
suffix should be a part of function name.

In short, I think that the name of the function should be murmur3_32, or
murmurhash3_32, or possibly murmur3_32_seed, or something like that.


About types of parameters and the return type of function: I understand
that 'data' parameter is of type 'const char *', instead of more generic
'const uint8_t*' or 'const void *' because of what we will be using the
hash function for.  On the other hand taking a look at implementation of
FNV hash function in hashmap.{c,h} we see that the 'str*' variants take
'const char *' parameter _without_ length, and 'mem*' variants take
'const void *' parmeter with length of data.

Shouldn't 'len' parameter be of 'size_t' type, rather than 'int'?  Both
the example implementation in C on Wikipedia page, and implementation in
C in qLibc use 'size_t'; the implementation of FNV hash in hashmap in
Git also uses 'size_t' (while admittedly the reference implementation in
C++ of Austin Appleby uses 'int' type for len parameter).

For 32-bit output variant of Murmur3 hash, using uint32_t as return type
is just fine.  The '*hash*' functions from hashmap.{c,h} use 'unsigned
int' but I think 'uint32_t' is better.


About names and ordering of parameters: the 'seed' or 'hash_seed'
parameter should be either first or last; it is a matter of preference.
While example implementation on Wikipedia page, Appleby's reference
implementation in C++ have 'seed' as last parameter, memihash_cont()
from hashmap.c in Git has it as first parameter.

In short: I'm fine with either order (seed parameter first or last), and
either name (be it 'seed' or 'hash_seed').

> +{
> +	const uint32_t c1 =3D 0xcc9e2d51;
> +	const uint32_t c2 =3D 0x1b873593;
> +	const uint32_t r1 =3D 15;
> +	const uint32_t r2 =3D 13;
> +	const uint32_t m =3D 5;
> +	const uint32_t n =3D 0xe6546b64;
> +	int i;
> +	uint32_t k1 =3D 0;
> +	const char *tail;
> +
> +	int len4 =3D len / sizeof(uint32_t);
> +
> +	const uint32_t *blocks =3D (const uint32_t*)data;
> +
> +	uint32_t k;
> +	for (i =3D 0; i < len4; i++)
> +	{
> +		k =3D blocks[i];

IMPORTANT: There is a comment around there in the example implementation
in C on Wikipedia that this operation above is a source of differing
results across endianness.  The pseudo-code description of the algorithm
on Wikipedia (above of C code) says that endian swapping is only
necessary on big-endian machines (and that it is needed to place the
meaningful digits towards the low end of the value, to not be discarded
by the modulo arithmetic under overflow).

The original / reference implementation by Austin Appleby in C++ uses
getblock32() function for doing the block read... but it doesn't
actually implement the endian-swapping on big-endian architecture:

  //-----------------------------------------------------------------------=
------
  // Block read - if your platform needs to do endian-swapping or can only
  // handle aligned reads, do the conversion here

  FORCE_INLINE uint32_t getblock32 ( const uint32_t * p, int i )
  {
    return p[i];
  }

References:
-----------
1. https://en.wikipedia.org/wiki/MurmurHash#Algorithm
2. https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp

> +		k *=3D c1;
> +		k =3D rotate_right(k, r1);

It is  k ROL r1 / ROTL32(k,15) / (k << 15) | (k >> (32 - 15))
(in other implementations), not rotate_right.

> +		k *=3D c2;
> +
> +		seed ^=3D k;
> +		seed =3D rotate_right(seed, r2) * m + n;

It is  hash ROL r2 / ROTL32(h1,13) / (h << 13) | (h >> (32 - 13))
(in other implementations), not rotate_right.

References:
-----------
1. https://en.wikipedia.org/wiki/MurmurHash#Algorithm
2. https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp#L94
3. https://github.com/wolkykim/qlibc/blob/master/src/utilities/qhash.c#L258

> +	}
> +
> +	tail =3D (data + len4 * sizeof(uint32_t));

Hmmm... in the pseudocode implementation on Wikipedia this is the place
where one needs to respect endianness:

    with any remainingBytesInKey do
        remainingBytes =E2=86=90 SwapToLittleEndian(remainingBytesInKey)
        // Note: Endian swapping is only necessary on big-endian machines.
        //       The purpose is to place the meaningful digits towards the =
low end of the value,
        //       so that these digits have the greatest potential to affect=
 the low range digits
        //       in the subsequent multiplication.  Consider that locating =
the meaningful digits
        //       in the high range would produce a greater effect upon the =
high digits of the
        //       multiplication, and notably, that such high digits are lik=
ely to be discarded
        //       by the modulo arithmetic under overflow.  We don't want th=
at.

On the other hand in the reference Appleby's C++ implementation the
endian-swapping is [ssumed to be] done only in the loop over data.
Either should be enough alone, but doing swapping for remaining bytes
only would work, it would be a better solution -- you do swap only once,
at the end.

It looks like the Chromium implementation in C by Shane Day (public
domain) uses the second solution; well almost, see:
https://chromium.googlesource.com/external/smhasher/+/5b8fd3c31a58b87b80605=
dca7a64fad6cb3f8a0f/PMurHash.c#189

> +
> +	switch (len & (sizeof(uint32_t) - 1))
> +	{
> +	case 3:
> +		k1 ^=3D ((uint32_t)tail[2]) << 16;
> +		/*-fallthrough*/
> +	case 2:
> +		k1 ^=3D ((uint32_t)tail[1]) << 8;
> +		/*-fallthrough*/
> +	case 1:
> +		k1 ^=3D ((uint32_t)tail[0]) << 0;
> +		k1 *=3D c1;
> +		k1 =3D rotate_right(k1, r1);

It is  remainingBytes ROL r1 / ROTL32(k1,15) / (k << 15) | (k >> (32 - 15))=
=20
(in other implementations), not rotate_right.  The same references as
before.

> +		k1 *=3D c2;
> +		seed ^=3D k1;
> +		break;
> +	}
> +
> +	seed ^=3D (uint32_t)len;
> +	seed ^=3D (seed >> 16);
> +	seed *=3D 0x85ebca6b;
> +	seed ^=3D (seed >> 13);
> +	seed *=3D 0xc2b2ae35;
> +	seed ^=3D (seed >> 16);
> +
> +	return seed;
> +}

In https://public-inbox.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.=
com/
you posted "[PATCH] Process bloom filter data as 1 byte words".
This may avoid the Big-endian vs Little-endian confusion,
that is wrong results on Big-endian architectures, but
it also may slow down the algorithm.

The public domain implementation in PMurHash.c in SMHasher
(re)implementation in Chromium (see URL above) fall backs to 1-byte
operations only if it doesn't know the endianness (or if it is neither
little-endian, nor big-endian, i.e. middle-endian or mixed-endian --
though I doubt that Git works correctly on mixed-endian anyway).


Sidenote: it looks like the current implementation if Murmur hash in
Cromium uses MurmurHash3_x86_32, i.e. little-endian unaligned-safe
implementation, but prepares data by swapping with StringToLE32
https://github.com/chromium/chromium/blob/master/components/variations/vari=
ations_murmur_hash.h


Assuming that the terminating NUL ("\0") character of a c-string is not
included in hash calculations, then murmur3_x86_32 hash has the
following results (all results are for seed equal 0):

''               -> 0x00000000
' '              -> 0x7ef49b98
'Hello world!'   -> 0x627b0c2c
'The quick brown fox jumps over the lazy dog'   -> 0x2e4ff723

C source (from Wikipedia): https://godbolt.org/z/ofa2p8
C++ source (Appleby's):    https://godbolt.org/z/BoSt6V

The implementation provided in this patch, with rotate_right (instead of
rotate_left) gives, on little-endian machine, different results:

''               -> 0x00000000
' '              -> 0xd1f27e64
'Hello world!'   -> 0xa0791ad7
'The quick brown fox jumps over the lazy dog'   -> 0x99f1676c

https://github.com/gitgitgadget/git/blob/e1b076a714d611e59d3d71c89221e41a34=
27fae4/bloom.c#L21
C source (via GitGitGadget): https://godbolt.org/z/R9s8Tt

Sidenote: While Godbolt.org site supports compiling with many different
compilers, including GCC, Clang (LLVM), icc (Intel), MSVC (via Wine),
and cross compiling for different platforms, including x86_64, ARM, MIPS,
PowerPC, power64 and power64le, AVR, it allows for execution only on
x86_64 i.e. little-endian.


We could create test similar to the one for SHA-1 and SHA-256 in
t/t0015-hash.sh but for murmur3, for example:

  test_expect_success 'test basic Murmur3_32 hash values' '
  	printf " " | test-tool murmur3_32 0 >actual &&
        printf "7ef49b98" >expected &&
        test_cmp expected actual &&
        ...
  '

or

  test_expect_success 'test basic Murmur3_32 hash values' '
  	printf " " | test-tool murmur3_32 0 >actual &&
        grep "7ef49b98" actual &&
        ...
  '

> +
> +static inline uint64_t get_bitmask(uint32_t pos)
> +{
> +	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
> +}

All right, that creates 64-bit wide mask with 1 bit set to 1 for a
64-bit word within filter data.  I just wonder if the trick with the &
operation is truly faster than using simpler to understand modulo
with compiler optimizations.

   static inline uint64_t get_bitmask(uint32_t pos)
   {
   	return ((uint64_t)1) << (pos % BITS_PER_WORD);
   }

Anyway, looks good (beside naming things, but I don't have better
proposal, and the function is static i.e. file-local anyway).

> +
> +void load_bloom_filters(void)
> +{
> +	init_bloom_filter_slab(&bloom_filters);
> +}


Actually this function doesn't load anything.  Perhaps it should be
named init_bloom_filters() or init_bloom_filters_storage(), or
bloom_filters_init()?

> +
> +void fill_bloom_key(const char *data,
> +					int len,
> +					struct bloom_key *key,
> +					struct bloom_filter_settings *settings)

The last parameter could be of 'const bloom_filter_settings *' type.

> +{
> +	int i;
> +	const uint32_t seed0 =3D 0x293ae76f;
> +	const uint32_t seed1 =3D 0x7e646e2c;

Where did those seeds values came from?

> +	const uint32_t hash0 =3D seed_murmur3(seed0, data, len);
> +	const uint32_t hash1 =3D seed_murmur3(seed1, data, len);
> +
> +	key->hashes =3D (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32=
_t));
> +	for (i =3D 0; i < settings->num_hashes; i++)
> +		key->hashes[i] =3D hash0 + i * hash1;

Note that in [3] authors say that double hashing technique has some
problems.  For one, we should ensure that hash1 is not zero, and even
better that it is odd (which makes it relatively prime to filter size
which is multiple of 64).  It also suffers from something called
"approximate fingerprint collisions".

That is why the define "enhanced double hashing" technique, which does
not suffer from those problems (Algorithm 2, page 11/15).

  +	for (i =3D 0; i < settings->num_hashes; i++) {
  +		key->hashes[i] =3D hash0;
  +
  +		hash0 =3D hash0 + hash1;
  +		hash1 =3D hash1 + i;
  +	}

This can also be written in closed form, based on equation (6)

  +	for (i =3D 0; i < settings->num_hashes; i++)
  +		key->hashes[i] =3D hash0 + i * hash1 + i*(i*i - 1)/6;


In later paper [6] the closed form for "enhanced double hashing"
(p. 188) is slightly modified (or rather they use different variant of
this technique):

  +	for (i =3D 0; i < settings->num_hashes; i++)
  +		key->hashes[i] =3D hash0 + i * hash1 + i*i;

This is a variant of more generic "enhanced double hashing", section
5.2 (Enhanced) Double Hashing Schemes (page 199):

        h_1(u) + i h_2(u) + f(i)    mod m

with f(i) =3D i^2 =3D i*i.

They have tested that enhanced double hashing with both f(i) equal i*i
and equal i*i*i, and triple hashing technique, and they have found that
it performs slightly better than straight double hashing technique
(Fig. 1, page 212, section 3).

> +}
> +
> +void add_key_to_filter(struct bloom_key *key,
> +					   struct bloom_filter *filter,
> +					   struct bloom_filter_settings *settings)

Here again the 'settings' argument can be const (as can the 'key'
parameter).

> +{
> +	int i;
> +	uint64_t mod =3D filter->len * BITS_PER_WORD;
> +
> +	for (i =3D 0; i < settings->num_hashes; i++) {
> +		uint64_t hash_mod =3D key->hashes[i] % mod;
> +		uint64_t block_pos =3D hash_mod / BITS_PER_WORD;
> +
> +		filter->data[block_pos] |=3D get_bitmask(hash_mod);
> +	}
> +}

All right, bloom_key is an intermediate representation that is used both
for creating Bloom filter, and for querying it.  In the latter case the
same path may be tested against Bloom filters for commits with different
number of (blob and tree) changes, and thus against Bloom filters with
different lengths.  It makes sense for bloom_key to store just values of
hash functions, without arithmetics modulo filter size.

Though I think it could be a good idea to create add_str_to_filter() as
a wrapper around add_key_to_filter() and fill_bloom_key() functions.

> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c)
> +{
> +	struct bloom_filter *filter;
> +	struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTINGS;
> +	int i;
> +	struct diff_options diffopt;
> +
> +	if (!bloom_filters.slab_size)
> +		return NULL;

This is testing that commit slab for per-commit Bloom filters is
initialized, isn't it?

First, should we write the condition as

	if (!bloom_filters.slab_size)

or would the following be more readable

	if (bloom_filters.slab_size =3D=3D 0)

Second, should we return NULL, or should we just initialize the slab?
Or is non-existence of slab treated as a signal that the Bloom filters
mechanism is turned off?

> +
> +	filter =3D bloom_filter_slab_at(&bloom_filters, c);

Wouldn't it be better to check if the data for commit exists already on
the slab, and create the Bloom filter for commit changes only if it does
not exists, i.e.:

  +	filter =3D bloom_filter_slab_peek(&bloom_filters, c);
  +	if (filter)
  +		return filter;
  +	filter =3D bloom_filter_slab_at(&bloom_filters, c);

> +
> +	repo_diff_setup(r, &diffopt);
> +	diffopt.flags.recursive =3D 1;
> +	diff_setup_done(&diffopt);

I'll punt on checking this.  Looks all right from first glance, and
follows calling sequence in https://github.com/git/git/blob/master/diff.h#L=
26

> +
> +	if (c->parents)
> +		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diff=
opt);
> +	else
> +		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
> +	diffcore_std(&diffopt);

All right, that computes first-parent diff (or diff from empty tree of
there are no parents).

> +
> +	if (diff_queued_diff.nr <=3D 512) {

First, shouldn't this magic value 512 be hidden behind some symbolic
name (some preprocessor constant), e.g. BLOOM_MAX_CHANGES?  On the other
hand this value is used only once (except tests), so it might be not
worth it -- especially coming up with a good name.

Second, there is a minor issue that diff_queue_struct.nr stores the
number of filepairs, that is the number of changed files, while the
number of elements added to Bloom filter is number of changed blobs and
trees.  For example if the following files are changed:

  sub/dir/file1
  sub/file2

then diff_queued_diff.nr is 2, but number of elements to be added to
Bloom filter is 4.

  sub/dir/file1
  sub/file2
  sub/dir/
  sub/

I'm not sure if it matters in practice.

> +		struct hashmap pathmap;
> +		struct pathmap_hash_entry* e;
> +		struct hashmap_iter iter;
> +		hashmap_init(&pathmap, NULL, NULL, 0);

Stylistic issue: I have just noticed that here (and in some other
places), but not in all cases, you declare pointer types with asterisk
cuddled to type name, not to variable name, which contradicts
CodingGuidelines:

 - When declaring pointers, the star sides with the variable
   name, i.e. "char *string", not "char* string" or
   "char * string".  This makes it easier to understand code
   like "char *string, c;".

In this case it should be

  +		struct pathmap_hash_entry *e;

In many other places in this patch it is correct, though.

> +
> +		for (i =3D 0; i < diff_queued_diff.nr; i++) {
> +			const char* path =3D diff_queued_diff.queue[i]->two->path;

Is that correct that we consider only post-image name for storing
changes in Bloom filter?  Currently if file was renamed (or deleted), it
is considered changed, and `git log -- <old-name>` lists commit that
changed file name too.

> +			const char* p =3D path;

It should be "const char *" for both.

> +
> +			/*
> +			* Add each leading directory of the changed file, i.e. for
> +			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
> +			* the Bloom filter could be used to speed up commands like
> +			* 'git log dir/subdir', too.
> +			*
> +			* Note that directories are added without the trailing '/'.
> +			*/
> +			do {
> +				char* last_slash =3D strrchr(p, '/');
> +
> +				FLEX_ALLOC_STR(e, path, path);

Here first 'path' is the field name, i.e. pathmap_hash_entry.path,
second 'path' is the name of local variable, aliased also to 'p'.

> +				hashmap_entry_init(&e->entry, strhash(p));

I don't know why both 'path' and 'p' are used, while both point to the
same memory (and thus have the same contents).  It is a bit confusing.
See also my previous comment.

> +				hashmap_add(&pathmap, &e->entry);
> +
> +				if (!last_slash)
> +					last_slash =3D (char*)p;
> +				*last_slash =3D '\0';
> +
> +			} while (*p);

Looks good.  We overwrite '/' with '\0', and gather shrinking pathnames
along the way.

> +
> +			diff_free_filepair(diff_queued_diff.queue[i]);
> +		}
> +
> +		filter->len =3D (hashmap_get_size(&pathmap) * settings.bits_per_entry =
+ BITS_PER_WORD - 1) / BITS_PER_WORD;

All right, this is division by BITS_PER_WORD, rounding up.

Sidenote: I see now why hashmap was used, it was to be able to get
number of unique changes (changed blobs and trees) easily.

> +		filter->data =3D xcalloc(filter->len, sizeof(uint64_t));
> +
> +		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
> +			struct bloom_key key;
> +			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
> +			add_key_to_filter(&key, filter, &settings);
> +		}

All right.

> +
> +		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
> +	} else {
> +		for (i =3D 0; i < diff_queued_diff.nr; i++)
> +			diff_free_filepair(diff_queued_diff.queue[i]);

All right, that frees the memory taken by diff results.

> +		filter->data =3D NULL;
> +		filter->len =3D 0;

This needs to be explicitly stated both in the commit message and in the
API documentation (in comments) that bloom_filter.len =3D=3D 0 means "no
data", while "no changes" is represented as bloom_filter with len =3D=3D 1
and *data =3D=3D (uint64_t)0;

EDIT: actually "no changes" is also represented as bloom_filter with len
equal 0, as it turns out.

One possible alternative could be representing "no data" value with
Bloom filter of length 1 and all 64 bits set to 1, and "no changes"
represented as filter of length 0.  This is not unambiguous choice!

> +	}
> +
> +	free(diff_queued_diff.queue);
> +	DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +	return filter;
> +}

All right.

> +
> +int bloom_filter_contains(struct bloom_filter *filter,
> +			  struct bloom_key *key,
> +			  struct bloom_filter_settings *settings)

It might be good idea to define enum for return values, that is
NO_DATA =3D -1, NO =3D 0, MAYBE =3D 1.

> +{
> +	int i;
> +	uint64_t mod =3D filter->len * BITS_PER_WORD;
> +
> +	if (!mod)
> +		return -1;

All right, it is different way of writing

	if (filter->len =3D=3D 0)
		return -1;

which means "no data" (too many elements for Bloom filter to store).
EDIT: or "no changes".

> +
> +	for (i =3D 0; i < settings->num_hashes; i++) {
> +		uint64_t hash_mod =3D key->hashes[i] % mod;
> +		uint64_t block_pos =3D hash_mod / BITS_PER_WORD;
> +		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
> +			return 0;

All right, if any of hash functions (hash results) doesn't match what is
stored in filter, then the key cannot be contained in the Bloom filter.

> +	}
> +
> +	return 1;

All right, otherwise the key is probably included in filter, but may be
false positive (with around 1% probability in theory).

This means that if we get value of 0, we can skip checking the diff; we
know commit is TREESAME with respect to the path given.

> +}
> diff --git a/bloom.h b/bloom.h
> new file mode 100644
> index 0000000000..7f40c751f7
> --- /dev/null
> +++ b/bloom.h
> @@ -0,0 +1,56 @@
> +#ifndef BLOOM_H
> +#define BLOOM_H

Should we #include the stdint.h header for uint32_t and uint64_t types?

> +
> +struct commit;
> +struct repository;
> +struct commit_graph;
> +

Perhaps we should add block comment for this struct, like there is one
for struct bloom_filter below.

> +struct bloom_filter_settings {
> +	uint32_t hash_version;
> +	uint32_t num_hashes;
> +	uint32_t bits_per_entry;

I guess that the type uint32_t was chosen to make it easier to store
this information and later retrieve it from the commit-graph file, isn't
it?  Otherwise those types are much too large for sensible range of
values (which would all fit in 8-bits byte).

> +};
> +
> +#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
> +#define BITS_PER_WORD 64

Sidenote: While CodingGuidelines explicitly says:

 - We try to support a wide range of C compilers to compile Git with,
   including old ones.  You should not use features from newer C
   standard, even if your compiler groks them.

   There are a few exceptions to this guideline:

   [...]

   . since mid 2017 with cbc0f81d, we have been using designated
     initializers for struct (e.g. "struct t v =3D { .val =3D 'a' };").

I don't think however that using designated initializers in
DEFAULT_BLOOM_FILTER_SETTINGS is needed, as this preprocessor constant
is just below the definition of struct bloom_filter_settings type.

> +
> +/*
> + * A bloom_filter struct represents a data segment to
> + * use when testing hash values. The 'len' member
> + * dictates how many uint64_t entries are stored in
> + * 'data'.
> + */
> +struct bloom_filter {
> +	uint64_t *data;
> +	int len;
> +};

Just wondering: is there any advantage or disadvantage to putting 'len'
field first (i.e. before 'data') versus putting it after (i.e. after
'data')?  Is there a convention that Git uses?

> +
> +/*
> + * A bloom_key represents the k hash values for a
> + * given hash input. These can be precomputed and
> + * stored in a bloom_key for re-use when testing
> + * against a bloom_filter.

We might want to add that the number of hash values is given by Bloom
filter settings, and it is assumed to be the same for all bloom_key
variables / objects.

> + */
> +struct bloom_key {
> +	uint32_t *hashes;
> +};
> +
> +void load_bloom_filters(void);
> +
> +void fill_bloom_key(const char *data,
> +		    int len,
> +		    struct bloom_key *key,
> +		    struct bloom_filter_settings *settings);
> +
> +void add_key_to_filter(struct bloom_key *key,
> +					   struct bloom_filter *filter,
> +					   struct bloom_filter_settings *settings);
> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c);
> +
> +int bloom_filter_contains(struct bloom_filter *filter,
> +			  struct bloom_key *key,
> +			  struct bloom_filter_settings *settings);
> +
> +#endif
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> new file mode 100644
> index 0000000000..331957011b
> --- /dev/null
> +++ b/t/helper/test-bloom.c
> @@ -0,0 +1,84 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "bloom.h"
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "commit-graph.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "object-store.h"
> +#include "object.h"
> +#include "repository.h"
> +#include "tree.h"
> +
> +struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTINGS;
> +
> +static void print_bloom_filter(struct bloom_filter *filter) {
> +	int i;
> +
> +	if (!filter) {
> +		printf("No filter.\n");
> +		return;
> +	}
> +	printf("Filter_Length:%d\n", filter->len);
> +	printf("Filter_Data:");
> +	for (i =3D 0; i < filter->len; i++){
> +		printf("%"PRIx64"|", filter->data[i]);
> +	}
> +	printf("\n");
> +}
> +
> +static void add_string_to_filter(const char *data, struct bloom_filter *=
filter) {
> +		struct bloom_key key;
> +		int i;
> +
> +		fill_bloom_key(data, strlen(data), &key, &settings);
> +		printf("Hashes:");
> +		for (i =3D 0; i < settings.num_hashes; i++){
> +			printf("%08x|", key.hashes[i]);
> +		}
> +		printf("\n");
> +		add_key_to_filter(&key, filter, &settings);
> +}
> +
> +static void get_bloom_filter_for_commit(const struct object_id *commit_o=
id)
> +{
> +	struct commit *c;
> +	struct bloom_filter *filter;
> +	setup_git_directory();
> +	c =3D lookup_commit(the_repository, commit_oid);
> +	filter =3D get_bloom_filter(the_repository, c);
> +	print_bloom_filter(filter);
> +}
> +
> +int cmd__bloom(int argc, const char **argv)
> +{
> +    if (!strcmp(argv[1], "generate_filter")) {
> +		struct bloom_filter filter;
> +		int i =3D 2;
> +		filter.len =3D  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_P=
ER_WORD;
> +		filter.data =3D xcalloc(filter.len, sizeof(uint64_t));
> +
> +		if (!argv[2]){
> +			die("at least one input string expected");
> +		}
> +
> +		while (argv[i]) {
> +			add_string_to_filter(argv[i], &filter);
> +			i++;
> +		}
> +
> +		print_bloom_filter(&filter);
> +	}
> +
> +	if (!strcmp(argv[1], "get_filter_for_commit")) {
> +		struct object_id oid;
> +		const char *end;
> +		if (parse_oid_hex(argv[2], &oid, &end))
> +			die("cannot parse oid '%s'", argv[2]);
> +		load_bloom_filters();
> +		get_bloom_filter_for_commit(&oid);
> +	}
> +
> +	return 0;
> +}


I won't comment on test-tool code, as I think the Bloom filter and
Murmur3 hash tests should be structured differently, which would
completely change test-bloom.c code.

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c9a232d238..ca4f4b0066 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -14,6 +14,7 @@ struct test_cmd {
>  };
>=20=20
>  static struct test_cmd cmds[] =3D {
> +	{ "bloom", cmd__bloom },
>  	{ "chmtime", cmd__chmtime },
>  	{ "config", cmd__config },
>  	{ "ctype", cmd__ctype },

> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index c8549fd87f..05d2b32451 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -4,6 +4,7 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "git-compat-util.h"
>=20=20
> +int cmd__bloom(int argc, const char **argv);
>  int cmd__chmtime(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
>  int cmd__ctype(int argc, const char **argv);

All right, looks good.

> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> new file mode 100755
> index 0000000000..424fe4fc29
> --- /dev/null
> +++ b/t/t0095-bloom.sh
> @@ -0,0 +1,113 @@
> +#!/bin/sh
> +
> +test_description=3D'test bloom.c'

This description is a bit lackluster...

> +. ./test-lib.sh
> +
> +test_expect_success 'get bloom filters for commit with no changes' '
> +	git init &&
> +	git commit --allow-empty -m "c0" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:0
> +	Filter_Data:
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'

A few things.  First, I wonder why we need to provide object ID;
couldn't 'test-tool bloom get_filter_for_commit' parse commit-ish
argument, or would it make it too complicated for no reason?

Second, why both "no changes" (here) and "no data" have the same
representation of filter with length equal 0?  Let's take a look at the
code.

For no changes:

  filter->len =3D (hashmap_get_size(&pathmap) * settings.bits_per_entry + B=
ITS_PER_WORD - 1) / BITS_PER_WORD;
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^ =3D=3D 0  for no changes
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^
                 \-- =3D=3D 0 + BITS_PER_WORD - 1     for no changes
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 \-- =3D=3D 0  for no changes
  filter->data =3D xcalloc(filter->len, sizeof(uint64_t));
                         ^^^^^^^^^^^ =3D=3D 0  for no changes
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 \-- is NULL or unique pointer that can be passed to free()

For more than 512 changed files:

  filter->data =3D NULL;
  filter->len =3D 0;

Not being able to distinguish between "no data" and "no changes in the
commit" cases means that we would always perform full diff for commit
with no changes, unnecessarily.  Fortunately there should be no hit to
performance, as in this case we need to simply compare objects IDs of
top tree to know that there is no change.

If it is a design decision we go with, it should be in my opinion at
least explained in the commit message explicitly.

> +
> +test_expect_success 'get bloom filter for commit with 10 changes' '
> +	rm actual &&
> +	rm expect &&
> +	mkdir smallDir &&
> +	for i in $(test_seq 0 9)
> +	do
> +		echo $i >smallDir/$i
> +	done &&
> +	git add smallDir &&
> +	git commit -m "commit with 10 changes" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:4
> +	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab3100=
98051a8|
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'

This test is in my opinion fragile, as it unnecessarily test the
implementation details instead of the functionality provided.  If we
change the hashing scheme (for example going from double hashing to some
variant of enhanced double hashing), or change the base hash function
(for example from Murmur3_32 to xxHash_64), or change the number of hash
functions (perhaps because changing of number of bits per element, and
thus optimal number of hash functions from 7 to 6), or change from
64-bit word blocks to 32-bit word blocks, the test would have to be
changed.

What I think would be a good test is something like t/t0011-hashmap.sh.
For example test that the Bloom filter size scales correctly could look
like this:

   test_bloom() {
   	echo "$1" | test-tool bloom $3 >actual &&
   	echo "$2" >expect &&
   	test_cmp expect actual
   }

   test_expect_success 'Bloom filter for commit size scales with number of =
changes' '
   	mkdir smallDir &&
	for i in $(test_seq 0 9)
	do
		echo $i >smallDir/$i
	done &&
	git add smallDir &&
	git commit -m "commit with 10 changes" &&
        HEAD=3D$(git rev-parse HEAD) &&
        cat | test-tool bloom >actual <<-EOF &&
        add-commit $HEAD
        len-commit $HEAD
        EOF
        echo "4" >expect &&
        test_cmp expect actual
   '

> +
> +test_expect_success EXPENSIVE 'get bloom filter for commit with 513 chan=
ges' '
> +	rm actual &&
> +	rm expect &&
> +	mkdir bigDir &&
> +	for i in $(test_seq 0 512)
> +	do
> +		echo $i >bigDir/$i
> +	done &&
> +	git add bigDir &&
> +	git commit -m "commit with 513 changes" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:0
> +	Filter_Data:
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'

All right, it is good test to have (though perhaps in modified form,
less fragile one).

> +
> +test_expect_success 'compute bloom key for empty string' '
> +	cat >expect <<-\EOF &&
> +	Hashes:5615800c|5b966560|61174ab4|66983008|6c19155c|7199fab0|771ae004|
> +	Filter_Length:1
> +	Filter_Data:11000110001110|
> +	EOF
> +	test-tool bloom generate_filter "" >actual &&
> +	test_cmp expect actual
> +'

This might be unnecessarily fragile test, but it might be a good test
for double hashing or enhanced double hashing technique.  Murmur3 hash
on empty data (empty string) always return seed value, so the result of
(enhanced) double hashing technique is predictable, given two seed
values.

> +
> +test_expect_success 'compute bloom key for whitespace' '
> +	cat >expect <<-\EOF &&
> +	Hashes:1bf014e6|8a91b50b|f9335530|67d4f555|d676957a|4518359f|b3b9d5c4|
> +	Filter_Length:1
> +	Filter_Data:401004080200810|
> +	EOF
> +	test-tool bloom generate_filter " " >actual &&
> +	test_cmp expect actual
> +'

Instead of those two fragile tests (that depend on irrelevant details of
the implementation), it would be better to create test similar to those
in t/t0011-hashmap.sh, for example:

   test_expect_success 'testing Bloom filter querying' '
   	test_bloom "add abc
        add abcdef
        check abc
        check abcdef
        check abcdee
        check abcdefghi
        len" "maybe
        maybe
        no
        no
        1"
   '

Or maybe something like this:

   test_expect_success 'testing Bloom filter querying' '
   	cat >commands <<\-EOF &&
        add abc
        add abcdef
        check abc
        check abcdef
        check abcdee
        check abcdefghi
        len
        EOF

   	cat >expect <<\-EOF &&
        maybe
        maybe
        no
        no
        1
        EOF
=20=20=20=20=20=20=20=20
        test-tool bloom <commands >actual &&
        test_cmp expect actual
   '

> +
> +test_expect_success 'compute bloom key for a root level folder' '
> +	cat >expect <<-\EOF &&
> +	Hashes:1a21016f|fff1c06d|e5c27f6b|cb933e69|b163fd67|9734bc65|7d057b63|
> +	Filter_Length:1
> +	Filter_Data:aaa800000000|
> +	EOF
> +	test-tool bloom generate_filter "A" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'compute bloom key for a root level file' '
> +	cat >expect <<-\EOF &&
> +	Hashes:e2d51107|30970605|7e58fb03|cc1af001|19dce4ff|679ed9fd|b560cefb|
> +	Filter_Length:1
> +	Filter_Data:a8000000000000aa|
> +	EOF
> +	test-tool bloom generate_filter "file.txt" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'compute bloom key for a deep folder' '
> +	cat >expect <<-\EOF &&
> +	Hashes:864cf838|27f055cd|c993b362|6b3710f7|0cda6e8c|ae7dcc21|502129b6|
> +	Filter_Length:1
> +	Filter_Data:1c0000600003000|
> +	EOF
> +	test-tool bloom generate_filter "A/B/C/D/E" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'compute bloom key for a deep file' '
> +	cat >expect <<-\EOF &&
> +	Hashes:07cdf850|4af629c7|8e1e5b3e|d1468cb5|146ebe2c|5796efa3|9abf211a|
> +	Filter_Length:1
> +	Filter_Data:4020100804010080|
> +	EOF
> +	test-tool bloom generate_filter "A/B/C/D/E/file.txt" >actual &&
> +	test_cmp expect actual
> +'

What are those meant to test?  For the Bloom filter itself it doesn't
matter if we add "A/B/C/file.txt" string to filter, or "ABC" string.

What we didn't test is that changed _directories_ are also added to the
Bloom filter for a commit.  Such test could look like this:

   test_expect_success 'changed directories are added to Bloom filter' '
   	mkdir -p A/B &&
	echo "foo" >A/B/file.txt &&
	git add A/B/file.txt &&
	git commit -m "add A/B/file.txt" &&
        HEAD=3D$(git rev-parse HEAD) &&

   	cat >commands <<-EOF &&
        add-commit $HEAD
        check A/B/file.txt
        check A/B
        check A
        EOF

   	cat >expect <<\-EOF &&
        maybe
        maybe
	maybe
        EOF
=20=20=20=20=20=20=20=20
        test-tool bloom <commands >actual &&
        test_cmp expect actual
   '


> +
> +test_done

Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Thanks for working on this.

Best,
--=20
Jakub Nar=C4=99bski
