From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [Discussion] cherry-picking a merge
Date: Thu, 15 Nov 2007 03:16:49 -0500
Message-ID: <20071115081648.GK14735@spearce.org>
References: <7v3av86iqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:17:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZuT-00011C-8L
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbXKOIQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXKOIQx
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:16:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33582 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXKOIQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:16:52 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsZu5-0007hQ-PM; Thu, 15 Nov 2007 03:16:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0EE7920FBAE; Thu, 15 Nov 2007 03:16:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3av86iqa.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65083>

Junio C Hamano <gitster@pobox.com> wrote:
> You can replay the change between A and M (in other words, the
> effect of merging B into A) on top of C to create a new commit,
> with:
> 
>         $ git cherry-pick -m 1 M
> 
> In the current implementation, the resulting commit has a single
> parent C.  This is quite similar to a squash merge of B into C.
> 
> When you think about it, as long as the topological relationship
> between A and B is very similar to that of C and B (iow,
> "merge-base A B" and "merge-base C B" are the same), the effect
> should be the same as a real merge between B and C, shouldn't it?
> 
>   ---o---o---C---A---M
>       \       \     /
>        o---o---\---B
>                 \   \
>                  `---X
> 
> I am wondering if it makes sense to record the result of
> "cherry-pick -m" as a real merge between the current HEAD and
> all the other parents of the cherry-picked merge except the one
> that is named with the <parent-number>.

Yes.

Then `rebase -i` might be able to learn how to "pick" merge commits.
And then my coworkers can stop bothering me about that.  And just
do it themselves.

I used to think of merges as something special.  I now really only
look at them as being special *during* the merge process, as you
may need to generate that recursive base.  But otherwise its just
"diff M^1..M".  So why isn't it?

:-)

-- 
Shawn.
