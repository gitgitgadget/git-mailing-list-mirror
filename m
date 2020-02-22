Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E67C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70362071E
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRbi0Y5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBVAcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:32:06 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43172 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBVAcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 19:32:06 -0500
Received: by mail-yw1-f66.google.com with SMTP id f204so2030097ywc.10
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 16:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FhP3uXShZhxihsCpAhxSbwyR+xgvBDDQu8OZXOtJ7k0=;
        b=TRbi0Y5cFSWu9xVFrBOILbEYsudB9PCR/hAsOtBkLNtz81GdyoJ7aj5gJMtNq475wc
         QtYytxX5rQ3KHSLpdeG2tR2b5xhhbTMiYaChXpo8DSYatrQMzk7s7rd0a83hBHzCTcI0
         yZ86cp0RqGEcXkgcqTEPpJlkNRhJkCAfInP26APHp90QUjYMhIwdos0GuKaDh/oNwgNT
         bOO9ZnVyEcOJZn/2H18gA8v3U+8J5dhhv5UUSoEJB1h0oQA+JlFXmtUvaFlocAOekNpZ
         L+6Cse8YSMdRvzxkeAX6yUtsIKKLKvGIS2QdLhWvpdP1H01gg6OZQpDsSLU+Yx/6/6Wy
         1opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhP3uXShZhxihsCpAhxSbwyR+xgvBDDQu8OZXOtJ7k0=;
        b=P7jRlwItSG5ty4UYvVHgtyFeSAET2sn4cglOFuI1LoPHBv93YEt6pmkx3eklwpd0Ph
         cE1K9zvwJmWqPu1JE4xsf6cwCGuMKumEXjTCFlJVIDwf9NN5iuiTEb7QFQjsfCCMK63A
         gr/ru2cNvqttnPsB1UG2q1eywiE4feriVmJTF3BUeOETTpeQQsW8b5I1hvUglo8Ci4rL
         /wyhrXQFqp1tvrXSMewFybJPJXymkSbYaAgLvKLDlLsI1ck1BrpjxtAL3tNIQ8mPneZ/
         QfQ2uh47cCNqjgqalWVNrcBeFtnqUtM7f56wYmkpvBQKWE+xzJ6olK7HX0eFFmAWS/Lt
         /zXw==
X-Gm-Message-State: APjAAAU6L+vCO9UkNryBRgpxalMU1F5y86E41EmbN4RQUL2nUFc5qXk0
        MNiSbgSWxIfxHIXjUzUzzhk=
X-Google-Smtp-Source: APXvYqyY1C8VGD9lQyzciW3CWeLFH7wotKZXcBuBWdFtum/1+9k0Vy2sy/UnohcJl/0HHhcH1UR5EQ==
X-Received: by 2002:a25:c6d5:: with SMTP id k204mr34419150ybf.51.1582331524374;
        Fri, 21 Feb 2020 16:32:04 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:25f3:c564:ed3b:ab96? ([2600:1700:b00:7980:25f3:c564:ed3b:ab96])
        by smtp.gmail.com with ESMTPSA id i84sm2036115ywc.43.2020.02.21.16.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:32:03 -0800 (PST)
Subject: Re: [PATCH v2 02/11] bloom: core Bloom filter implementation for
 changed paths
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
 <86tv3qqxyn.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <a6c08b27-18d7-cf30-c076-3f6451a21519@gmail.com>
Date:   Fri, 21 Feb 2020 19:32:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86tv3qqxyn.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/16/2020 11:49 AM, Jakub Narebski wrote:
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Add the core Bloom filter logic for computing the paths changed between a
>> commit and its first parent. For details on what Bloom filters are and how they
>> work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a concise
>> explaination of the adoption of Bloom filters as described in [2] and [3].
>                                                                            ^^- to add

Not sure what this means. Can you please clarify. 

>> 1. We currently use 7 and 10 for the number of hashes and the size of each
>>    entry respectively. They served as great starting values, the mathematical
>>    details behind this choice are described in [1] and [4]. The implementation,
>                                                                                 ^^- to add

Not sure what this means. Can you please clarify.

