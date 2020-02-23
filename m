Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5FAC35666
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CAB206E0
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpHSW1BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBWNio (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:38:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35674 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWNio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 08:38:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so7079167ljb.2
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 05:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=heX0hBrkOe5D3chyXwrxnBH4sOHFx/dh69zfKjVAQ7c=;
        b=ZpHSW1BDbYAwH2prQazntnpb6sUtWYluLHEW7SnH6HTHtB3muVhwvPMd5099F09IWE
         ockwcvV4ii1AW4lt5kiOtrldiMWvvyYbKl6ohZkSh0Jj9weD6zLNkYhIQIb1s9HHfbFn
         hWUNDdsihYiDPQUSvEKr/MfeggpzpJFe5H7ubLVjVL+szRl1Zkz9AvwQiJ94Lt7uTSaj
         WIoTJfyC2Nor0go6Sk/bkYU4jf1MWTBXK76NDXUPPSqtN6403RiIHJTFl394YtxgRvpX
         5iTdJZj7fEPZGz6AkYIkPS87JC8R60QCz/m2rA3VrZZy48UARA8HD5CYHNfPP7e+KO51
         LZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=heX0hBrkOe5D3chyXwrxnBH4sOHFx/dh69zfKjVAQ7c=;
        b=fl3llnD7sd2IZXAfSyt/tjorny6ysDR63v64kZYg2ZBgJPpSi68+dMi9NBn2eTCkhG
         LyAmPGJ5H2FCvZtdS44GkolseOfxCQWuiYQ3icq1qmyqPuPLWKaiylosWuB59g/fzdTd
         8QDwszyg3kSi6iaMzNsmREabHWeerXvcizgEfvqiuo/rMsSdzjtHoE5Ieoac5ORdEv3W
         /qJWZDyJg/MZoLtO64HHovaKxxbLSkKtw97LV1EWD+Ly179W7+/15ieonLEhzkChXj/B
         cm3RFxnCkhzU3B9ZbkMmN7Gvd4Bgw2DLLoFnm8+bQlaKJMM2zSQNORt0rnbAn2GceA/Y
         RqbQ==
X-Gm-Message-State: APjAAAXzpyLbxko9QPeVhTIdNcRfVbSahFKZDiE6iIUoxvzX3x7WG4kH
        SFjsAJYz41BVF+rNM5/4JSs=
X-Google-Smtp-Source: APXvYqz1lKb15u2Ux2JYQWvkOkaId4NcT/S7XDuFNJUTQlOoSpvFGP8a7BZ+e6JntbMVf6gbI5jJTQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr28144822ljg.108.1582465118646;
        Sun, 23 Feb 2020 05:38:38 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id n189sm2103420lfa.14.2020.02.23.05.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 05:38:37 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 02/11] bloom: core Bloom filter implementation for changed paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
        <86tv3qqxyn.fsf@gmail.com>
        <a6c08b27-18d7-cf30-c076-3f6451a21519@gmail.com>
Date:   Sun, 23 Feb 2020 14:38:35 +0100
In-Reply-To: <a6c08b27-18d7-cf30-c076-3f6451a21519@gmail.com> (Garima Singh's
        message of "Fri, 21 Feb 2020 19:32:03 -0500")
Message-ID: <86wo8d8lus.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 2/16/2020 11:49 AM, Jakub Narebski wrote:
>>> From: Garima Singh <garima.singh@microsoft.com>
>>>
>>> Add the core Bloom filter logic for computing the paths changed between=
 a
>>> commit and its first parent. For details on what Bloom filters are and =
how they
>>> work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a=
 concise
>>> explaination of the adoption of Bloom filters as described in [2] and [=
3].
>>                                                                         =
  ^^- to add
>
> Not sure what this means. Can you please clarify.=20
>
>>> 1. We currently use 7 and 10 for the number of hashes and the size of e=
ach
>>>    entry respectively. They served as great starting values, the mathem=
atical
>>>    details behind this choice are described in [1] and [4]. The impleme=
ntation,
>>                                                                         =
       ^^- to add
