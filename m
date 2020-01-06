Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65CC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF7F208C4
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PneRuo+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgAFSo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:44:28 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39421 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 13:44:28 -0500
Received: by mail-lj1-f182.google.com with SMTP id l2so51962447lja.6
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0EoV1ZbTJXiFQMG5lfjtR0JH3ncskQZb2xuXNd4UsxY=;
        b=PneRuo+vYkzey5388iEu+Nw9x/LBGp/t5WM/mXPF0mckQhYfRAnSnNQJQ2OREYJ/VR
         3dPhAIqC6h8x7T7ke/rLNGXg2oHoVaoGiDSNhqMqT63UGRh14V531kBOTqDgX/vmFFHP
         /A0ytIDCbvbSTibXZZ4YgQC8+YN/F9/n4z+gGEAwMXhKMKet2IEJMZFCwBodYnF/5JNB
         hC8rjW4WgIuOAXLb6zlhARaYf8FLlZsPMJU85yoP0X6ZAjOFXv6i3UkzHa3aDUCYFc+7
         ioUQZgO0dPNy/4nUKsCfMv/PycZOESqZB6oLN4WfDOGZ/9aOsn66PlEVtUxzIHaJ2U1T
         /QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0EoV1ZbTJXiFQMG5lfjtR0JH3ncskQZb2xuXNd4UsxY=;
        b=fLclqk/SxbSLvh4AVXhJ932cO8i0Zo0PulGscgKyxDoINc6Gjb2TiTguAZJ0UXtnYq
         J1g2UeYKymoU0RNdi0UiOdST8l0hKwfhsyp+RDqxR9DbmA+e4j71vTNpYOiznbGbK30u
         dauViGOtVkj90hzvUeZPT0YZ8O3dXBlqyRPRCbtnDUQ//ihp6e0+P3ssmMRBWDsCvZG6
         yBK80nf3affAjqpjEKGj4QQWtNJk6AC3FO06KHZtCKM5D/VRJb1THcMtHnPRYWpAKwib
         n2OmgiItT/vwHEtAZeQRv79zpp3IerOuMqP7XYLrCjxzcMP1DCLygQZfMp3ImxFrzhaq
         YXpA==
X-Gm-Message-State: APjAAAWEOucvL3PS/S1yxpjQoKZIl5f6YDp46nKRWIJjSQhygVvegX/g
        PtxpVEhLn4dfRCMHyQUxW34=
X-Google-Smtp-Source: APXvYqwFEqdgkaYcgLMiAMxLs4j4tF392fL+O4of98SIrEHOsl6wgilJqSq92pnm7tAzRXUka0gTmA==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr12143083ljl.56.1578336262643;
        Mon, 06 Jan 2020 10:44:22 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s23sm22282936lji.70.2020.01.06.10.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 10:44:21 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 2/9] commit-graph: write changed paths bloom filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 19:44:14 +0100
In-Reply-To: <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:13
        +0000")
Message-ID: <86eewczapt.fsf@gmail.com>
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
> The changed path bloom filters help determine which paths changed between=
 a
