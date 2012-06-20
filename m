From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 20:35:14 +0100
Message-ID: <20120620193513.GA3192@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:35:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQgW-0006bH-GF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab2FTTfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:35:21 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:59102 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab2FTTfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:35:20 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1ShQgR-0005Ti-31; Wed, 20 Jun 2012 20:35:19 +0100
Content-Disposition: inline
In-Reply-To: <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200341>

Junio C Hamano <gitster@pobox.com> writes:

> What if we do not say --onto here?  I am not asking what the current
> implementation does (we get an error message saying "I want 'onto'
> specified").  What _should_ this command mean to a na??ve user?
> 
>     $ git rebase [-i] --root
> 
> I think it should mean "replay all my history down to root".  The
> original root commit should become the new root commit in the
> rewritten history.

Yes, I definitely agree with everything you say here. That's exactly what
I'd expect from git rebase --root without --onto, and what I'd hope to be
able to implement in a patch series.

> For the root commit in the history, you check it out on the detached
> HEAD.  Under "--interactive" if the insn sheet tells you to allow
> the user to "edit/amend/reword" it, give control back the user after
> you have detached HEAD at that commit.  The user experience should
> be identical to the case you are replaying on an existing commit
> after that point.

I think it might a little more complicated than detecting when we have to do
a commit --amend on the root commit though? The user might have reordered
the first commit (introducing A and B, say) with the second commit
(introducing C and D), or dropped the original root commit entirely.

My understanding of the way --interactive works at the moment is that it
checks out the starting commit (whether given explicitly by --onto or taken
from <upstream>) and then 'plays out' the commits as described in the
instruction sheet.

I could re-use this unchanged if I could do a git checkout --orphan without
having to create a new branch, but I don't think this is allowed: I can have
a detached head or make an orphan checkout onto a new branch, but not both
at the same time? Would you prefer that I create a temporary branch just to
be able to git checkout --orphan onto it here, or that I add support for
this kind of 'detached HEAD with no parent' state, or is there a natural way
to rework --interactive without needing to do this which I'm missing?

Best wishes,

Chris.