>
> Not sure what this means. Can you please clarify.

I'm sorry for not being clear.  What I wanted to say that in both cases
the last line should have ended in either full stop in first case, or
comma in second case:

  "as described in [2] and [3]."

  "The implementation,"

What I wrote (trying to put the arrow below final fullstop or comma)
only works when one is using with fixed-width font.

>>> 3. The filters are sized according to the number of changes in the each=
 commit,
>>>    with minimum size of one 64 bit word.

[...]
>> The interesting corner case, which might be worth specifying explicitly,
>> is what happens in the case there are _no changes_ with respect to first
>> parent (which can happen with either commit created with `git commit
>> --allow-empty`, or merge created e.g. with `git merge --strategy=3Dours`=
).
>> Is this case represented as Bloom filter of length 0, or as a Bloom
>> filter of length  of one 64-bit word which is minimal length composed of
>> all 0's (0x0000000000000000)?
>>=20
>
> See t0095-bloom.sh: The filter for a commit with no changes is of length =
0.
> I will call it out specifically in the appropriate commit message as well=
.=20

I have realized this only later that both "no changes" and "no data"
uses filter of length 0; which works well because checking the diff if
there were no changes is cheap (both tree oids are the same).

>>> ---
>>>  Makefile              |   2 +
>>>  bloom.c               | 228 ++++++++++++++++++++++++++++++++++++++++++
>>>  bloom.h               |  56 +++++++++++
>>>  t/helper/test-bloom.c |  84 ++++++++++++++++
>>>  t/helper/test-tool.c  |   1 +
>>>  t/helper/test-tool.h  |   1 +
>>>  t/t0095-bloom.sh      | 113 +++++++++++++++++++++
>>>  7 files changed, 485 insertions(+)
>>>  create mode 100644 bloom.c
>>>  create mode 100644 bloom.h
>>>  create mode 100644 t/helper/test-bloom.c
>>>  create mode 100755 t/t0095-bloom.sh
>>=20
>> As I wrote earlier, In my opinion this patch could be split into three
>> individual single-functionality pieces, to make it easier to review and
>> aid in bisectability if needed.
>
> Doing this in v3.=20

Thanks.  Though if it makes (much) more work for you, I can work with
unsplit patch, no problem.

>>> +
>>> +static uint32_t rotate_right(uint32_t value, int32_t count)
>>> +{
>>> +	uint32_t mask =3D 8 * sizeof(uint32_t) - 1;
>>> +	count &=3D mask;
>>> +	return ((value >> count) | (value << ((-count) & mask)));
>>> +}
>>=20
>> Hmmm... both the algoritm on Wikipedia, and reference implementation use
>> rotate *left*, not rotate *right* in the implementation of Murmur3 hash,
>> see
>>=20
>>   https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>>   https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp#L=
23
>>=20
>>=20
>> inline uint32_t rotl32 ( uint32_t x, int8_t r )
>> {
>>   return (x << r) | (x >> (32 - r));
>> }
>
> Thanks! Fixed this in v3. More on it later.=20

Sidenote: If I understand it correctly Bloom filters functionality is
included in Scalar [1].  What will happen then with all those Bloom
filter chunks in commit-graph files with wrong hash functions?

[1]: https://devblogs.microsoft.com/devops/introducing-scalar/

>>> +
>>> +/*
>>> + * Calculate a hash value for the given data using the given seed.
>>> + * Produces a uniformly distributed hash value.
>>> + * Not considered to be cryptographically secure.
>>> + * Implemented as described in https://en.wikipedia.org/wiki/MurmurHas=
h#Algorithm
>>> + **/
>>     ^^-- why two _trailing_ asterisks?
>
> Oops. Fixed.=20

Often two _leading_ asterisks are used to mark commit as containing
docstring in some specific format, like Doxygen.  Two _trailing_
asterisks looks like typo.