>> 3. The filters are sized according to the number of changes in the each commit,
>>    with minimum size of one 64 bit word.
> 
> If I understand it correctly (but which might not be entirely clear),
> the filter size in bits is the number of changes^* times 10, rounded up
> to the nearest multiple of 64.
> 
> [*] where the number of changes is the number of changed files (new blob
> objects) _and_ the number of changed directories (new tree objects,
> excluding root tree object change).
> 

Yes. 

> The interesting corner case, which might be worth specifying explicitly,
> is what happens in the case there are _no changes_ with respect to first
> parent (which can happen with either commit created with `git commit
> --allow-empty`, or merge created e.g. with `git merge --strategy=ours`).
> Is this case represented as Bloom filter of length 0, or as a Bloom
> filter of length  of one 64-bit word which is minimal length composed of
> all 0's (0x0000000000000000)?
> 

See t0095-bloom.sh: The filter for a commit with no changes is of length 0.
I will call it out specifically in the appropriate commit message as well. 

>>
>> [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/
> 
> I would write it in full, similar to subsequent bibliographical entries,
> that is:
> 
>   [1] Derrick Stolee
>       "Supercharging the Git Commit Graph IV: Bloom Filters"
>       https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/
> 
> But that is just a matter of style.
> 

Sounds good. Will do. 

>>
>> [4] Thomas Mueller Graf, Daniel Lemire
>>     "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
>>     https://arxiv.org/abs/1912.08258
>>
>> [5] https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  Makefile              |   2 +
>>  bloom.c               | 228 ++++++++++++++++++++++++++++++++++++++++++
>>  bloom.h               |  56 +++++++++++
>>  t/helper/test-bloom.c |  84 ++++++++++++++++
>>  t/helper/test-tool.c  |   1 +
>>  t/helper/test-tool.h  |   1 +
>>  t/t0095-bloom.sh      | 113 +++++++++++++++++++++
>>  7 files changed, 485 insertions(+)
>>  create mode 100644 bloom.c
>>  create mode 100644 bloom.h
>>  create mode 100644 t/helper/test-bloom.c
>>  create mode 100755 t/t0095-bloom.sh
> 
> As I wrote earlier, In my opinion this patch could be split into three
> individual single-functionality pieces, to make it easier to review and
> aid in bisectability if needed.
> 

Doing this in v3. 


>> +
>> +static uint32_t rotate_right(uint32_t value, int32_t count)
>> +{
>> +	uint32_t mask = 8 * sizeof(uint32_t) - 1;
>> +	count &= mask;
>> +	return ((value >> count) | (value << ((-count) & mask)));
>> +}
> 
> Hmmm... both the algoritm on Wikipedia, and reference implementation use
> rotate *left*, not rotate *right* in the implementation of Murmur3 hash,
> see
> 
>   https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>   https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp#L23
> 
> 
> inline uint32_t rotl32 ( uint32_t x, int8_t r )
> {
>   return (x << r) | (x >> (32 - r));
> }
> 

Thanks! Fixed this in v3. More on it later. 

>> +
>> +/*
>> + * Calculate a hash value for the given data using the given seed.
>> + * Produces a uniformly distributed hash value.
>> + * Not considered to be cryptographically secure.
>> + * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>> + **/
>     ^^-- why two _trailing_ asterisks?
> 

Oops. Fixed. 

>> +static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
> 
> In short, I think that the name of the function should be murmur3_32, or
> murmurhash3_32, or possibly murmur3_32_seed, or something like that.
>

Renamed it to murmur3_seeded in v3. The input and output types in the 
signature make it clear that it is 32-bit version.
 
>> +{
>> +	const uint32_t c1 = 0xcc9e2d51;
>> +	const uint32_t c2 = 0x1b873593;
>> +	const uint32_t r1 = 15;
>> +	const uint32_t r2 = 13;
>> +	const uint32_t m = 5;
>> +	const uint32_t n = 0xe6546b64;
>> +	int i;
>> +	uint32_t k1 = 0;
>> +	const char *tail;
>> +
>> +	int len4 = len / sizeof(uint32_t);
>> +
>> +	const uint32_t *blocks = (const uint32_t*)data;
>> +
>> +	uint32_t k;
>> +	for (i = 0; i < len4; i++)
>> +	{
>> +		k = blocks[i];
> 
> IMPORTANT: There is a comment around there in the example implementation
> in C on Wikipedia that this operation above is a source of differing
> results across endianness.  

Thanks! SZEDER found this on his CI pipeline and we have fixed it to 
process the data in 1 byte words to avoid hitting any endian-ness issues. 
See this part of the thread that carries the fix and the related discussion. 
  https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/
I will be squashing those changes in appropriately in v3.  
 
>> +		k1 *= c2;
>> +		seed ^= k1;
>> +		break;
>> +	}
>> +
>> +	seed ^= (uint32_t)len;
>> +	seed ^= (seed >> 16);
>> +	seed *= 0x85ebca6b;
>> +	seed ^= (seed >> 13);
>> +	seed *= 0xc2b2ae35;
>> +	seed ^= (seed >> 16);
>> +
>> +	return seed;
>> +}
> 
> In https://public-inbox.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/
> you posted "[PATCH] Process bloom filter data as 1 byte words".
> This may avoid the Big-endian vs Little-endian confusion,
> that is wrong results on Big-endian architectures, but
> it also may slow down the algorithm.
> 

Oh cool! You have seen that patch. And yes, we understand that it might add 
a little overhead but at this point it is more important to be correct on all
architectures instead of micro-optimizing and introducing different 
implementations for Little-endian and Big-endian. This would make this 
series overly complicated. Optimizing the hashing techniques would deserve a
series of its own, which we can definitely revisit later.

> The public domain implementation in PMurHash.c in SMHasher
> (re)implementation in Chromium (see URL above) fall backs to 1-byte
> operations only if it doesn't know the endianness (or if it is neither
> little-endian, nor big-endian, i.e. middle-endian or mixed-endian --
> though I doubt that Git works correctly on mixed-endian anyway).
> 
> 
> Sidenote: it looks like the current implementation if Murmur hash in
> Cromium uses MurmurHash3_x86_32, i.e. little-endian unaligned-safe
> implementation, but prepares data by swapping with StringToLE32
> https://github.com/chromium/chromium/blob/master/components/variations/variations_murmur_hash.h
> 
> 
> Assuming that the terminating NUL ("\0") character of a c-string is not
> included in hash calculations, then murmur3_x86_32 hash has the
> following results (all results are for seed equal 0):
> 
> ''               -> 0x00000000
> ' '              -> 0x7ef49b98
> 'Hello world!'   -> 0x627b0c2c
> 'The quick brown fox jumps over the lazy dog'   -> 0x2e4ff723
> 
> C source (from Wikipedia): https://godbolt.org/z/ofa2p8
> C++ source (Appleby's):    https://godbolt.org/z/BoSt6V
> 
> The implementation provided in this patch, with rotate_right (instead of
> rotate_left) gives, on little-endian machine, different results:
> 
> ''               -> 0x00000000
> ' '              -> 0xd1f27e64
> 'Hello world!'   -> 0xa0791ad7
> 'The quick brown fox jumps over the lazy dog'   -> 0x99f1676c
> 
> https://github.com/gitgitgadget/git/blob/e1b076a714d611e59d3d71c89221e41a3427fae4/bloom.c#L21
> C source (via GitGitGadget): https://godbolt.org/z/R9s8Tt
> 

Thanks! This is an excellent catch! Fixing the rotate_right to rotate_left, 
gives us the same answers as the two implementations you pointed out. I have
added the appropriate unit tests in v3 and they match the values you obtained 
from the other implementations. Thanks a lot for the rigor! 

We based our implementation on the pseudo code and not on the sample code 
presented here: https://en.wikipedia.org/wiki/MurmurHash#Algorithm
We just didn't parse the ROL instruction correctly. 

>> +
>> +void load_bloom_filters(void)
>> +{
>> +	init_bloom_filter_slab(&bloom_filters);
>> +}
> 
> 
> Actually this function doesn't load anything.  Perhaps it should be
> named init_bloom_filters() or init_bloom_filters_storage(), or
> bloom_filters_init()?
>

Changed to init_bloom_filters() in v3. Thanks! 
 
>> +
>> +void fill_bloom_key(const char *data,
>> +					int len,
>> +					struct bloom_key *key,
>> +					struct bloom_filter_settings *settings)
> 
> The last parameter could be of 'const bloom_filter_settings *' type.
> 

Done. 

>> +{
>> +	int i;
>> +	const uint32_t seed0 = 0x293ae76f;
>> +	const uint32_t seed1 = 0x7e646e2c;
> 
> Where did those seeds values came from?
> 

Those values were chosen randomly. They will be fixed constants for the 
current hashing version. I will add a note calling this out in the 
appropriate commit messages and the Documentation in v3. 

>> +	const uint32_t hash0 = seed_murmur3(seed0, data, len);
>> +	const uint32_t hash1 = seed_murmur3(seed1, data, len);
>> +
>> +	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
>> +	for (i = 0; i < settings->num_hashes; i++)
>> +		key->hashes[i] = hash0 + i * hash1;
> 
> Note that in [3] authors say that double hashing technique has some
> problems.  For one, we should ensure that hash1 is not zero, and even
> better that it is odd (which makes it relatively prime to filter size
> which is multiple of 64).  It also suffers from something called
> "approximate fingerprint collisions".
> 
> That is why the define "enhanced double hashing" technique, which does
> not suffer from those problems (Algorithm 2, page 11/15).
> 
>   +	for (i = 0; i < settings->num_hashes; i++) {
>   +		key->hashes[i] = hash0;
>   +
>   +		hash0 = hash0 + hash1;
>   +		hash1 = hash1 + i;
>   +	}
> 
> This can also be written in closed form, based on equation (6)
> 
>   +	for (i = 0; i < settings->num_hashes; i++)
>   +		key->hashes[i] = hash0 + i * hash1 + i*(i*i - 1)/6;
> 
> 
> In later paper [6] the closed form for "enhanced double hashing"
> (p. 188) is slightly modified (or rather they use different variant of
> this technique):
> 
>   +	for (i = 0; i < settings->num_hashes; i++)
>   +		key->hashes[i] = hash0 + i * hash1 + i*i;
> 
> This is a variant of more generic "enhanced double hashing", section
> 5.2 (Enhanced) Double Hashing Schemes (page 199):
> 
>         h_1(u) + i h_2(u) + f(i)    mod m
> 
> with f(i) = i^2 = i*i.
> 
> They have tested that enhanced double hashing with both f(i) equal i*i
> and equal i*i*i, and triple hashing technique, and they have found that
> it performs slightly better than straight double hashing technique
> (Fig. 1, page 212, section 3).
> 

Thanks for the detailed research here! The hash becoming zero and the 
approximate fingerprint collision are both extremely rare situations. In both
cases, we would just see git log having to diff more trees than if it didn't 
occur. While these techniques would be great optimizations to do, especially
if this implementation gets pulled into more generic hashing applications
in the code, we think that for the purposes of the current series - it is not 
worth it. I say this because Azure Repos has been using this exact hashing 
technique for several years now without any glitches. And we think it would
be great to rely on this battle tested strategy in atleast the first version
of this feature. 

>> +}
>> +
>> +void add_key_to_filter(struct bloom_key *key,
>> +					   struct bloom_filter *filter,
>> +					   struct bloom_filter_settings *settings)
> 
> Here again the 'settings' argument can be const (as can the 'key'
> parameter).
> 

Done. 

>> +
>> +struct bloom_filter *get_bloom_filter(struct repository *r,
>> +				      struct commit *c)
>> +{
>> +	struct bloom_filter *filter;
>> +	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>> +	int i;
>> +	struct diff_options diffopt;
>> +
>> +	if (!bloom_filters.slab_size)
>> +		return NULL;
> 
> This is testing that commit slab for per-commit Bloom filters is
> initialized, isn't it?
> 
> First, should we write the condition as
> 
> 	if (!bloom_filters.slab_size)
> 
> or would the following be more readable
> 
> 	if (bloom_filters.slab_size == 0)
> 

Sure. Switched to `if (bloom_filter.slab_size == 0)` in v3. 

> Second, should we return NULL, or should we just initialize the slab?
> Or is non-existence of slab treated as a signal that the Bloom filters
> mechanism is turned off?
> 

Yes. We purposefully choose to return NULL and ignore the mechanism 
overall because we use Bloom filters best effort only. 

>> +
>> +	if (diff_queued_diff.nr <= 512) {
>
> Second, there is a minor issue that diff_queue_struct.nr stores the
> number of filepairs, that is the number of changed files, while the
> number of elements added to Bloom filter is number of changed blobs and
> trees.  For example if the following files are changed:
> 
>   sub/dir/file1
>   sub/file2
> 
> then diff_queued_diff.nr is 2, but number of elements to be added to
> Bloom filter is 4.
> 
>   sub/dir/file1
>   sub/file2
>   sub/dir/
>   sub/
> 
> I'm not sure if it matters in practice.
> 

It does not matter much in practice, since the directories usually tend
to collapse across the changes. Still, I will add another limit after 
creating the hashmap entries to cap at 640 so that we have a maximum of 
100 changes in the bloom filter. 

We plan to make these values configurable later. 

>> +		struct hashmap pathmap;
>> +		struct pathmap_hash_entry* e;
>> +		struct hashmap_iter iter;
>> +		hashmap_init(&pathmap, NULL, NULL, 0);
> 
> Stylistic issue: I have just noticed that here (and in some other
> places), but not in all cases, you declare pointer types with asterisk
> cuddled to type name, not to variable name, which contradicts
> CodingGuidelines

Thanks for noticing that! Fixed all of these in v3. 

>> +
>> +		for (i = 0; i < diff_queued_diff.nr; i++) {
>> +			const char* path = diff_queued_diff.queue[i]->two->path;
> 
> Is that correct that we consider only post-image name for storing
> changes in Bloom filter?  Currently if file was renamed (or deleted), it
> is considered changed, and `git log -- <old-name>` lists commit that
> changed file name too.
>

The tests in t4216-log-bloom.sh ensure that the output of `git log -- <oldname>` 
remains unchanged for renamed and deleted files, when using bloom filters. 
I realize that I fat fingered over checking the old name, and didn't have an 
explicit deleted file in the test. I have added them in v3, and the tests pass. 
So the behavior is preserved and as expected when using Bloom filters. 
Thanks for paying close attention! 
 
>> +			const char* p = path;
> 
> It should be "const char *" for both.
> 
>> +
>> +			/*
>> +			* Add each leading directory of the changed file, i.e. for
>> +			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
>> +			* the Bloom filter could be used to speed up commands like
>> +			* 'git log dir/subdir', too.
>> +			*
>> +			* Note that directories are added without the trailing '/'.
>> +			*/
>> +			do {
>> +				char* last_slash = strrchr(p, '/');
>> +
>> +				FLEX_ALLOC_STR(e, path, path);
> 
> Here first 'path' is the field name, i.e. pathmap_hash_entry.path,
> second 'path' is the name of local variable, aliased also to 'p'.
> 
>> +				hashmap_entry_init(&e->entry, strhash(p));
> 
> I don't know why both 'path' and 'p' are used, while both point to the
> same memory (and thus have the same contents).  It is a bit confusing.
> See also my previous comment.
> 

Cleaned up in v3. Thanks! 
>> +		filter->data = NULL;
>> +		filter->len = 0;
> 
> This needs to be explicitly stated both in the commit message and in the
> API documentation (in comments) that bloom_filter.len == 0 means "no
> data", while "no changes" is represented as bloom_filter with len == 1
> and *data == (uint64_t)0;
> 
> EDIT: actually "no changes" is also represented as bloom_filter with len
> equal 0, as it turns out.
> 
> One possible alternative could be representing "no data" value with
> Bloom filter of length 1 and all 64 bits set to 1, and "no changes"
> represented as filter of length 0.  This is not unambiguous choice!
>

There is no gain in distinguishing between the absence of a filter and
a commit having no changes. The effect on `git log -- path` is the same in 
both cases. We fall back to the normal diffing algorithm in revision.c.
I will make this clearer in the appropriate commit messages and in the 
Documentation in v3. 
 
>> +}
>> diff --git a/bloom.h b/bloom.h
>> new file mode 100644
>> index 0000000000..7f40c751f7
>> --- /dev/null
>> +++ b/bloom.h
>> @@ -0,0 +1,56 @@
>> +#ifndef BLOOM_H
>> +#define BLOOM_H
> 
> Should we #include the stdint.h header for uint32_t and uint64_t types?
> 

git-compat-util.h takes care of this. 

>> +
>> +struct commit;
>> +struct repository;
>> +struct commit_graph;
>> +
> 
> Perhaps we should add block comment for this struct, like there is one
> for struct bloom_filter below.
> 

Done in v3.

>> +struct bloom_filter_settings {
>> +	uint32_t hash_version;
>> +	uint32_t num_hashes;
>> +	uint32_t bits_per_entry;
> 
> I guess that the type uint32_t was chosen to make it easier to store
> this information and later retrieve it from the commit-graph file, isn't
> it?  Otherwise those types are much too large for sensible range of
> values (which would all fit in 8-bits byte).
> 

Yes.

>> +
>> +/*
>> + * A bloom_key represents the k hash values for a
>> + * given hash input. These can be precomputed and
>> + * stored in a bloom_key for re-use when testing
>> + * against a bloom_filter.
> 
> We might want to add that the number of hash values is given by Bloom
> filter settings, and it is assumed to be the same for all bloom_key
> variables / objects.
> 

Incorporated in v3. 

>> +. ./test-lib.sh
>> +
>> +test_expect_success 'get bloom filters for commit with no changes' '
>> +	git init &&
>> +	git commit --allow-empty -m "c0" &&
>> +	cat >expect <<-\EOF &&
>> +	Filter_Length:0
>> +	Filter_Data:
>> +	EOF
>> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
>> +	test_cmp expect actual
>> +'
> 
> A few things.  First, I wonder why we need to provide object ID;
> couldn't 'test-tool bloom get_filter_for_commit' parse commit-ish
> argument, or would it make it too complicated for no reason?
> 

Yes it was overkill for what I need in the test. 

>> +
>> +test_expect_success 'get bloom filter for commit with 10 changes' '
>> +	rm actual &&
>> +	rm expect &&
>> +	mkdir smallDir &&
>> +	for i in $(test_seq 0 9)
>> +	do
>> +		echo $i >smallDir/$i
>> +	done &&
>> +	git add smallDir &&
>> +	git commit -m "commit with 10 changes" &&
>> +	cat >expect <<-\EOF &&
>> +	Filter_Length:4
>> +	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|
>> +	EOF
>> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
>> +	test_cmp expect actual
>> +'
> 
> This test is in my opinion fragile, as it unnecessarily test the
> implementation details instead of the functionality provided.  If we
> change the hashing scheme (for example going from double hashing to some
> variant of enhanced double hashing), or change the base hash function
> (for example from Murmur3_32 to xxHash_64), or change the number of hash
> functions (perhaps because changing of number of bits per element, and
> thus optimal number of hash functions from 7 to 6), or change from
> 64-bit word blocks to 32-bit word blocks, the test would have to be
> changed.
> 

Regarding this and the rest of you comments on t0095-log-bloom.sh:

I am tweaking it as necessary but the entire point of these tests is to
break for the things you called out. They need to be intricately tied
to the current hashing strategy and are hence intended to be fragile so 
as to catch any subtle or accidental changes in the hashing computation. 
Any change like the ones you have called out would require a hash version
change and all the compatibility reactions that come with it. 

I have added more tests around the murmur3_seeded method in v3. Removed
some of the redundant ones. 

The other more evolved test cases you call out are covered in the e2e
integration tests in t4216-log-bloom.sh

> 
> Reviewed-by: Jakub Narębski <jnareb@gmail.com>
> 
> Thanks for working on this.
> 
> Best,
> 

Thank you once again for an excellent and in-depth review of this patch! 
You have helped make this code so much better!

Cheers! 
Garima Singh
