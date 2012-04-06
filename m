From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Fri, 6 Apr 2012 12:21:09 -0700
Message-ID: <CAJo=hJusnnaMomQzb90ed9=HHpamVTktN0Qrw8MsaY+addF=rw@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
 <20120402203728.GB26503@sigill.intra.peff.net> <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
 <CACsJy8BbNEJBn5i0Rntv21d8qvhPwkrNBdaj+sGh2W-aN9jYGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Colby Ranger <cranger@google.com>
To: Jeff King <peff@peff.net>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 21:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGEj3-0007ZY-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 21:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab2DFTVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 15:21:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65163 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757734Ab2DFTVa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 15:21:30 -0400
Received: by pbcun15 with SMTP id un15so2912511pbc.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1De7ISpwKXOX6cGuI5wQB/CE05842RlI3yHsyZIJIz0=;
        b=FGiVIp5OLTJoBWSbUKBXCQG873hfbciAJX/YYdbUjo1RcoIm4QbZeXO9vL6h5GnTz4
         40rxeRnZYPFQ1igyJChgY4weQNpFP5390i0ydhXkGVnzJFG+3k6eDkf7kGtQiqnEOuj2
         OUULfpHjRtPsLPN/upJ0F4YvLvKxWwGcankZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=1De7ISpwKXOX6cGuI5wQB/CE05842RlI3yHsyZIJIz0=;
        b=UK0CKQIrCROtXyuD19MVvrGGzEWp9JQOz9ShRfYcvyREAveFKfJehOmTf45rZ1fUG7
         kbFlAIczYcpGVplJsr8GN4gVqxBY2RyAhe9UXqiTyknNkBSOc+UBohJNQsNWq5KCbM5O
         8Pw6uNrqM75BW6iO/DVRmcpCB3aUNSPvDiJm+yUGoixA/Y+JuQCkx7kQHXOKuOsu9Ccl
         u3wuwBfEj6A85EXPXzimmw6eU3kE+uolw92/bLG2x5LmnZ2fJZGI4nWHG3zmWcubk2jt
         Pl8KHkCUkTFckf/JSzXgC9YjjelaarnS80h7Uk8/dw3djpV1C9s6Ec9CEFI5zseZcJ1i
         WqJg==
Received: by 10.68.202.226 with SMTP id kl2mr10074688pbc.149.1333740089805;
 Fri, 06 Apr 2012 12:21:29 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Fri, 6 Apr 2012 12:21:09 -0700 (PDT)
In-Reply-To: <CACsJy8BbNEJBn5i0Rntv21d8qvhPwkrNBdaj+sGh2W-aN9jYGg@mail.gmail.com>
X-Gm-Message-State: ALoCoQlwMlDmrojDdFhZ0SVPs4pjeRQ6jI0AcwubDWSEpFsCR9fTgdrxTwoSvCK3XXKaVkaQiIIO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194896>

On Thu, Apr 5, 2012 at 06:02, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On linux-2.6.git, one 521MB pack, it generates a 356MB cache and a
> 30MB index companion. Though if you are willing to pay extra 5 second=
s
> for decompressing, then the cache can go down to 94MB. We can cut
> nearly half "rev-list --objects --all" time with this cache
> (uncompressed cache):
>
> $ time ~/w/git/git rev-list --objects --all --quiet </dev/null
> real =A0 =A02m31.310s
> user =A0 =A02m28.735s
> sys =A0 =A0 0m1.604s
>
> $ time TREE_CACHE=3Dcache ~/w/git/git rev-list --objects --all --quie=
t </dev/null
> real =A0 =A01m6.810s
> user =A0 =A01m6.091s
> sys =A0 =A0 0m0.708s
>
> =A0$ time ~/w/git/git rev-list --all --quiet </dev/null
> real =A0 =A00m14.261s =A0# should be cut down to one third with commi=
t cache
> user =A0 =A00m14.088s
> sys =A0 =A0 0m0.171s
>
> Not really good. "rev-list --objects"'s taking less than 30s would be
> nicer. lookup_object() is on top from 'perf' report with cache on. No=
t
> sure what to do with it.


