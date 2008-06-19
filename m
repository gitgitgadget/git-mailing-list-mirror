From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Thu, 19 Jun 2008 10:24:28 +0100
Message-ID: <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
	 <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
	 <20080618143633.GB30540@diana.vm.bytemark.co.uk>
	 <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com>
	 <20080618173246.GA1155@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 11:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9GOU-0008P3-53
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 11:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYFSJYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 05:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbYFSJYa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 05:24:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:10533 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYFSJY2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 05:24:28 -0400
Received: by wa-out-1112.google.com with SMTP id j37so514577waf.23
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k2+hwoGM9wH4Tv597EpwfnFMORS9L35X3praP/MvFAE=;
        b=nHSlnBfjxnWaAee0/oG/ci9w5+P3cbhGX7GbOj6YskiI1fcng/yhK3qdvtcw+cFVr5
         kyn0Ce666r/EqP43e56GxKDn0uPryELHMcsh8Zrq6cv0fZ6h/07oJGTxBdNC9x9kpoSu
         L7rgDnHt+szpJxUR3CMhfddrRF+S1rO7NuCUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O+h8qtohUMKsYYkhfe3U5+tpdcv9klpf9JmmAQzaWb15wblRdGt1JlHlyGfYwiOui2
         /aIZDbMNjTp9SBI2AY5Vxm7IMl1Gov/ATZuXhBiZh6uHdVdtxdK6giuHzPaXx1BcEpsh
         GefRFGYO+i6H31WK+usIV0ae5xiUFlOozghRE=
Received: by 10.115.47.1 with SMTP id z1mr2137554waj.129.1213867468102;
        Thu, 19 Jun 2008 02:24:28 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Thu, 19 Jun 2008 02:24:28 -0700 (PDT)
In-Reply-To: <20080618173246.GA1155@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85464>

2008/6/18 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-18 17:16:10 +0100, Catalin Marinas wrote:
>> We could also easily use the commit message directly for metadata
>> instead of .git/patches/<branch>/.
>
> Yes. This is true for any log scheme, though. (But I agree -- longer
> term, it would be very nice to have _only_ the log.)

It would make collaboration using stgit stacks easier. I can start
looking at this once we agree on the log structure.

>> The time to create that tree and blobs worries me a bit, plus the
>> (in my view) complicated structure.
>
> You're right to worry. My log format makes things feel slightly slowe=
r
> when logging a 20-30 deep stack. If I can't make it faster, it's not
> viable. But I'm pretty sure I can -- it should be simple to reuse all
> the trees and blobs for the patches that weren't touched. (And
> operations that touch lots of patches, like rebase, have to write a
> lot of git objects anyway as part of their operation, so the relative
> slowdown should not be large.)
>
> Anyway, benchmarking is the way to go here. Talk will only get us tha=
t
> far.

In the past, I ran some tests because people complained that stgit was
slow compared to quilt:

http://article.gmane.org/gmane.comp.version-control.git/9670

After profiling (the stg-prof file), as expected, most of the time was
spent in external Git calls which I tried to keep to a minimum. With
your approach, you probably add at least 4-5 calls to Git (just a
guess, I haven't counted) and, with a big repository, it will be
visible (I have about 15 branches on my Linux kernel clone going back
to the 2.6.12 kernel and the .git size is over 1/2GB after git-gc).

>> Making the first log entry special gets difficult with log pruning
>> (unless you prune the whole log rather than entries older than a
>> chosen time or number) since you might have to re-create all the
>> chained log entries as the first log's sha1 will probably change.
>
> You have to re-create all the commits anyway, since they all are
> immutable, and all have a back pointer.

Ah, OK. So, at least initially, we should only support the full log pru=
ning.

>> The applied patches are chained automatically via HEAD. For
>> unapplied patches, we could add the correponding commits as parents
>> of the logging commit (starting with the third parent as the first
>> two are used for log chaining and applied patches). Do we hit any OS
>> limit with the number of arguments?
>
> Not until long after we hit git limits to the number of parents of a
> commit. I believe the octopus merge refuses to create merges with mor=
e
> than about 25 parents, and we probably shouldn't do more than that
> either. We'll have to do a tree of octopuses.

=46or the first log only, we could chain the unapplied patches using
commits with 2 parents. We just need to warn people not to stare at
the <branch>.stgit directly :-)

>> Since we only need the unapplied commits tracking for gc and pull
>> reasons, we could only create that commit that references them when
>> we prune the stack log and link it from the top one (but it won't be
>> used by stgit).
>
> Yes, we need to create an "unapplied octopus" if and only if we have
> unapplied patches that we can't prove are reachable from the stack to=
p
> or the branch head (we have to save both, in case the user has done
> something such as git-committing on topp of the stack and caused head
> !=3D top). Which is for the first log entry, and in situations such a=
s
> "stg pick --unapplied", but not for "stg pop" and the like.

Yes, but just chain unapplied commits rather than using octopus (you
could try to the -mm series with 500+ patches and see what happens).

> I do agree that we shouldn't try to use the octopuses to get hold of
> the commits, though -- just to keep them reachable. We save the sha1
> along with the patch name elsewhere in a more convenient form. (My
> proposed format does precisely this.)

Yes, but you still have to refer the tree objects corresponding to a
patch and extra work to generate the simplified log.

> So. If I got it right, your proposal is:
>
>  * Tree: just take the HEAD tree.

Yes.

>  * Commit message: list the applied and unapplied patches with their
>    commit sha1s.

We don't even need to differentiate between applied and unapplied in
the commit message as long as they are listed in order since one of
the parents would represent the boundary between them. Since lib.stack
is pretty well structured, we could later modify PatchOrder to use the
log.

>  * Parents: the previous log entry; branch head; something that
>    (recusively) points to all unapplied commits, if necessary.

As you pointed below, "branch head" should probably be the "stack
top". We don't need to track the "branch head" if different, just need
to fix up the error and add the patches to the stack. And, anyway, if
one modifies the HEAD using git directly, the log will still point to
the top of the stack.

The third head would only be needed for the first log entry or when we
use pick --unapplied (in the latter, it only points to the unapplied
commit). The third head shouldn't be used at all in the log, just
created when needed.

> I'd add to that:
>
>  * The stack top must be a parent too if head !=3D top.

See above, branch head would actually be the stack top.

>  * The commit message must include a version number, and the branch
>    head sha1.

OK with the version number but the branch head (or stack top) is one
of the parents already.

>  * I'm pretty sure we want the kind of "simplified" log I have in my
>    proposal. The full log in your proposal is going to look every bit
>    as ugly as the one in mine.

I agree it will look ugly but the simplified log adds an extra
overhead on any stgit action. If we don't use stg log -g, a text only
log command could show the diff. We can add it afterwards though if it
is fast enough.

--=20
Catalin