> commit and its first parent. We already have the "--changed-paths" option
> for the "git commit-graph write" subcommand, now actually compute them un=
der
> that option. The COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag enables this
> computation.
>
> RFC Notes: Here are some details about the implementation and I would love
> to know your thoughts and suggestions for improvements here.
>
> For details on what bloom filters are and how they work, please refer to
> Dr. Derrick Stolee's blog post [1].
> [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-g=
raph-iv-bloom-filters/
>
> 1. The implementation sticks to the recommended values of 7 and 10 for the
>    number of hashes and the size of each entry, as described in the blog.

Please provide references to original work for this.  Derrick Stolee
blog post references the following work:

  Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, George=
 Varghese
  "An Improved Construction for Counting Bloom Filters"
  http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
  https://doi.org/10.1007/11841036_61

However, we do not use Counting Bloom Filters, but ordinary Bloom
Filters, if used in untypical way: instead of testing many elements
(keys) against single filter, we test single element (path) against
mainy filters.

Also, I'm not sure that values 10 bits per entry and 7 hash functions
are recommended; the work states:

  "For example, when n/m =3D 10 and k =3D 7 the false positive probability
  is just over 0.008."

Given false positive probablity we can calculate best choice for n/m and
k.

On the other hand in https://arxiv.org/abs/1912.08258 we have

  "For efficient memory usage, a Bloom filter with a false-positive
   probability =CF=B5 should use about =E2=88=92 log_2(=CF=B5) hash functio=
ns
   [Broder2004]. At a false-positive probability of 1%, seven hash
   functions are thus required."

So k=3D7 being optimal is somewhat confirmed.

>    The implementation while not completely open to it at the moment, is f=
lexible
>    enough to allow for tweaking these settings in the future.

All right.

>    Note: The performance gains we have observed so far with these values =
is
>    significant enough to not that we did not need to tweak these settings.
                           ^^^
s/not/note/

Did you try to tweak settings, i.e. numbers of bits per entry, number
of hash functions (which is derivative of the former - at least the
optimal number), the size of the block, the cutoff threshold value?
It is not needed to be in this patch series - fine tuning is probably
better left for later.

>    The cover letter of this series has the details and the commit where w=
e have
>    git log use bloom filters.

The second part of this sentence, from "and the commit..." is a bit
unclear.  Did you mean here that the future / subsequent commit in this
patch series that makes Git actually use Bloom filters in `git log --
<path>` will have more details in its commit message?

> 2. As described in the blog and the linked technical paper therin, we do =
not need
                                                             ^^^^^^
s/therin/therein/

>    7 independent hashing functions. We use the Murmur3 hashing scheme - s=
eed it
>    twice and then combine those to procure an arbitrary number of hash va=
lues.

The "linked technical paper" in the blog post (which I would prefer to
have linked directly to in the commit message) is

  Peter C. Dillinger and Panagiotis Manolios
  "Bloom Filters in Probabilistic Verification"
  http://www.ccs.neu.edu/home/pete/pub/bloom-filters-verification.pdf
  https://doi.org/10.1007/978-3-540-30494-4_26

Sidenote: it looks like it is a reference from Wikipedia on Bloom filters.
This is according to authors the original paper with the _double hashing_
technique.

They also examine in much detail the optimal number of hash functions.

> 3. The filters are sized according to the number of changes in the each c=
ommit,
>    with minimum size of one 64 bit word.

Do I understand it correctly that the size of filter is 10*(number of
changed files) bits, rounded up to nearest multiple of 64?

How do you count renames and copies?  As two changes?

Do I understand it correctly that commit with no changes in it (which
can rarely happen) would have 64-bits i.e. 8-bytes Bloom filter of all
zeros: 0x0000000000000000?

How merges are handled?  Does the filter uses all changed files, or just
changes compared to first parent?

>
> [Call for advice] We currently cap writing bloom filters for commits with
> atmost 512 changed files. In the current implementation, we compute the d=
iff,
> and then just throw it away once we see it has more than 512 changes.
> Any suggestiongs on how to reduce the work we are doing in this case are =
more
> than welcome.

This got solved in "[PATCH] diff: halt tree-diff early after max_changes"
https://public-inbox.org/git/e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com/

> [Call for advice] Would the git community like this commit to be split up=
 into
> more granular commits? This commit could possibly be split out further wi=
th the
> bloom.c code in its own commit, to be used by the commit-graph in a subse=
quent
> commit. While I prefer it being contained in one commit this way, I am op=
en to
> suggestions.

I think it might be a good idea to split this commit into purely Bloom
filter implementation (bloom.c) AND unit tests for Bloom filter itself
(which would probably involve some new test-tool).

I have not read further messages in the series [edit: they don't], so I
don't know if such tests already exist or not.  One could test for
negative match, maybe also (for specific choice of hash function) for
positive and maybe even false positive match, for filter size depending
on the number of changes, for changes cap (maybe), maybe also for
no-changes scenario.


As for splitting the main part of the series, I would envision it in the
following way (which is of course only one possibility):

1. Implementation of generic-ish Bloom filter (with elements being
   strings / paths, and optimized to test single key against many
   filters, each taking small-ish space, variable size filter, limit on
   maximum number of elements).

   Technical documentation in comments in bloom.h (description of API)
   and bloom.c (details of the algorithm, with references).

   TODO: test-tool and unit tests.

2. Using per-commit Bloom filter(s) to store changeset information
   i.e. changed paths.  This would implement in-memory storage (on slab)
   and creating Bloom filter out of commit and repository information.

   Perhaps this should also get its own unit tests (that Bloom filter
   catches changed files, and excluding false positivess catches
   unchanged files).

3. Storing per-commit Bloom filters in the commit-graph file:

   a.) writing Bloom filters data to commit-graph file, which means
       designing the chunk(s) format,
   b.) verifying Bloom filter chunks, at least sanity-checks
   c.) reading Bloom filters from commit-graph file into memory

   Perhaps also some integration tests that the information is stored
   and retrieved correctly, and that verifying finds bugs in
   intentionally corrupted Bloom filter chunks.