My officemate Colby and I came up with a better solution a few weeks
ago, but haven't really had a chance to discuss it in on the list. I
guess I should try to do that now. Like anything else, we went into
this work with some assumptions.

There are two operations we really wanted to improve the performance
of, `git rev-list --objects` for the two commonly used cases from
pack-objects, notably `rev-list --objects $WANT` and `rev-list
--objects $WANT --not $HAVE`. That is, clone and incrementally
fetching something when you have a common ancestor. I'm currently
ignoring shallow clone in this work as it tends to be a bit less
expensive on the object enumeration part.

Working from the linux repository, with roughly 2.2M objects, we can
assume the vast majority of these objects are stored in a pack file.
If we further assume these are mostly in a single pack file, we can
easily assign every packed object a unique integer. We do this by
assigning the N-th object in the pack integer N. You can already do
this by taking the pack index and computing the reverse index, sorted
by offset in pack. Finding the integer value for any SHA-1 is then a
matter of locating its offset in the normal index, and locating the
position of it in the reverse index... a O(2 log N) operation.

With all of the packed objects named by an integer [0, N) we can build
a series of bitmaps representing reachability. Given a commit, its
bitmap has every bit set for every object that `git rev-list --objects
$COMMIT_SHA1` would output. If the pack is built from a single branch
(e.g. a repository with no tags and only a master branch), that tip
commit would have every bit set in its bitmap, as all objects in the
pack are contained in the bitmap.

A bitmap of 2.2M objects is 2.2M bits in size, and is roughly 275 KiB
worth of data. But we can compress the bitmap using word aligned
hybrid compression (WAH) [1] and have it drop to about 1 KiB in size.

Packs have fairly good locality given that they are roughly ordered by
time. The further back in history you go, the bitmap for any given
commit will start to contain more zeros than ones, and the zeros will
be roughly consecutive as the regions of the pack are less full, so
the bitmap still compresses well.

We actually did an experiment computing the bitmaps for all of the
commits in the kernel repository, IIRC the largest ones were coming in
around 40 KiB in the middle of history, and then shrinking smaller
again as you got further back in history.

Assuming all bitmaps are around 20 KiB average size (most were in this
range), storing bitmaps for every commit costs around 4.2G. Not worth
it. However.

If we take the kernel history in rev-list and pick two commits that
are roughly ~10,000 commits apart from one another, JGit can compute
the rev-list --objects between these two commits in about 120
milliseconds (git-core should be faster, or at least comparable).

Given that, we don't have to store every bitmap. Instead you store the
bitmaps about every 10,000 commits. Now your bitmap storage is closer
to 1 MiB in size for the entire pack. This can be easily appended to
the end of the pack-*.idx file as a new section when the pack is
built. The packer can construct the necessary data during packing with
what I suspect relatively little additional cost to what its already
doing, as most of the required data is in memory or being touched
anyway.

Obviously that 10k distance between bitmaps is tuneable, and could be
a config variable. We could even make it a % of the pack size, with
Git automatically selecting equidistant points between commits in the
history such that the compressed bitmaps fit within the target
percentage. Repository owners could set this to e.g. 10% and let the
machine do the rest of the work. (10% of a 560M pack might be ~56M
worth of bitmaps or every ~2800 commits.)


Computing `rev-list objects $WANT` is just a matter of OR-ing together
the bitmaps that correspond to what the client asked for. WAH
compressed bitmaps can apply OR without decompressing, in ~5ms time
range, rather than 14.2s... or 90s.  :-)

Computing `rev-list objects $WANT --not $HAVE` is likewise an OR of
the $WANT and $HAVE groups, then a negation, which again can be done
directly on the compressed bitmaps.

When the client uses a $WANT or $HAVE that we don't have a direct
bitmap for, build the bitmap on the fly by running `rev-list $WANT`
(or $HAVE) until the revision traversal produces a commit that does
have a bitmap. Extend the bitmap with the additional objects that
aren't in the pack by assigning them new temporary integers that are
larger than the number of objects in the pack. Finish the operation
with the bitmaps.


