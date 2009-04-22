From: Jeff King <peff@peff.net>
Subject: Re: How to merge from newer branch to older branches?
Date: Wed, 22 Apr 2009 17:17:10 -0400
Message-ID: <20090422211710.GA16096@coredump.intra.peff.net>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com> <20090421193615.GB7832@coredump.intra.peff.net> <7vmya946fg.fsf@gitster.siamese.dyndns.org> <2729632a0904221044q20e6cabau7dd06b3020a8ce49@mail.gmail.com> <20090422201541.GC14146@coredump.intra.peff.net> <2729632a0904221401u43af69a5ncec0f3f274ad648f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 22 23:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjqD-0007IQ-BK
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbZDVVRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZDVVRP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:17:15 -0400
Received: from peff.net ([208.65.91.99]:44894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbZDVVRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:17:14 -0400
Received: (qmail 18642 invoked by uid 107); 22 Apr 2009 21:17:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 17:17:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 17:17:10 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0904221401u43af69a5ncec0f3f274ad648f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117265>

On Wed, Apr 22, 2009 at 02:01:01PM -0700, skillzero@gmail.com wrote:

> I'm not sure I understand. When I did the original rebase of "feature"
> onto the merge-base of all the branches I wanted to merge to (v1.1 and
> v1.2 in this case), the end result was that "feature" is now based on

Err, sorry, I was confusing your "future" branch and your "feature"
branch. Wherever I said "feature", I meant "future", and "topic" I meant
"feature". Yikes.

So you would make bug-fixes on "feature", and then just re-merge it to
1.1, 1.2, and future.

> the merge-base. When I merged "feature" into 1.1, I had to fix some
> conflicts so in the log I see my conflict fix commit then a merge
> commit, but "feature" wasn't changed (only v1.1 was).

Right. So now the merge-base between feature and 1.1 is the new merge
commit. And when you re-merge them, you will only look at things that
happened on the feature branch since that merge-base.

> I was thinking that if I find a bug in my original "feature" branch, I
> would commit the fix to the "feature" branch then merge that into
> v1.1, v1.2, master, etc. But I was thinking that when I tried to merge
> "feature" into v1.1 (which previously needed a commit to fix
> conflicts), I'd need to re-fix those same conflicts.

Nope, because the merge commit already records the state of the tree
once those conflicts are fixed. Now it's possible that the _bugfix_ may
have its own conflicts. But you shouldn't see the same conflicts again.

> When I look at the log for v1.1 though, maybe I just misunderstood the
> way the conflicts are resolved in git? I was thinking the conflicting
> merge would end up as one big commit that's a combination of the
> "feature"'s commits and my conflict fixes.

Sort of.  It is a new commit with two parents: the previous tip of v1.1,
and the tip of "feature". But its tree contains the state with all of
v1.1, all of feature's commits, and your fixes.

-Peff
