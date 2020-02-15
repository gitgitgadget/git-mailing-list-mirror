Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607EC2BA83
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 17:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253DF2082F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 17:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k62ft3aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBORRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:17:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40368 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgBORRu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 12:17:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so14161877ljo.7
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=QAM2FOjeP8IPc3xHuzwFTwL+3YIjN48mWMILsD5OGwI=;
        b=k62ft3aZ8gadCaFLKqmT0KBG5yx9XMqjVC964bsppt0O25x5T1uML2tNkzYA+wSeRS
         0UMnjI4beyTI9cS1UD16GtADlMKPdwfZ1l/9vuuU0KbjwNa1ACnXAZRCKoSkFbzcJf8A
         CdTtjflSRY8ApH93IJGzpZsBGJHoucKg7CkBP3v+tFqyazX2ulmSTkkSPRj3Gk+FHIEt
         BUlVmdPDInRKRNhIPX0ALhRLJkKX7dKPkate0to1LvC6t4sY1oi5PhUaCg3gJqgPGJbe
         DMfHNqWDUxyRdQ3fa3Y5BL8EwU4EqBcd2WopEQtAONYkHp3rMLMuYR3+DwlBQ+uC5ice
         /1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QAM2FOjeP8IPc3xHuzwFTwL+3YIjN48mWMILsD5OGwI=;
        b=j9bp9VBpQaC2KKNm3wAw7qG3M1CvHarkIY3lrKK4SL9cGkyybZHXrKzVknNsqwpJD4
         0frbyn4hb3d3Q4NBS+VRuxMlVTBQpt554iSgFD6RdehnrQqhe1I95i24vruuUFl7KCWu
         p7Jt/CVOrjTbXRA6IlORZJANYKNXX+sRNLi0uSUNxB84uOs4I0Dy4iFQPepKKsOfax94
         +UH5umTUOLEJmjuuFt7w7pZfymWXVhM9evLO1L1egmsPOxWqTeQ8Q/b2gQ7ghpak15CE
         vtXV51UXdtJGEzEZuJyZnICqzaBjH+WdU9uR9sGxSvPH+ZThrruTdnnA7BSA/M7NDL6w
         0A7w==
X-Gm-Message-State: APjAAAXZuTbvnxFGz0pBa8zQS2EMQaverU+r4pDfnW6tdqnoM+9t00vx
        A+RfSCcXwI56rQKH4uUh/5k=
X-Google-Smtp-Source: APXvYqynQK2hbZAWUtgk/1Auoo3EsuU0O0DeroBN+BfcuK2VpvpAA1yAJF429tUaJ6BdjcCIg8Xc8g==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr5475146ljj.225.1581787065969;
        Sat, 15 Feb 2020 09:17:45 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r21sm5428283ljn.64.2020.02.15.09.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Feb 2020 09:17:44 -0800 (PST)
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
Date:   Sat, 15 Feb 2020 18:17:39 +0100
Message-ID: <86eeuvwz0s.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

It looks like the Crhomium implementation in C by Shane Day (public
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
> +
> +static inline uint64_t get_bitmask(uint32_t pos)
> +{
> +	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
> +}
> +
> +void load_bloom_filters(void)
> +{
> +	init_bloom_filter_slab(&bloom_filters);
> +}
> +
> +void fill_bloom_key(const char *data,
> +					int len,
> +					struct bloom_key *key,
> +					struct bloom_filter_settings *settings)
> +{
> +	int i;
> +	const uint32_t seed0 =3D 0x293ae76f;
> +	const uint32_t seed1 =3D 0x7e646e2c;
> +	const uint32_t hash0 =3D seed_murmur3(seed0, data, len);
> +	const uint32_t hash1 =3D seed_murmur3(seed1, data, len);
> +
> +	key->hashes =3D (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32=
_t));
> +	for (i =3D 0; i < settings->num_hashes; i++)
> +		key->hashes[i] =3D hash0 + i * hash1;
> +}
> +
> +void add_key_to_filter(struct bloom_key *key,
> +					   struct bloom_filter *filter,
> +					   struct bloom_filter_settings *settings)
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
> +
> +	filter =3D bloom_filter_slab_at(&bloom_filters, c);
> +
> +	repo_diff_setup(r, &diffopt);
> +	diffopt.flags.recursive =3D 1;
> +	diff_setup_done(&diffopt);
> +
> +	if (c->parents)
> +		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diff=
opt);
> +	else
> +		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
> +	diffcore_std(&diffopt);
> +
> +	if (diff_queued_diff.nr <=3D 512) {
> +		struct hashmap pathmap;
> +		struct pathmap_hash_entry* e;
> +		struct hashmap_iter iter;
> +		hashmap_init(&pathmap, NULL, NULL, 0);
> +
> +		for (i =3D 0; i < diff_queued_diff.nr; i++) {
> +			const char* path =3D diff_queued_diff.queue[i]->two->path;
> +			const char* p =3D path;
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
> +				hashmap_entry_init(&e->entry, strhash(p));
> +				hashmap_add(&pathmap, &e->entry);
> +
> +				if (!last_slash)
> +					last_slash =3D (char*)p;
> +				*last_slash =3D '\0';
> +
> +			} while (*p);
> +
> +			diff_free_filepair(diff_queued_diff.queue[i]);
> +		}
> +
> +		filter->len =3D (hashmap_get_size(&pathmap) * settings.bits_per_entry =
+ BITS_PER_WORD - 1) / BITS_PER_WORD;
> +		filter->data =3D xcalloc(filter->len, sizeof(uint64_t));
> +
> +		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
> +			struct bloom_key key;
> +			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
> +			add_key_to_filter(&key, filter, &settings);
> +		}
> +
> +		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
> +	} else {
> +		for (i =3D 0; i < diff_queued_diff.nr; i++)
> +			diff_free_filepair(diff_queued_diff.queue[i]);
> +		filter->data =3D NULL;
> +		filter->len =3D 0;
> +	}
> +
> +	free(diff_queued_diff.queue);
> +	DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +	return filter;
> +}
> +
> +int bloom_filter_contains(struct bloom_filter *filter,
> +			  struct bloom_key *key,
> +			  struct bloom_filter_settings *settings)
> +{
> +	int i;
> +	uint64_t mod =3D filter->len * BITS_PER_WORD;
> +
> +	if (!mod)
> +		return -1;
> +
> +	for (i =3D 0; i < settings->num_hashes; i++) {
> +		uint64_t hash_mod =3D key->hashes[i] % mod;
> +		uint64_t block_pos =3D hash_mod / BITS_PER_WORD;
> +		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> diff --git a/bloom.h b/bloom.h
> new file mode 100644
> index 0000000000..7f40c751f7
> --- /dev/null
> +++ b/bloom.h
> @@ -0,0 +1,56 @@
> +#ifndef BLOOM_H
> +#define BLOOM_H
> +
> +struct commit;
> +struct repository;
> +struct commit_graph;
> +
> +struct bloom_filter_settings {
> +	uint32_t hash_version;
> +	uint32_t num_hashes;
> +	uint32_t bits_per_entry;
> +};
> +
> +#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
> +#define BITS_PER_WORD 64
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
> +
> +/*
> + * A bloom_key represents the k hash values for a
> + * given hash input. These can be precomputed and
> + * stored in a bloom_key for re-use when testing
> + * against a bloom_filter.
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
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> new file mode 100755
> index 0000000000..424fe4fc29
> --- /dev/null
> +++ b/t/t0095-bloom.sh
> @@ -0,0 +1,113 @@
> +#!/bin/sh
> +
> +test_description=3D'test bloom.c'
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
> +
> +test_done