4. Using Bloom filters to speed up `git log -- <path>` (and similar
   commands).

   It would be nice to have some functional tests, and maybe some
   performance tests, if possible.


> [Call for advice] Would a technical document explaining the exact details=
 of
> the bloom filter implemenation and the hashing calculations be helpful? I=
 will
> be adding details into Documentation/technical/commit-graph-format.txt, b=
ut the
> bloom filter code is an independent subsystem and could be used outside o=
f the
> commit-graph feature. Is it worth a separate document, or should we apply=
 "You
> Ain't Gonna Need It" principles?

As nowadays technical reference documentation is being moved from
Documentation/technical/api-*.txt to appropriate header files, maybe the
documentation of Bloom filter API (and some technical documentation and
references) be put in bloom.h?  See for example comments in strbuf.h.

> [Call for advice] I plan to add unit tests for bloom.c, specifically to e=
nsure
> that the hash algorithm and bloom key calculations are stable across vers=
ions.

Ah, so the unit tests for bloom.c does not exist, yet...

> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile       |   1 +
>  bloom.c        | 201 +++++++++++++++++++++++++++++++++++++++++++++++++
>  bloom.h        |  46 +++++++++++
>  commit-graph.c |  32 +++++++-
>  4 files changed, 279 insertions(+), 1 deletion(-)
>  create mode 100644 bloom.c
>  create mode 100644 bloom.h
>
> diff --git a/Makefile b/Makefile
> index 42a061d3fb..9d5e26f5d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -838,6 +838,7 @@ LIB_OBJS +=3D base85.o
>  LIB_OBJS +=3D bisect.o
>  LIB_OBJS +=3D blame.o
>  LIB_OBJS +=3D blob.o
> +LIB_OBJS +=3D bloom.o
>  LIB_OBJS +=3D branch.o
>  LIB_OBJS +=3D bulk-checkin.o
>  LIB_OBJS +=3D bundle.o

I'll put bloom.h first, to make it easier to review.

> diff --git a/bloom.h b/bloom.h
> new file mode 100644
> index 0000000000..ba8ae70b67
> --- /dev/null
> +++ b/bloom.h
> @@ -0,0 +1,46 @@
> +#ifndef BLOOM_H
> +#define BLOOM_H
> +
> +struct commit;
> +struct repository;

This would probably be missing if this patch was split in two:
introducing Bloom filter and saving Bloom filter in the repository
metadata (in commit-graphh file).

> +

O.K., the names of fields are descriptive enough so that this struct
doesn't need detailed description in comment (like the next one).

> +struct bloom_filter_settings {
> +	uint32_t hash_version;

Do we need full half-word for hash version?

> +	uint32_t num_hashes;

Do we need full 32-bits for number of hashes?  The "Bloom Filters in
Probabilistic Verification" paper mentioned in Stolee blog states that
no one should need number of hashes greater than k=3D32 - the accuracy is
so high that it doesn't matter that it is not optimal.

  "Notice one last thing about Bloom filters in verification, if $m$ is
   several gigabytes or less and $m/n$ calls for more than about 32 index
   functions, the accuracy is going to be so high that there is not much
   reason to use more than 32=E2=80=94for the next several years at least. =
In
   response to this, 3SPIN currently limits the user to $k =3D 32$. The
   point of this observation is that we do not have to worry about the
   runtime cost of $k$ being on the order of 64 or 100, because those
   choices do not really buy us anything over 32."

Here 'm' is the number of bits in Bloom filter, and m/n is number of
bits per element added to filter.

> +	uint32_t bits_per_entry;

All right, we wouldn't really want large Bloom filters, as we use one
filter per commit to match againts one key, not single Bloom filter to
match againts many keys.

> +};
> +
> +#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
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

