Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE3C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D924611CD
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhDOIr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhDOIr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:47:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C5C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:47:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so26989749ejb.12
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=R2T5zmYrXs5TNzD2y1IcJ8S1Kv49Ox7KHJnbEwLNpDA=;
        b=pehFy/Kj5j/Bd4f1CQsBh4xRtmQSc0iyzAV18BX4PVo9j2k+uFriXhbwfT9glJZrvx
         RgxGFuUD2hrR1/C6LFw1GX4dwusP+lEflN/9zQnTmpmQ0TmHf1nUGm/KSAK/lnTCtR0X
         7TmBXgOnY7uqB3WqM30OQaxfQcTB4ivL1xCJkxS7juiH6wq+RkHF2xoNjqVnl+qgqVBz
         +VC/khOCQM5+is5V5590TsVMG+SMkH7sspkgyXMbZLwEWAlzsMf27Rw9xXf14EcgISy8
         Y6f1RGRofkkyECwN1LEvdaWiwzdXBqEoBcgaMES1GuY8ZilaQH5yJuE2tEO/WJOswknk
         Le/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=R2T5zmYrXs5TNzD2y1IcJ8S1Kv49Ox7KHJnbEwLNpDA=;
        b=ENaZdDiImwnch9B70eTY7UM4SktYlfTUQtwml/xs+TolsKZPBh3eAmj9VjBIWXdob5
         WkIDzCFz+7L+7NQBfRYL4/OmEF6ZuFsbndApjDc5CB8CSnn/6/ka+X+1P5QZxfVtpIGo
         JHvYTYbWedACLSH+mwKQkTluQMkPOK8Wjr3lbXDYhlZtdKDjfiGzxSAzZy0u418ZJGyd
         rXieZOVP0F26Qep7Utm+dXotxRX5/0+P8V7pgdcVZ4dzxzPK9a0S/nhE+2adoE8Po6Y6
         ODygFMFOoyhjyHwd3uQOTR431RrNXx6RmDwUc0rhTNX549fkx+LDUou3tqaKfW7OXXfm
         12uQ==
X-Gm-Message-State: AOAM530ZEVKASn1bpp/2knXpCcbSl7DPOZwEon9XAgbuaNe+QtVor0CB
        Xa0SBR4rppaP2fTFW11PcmXp0BrLPmI=
X-Google-Smtp-Source: ABdhPJyk25c8ldUFUAiVQdi5nqkXvlatII9TWWfTP+gzefJtqjZE8pF0jYlfCGowR/OGPaz6laa2NQ==
X-Received: by 2002:a17:906:1101:: with SMTP id h1mr2293461eja.179.1618476422170;
        Thu, 15 Apr 2021 01:47:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hc43sm1432779ejc.97.2021.04.15.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:47:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
 <38f48634-077b-6351-5285-f8ecc6f552d0@gmail.com>
 <YHZApIpPBhpmwscP@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHZApIpPBhpmwscP@camp.crustytoothpaste.net>
Date:   Thu, 15 Apr 2021 10:47:00 +0200
Message-ID: <87pmyw0waj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, brian m. carlson wrote:

> On 2021-04-13 at 12:12:21, Derrick Stolee wrote:
>> On 4/10/2021 11:21 AM, brian m. carlson wrote:
>> > Now that we're working with multiple hash algorithms in the same repo,
>> > it's best if we label each object ID with its algorithm so we can
>> > determine how to format a given object ID. Add a member called algo to
>> > struct object_id.
>> > 
>> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> > ---
>> >  hash.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/hash.h b/hash.h
>> > index 3fb0c3d400..dafdcb3335 100644
>> > --- a/hash.h
>> > +++ b/hash.h
>> > @@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
>> >  
>> >  struct object_id {
>> >  	unsigned char hash[GIT_MAX_RAWSZ];
>> > +	int algo;
>> >  };
>> 
>> What are the performance implications of adding this single bit
>> (that actually costs us 4 to 8 bytes, based on alignment)? Later
>> in the series you add longer hash comparisons, too. These seem
>> like they will affect performance for existing SHA-1 repos, and
>> it would be nice to know how much we are paying for this support.
>
> I will do some performance numbers on these patches, but it will likely
> be the weekend before I can get to it.  I think this will add 4 bytes on
> most platforms, since int is typically 32 bits, and the alignment
> requirement would be for the most strictly aligned member, which is the
> int, so a 4-byte alignment.  I don't think the alignment requirements
> are especially onerous here.

I think if you're doing such a perf test one where we have SHA-1 mode
with SHA-1 length OID v.s. SHA-256 (the current behavior) would be
interesting as well.

It seems like good SHA1s to test that are 5a0cc8aca79 and
13eeedb5d17. Running:

    GIT_PERF_REPEAT_COUNT=10 \
    GIT_SKIP_TESTS="p0001.[3-9] p1450.2" \
    GIT_TEST_OPTS= GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3' \
    ./run 5a0cc8aca79 13eeedb5d17 -- p0001-rev-list.sh p1450-fsck.sh