To output the pack we don't even need to build up a huge list of
struct packed_obj in memory. Instead we iterate the set bits in the
bitmap, working off the compressed format. When an object has its bit
set, it needs to be sent to the client. The object can be found in the
pack by looking at the N-th position of the reverse index to get its
offset, or the N-th position in the reverse index to get its SHA-1.
Copying slices of pack data should be a pretty simple task. The bits
are already sorted by preferred pack order, since they came from a
pack, so the writer still produces a good stream. Obviously if you
want to change the ordering, or the deltas, aka repack -f, we need to
avoid using the bitmap ordering here.

There is some complication relating to swapping out delta compressed
form for non-delta compressed form if you cannot prove the peer has
the delta base that is currently being used. But with the bitmaps we
actually have a much more accurate representation of what the client
*actually* has. Instead of being limited to the common ancestor
negotiation point's trees, the $HAVE bitmap covers *every single
object to the beginning of time*. This significantly increases the
number of candidates available for delta reuse, because there are
better chances that the base we use is already available to the
client.

The $HAVE bitmap covering a much bigger section of history also means
we transmit fewer objects, which makes for a faster transfer for the
client. This often happens with cherry-picks or reverts across the
common ancestor cut point in the graph, where the peer already has the
relevant object(s) but we can't prove it from the limited section of
history we look at today. The $HAVE bitmap is much more comprehensive
picture of the client's state, making for a smaller transfer.


Having multiple packs is common, and does complicate this algorithm.
There are known ways to combine different bitmap indexes together to
create a single larger bitmap, mostly by applying a unique "base
prefix" to each bitmap's values. Its very common in the full text
search community to do this when incrementally updating a full text
index.

A process can assign each pack it observes a unique base prefix, and
then join together bitmaps across those packs to get a more complete
picture. Its not entirely that simple though because a commit in a
newer pack probably still references a parent in an older pack, and so
that commit in the newer pack doesn't have a complete bitmap.

One way out of this is to only produce bitmaps on a full GC, where the
entire repository is rewritten. If every 10k commits worth of history
costs about 100ms additional processing time to do object enumeration,
we only really have to do a major repack about every 100k commits when
processing is starting to come close to 1.2 seconds of CPU time. The
linux history has done ~220k commits in ~5 years, or 44k commits/year.
Asking a repository to do a full GC at least once per year so that
there only needs to be one set of bitmaps might be acceptable. :-)


The other operation that matters is `git rev-list --objects $NEW --not
--all`, which is done for a reachability test during receive of data
into a repository from the network (in either fetch or receive-pack).

If we know a pack was created locally by the git gc or git repack
command, we only need to run `git rev-list --objects $NEW` and stop
traversal for a section of the graph when we find a commit or object
that already exists in a locally created pack index. In other words we
don't use the "--not --all" bit and we instead we look at each object
coming out of the traversal to see if it is in a locally created pack,
if it exists in a pack's index we mark it UNINTERESTING and continue
the traversal. This would eliminate the need to parse and load --all
into the priority queue, instead we parse and insert only the commits
that are directly connected to the part of the $NEW graph we were just
given, and we only do that so we can stop traversal at the common
ancestor point(s) and avoid walking back to the root. It probably
isn't even necessary to parse or insert these commits, we just have to
tag them UNINTERESTING and avoid putting them into the priority queue.

However not all locally stored packs were locally created. Some are
created from the network (e.g. when the number of objects is > 100).
So for this optimization to work we need an additional chunk of
metadata written with the pack to say "this pack was made by git gc /
git repack and is trustworthy". This could be a new ".local" file
alongside .pack/.idx, or we could do a minor change to the .idx format
to allow a "source bit" to be written to say where the pack came from
(network or fast-import vs. local gc).


I think a lot of the other users of the commit graph / object graph
are just looking at small enough slices of history that walking
through 10k commits in 120 ms is acceptable response time to the human
running the command. So its not really pack v4. It only needs a few
MiB additional space on top of existing pack data, and is easily
stored onto the end of the local index file. But it gets us a lot of
improvement in some pretty tough areas.


I don't have any code to share, because we haven't written it yet. But
this should shave off some of the big corners within Git, with
relatively little additional disk usage.


[1] "Sorting improves word-aligned bitmap indexes", Daniel Lemire,
Owen Kaser, Kamel Aouiche
    http://arxiv.org/abs/0901.3751
