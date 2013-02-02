From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Sat, 2 Feb 2013 02:04:51 -0800
Message-ID: <CAJo=hJtBFoBXa0rmyo+oLwGa-7zPPAYXQ6nv33h2rFLyjbHKZA@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <CAJo=hJtTYZg+1+RZVfEGTgOGzqxQbN1CLYWrvUp+WHKGxGwHMQ@mail.gmail.com>
 <20130201091130.GB30644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 11:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Zz3-0007Sa-3p
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 11:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab3BBKFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 05:05:35 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43554 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab3BBKFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 05:05:12 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so3004486iea.10
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tkIAwj0RblSHlwOcURnV5DaJbCJSgrvEHqzCartgJYE=;
        b=dMQ+st+rggWWSJwE/uI3GfqSA7cvP043/jOXaP5+oNr/11HxKyLpK73C4Y8V4WXW3O
         pmuS5xgavFyB2oi4BFwpgZ6DVNpHF/s/VGbA80mj3dq2k3JHOEOxeMKScxtSFIdqQsUQ
         gtoutUMYCgiMucFm1F+SCll+cHg0rbZK2nCh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=tkIAwj0RblSHlwOcURnV5DaJbCJSgrvEHqzCartgJYE=;
        b=I+Zpb+LQg2v9K3a+DLtr8+g34//YsnqWvs6gipG10jzA7BkojevzLiF9cWwGKTCnhz
         yBBTj1QevCz8S/fhIe8uhRRUBPx8T9Zyl1HivEt3kWVSmVE2VfR2pRLJWqReRQRv14qP
         syZ5K2oL+hTMmJ6cdwaHgssNSiyIY7EPEYCtxQSlPsydS1g60H24eFpR5Nor6sQvE6G3
         nkCPAv6D1U/KfCXIDgb5eZz4qmY6IYHu0T29aneM+vJfMQ/2UAuWeI6qkye1U2CBCdQl
         j9gPmSgSRrHzLgqWqGLXdZPHTNW7NYiLCBpORscp+7P6kZsit8v6SFotmlG23jX9QSIO
         uZMA==
X-Received: by 10.42.159.194 with SMTP id m2mr11423526icx.13.1359799511499;
 Sat, 02 Feb 2013 02:05:11 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Sat, 2 Feb 2013 02:04:51 -0800 (PST)
In-Reply-To: <20130201091130.GB30644@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnhoxpxvRjec/ZM/jP26d+tXH1NQAEFQKZy3mzDuOozgVn1L+iriKu9YJ+RlJ3E45Ju4I72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215287>

On Fri, Feb 1, 2013 at 1:11 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 31, 2013 at 09:14:26AM -0800, Shawn O. Pearce wrote:
>
>> On Tue, Jan 29, 2013 at 1:14 AM, Jeff King <peff@peff.net> wrote:
>> > Coupled with using compression level 0 for trees (which do not compress
>> > well at all, and yield only a 2% increase in size when left
>> > uncompressed), my "git rev-list --objects --all" time drops from ~40s to
>> > ~25s.
>>
>> This uhm.... is nice?
>>
>> But consider reachability bitmaps. ~40s to ~80ms. :-)
>
> Yeah, yeah. I'm working my way up to it. :)

:-)

> At this point I'm convinced that my 25s is about the best we will do for
> reachability analysis with a graph traversal. The repeated hashcmps to
> see that we've visited each node are starting to dominate. So the next
> obvious step is to try reachability bitmaps.

Yea, its hard to make a big N go fast when you still have a big N...

> I was hoping to iron out
> the "pack metadata goes here" issues with the commit cache stuff,
> though, as the actual cache implementation is quite simple (whereas the
> bitmap stuff is more on the complex side, but can build on the same
> metadata base).

Junio and I were talking about putting these in an index v3, below the
current tables where he thought there was a hole in v2. I am inclined
to agree with his comment elsewhere that we don't want 50 auxiliary
files next to a pack in 5 years.

But if we go that route I also suggested we append the index below the
pack file itself, so its a single file, and that we rename the file to
be SHA1(all-bits) not SHA1(sorted-object-list). Both steps make it
much safer to perform git gc on Windows while the repository is being
accessed.