O.K., so it is single variable-sized (in 64-bit increments) Bloom filter
bit vector (bitmap).

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

That is smart.  I wonder however if it wouldn't be a good idea to
'typedef' a hash function return type.

I repeat myself: in Git case we have one key that we try to match
against many Bloom filters which are never updated, while in an ordinary
case many keys are matched against single Bloom filter - in many cases
updated (with keys inserted to Bloom filter).

I wonder if somebody from academia have examined such situation.
I couldn't find a good search query.


Sidenote: perhaps Xor or Xor+ filters from Graf & Lemire (2019)
https://arxiv.org/abs/1912.08258 would be better solution - they also
assume unchanging filter.  Though they are a very fresh proposal;
also construction time might be important for Git.
https://github.com/FastFilter/xor_singleheader

> +
> +void load_bloom_filters(void);
> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c);

Those two functions really need API documentation on how they are used,
if they are to be used in any other role, especially what is their
calling convention?  Why load_bloom_filters() doesn't take any
parameters?

Anyway, if this patch would be split into pure Bloom filter
implementation and Git use^W store of Bloom filters, then this would be
left for the latter patch.

> +
> +void fill_bloom_key(const char *data,
> +		    int len,
> +		    struct bloom_key *key,
> +		    struct bloom_filter_settings *settings);

It is a bit strange that two basic Bloom filter operations, namely
adding element to Bloom filter (and constructing Bloom filter), and
testing whether element is in Bloom filter are not part of a public
API...

This function should probably be documented, in particular the fact that
*key is an in/out parameter.  This could also be a good place to
document the mechanism itself (i.e. our implementation of Bloom filter,
with references), though it might be better to keep the details of how
it works in the bloom.c - close to the actual source (while keeping
description of API in bloom.h comments).

> +
> +#endif
> diff --git a/bloom.c b/bloom.c
> new file mode 100644
> index 0000000000..08328cc381
> --- /dev/null
> +++ b/bloom.c
> @@ -0,0 +1,201 @@
> +#include "git-compat-util.h"
> +#include "bloom.h"
> +#include "commit-graph.h"
> +#include "object-store.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "revision.h"
> +#include "hashmap.h"
> +
> +#define BITS_PER_BLOCK 64
> +
> +define_commit_slab(bloom_filter_slab, struct bloom_filter);
> +
> +struct bloom_filter_slab bloom_filters;

All right, so the Bloom filter data would be on slab.  This should
probably be mentioned in the commit message, like in
https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

Sidenote: If I remember correctly one of the unmet prerequisites for
switching to generation numbers v2 (corrected commit date with monotonic
offsets) was moving 'generation' field out of 'struct commit' and on to
slab (possibly also 'graph_pos'), and certainly having 'corrected_date'
on slab (Inside-Out Object style).  Which probably could be done with
Coccinelle script...

> +
> +struct pathmap_hash_entry {
> +    struct hashmap_entry entry;
> +    const char path[FLEX_ARRAY];
> +};

Hmmm... I wonder why use hashmap and not string_list.  This is for
adding path with leading directories to the Bloom filter, isn't it?

> +
> +static uint32_t rotate_right(uint32_t value, int32_t count)
> +{
> +	uint32_t mask =3D 8 * sizeof(uint32_t) - 1;
> +	count &=3D mask;
> +	return ((value >> count) | (value << ((-count) & mask)));
> +}

Does it actually work with count being negative?  Shouldn't 'count' be
of unsigned type, and if int32_t is needed, perhaps add an assertion (if
needed)?  I think it does not.

It looks like it is John Regehr [2] safe and compiler-friendly
implementation, with explicit 8 in place of CHAR_BIT from <limits.h>,
which should compile to "rotate" assembly instruction... it looks like
it is the case, see https://godbolt.org/z/5JP1Jb (at least for C++
compiler).

[2]: https://en.wikipedia.org/wiki/Circular_shift


