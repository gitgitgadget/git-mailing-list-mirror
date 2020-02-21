Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402FFC35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADB2222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSSFt/sJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBURl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:41:28 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39504 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBURl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 12:41:27 -0500
Received: by mail-oi1-f182.google.com with SMTP id z2so2369133oih.6
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMhWowbfWNO6GF3kTveex99KwDfIhVqyDCyXL0sXr+A=;
        b=FSSFt/sJhO7iGUp492aFRJiqTvo5g2cr28r65xmvTcpGKa+sTqWWsIHIiLSYJM2Jb3
         3/87ulcjuBvBafwO560co6KqPuZHLeGR7neLEv97QYG8weh4ZvAQXoFqr2ZmmVGnaiib
         Fswbct2BZaYyH16M/kSz8SvO6Boo/pGfl8BSc6GUf4syRBBYTcnSMblAarrQJOVx/BKj
         mtURdbvz0wB6+fbAefEdZi0QfLa2kQHn0Ev+SsFF736IZ+4CUp0rScjT+o/sSZ1br8o7
         o/d48JFdleMWbZO04ScSB9lrxiqmGLvmf3A0kwamUw1mvxiYLM7mgpTBW5rAq9qGad84
         Yk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMhWowbfWNO6GF3kTveex99KwDfIhVqyDCyXL0sXr+A=;
        b=X8Uuq7KKZQ3pnNdIf0VNILNu0a5EeTAogEgN3/jsvRg3BsMfe+IYVBPFXtfi8mzdbL
         7kHIVaFfr1Xd6gxMg8OLBPK8ZgDH95mBU8HinR4VQ8IJCSVCrummf/QiLJOW1Zl5lJNV
         zqw+s137BFZjJyUuQXWiLhL9nKDP8X7ow3oZQN3uGdGQEJCzkQYWj2gHduhXHx8vO/d8
         dALYJzSBZEsRpLTlfu/xxfYdSGagnKyIR6f4rCqHjz+IvN3TwmkLm+bBTvsu7YSwMbSy
         XP58geXKzQcg7oEUO1W5hDYkrwQDoBqPM5/Kq0YLgtBSQ9END76GzxphXgeHtethwiIo
         GoHw==
X-Gm-Message-State: APjAAAVAqeX3YorrZLjuFt55GisxlaDXKPTDPglMOaiW1hDNKw6fZUsr
        8bxoDKFw+6zBufs8SY9T7Xg=
X-Google-Smtp-Source: APXvYqwRBGBmcL0PgJOBtmcihYlI/brO9Urg0QdjMGGxVynbrjL7L8I1G3ZpdAP3KyCu2QZKo67AtA==
X-Received: by 2002:aca:cf07:: with SMTP id f7mr2931669oig.5.1582306884863;
        Fri, 21 Feb 2020 09:41:24 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:4883:85f3:7819:d905? ([2600:1700:b00:7980:4883:85f3:7819:d905])
        by smtp.gmail.com with ESMTPSA id l75sm705505oig.2.2020.02.21.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:41:24 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
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
 <86a75swuie.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com>
Date:   Fri, 21 Feb 2020 12:41:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86a75swuie.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/8/2020 6:04 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Hey! 
>>
>> The commit graph feature brought in a lot of performance improvements across
>> multiple commands. However, file based history continues to be a performance
>> pain point, especially in large repositories. 
>>
>> Adopting changed path Bloom filters has been discussed on the list before,
>> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
>> Derrick Stolee [1]. This series is based on Dr. Stolee's proof of
>> concept in [2].
> 
> Sidenote: I wondered why it did use MurmurHash3 (64-bit version), which
> requires adding its implementation, instead of reusing FNV-1 hash
> (Fowler–Noll–Vo hash function) used by Git hashmap implementation, see
> https://github.com/git/git/blob/228f53135a4a41a37b6be8e4d6e2b6153db4a8ed/hashmap.h#L109
> Beside the fact that everyone is using MurmurHash for Bloom filters ;-)
> 
> It turns out that in various benchmark MurmurHash is faster and also
> slightly better as a hash than FNV-1 or FNV-1b.
> 
> 
> I wonder then if it would be a good idea (in the future) to make it easy
> to use hashmap with MurmurHash3 instead of FNV-1, or maybe to even make
> it the default for hashing strings.
> 

Making Murmur3 hash the default for hashing strings is definitely outside the
scope of this series. Also, if the method signatures for the murmur3 hash 
matched the existing hash method signatures in hashmap.c, then it would be 
appropriate to place them adjacently, even if no hashmap consumer uses it for 
hashmaps. However, we need the option to start at a custom seed to do our double
hashing. A change in the future that involves adopting murmur3 in the hashmap
code would involve a simple code move before creating the new methods that 
avoid a custom seed. So for now, it makes sense that these methods leave in 
bloom.c where they are being used for a very specific purpose. 

>>
>> Performance Gains: We tested the performance of git log -- path on the git
>> repo, the linux repo and some internal large repos, with a variety of paths
>> of varying depths.
> 
> As I wrote in reply to previous version of this series, a good public
> repository (and thus being able to use by anyone) to test the Bloom
> filter performance improvements could be AOSP (Android) base:
> 
>   https://android.googlesource.com/platform/frameworks/base/
> 
> which is a large repository with long path depths (due to Java file
> naming conventions).
> 