>> Yup. I have also futzed with the one in JGit for quite a while now. I
>> pull some tricks there like making it a 2 level directory to reduce
>> the need to find a contiguous array of 8M entries when processing the
>> Linux kernel, and I try to preallocate the first level table based on
>> the number of objects in pack-*.idx files. But the bottleneck is
>> basically the cache lookups and hits, these happen like 100M times on
>> 2M objects, because its every link in nearly every tree.
>
> Right. I tried some multi-level tricks (and even a radix trie), but I
> couldn't get anything to beat the simple-and-stupid single hash table
> with linear probing.

O(1) lookup is hard for big N. Lets go shopping^Wcoding instead.

>> If we modified pack-objects' delta compressor for tree objects to only
>> generate delta instructions at tree record boundaries, a delta-encoded
>> tree can be processed without inflating the full content of that tree.
>> Because of the way deltas are created, "most" tree deltas should have
>> their delta base scanned by the object traversal before the delta is
>> considered. This means the tree delta just needs to consider the much
>> smaller records that are inserted into the base. We know these are
>> different SHA-1s than what was there before, so they are more likely
>> to be new to the lookup_object table.
>
> So sort of a magic shortcut tree diff you get while accessing the
> object. Neat idea.

Yes, exactly.

>> So the --objects traversal algorithm can change to get the delta base
>> SHA-1 and raw tree delta from the pack storage. Perform a
>> lookup_object on the base to see if it has been scanned. If it has,
>> just scan the delta insert instructions. If the base has not yet been
>> scanned, inflate the tree to its normal format and scan the entire
>> tree.
>
> This would not perform well if we hit the deltas before the bases. In
> general, though, our "use the larger as the base" heuristic should mean
> that our traversal hits the bases first.

It won't perform worse than the current code. And its actually the
time heuristic that should kick in here for trees. Most trees are
roughly the same size, or are only slightly bigger because a new
source file was added. More recent trees should appear earlier in the
delta window and be suitable candidates for older trees. So we should
get a large percentage of trees covered by this trick.

>> This is an approximation of what Nico and I were talking about doing
>> for pack v4. But doesn't require a file format change. :-)
>
> Yeah. It just needs to be very careful that the deltas it is looking at
> all fall on record boundaries, since we might get deltas generated by
> other versions of git. Can we necessarily identify that case for sure,
> though?  I imagine a tree delta like that would look something like:
>
>   delete bytes 100-120
>   add 20 bytes at offset 100: \x12\x34\x56...

Of course we can't know without some flag. I assumed it was obvious we
would need to tag the pack somehow with extra metadata to say "every
tree delta in this pack is on a record boundary". That does make delta
reuse more complex as a tree delta can only be reused if it is coming
from a pack that has the same promise about record boundaries.
Otherwise the delta must be regenerated during packing.

> Without looking at the base object, and without knowing whether the
> delta was generated by our particular implementation, how can we be sure
> this is a sha1 replacement and not the renaming of part of a file? Or
> are you proposing some flag in the packfile to indicate "yes, this tree
> really was delta'd only at record boundaries"?

Yes, some sort of flag would be required on the pack. :-\

> It could be a big win, but it does seem quite complex and error-prone.

It is complex. But it seems so simple on the Internet...

> And it only helps with reachability, not regular traversals, so it's not
> very generic.

It should also help with path filter traversals. If we require the
deltas to be only at tree record boundaries then the mode and path
will be part of the delta, even if it is unmodified from the base
tree. A path filter can avoid scanning the base sections if its
already seen that base tree before. This could be a substantial
reduction in the number of tree records a path filter needs to examine
to get a `git log -- path` or `git blame path` completed.

> Which makes me think the bitmap route is a much better way
> to go.

Bitmaps discard a lot of useful data in favor of being really freaking
small. Colby was toying around with some other allocations of bitmaps
today. I think he managed to bitmap basically every commit in the
Linux kernel history since September... and its only 3M of data to
store on disk / cache in RAM. Very useful for serving fetch requests
to clients that are at varying points in history, but not so good for
doing things like new delta compression or path limited history
traversal.

<thought type="random" why="look at the Date header">

What if we built a bitmap for each path? Linux kernel history is
~41.5k paths. If the packer constructs a bitmap for each path that
sets a commit's bit if the path is impacted in that commit, you can do
some incredibly fast path traversal operations. Naive implementation
would cost around 1.7G of disk, but I wonder how well that set of maps
might compress.

</thought>