(I added a fsck --connectivity-only test)

Gives us:

    Test                               5a0cc8aca79         13eeedb5d17            
    ------------------------------------------------------------------------------
    0001.1: rev-list --all             2.46(2.22+0.14)     2.48(2.25+0.14) +0.8%  
    0001.2: rev-list --all --objects   10.79(10.22+0.14)   10.92(10.24+0.20) +1.2%
    1450.1: fsck --connectivity-only   16.61(15.42+0.34)   16.94(15.60+0.32) +2.0%

So at least on my box none of those are outside of the confidence
intervals. This was against my copy of git.git. Perhaps it matters more
under memory pressure.

>> I assume that we already checked what happened when GIT_MAX_RAWSZ
>> increased, but that seemed worth the cost so we could have SHA-256
>> at all. I find the justification for this interoperability mode to
>> be less significant, and potentially adding too much of a tax onto
>> both SHA-1 repos that will never upgrade, and SHA-256 repos that
>> upgrade all at once (or start as SHA-256).
>
> The entire goal of the interoperability is to let people seamlessly and
> transparently move from SHA-1 to SHA-256.  Currently, the only way
> people can move a SHA-1 repository to a SHA-256 repository is with
> fast-import and fast-export, which loses all digital signatures and tags
> to blobs.  This also requires a flag day.
>
> SHA-1 can now be attacked for USD 45,000.  That means it is within the
> budget of a dedicated professional and virtually all medium or large
> corporations, including even most municipal governments, to create a
> SHA-1 collision.

Is that for vanilla SHA-1, or SHA-1DC?

> Unfortunately, the way we deal with this is to die, so
> as soon as this happens, the repository fails closed.  While an attacker
> cannot make use of the collisions to spread malicious objects, because
> of the way Git works, they can effectively DoS a repository, which is in
> itself a security issue.  Fixing this requires major surgery.

Can you elaborate on this? I believe that we die on any known collision
via the SHA1-DC code, and even if we didn't have that we'd detect the
collision (see [1] for the code) and die while the object is in the
temporary quarantine.

I believe such a request is cheaper to serve than one that doesn't
upload colliding objects, we die earlier (less CPU etc.), and don't add
objects to the store.

So what's the DoS vector?

> We need the interoperability code to let people transition their
> repositories away from SHA-1, even if it has some performance impact,
> because without that most SHA-1 repositories will never transition.
> That's what's outlined in the transition plan, and why that approach was
> proposed, even though it would be nicer to avoid having to implement it
> at all.

There's no question that we need working interop.

The question at least in my mind is why that interop is happening by
annotating every object held in memory with whether they're SHA-1 or
SHA-256, as opposed to having some translation layer earlier in the
chain.

Not all our file or in-memory structures are are like that, e.g. the
commit graph has a header saying "this is a bunch of SHA-1/256", and the
objects that follow are padded to that actual hash size, not the max
size we know about.

My understanding of the transition plan was that we'd e.g. have a
SHA-1<->SHA-256 mapping of objects, which we'd say use to push/pull.

But that by the time I ran say a "git commit" none of that machinery
needed to care that I was interoping with a SHA-1 repo on the other end.
It would just happily have all SHA-256 objects, create new ones, and
only by the time I needed to push them would something kick in to
re-hash them.

I *think* the anwer is just "it's easier on the C-level" and "the
wastage doesn't seem to matter much", which is fair enough.

*Goes and digs in the ML archive*:

    https://lore.kernel.org/git/1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net/#t
    https://lore.kernel.org/git/55016A3A.6010100@alum.mit.edu/

To answer (some) of that myself:

Digging up some of the initial discussion that seems to be the case, at
that point there was a suggestion of:

    struct object_id {
        unsigned char hash_type;
        union {
            unsigned char sha1[GIT_SHA1_RAWSZ];
            unsigned char sha256[GIT_SHA256_RAWSZ];
        } hash;
    };

To which you replied:
    
    What I think might be more beneficial is to make the hash function
    specific to a particular repository, and therefore you could maintain
    something like this:
    
      struct object_id {
          unsigned char hash[GIT_MAX_RAWSZ];
      };

It wouldn't matter for the memory use to make it a union, but my reading
of the above is that the reason for the current object_id not-a-union
structure might not be valid now that there's a "hash_type" member, no?

> I will endeavor to make the performance impact as small as possible, of
> course, and ideally there will be none.  I am sensitive to the fact that
> people do run absurdly large workloads on Git, as we both know, and I do
> want to support that.

All of the above being said I do wonder if for those who worry about
hash size inflating their object store whether a more sensible end-goal
if that's an issue wouldn't be to store abbreviated hashes.

As long as you'd re-hash/inflate the size in the case of collisions
(which would be a more expensive check at the "fetch" boundary) you
could do so safely, and the result would be less memory consumption.

But maybe it's just a non-issue :)

1. https://lore.kernel.org/git/20181113201910.11518-1-avarab@gmail.com/