Thank you! I will incorporate these results into the commit messages as 
appropriate in v3. 

>>
>> On the git and linux repos: We observed a 2x to 5x speed up.
>>
>> On a large internal repo with files seated 6-10 levels deep in the tree: We
>> observed 10x to 20x speed ups, with some paths going up to 28 times faster.
> 
> Very nice! Good work!
> 
> What is the cost of this feature, that is how long it takes to generate
> Bloom filters, and how much larger commit-graph file gets?  It would be
> nice to know.
> 

The cost of writing is much better now with Peff and Dr. Stolee's improvements. 
I will include these numbers as well in the commit messages as appropriate in 
v3. 

>>
>> Future Work (not included in the scope of this series):
>>
>>  1. Supporting multiple path based revision walk
> 
> Shouldn't then tests that were added in v2 mark use of Bloom filters
> with multiple paths revision walking as _not working *yet*_
> (test_expect_failure), and not expected to not work (test_expect_success
> with test_bloom_filters_not_used)?
> 

My intent is to ensure that bloom filters are not being used in any of the 
unsupported code paths. I don't have a strong preference about the test 
semantics as long as I get that coverage :) So I will look into switching it 
to test_expect_failure as you have suggested. 

>> Derrick Stolee (2):
>>   diff: halt tree-diff early after max_changes
>>   commit-graph: examine commits by generation number
>>
>> Garima Singh (8):
>>   commit-graph: use MAX_NUM_CHUNKS
>>   bloom: core Bloom filter implementation for changed paths
>>   commit-graph: compute Bloom filters for changed paths
>>   commit-graph: write Bloom filters to commit graph file
>>   commit-graph: reuse existing Bloom filters during write.
>>   commit-graph: add --changed-paths option to write subcommand
>>   revision.c: use Bloom filters to speed up path based revision walks
>>   commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>>
>> Jeff King (1):
>>   commit-graph: examine changed-path objects in pack order
> 
> The shortlog summary is a fine tool to show contributors to the patch
> series, but is not as useful to show patch series as a whole: splitting
> of patches and their ordering.
> 

This is a GitGitGadget specific thing, and it is probably by design. I have 
opened an issue in that repo for any follow up discussions:
  https://github.com/gitgitgadget/gitgitgadget/issues/203

> - [PATCH v2 02/11] bloom: core Bloom filter implementation for changed paths
> 
>   In my opinion this patch could be split into three individual pieces,
>   though one might think it is not worth it.
> 

I have gone back and forth on doing this. I like most of the core Bloom filter
computations being isolated in one patch/commit. But based on the rest of your
review, it seems like you are leaning heavily on having this split out. 
So, I will take a proper stab at doing it for v3. 

> - [PATCH v2 07/11] commit-graph: write Bloom filters to commit graph file
> 
>   This commit includes the documentation of the two new chunks of
>   commit-graph file format.
> 
>   I wonder if the 9th patch in this series, namely
>   commit-graph: add --changed-paths option to write subcommand
>   should not precede this commit.  Otherwise we have this new code but
>   no way of testing it.  On the other hand it makes it easier to
>   review.  On the gripping hand, you can't really test that writing
>   works without the ability to parse Bloom filter data out of
>   commit-graph file... which is the next commit.
> 

Getting complete test coverage within a single patch would require 2 or 3 of 
these patches to be combined. This would lead to a large patch that would be 
much more difficult to review.
 
My tests in the patches following this one run git commands. Hence the tests 
get introduced when the command line is ready to use all the new code. 

The current ordering of patches works better than adding the --changed-paths 
option before the logic that computes and writes. Otherwise the option will not 
be doing what it is supposed to do in the patch it was introduced in.

> - [PATCH v2 08/11] commit-graph: reuse existing Bloom filters during write
> 
>   This implements reading Bloom filters data from commit-graph file.
>   Is it a good split?  I think it makes it easier to review the single
>   patch, but itt also makes them less standalone.
> 

All the logic upto this point works just fine without the ability to read and 
parse precomputed bloom filters. This patch is an enhancement and it also 
separates out the reading and writing logic. Reusing existing bloom filters 
during write is the simplest interatcion that involves reading from the commit
graph file, and builds the foundation to make the `git log` improvements. 
Hence, it warrants its own patch and review. 

> - [PATCH v2 10/11] revision.c: use Bloom filters to speed up path based revision walks
> 
>   This is quite a big and involved patch, which in my opinion could be
>   split in two or three parts:
> 
>   a. Add a bare bones implementation, like in v2
> 
>   This limits amount of testing we can do; the only thing we can really
>   test is that we get the same results with and without Bloom filters.
> 
>   b.1. Add trace2 Bloom filter statistics
>   b.2. Use said trace2 statistics to test use of Bloom filters
> 

Sure. I will look into doing this split as well for v3. 

> 
> Feel free to disagree with those ideas.
> 
> Best,

Thanks for taking the time for reviewing this series so thoroughly! 
It is greatly appreciated! 

Cheers,
Garima Singh