I wonder if this should, in the future, be a part of 'compat/', maybe
even using compiler intrinsics for "rotate right" if available (see
https://stackoverflow.com/a/776523/46058).  But that might be outside of
the scope of this patch (perhaps outside of choosing function name).

> +

It would be nice to have reference to the source of algorithm, or to the
code that was borrowed for this in the header comment for the following
function.

I will be comparing the algorithm itself in Wikipedia
https://en.wikipedia.org/wiki/MurmurHash#Algorithm
and its implementation in C in qLibc library (BSD licensed)
https://github.com/wolkykim/qlibc/blob/03a8ce035391adf88d6d755f9a26967c16a1=
a567/src/utilities/qhash.c#L258

> +static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
> +{
> +	const uint32_t c1 =3D 0xcc9e2d51;
> +	const uint32_t c2 =3D 0x1b873593;
> +	const int32_t r1 =3D 15;
> +	const int32_t r2 =3D 13;

Those two: r1 and r1, probably should be both uint32_t type.

> +	const uint32_t m =3D 5;
> +	const uint32_t n =3D 0xe6546b64;
> +	int i;
> +	uint32_t k1 =3D 0;
> +	const char *tail;

*tail should probably be 'uint8_t', not 'char', isn't it?

> +
> +	int len4 =3D len / sizeof(uint32_t);

All length variables and parameters, i.e. `len`, `len4`, `i`, could
possibly be `size_t` and not `int` type.

> +
> +	const uint32_t *blocks =3D (const uint32_t*)data;
> +

Some implementations copy `seed` (or assume seed=3D0) to the local
variable named `h` or `hash`.

> +	uint32_t k;
> +	for (i =3D 0; i < len4; i++)
> +	{
> +		k =3D blocks[i];
> +		k *=3D c1;
> +		k =3D rotate_right(k, r1);

Shouldn't it be *rotate_left* (ROL), not rotate_right (ROR)???
This affects all cases / uses.

> +		k *=3D c2;
> +
> +		seed ^=3D k;
> +		seed =3D rotate_right(seed, r2) * m + n;
> +	}
> +
> +	tail =3D (data + len4 * sizeof(uint32_t));
> +

We could have reused variable `k`, like the implementation in qLibc
does, instead of introducing new `k1` variable, but this way it is more
clean.  Or name it `remainingBytes` instead of `k1`

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

It would be nice to have header comment describing what this function is
intended to actually do.

> +static inline uint64_t get_bitmask(uint32_t pos)
> +{
> +	return ((uint64_t)1) << (pos & (BITS_PER_BLOCK - 1));
> +}

Sidenote: I wonder if ewah/bitmap.c implements something similar.
Certainly possible consolidation, if any possible exists, should be left
for the future.

> +
> +void fill_bloom_key(const char *data,
> +		    int len,
> +		    struct bloom_key *key,
> +		    struct bloom_filter_settings *settings)
> +{
> +	int i;
> +	uint32_t seed0 =3D 0x293ae76f;
> +	uint32_t seed1 =3D 0x7e646e2c;

Where did those constants came from?  It would be nice to have a
reference either in header comment (in bloom.h or bloom.c), or in a
commit message, or both.

Note that above *constants* are each used only once.

> +
> +	uint32_t hash0 =3D seed_murmur3(seed0, data, len);
> +	uint32_t hash1 =3D seed_murmur3(seed1, data, len);

Those are constant values, so perhaps they should be `const uint32_t`.

> +
> +	key->hashes =3D (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32=
_t));
> +	for (i =3D 0; i < settings->num_hashes; i++)
> +		key->hashes[i] =3D hash0 + i * hash1;

It looks like this code implements the double hashing technique given in
Eq. (4) in http://www.ccs.neu.edu/home/pete/pub/bloom-filters-verification.=
pdf
that is "Bloom Filters in Probabilistic Verification".

Note that Dillinger and Manolios in this paper propose also _enhanced_
double hashing algorithm (Algorithm 2 on page 11), which has closed form
given by Eq. (6) - with better science-theoretical properties at
similar cost.


It might be a good idea to explicitly state in the header comment that
all arithmetic is performed with unsigned 32-bit integers, which means
that operations are performed modulo 2^32.  Or it might not be needed.

> +}
> +
> +static void add_key_to_filter(struct bloom_key *key,
> +			      struct bloom_filter *filter,
> +			      struct bloom_filter_settings *settings)
> +{
> +	int i;
> +	uint64_t mod =3D filter->len * BITS_PER_BLOCK;
> +
> +	for (i =3D 0; i < settings->num_hashes; i++) {
> +		uint64_t hash_mod =3D key->hashes[i] % mod;
> +		uint64_t block_pos =3D hash_mod / BITS_PER_BLOCK;

All right.  Because Bloom filters for different commits (and the same
key) may have different lengths, we can perform modulo operation only
here.  `hash_mod` is i-th hash modulo size of filter, and `block_pos` is
the block the '1' bit would go into.

> +
> +		filter->data[block_pos] |=3D get_bitmask(hash_mod);

I'm not quite convinced that get_bitmask() is a good name: this function
returns bitmap with hash_mod's bit set to 1.  On the other hand it
doesn't matter, because it is static (file-local) helper function.

Never mind then.

> +	}
> +}
> +
> +void load_bloom_filters(void)
> +{
> +	init_bloom_filter_slab(&bloom_filters);
> +}

Why *load* if all it does is initialize?

> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c)

