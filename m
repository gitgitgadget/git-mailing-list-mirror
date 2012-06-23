From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Sat, 23 Jun 2012 08:20:17 +0100
Message-ID: <20120623072017.GI25478@arachsys.com>
References: <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
 <7vobobm3mi.fsf@alter.siamese.dyndns.org>
 <20120622220231.GG25478@arachsys.com>
 <20120622222633.GH25478@arachsys.com>
 <7vhau3m06e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 09:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiKeY-0001Gm-Dq
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 09:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab2FWHUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 03:20:25 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:43656 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2FWHUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 03:20:24 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SiKdp-0001BQ-JH; Sat, 23 Jun 2012 08:20:22 +0100
Content-Disposition: inline
In-Reply-To: <7vhau3m06e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200494>

Junio C Hamano <gitster@pobox.com> writes:

> If you are doing "rebase -i --root", what does it _mean_ to reorder
> commits and move the root commit to somewhere else, or insert
> something else that is _not_ the root to the beginning of the
> sequence?
> 
> It does not make _any_ sense to me.  For one thing, the root commit
> is to replay "addition of all these paths" to void (if you were doing
> "rebase -i --root --onto $there", then $there may not be a void, but
> it needs not to have overlapping paths for the result to make any
> sense), and moving it to somewhere _other than_ the root location
> does not make much sense.  For another, a non-root commit is mostly
> replay "these changes to these existing paths", and replaying such a
> change to a void does not make any sense either.

As you say, it depends on the commits you're re-ordering, but in my case the
first few commits were entirely additions, and I wanted to add these files
in a different order, and add different batches at once, with more sensible
commit messages to explain to the reader what was going on. The addition of
COPYING from quite a long way forward needed to move right back into the
first commit too.

> So in that sense, perhaps
> 
> 	rebase -i --root
> 
> in a history
> 
> 	A---B---C
> 
> should behave as if you did
> 
> 	rebase -i A
> 
> got an insn sheet that looked like
> 
> 	pick B
>         pick C
> 
> and then you made it to look like
> 
> 	exec false
>         pick B
>         pick C
> 
> to get the control back when the HEAD is detached at A, in order for
> you to muck with the tree and "git commit --amend" to reword the
> message.

That would be easier to implement, certainly, but it makes --root --onto
inconsistent with --root without --onto, which does work 'in the standard
way' at present. It's also just a bit of syntactic sugar for something you
can already do with rebase -i at present, in exactly the way you describe
above.

Maybe it's the best I can sensibly do though. I'm away this weekend, but
will see what I can cook up one way or the other next week when the round
tuit supply is topped up!

Cheers,

Chris.
