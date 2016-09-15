Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2421FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 00:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbcIOAwT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 20:52:19 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38599 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbcIOAwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 20:52:17 -0400
Received: by mail-it0-f50.google.com with SMTP id n143so51673025ita.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5kkP9ikGU8QnEfYxc9xY7NDfdvvj59bmJYqRzsv1I5w=;
        b=cKP9T7BuwwnR7taZKyf9FIx70SQeSmQ60/OgI2qitrCm0tzSixyGhL5KZeVYxNHY9p
         mZ2/5lXi9FJVFYSzjxNDdRDFWilG9owz6EO/oDItKmR21S63oRLl9IBfKzuWuO5Rsr6I
         G32jD3ph72LqoABQUl5hitGJ7ARIVni0e8KmCibgXeuf+JFQRlBcrHolXxtVp54Fg9um
         rQDgX1Jcz6KYmS8AWAeAwKKOeLGH7wU8r2q/IZ+YV7bvRqcvcO0jKfDZcdGB3WxkJ2tW
         WCVyQ1/IL8hf+3h0ukXjNrS5h8J5Mj6GpXLFdEUHyst60On62gsir2ejk1+sp7YHS7lZ
         MPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5kkP9ikGU8QnEfYxc9xY7NDfdvvj59bmJYqRzsv1I5w=;
        b=bky5oo4+T2fXPfAVl46/+NTSIoV53JuNoLsgQJSzAvWxnhPv0/tOxLFwKsQhgCpz9z
         /FsGR+7GuCczqz6y3qvGRkcfOt8bjVdCLhDzI35Q7mGctGam9MNRdkzPItmnBxrHf/LS
         /9fzTGmCxvYxPSB92t3Q0vt5lOL6zOqS6KXOhE2nchZUyoEiBs0F3FGQEjYjV0W+B2m5
         zHWRtiricWF2GBLw7GK0vdBwT6VbZJHXSwVxKBR5Yxm/dgWSs45EskVqNTWcvNB2dI0/
         XysdXZLT1gKKXb9oaxxcXfX+dCjwk+/Wq6wstQWNqQvHQl/8u2pEPp+5qmLA46qNYnHG
         KDlQ==
X-Gm-Message-State: AE9vXwOmppLQFVt7bDPa+ruGTfBoi3PEJf1dGAMbYDbL4XzG4f2MXcgftndvAOuN49CTA1p1TA3wTgsDjUf/dPrt
X-Received: by 10.107.170.168 with SMTP id g40mr11628135ioj.173.1473900726851;
 Wed, 14 Sep 2016 17:52:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 14 Sep 2016 17:52:06 -0700 (PDT)
In-Reply-To: <20160914235633.gofr534hvslkclzm@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net> <20160914235633.gofr534hvslkclzm@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Sep 2016 17:52:06 -0700
Message-ID: <CAGZ79kb4_k=+O6pzQkZBGHQty+kdYTnQX_3110RNt097AVn+Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] obj_hash: convert to a critbit tree
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> For operations that traverse the whole reachability graph,
> like "rev-list --objects", the obj_hash in object.c shows up
> as a hotspot. We basically have to do "nr_commits *
> size_of_tree" hash lookups, because each tree we look at, we
> need to say "have we seen this sha1 yet?" (it's a little
> more complicated because we avoid digging into sub-trees we
> know we've already seen, but it's a reasonable
> approximation).  So graph traversal operations like that are
> very sensitive to improvements in lookup time.
>
> For keys with length "m", a hash table is generally O(m) to
> compute the hash (and verify that you've found the correct
> key), and O(1) in finding the correct slot. The latter is
> subject to collisions and probing strategy, but we keep the
> load factor on the obj_hash table below 50%, which is quite
> low. And we have a good hash (we reuse the sha1s themselves,
> which are effectively random). So we'd expect relatively few
> collisions, and past experiments to tweak the probing
> strategy haven't yielded any benefit (we use linear probing;
> I tried quadratic probing at one point, and Junio tried
> cuckoo hashing).
>
> Another data structure with similar properties is sometimes
> known as a "critbit tree" (see http://cr.yp.to/critbit.html
> for discussion and history). The basic idea is a binary trie
> where each node is either an internal node, representing a
> single bit of a stored key, or a leaf node, representing one
> or more "remainder" bits. So if you were storing two bit
> sequences 1011 and "1100", you'd have three nodes (besides
> the root):
>
>         (root)
>         /    \
>        0      1
>       /        \
>     NULL    (internal)
>              /    \
>             0      1
>            /        \
>         "11"       "00"
>
> So finding "1011" involves traversing the trie: down the "1"
> side, then the "0" side, and then check that the rest
> matches "11".

