From: Charles Bailey <charles@hashpling.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 18:16:31 +0000
Message-ID: <20080223181631.GA9405@hashpling.org>
References: <7vfxvk4f07.fsf@gitster.siamese.dyndns.org> <20080223020913.GL27894@ZenIV.linux.org.uk> <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com> <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com> <20080223113952.GA4936@hashpling.org> <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com> <20080223131749.GA5811@hashpling.org> <998d0e4a0802230536w74e93ec3s40c77d52b183a419@mail.gmail.com> <20080223140153.GB5811@hashpling.org> <998d0e4a0802230910o1cd087f1y6b2398cfde4cfe08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSyw1-0005IC-91
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbYBWSQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 13:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYBWSQk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:16:40 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:41914 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbYBWSQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 13:16:39 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JSyvQ-0005JR-3G; Sat, 23 Feb 2008 18:16:40 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1NIGWYI010148;
	Sat, 23 Feb 2008 18:16:32 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1NIGVrM010147;
	Sat, 23 Feb 2008 18:16:31 GMT
Content-Disposition: inline
In-Reply-To: <998d0e4a0802230910o1cd087f1y6b2398cfde4cfe08@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 4e0a6314b6de1c20ff079c304412b7c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74831>

I've cut the cc'list down to just the git mailing list as this isn't a
linux kernel issue.

On Sat, Feb 23, 2008 at 06:10:58PM +0100, J.C. Pizarro wrote:
> Don't you understand i'm saying? I will give you a practical example.
> 1. zip -r -8  foo1.zip foo1  # in foo1 there are tons of information
> as from git repo
> 2. mv foo1 foo2 ; cp bar.txt foo2/
> 3. zip -r -9 foo2.zip foo2   # still little bit more optimized (=
> higher repacked)
> 4. Apply binary delta between foo1.zip & foo2.zip with a supposed program
>      deltaier and you get delta_foo1_foo2.bin. The size(delta_foo1_foo2.bin) is
>      not nearly ~( size(foo2.zip) - size(foo1.zip) )
> 5. Apply hexadecimal diff and you will understand why it gives the exemplar
>      ~52 MiB instead of ~2 MiB that i said it.
> 6. You will know some identical parts in both foo1.zip and foo2.zip.
>      Identical parts are good for smaller binary deltas. It's possible to get
>      still smaller binary deltas when their identical parts are in
> random offsets
>      or random locations depending of how deltaier program is advanced.
> 7. Same above but instead of both files, apply binary delta of both directories.

I totally understand what you are saying here with your zip example.
In fact this supports my original interpretation of what you were
saying. There size of the difference between the 775 MiB repository
and the 777 MiB repository is 52 MiB, not because there is 52 MiB of
new data in the latter repoistory but because of the difficulty in
generating a minimal binary delta between the two.

This is why I suggest that an incremental pack file will probably make
a better method of supplying a 'diff' between the two.

> Databases of immutable objects <--- You're wrong because you confuse.
> There are mutable objects as the better deltas of min. spanning tree.
> 
> The missing objects are not only the missing sources that you're thinking,
> they can be any thing (blob, tree, commit, tag, etc.). The deltas of the
> minimum spanning tree too are objects of the database that can be erased
> or added when the spanning tree is alterated (because the alterated spanning
> tree is smaller than previous) for better repack. Best repack is still
> NP-problem
> and to solve this bigger NP-problem of each day is 24/365 (eternal computing).
> 
> The git database is the top-level ".git/" directory but it has repacked binary
> information and has always some size measured normally in MiBs that i was
> saying above.

You're confusing two things together here. Conceptually, the git
database is a database of immutable objects. How it is stored is a
lower level implementation detail (albeit a very important one in
practice). The delta chains in the pack files are nothing to do with
git objects.

> >                                                                        If the two
> >  databases are actually a database and the same database at short time
> >  interval later, then almost all the objects are going to be common and
> >  the difference will be a small set of objects. Using git:// this set
> >  of objects can be efficiently transfered as a pack file.
> 
> You're saying    repacked(A) + new objects   with the bandwith cost of
> new objects
> but i'm saying  rerepacked(A+new objects)   with the bandwith cost of
> binary delta
>                                    where delta is repacked(A) -
> rerepacked(A+new objects)
>                                          and rerepacked(X) is more
> time repacking again X.

You seem to be comparing something that I've said with something that
you said. Originally I thought that you were making a bandwidth
argument, now you seem to be making a repacking time argument. Is X
supposed to represent to second cloned repository?

If you git clone with --reference or git fetch from a non-dumb source
repository then the remote end will generate a packfile of just the
objects that you need to update the local repository. If the remote
side is fully packed then A can reuse the delta information it already
has to generate this pack efficiently. On the local side, there is no
need to unpack these objects at all. The pack can just be placed in
the repository and used as as.

> >                                                                                     You may have
> >  a corner case scenario where the following isn't true, but in my
> >  experience an incremental pack file will be a more compact
> >  representation of this difference than a binary difference of two
> >  aggressively repacked git repositories as generated by a generic
> >  binary difference engine.
> 
> Yes, it's more simple and compact, but the eternal repacking 24/365 can do it
>  e.g. 30% smaller after few weeks when the incremental pack has made nothing.

What do you mean by 'the eternal repacking 24/365'? What is it trying
to achieve?

> It's good idea that the weekly user picks the binary delta and the
> daily developer
>  picks the incremental pack. Put both modes working in the git server.

What is the weekly user? Why would the 'binary delta' be better than
an incremental pack in this case?