>>> +static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
>>=20
>> In short, I think that the name of the function should be murmur3_32, or
>> murmurhash3_32, or possibly murmur3_32_seed, or something like that.
>
> Renamed it to murmur3_seeded in v3. The input and output types in the=20
> signature make it clear that it is 32-bit version.

All right, I can agree with that.

>>> +{
>>> +	const uint32_t c1 =3D 0xcc9e2d51;
>>> +	const uint32_t c2 =3D 0x1b873593;
>>> +	const uint32_t r1 =3D 15;
>>> +	const uint32_t r2 =3D 13;
>>> +	const uint32_t m =3D 5;
>>> +	const uint32_t n =3D 0xe6546b64;
>>> +	int i;
>>> +	uint32_t k1 =3D 0;
>>> +	const char *tail;
>>> +
>>> +	int len4 =3D len / sizeof(uint32_t);
>>> +
>>> +	const uint32_t *blocks =3D (const uint32_t*)data;
>>> +
>>> +	uint32_t k;
>>> +	for (i =3D 0; i < len4; i++)
>>> +	{
>>> +		k =3D blocks[i];
>>=20
>> IMPORTANT: There is a comment around there in the example implementation
>> in C on Wikipedia that this operation above is a source of differing
>> results across endianness.=20=20
>
> Thanks! SZEDER found this on his CI pipeline and we have fixed it to=20
> process the data in 1 byte words to avoid hitting any endian-ness issues.=
=20
> See this part of the thread that carries the fix and the related discussi=
on.=20
>   https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.=
com/
> I will be squashing those changes in appropriately in v3.=20=20

[...]
>>> +		k1 *=3D c2;
>>> +		seed ^=3D k1;
>>> +		break;
>>> +	}
>>> +
>>> +	seed ^=3D (uint32_t)len;
>>> +	seed ^=3D (seed >> 16);
>>> +	seed *=3D 0x85ebca6b;
>>> +	seed ^=3D (seed >> 13);
>>> +	seed *=3D 0xc2b2ae35;
>>> +	seed ^=3D (seed >> 16);
>>> +
>>> +	return seed;
>>> +}
>>=20
>> In https://public-inbox.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gma=
il.com/
>> you posted "[PATCH] Process bloom filter data as 1 byte words".
>> This may avoid the Big-endian vs Little-endian confusion,
>> that is wrong results on Big-endian architectures, but
>> it also may slow down the algorithm.
>
> Oh cool! You have seen that patch. And yes, we understand that it might a=
dd=20
> a little overhead but at this point it is more important to be correct on=
 all
> architectures instead of micro-optimizing and introducing different=20
> implementations for Little-endian and Big-endian. This would make this=20
> series overly complicated. Optimizing the hashing techniques would deserv=
e a
> series of its own, which we can definitely revisit later.

Right, "first make it work, then make it right, and, finally, make it fast.=
".

Anyway, could you maybe compare performance of Git for old version
(operating on 32-bit/4-bytes words) and new version (operating on 1-byte
words) file history operation with Bloom filters, to see if it matters
or not?

>> The public domain implementation in PMurHash.c in SMHasher
>> (re)implementation in Chromium (see URL above) fall backs to 1-byte
>> operations only if it doesn't know the endianness (or if it is neither
>> little-endian, nor big-endian, i.e. middle-endian or mixed-endian --
>> though I doubt that Git works correctly on mixed-endian anyway).
>>=20
>>=20
>> Sidenote: it looks like the current implementation if Murmur hash in
>> Chromium uses MurmurHash3_x86_32, i.e. little-endian unaligned-safe
>> implementation, but prepares data by swapping with StringToLE32
>> https://github.com/chromium/chromium/blob/master/components/variations/v=
ariations_murmur_hash.h