So we stop building a tree as soon as we hit a unique data
element (i.e. if we stick to the idea of encoding the hash along the way,
we would have needed another node each for "11" as well as "00"
that points to NULL and the ending data respectively.

So we stop short as soon as we have a unique.

That makes insertion very easy, because as soon as we hit
a unique, we'd just introduce a node and add the two uniques
left and right. (Well what happens if we were to insert
101010111 and 101010101 ? Both have a long prefix,
I suppose we'd have 7 nodes and then the distiguishing
node for those 2.)

>
> Looking up a key is O(m), and there's no issue with
> collisions or probing. It can use less memory than a hash
> table, because there's no load factor to care about.
>
> That's the good news. The bad news is that big-O analysis
> is not the whole story. You'll notice that we have to do a
> lot of conditional pointer-jumping to walk the trie. Whereas
> a hash table can jump right to a proposed key and do a
> memcmp() to see if we got it.
>
> So I wasn't overly optimistic that this would be any faster.
> And indeed it's not. It's about three times slower (about
> 4.5s versus 1.5s running "rev-list --objects --all" on
> git.git).
>
> The reason is, I think, a combination of:
>
>   0. We care much more about performance for this hash than
>      memory efficiency. So we keep the load factor
>      quite low, and thus reduce the number of collisions.
>
>   1. For many hash tables, computing the hash is expensive.
>      Not so here, because we are storing sha1s. So it is
>      literally just casting the first 4 bytes of the sha1 to
>      an int; we don't even look at the other bytes until the
>      collision check (and because of point 0, we don't
>      generally have to do very many collision checks during
>      our probe).
>
>   2. The collision check _does_ have to look at all 20 bytes
>      of the sha1. And we may have to do it multiple times as
>      we linearly probe the collisions. _But_ it can be done
>      with memcmp(), which is optimized to compare 32 or 64
>      bits at a time. So we our O(m) has a very nice constant
>      factor.
>
>      Whereas in the critbit tree, we pay an instruction for
>      _each_ bit we look at.
>
> It's possible that (2) would be better if instead of a
> critbit tree, we used a "critbyte" tree. That would involve
> fewer node traversals, at the cost of making each node
> larger (right now the internal nodes store 2 pointer slots;
> they'd have to store 256 to handle a full byte). I didn't
> try it, but I suspect it would still be slower for the same
> reasons.

I would expect to go for a crit-"variable-length" tree instead.

The reason for this is that a higher fan out seems to be more
beneficial in the earlier stages, e.g. we could use critbyte trees
for the first 1-3 layers in the tree as that will have good memory
efficiency (all 256 slots filled), but will be faster than the critbit trees
(one lookup instead of 8 conditional jumps).

In a degenerated form a crit-"variable-length" tree could be
imagined as a hashmap with a critbit tree as the collision resolver,
as we flip from the one extreme of hashmaps (memory inefficient,
but O(1) lookup with low constant factors), to the other extreme
of critbits (memory efficient, but need O(log(size)) nodes which
each need time per bit)

So maybe we could start with a crit-word (16bit) node at the top,
then have critbyte tree nodes (8 bits), and then go for critbit nodes?
The crit-word would have 2**16 entries, i.e. 64k, which is more than
git.gits count of objects (~44k), so we'd get the memory inefficiency of
a hash map, combined with slightly higher costs for collision resolving.

I guess when trying to improve the hashsets, someone tried trees
as a collision resolver?

>
> The code is below for reference. I pulled the critbit
> implementation from:
>
>   https://github.com/ennorehling/critbit
>
> but made a few tweaks:
>
>   - the critbit does not store the keys themselves, as we
>     already have them in the "struct object", and do not
>     want to waste space. As a result, I baked in some
>     assumptions about the 20-byte key-length (which is fine
>     for our purposes here).
>
>   - rather than malloc() each node, I used a pool allocator
>     (to try to keep the nodes closer together in cache)


I think this is another interesting part, so let's talk about caching.
While we may not care about the memory inefficiency for the lost
memory, it is still bad for caches. And the cache inefficiency may
be worse than a few instructions of walking down a critbit for
example. I was instantly reminded of 9a414486d9f0
(lookup_object: prioritize recently found objects)

So maybe we could have some software sided cache for hot entries?
(I imagine a data structure consisting of 2 hash sets here, one
hashset containing
the complete data set, and the other hashset is a very small hashset with e.g.
just 256(?) entries that are an LRU cache for the cache entries.
Though this sounds like we'd be trying to outsmart the hardware... Not sure
I'd expect gains from that)

I guess we rather want to split up the data sets on the application
side: i.e. instead of
having so many objects, have hash sets for e.g. blobs, trees, commits separately
and then use slightly different strategies there (different load factors?)

Unrelated note about hashmaps:
I wonder if we rather want to give good initial estimates of the size
as one improvement


Thanks for posting these patches!
They are really fun to learn from!

Stefan