I will not comment on this function; see Jeff King reply and Derrick
Stolee reply.

> +{
[...]
> +}
> \ No newline at end of file

Why there is no newline at the end of the file?  Accident?

> diff --git a/commit-graph.c b/commit-graph.c
> index e771394aff..61e60ff98a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -16,6 +16,7 @@
>  #include "hashmap.h"
>  #include "replace-object.h"
>  #include "progress.h"
> +#include "bloom.h"
>=20=20
>  #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> @@ -794,9 +795,11 @@ struct write_commit_graph_context {
>  	unsigned append:1,
>  		 report_progress:1,
>  		 split:1,
> -		 check_oids:1;
> +		 check_oids:1,
> +		 bloom:1;

Very minor nitpick: why `bloom` and not `bloom_filter`?

>=20=20
>  	const struct split_commit_graph_opts *split_opts;
> +	uint32_t total_bloom_filter_size;

All right, I guess size of all Bloom filters would fit in uint32_t, no
need for size_t, is it?

Shouldn't it be total_bloom_filters_size -- it is not a single Bloom
filter, but many (minor nitpick)?

>  };
>=20=20
>  static void write_graph_chunk_fanout(struct hashfile *f,
> @@ -1139,6 +1142,28 @@ static void compute_generation_numbers(struct writ=
e_commit_graph_context *ctx)
>  	stop_progress(&ctx->progress);
>  }
>=20=20
> +static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> +{
> +	int i;
> +	struct progress *progress =3D NULL;
> +
> +	load_bloom_filters();
> +
> +	if (ctx->report_progress)
> +		progress =3D start_progress(
> +			_("Computing commit diff Bloom filters"),
> +			ctx->commits.nr);
> +
> +	for (i =3D 0; i < ctx->commits.nr; i++) {
> +		struct commit *c =3D ctx->commits.list[i];
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c);
> +		ctx->total_bloom_filter_size +=3D sizeof(uint64_t) * filter->len;

Wouldn't it be more future proof instead of using `sizeof(uint64_t)` to
use `sizeof(filter->data[0])` here?  This may be not worth it, and be
less readable (we have hard-coded use of 64-bits blocks in other places).

> +		display_progress(progress, i + 1);
> +	}
> +
> +	stop_progress(&progress);
> +}
> +
>  static int add_ref_to_list(const char *refname,
>  			   const struct object_id *oid,
>  			   int flags, void *cb_data)
> @@ -1791,6 +1816,8 @@ int write_commit_graph(const char *obj_dir,
>  	ctx->split =3D flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
>  	ctx->check_oids =3D flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
>  	ctx->split_opts =3D split_opts;
> +	ctx->bloom =3D flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;

All right, this flag was defined in [PATCH 1/9].

The ordering of setting `ctx` members looks a bit strange.  Now it is
neither check `flags` firsts, neither keep related stuff together (see
ctx->split vs ctx->split_opts).  This is a very minor nitpick.

> +	ctx->total_bloom_filter_size =3D 0;
>=20=20
>  	if (ctx->split) {
>  		struct commit_graph *g;
> @@ -1885,6 +1912,9 @@ int write_commit_graph(const char *obj_dir,
>=20=20
>  	compute_generation_numbers(ctx);
>=20=20
> +	if (ctx->bloom)
> +		compute_bloom_filters(ctx);
> +
>  	res =3D write_commit_graph_file(ctx);
>=20=20
>  	if (ctx->split)

Regards,
--=20
Jakub Nar=C4=99bski