The solution in PMurHash.c in Chromium, and the pseudo-code algorithm on
Wikipedia do endian handling only for remaining bytes (while the
solution in Appleby's code [beginnings of], and in current
above-mentioned Chromium implementation do the conversion for all
bytes).  I think that handling it only for remaining bytes (for data
sizes not being multiply of 32-bits / 4-bytes) is enough; all other
operations, that is multiply, rotate, xor and addition do not depend on
endianness.

>> Assuming that the terminating NUL ("\0") character of a c-string is not
>> included in hash calculations, then murmur3_x86_32 hash has the
>> following results (all results are for seed equal 0):
>>=20
>> ''               -> 0x00000000
>> ' '              -> 0x7ef49b98
>> 'Hello world!'   -> 0x627b0c2c
>> 'The quick brown fox jumps over the lazy dog'   -> 0x2e4ff723
>>=20
>> C source (from Wikipedia): https://godbolt.org/z/ofa2p8
>> C++ source (Appleby's):    https://godbolt.org/z/BoSt6V
>>=20
>> The implementation provided in this patch, with rotate_right (instead of
>> rotate_left) gives, on little-endian machine, different results:
>>=20
>> ''               -> 0x00000000
>> ' '              -> 0xd1f27e64
>> 'Hello world!'   -> 0xa0791ad7
>> 'The quick brown fox jumps over the lazy dog'   -> 0x99f1676c
>>=20
>> https://github.com/gitgitgadget/git/blob/e1b076a714d611e59d3d71c89221e41=
a3427fae4/bloom.c#L21
>> C source (via GitGitGadget): https://godbolt.org/z/R9s8Tt
>>=20
>
> Thanks! This is an excellent catch! Fixing the rotate_right to rotate_lef=
t,=20
> gives us the same answers as the two implementations you pointed out. I h=
ave
> added the appropriate unit tests in v3 and they match the values you obta=
ined=20
> from the other implementations. Thanks a lot for the rigor!=20
>
> We based our implementation on the pseudo code and not on the sample code=
=20
> presented here: https://en.wikipedia.org/wiki/MurmurHash#Algorithm
> We just didn't parse the ROL instruction correctly.=20

All right, that's good.

Note that the pseudo code includes the following:

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

[...]
>>> +{
>>> +	int i;
>>> +	const uint32_t seed0 =3D 0x293ae76f;
>>> +	const uint32_t seed1 =3D 0x7e646e2c;
>>=20
>> Where did those seeds values came from?
>>
>
> Those values were chosen randomly. They will be fixed constants for the=20
> current hashing version. I will add a note calling this out in the=20
> appropriate commit messages and the Documentation in v3.=20

Nice to know.

I wonder if those seed values should be relatively prime, and whether
seed1 should be odd (from theoretical point of view).

>>> +	const uint32_t hash0 =3D seed_murmur3(seed0, data, len);
>>> +	const uint32_t hash1 =3D seed_murmur3(seed1, data, len);
>>> +
>>> +	key->hashes =3D (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint=
32_t));
>>> +	for (i =3D 0; i < settings->num_hashes; i++)
>>> +		key->hashes[i] =3D hash0 + i * hash1;
>>=20
>> Note that in [3] authors say that double hashing technique has some
>> problems.  For one, we should ensure that hash1 is not zero, and even
>> better that it is odd (which makes it relatively prime to filter size
>> which is multiple of 64).  It also suffers from something called
>> "approximate fingerprint collisions".
>>=20
>> That is why the define "enhanced double hashing" technique, which does
>> not suffer from those problems (Algorithm 2, page 11/15).
>>=20
>>   +	for (i =3D 0; i < settings->num_hashes; i++) {
>>   +		key->hashes[i] =3D hash0;
>>   +
>>   +		hash0 =3D hash0 + hash1;
>>   +		hash1 =3D hash1 + i;
>>   +	}
>>=20
>> This can also be written in closed form, based on equation (6)
>>=20
>>   +	for (i =3D 0; i < settings->num_hashes; i++)
>>   +		key->hashes[i] =3D hash0 + i * hash1 + i*(i*i - 1)/6;
>>=20
>>=20
>> In later paper [6] the closed form for "enhanced double hashing"
>> (p. 188) is slightly modified (or rather they use different variant of
>> this technique):
>>=20
>>   +	for (i =3D 0; i < settings->num_hashes; i++)
>>   +		key->hashes[i] =3D hash0 + i * hash1 + i*i;
>>=20
>> This is a variant of more generic "enhanced double hashing", section
>> 5.2 (Enhanced) Double Hashing Schemes (page 199):
>>=20
>>         h_1(u) + i h_2(u) + f(i)    mod m
>>=20
>> with f(i) =3D i^2 =3D i*i.
>>=20
>> They have tested that enhanced double hashing with both f(i) equal i*i
>> and equal i*i*i, and triple hashing technique, and they have found that
>> it performs slightly better than straight double hashing technique
>> (Fig. 1, page 212, section 3).
>>=20
>
> Thanks for the detailed research here! The hash becoming zero and the=20
> approximate fingerprint collision are both extremely rare situations. In =
both
> cases, we would just see `git log` having to diff more trees than if it d=
idn't=20
> occur. While these techniques would be great optimizations to do, especia=
lly
> if this implementation gets pulled into more generic hashing applications
> in the code, we think that for the purposes of the current series - it is=
 not=20
> worth it. I say this because Azure Repos has been using this exact hashin=
g=20
> technique for several years now without any glitches. And we think it wou=
ld
> be great to rely on this battle tested strategy in at least the first ver=
sion
> of this feature.=20

All right, that is a good strategy.

I wonder if switching from double hashing to enhanced double hashing
(for example the variant with i*i added) would bring any noticeable
performance improvements in Git operations (due to less false
positives).

>>> +
>>> +struct bloom_filter *get_bloom_filter(struct repository *r,
>>> +				      struct commit *c)
>>> +{
>>> +	struct bloom_filter *filter;
>>> +	struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTIN=
GS;
>>> +	int i;
>>> +	struct diff_options diffopt;
>>> +
>>> +	if (!bloom_filters.slab_size)
>>> +		return NULL;
>>=20
>> This is testing that commit slab for per-commit Bloom filters is
>> initialized, isn't it?
>>=20
>> First, should we write the condition as
>>=20
>> 	if (!bloom_filters.slab_size)
>>=20
>> or would the following be more readable
>>=20
>> 	if (bloom_filters.slab_size =3D=3D 0)
>>=20
>
> Sure. Switched to `if (bloom_filter.slab_size =3D=3D 0)` in v3.=20

Though either works, and the former looks more like the test if
bloom_filters slab are initialized, now that I thought about it a bit.
Your choice.

>> Second, should we return NULL, or should we just initialize the slab?
>> Or is non-existence of slab treated as a signal that the Bloom filters
>> mechanism is turned off?
>>=20
>
> Yes. We purposefully choose to return NULL and ignore the mechanism=20
> overall because we use Bloom filters best effort only.=20

All right.

>>> +
>>> +	if (diff_queued_diff.nr <=3D 512) {
>>
>> Second, there is a minor issue that diff_queue_struct.nr stores the
>> number of filepairs, that is the number of changed files, while the
>> number of elements added to Bloom filter is number of changed blobs and
>> trees.  For example if the following files are changed:
>>=20
>>   sub/dir/file1
>>   sub/file2
>>=20
>> then diff_queued_diff.nr is 2, but number of elements to be added to
>> Bloom filter is 4.
>>=20
>>   sub/dir/file1
>>   sub/file2
>>   sub/dir/
>>   sub/
>>=20
>> I'm not sure if it matters in practice.
>>=20
>
> It does not matter much in practice, since the directories usually tend
> to collapse across the changes. Still, I will add another limit after=20
> creating the hashmap entries to cap at 640 so that we have a maximum of=20
> 100 changes in the bloom filter.=20
>
> We plan to make these values configurable later.=20

I'm not sure if it is truly necessary; we can treat limit on number of
changed paths as "best effort" limit on Bloom filter size.

I just wanted to point out the difference.


Side note: I wonder if it would be worth it (in the future) to change
handling commits with large amount of changes.  I was thinking about
switching to soft and hard limit: soft limit would be on the size of the
Bloom filter, that is if number of elements times bits per element is
greater that size threshold, we don't increase the size of the filter.

This would mean that the false positives ratio (the number of files that
are not present but get answer "maybe" instead of "no" out of the
filter) would increase, so there would be a need for another hard limit
where we decide that it is not worth it, and not store the data for the
Bloom filter -- current "no data" case with empty filter with length 0.
This hard limit can be imposed on number of changed files, or on number
of paths added to filter, or on number of bits set to 1 in the filter
(on popcount), or some combination thereof.

[...]
>>> +
>>> +		for (i =3D 0; i < diff_queued_diff.nr; i++) {
>>> +			const char* path =3D diff_queued_diff.queue[i]->two->path;
>>=20
>> Is that correct that we consider only post-image name for storing
>> changes in Bloom filter?  Currently if file was renamed (or deleted), it
>> is considered changed, and `git log -- <old-name>` lists commit that
>> changed file name too.
>
> The tests in t4216-log-bloom.sh ensure that the output of `git log -- <ol=
dname>`=20
> remains unchanged for renamed and deleted files, when using bloom filters=
.=20
> I realize that I fat fingered over checking the old name, and didn't have=
 an=20
> explicit deleted file in the test. I have added them in v3, and the tests=
 pass.=20
> So the behavior is preserved and as expected when using Bloom filters.=20
> Thanks for paying close attention!=20

It seems like it shouldn't be working, as we are not adding the old name
to Bloom filter, but that only means that I misunderstood how
diff_tree_oid() works with default options.  It turns out that without
explicitly turning on rename detection it shows rename as deletion of
old name and addition of new name -- so if tracking deletion works
correctly, then tracking renames should work correctly.

So it is in fact correct, which as you said was confirmed by (improved)
tests.  I think also that if there was a bug in handling renames in this
code it would have been detected when running CI with
GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS.

[...]
>>> +		filter->data =3D NULL;
>>> +		filter->len =3D 0;
>>=20
>> This needs to be explicitly stated both in the commit message and in the
>> API documentation (in comments) that bloom_filter.len =3D=3D 0 means "no
>> data", while "no changes" is represented as bloom_filter with len =3D=3D=
 1
>> and *data =3D=3D (uint64_t)0;
>>=20
>> EDIT: actually "no changes" is also represented as bloom_filter with len
>> equal 0, as it turns out.
>>=20
>> One possible alternative could be representing "no data" value with
>> Bloom filter of length 1 and all 64 bits set to 1, and "no changes"
>> represented as filter of length 0.  This is not unambiguous choice!
>>
>
> There is no gain in distinguishing between the absence of a filter and
> a commit having no changes. The effect on `git log -- path` is the same i=
n=20
> both cases. We fall back to the normal diffing algorithm in revision.c.
> I will make this clearer in the appropriate commit messages and in the=20
> Documentation in v3.=20

You are right, which I have realized only when reviewing subsequent
patches in the series.

In the absence of a filter, the "no data" case, we need to fall back to
examining the diff anyway.

In the case of commit having no changes, the "no changes" case,
computing the diff is cheap because Git can realize that both trees have
the same oid.  So we do not lose performance this way, and we avoid
special-casing it (avoiding branching) when computing the Bloom filter,
if the "no change" case was represented by filter of length 1 and all
zero bits as data.  Comparing tree oids and matching first hash function
in bloom_key against all zeros Bloom filter should be, I think, of
similar performance.

[...]
>>> +. ./test-lib.sh
>>> +
>>> +test_expect_success 'get bloom filters for commit with no changes' '
>>> +	git init &&
>>> +	git commit --allow-empty -m "c0" &&
>>> +	cat >expect <<-\EOF &&
>>> +	Filter_Length:0
>>> +	Filter_Data:
>>> +	EOF
>>> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual=
 &&
>>> +	test_cmp expect actual
>>> +'
>>=20
>> A few things.  First, I wonder why we need to provide object ID;
>> couldn't 'test-tool bloom get_filter_for_commit' parse commit-ish
>> argument, or would it make it too complicated for no reason?=20
>
> Yes it was overkill for what I need in the test.=20

All right, I agree with that.

>>> +
>>> +test_expect_success 'get bloom filter for commit with 10 changes' '
>>> +	rm actual &&
>>> +	rm expect &&
>>> +	mkdir smallDir &&
>>> +	for i in $(test_seq 0 9)
>>> +	do
>>> +		echo $i >smallDir/$i
>>> +	done &&
>>> +	git add smallDir &&
>>> +	git commit -m "commit with 10 changes" &&
>>> +	cat >expect <<-\EOF &&
>>> +	Filter_Length:4
>>> +	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab31=
0098051a8|
>>> +	EOF
>>> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual=
 &&
>>> +	test_cmp expect actual
>>> +'
>>=20
>> This test is in my opinion fragile, as it unnecessarily test the
>> implementation details instead of the functionality provided.  If we
>> change the hashing scheme (for example going from double hashing to some
>> variant of enhanced double hashing), or change the base hash function
>> (for example from Murmur3_32 to xxHash_64), or change the number of hash
>> functions (perhaps because changing of number of bits per element, and
>> thus optimal number of hash functions from 7 to 6), or change from
>> 64-bit word blocks to 32-bit word blocks, the test would have to be
>> changed.
>
> Regarding this and the rest of you comments on t0095-log-bloom.sh:
>
> I am tweaking it as necessary but the entire point of these tests is to
> break for the things you called out. They need to be intricately tied
> to the current hashing strategy and are hence intended to be fragile so=20
> as to catch any subtle or accidental changes in the hashing computation.=
=20
> Any change like the ones you have called out would require a hash version
> change and all the compatibility reactions that come with it.=20

All right, if we assume that commit-graph is not something purely local^*,
and we need iteroperability, then this test is necessary and is
necessarily fragile.

*. This may happen because the repository and the commit-graph file in
   it is on network disk, and accessed by hosts with different
   endianness.  Or in the future (or possibly now, if one is using
   Scalar) the commit-graph file can be sent together with packfile
   during the fetch operation.

On the other hand testing the functionality of Murmur hash, and of Bloom
filter would help finding possible troubles if we decide in the future
to change the algorithm details (change hash function, and/or move from
double hashing to enhanced double hashing, and/or change how commits
with large number of changes are handled, or even switching to xor
filters [1]).

[1]: Graf, Thomas Mueller; Lemire, Daniel (2019), "Xor Filters: Faster
and Smaller Than Bloom and Cuckoo Filters", https://arxiv.org/abs/1912.08258

> I have added more tests around the murmur3_seeded method in v3. Removed
> some of the redundant ones.=20

There is another test that might be worth adding (see the comment below
why), namely one test checking that bloom_key is computed as expected.

> The other more evolved test cases you call out are covered in the e2e
> integration tests in t4216-log-bloom.sh

All right, but there is another issue to consider.  Good tests should
not only catch the breakage, but also help to detect where the bug is.
That is one of advantages that unit tests (like the ones I have
proposed) have over end-to-end functional tests.  They are also often
faster.

On the other hand e2e tests can catch problems with integration, and
actually check that the user-visible behaviour is as expected.


Best,
--
Jakub Nar=C4=99bski

>>=20
>> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>>=20
>> Thanks for working on this.
>>=20
>> Best,=20
>
> Thank you once again for an excellent and in-depth review of this patch!=
=20
> You have helped make this code so much better!
