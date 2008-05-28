From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Wed, 28 May 2008 19:45:54 -0400
Message-ID: <20080528234554.GO30245@spearce.org>
References: <200805281608.02000.robin.rosenberg.lists@dewire.com> <7v63sywhkr.fsf@gitster.siamese.dyndns.org> <200805290133.48490.robin.rosenberg.lists@dewire.com> <7vlk1urob4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VM3-0005d4-Ft
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYE1XqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYE1XqA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:46:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43099 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbYE1Xp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:45:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K1VL0-0002YF-0H; Wed, 28 May 2008 19:45:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7974E20FBAE; Wed, 28 May 2008 19:45:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vlk1urob4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83150>

Junio C Hamano <gitster@pobox.com> wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > onsdagen den 28 maj 2008 17.53.40 skrev Junio C Hamano:
> >> Does this mean that it would help reduce mistakes if "git commit --amend"
> >> noticed the presense of .dotest-merge but absense of .dotest-merge/amend
> >> and refused to operate, I have to wonder?
> >
> > Well I found myself making these mistakes. That would probably be better. 
> > Shouldn't one block commit without amend too then?
> 
> If you mean to forbid "git commit" during rebase (perhaps interrupted by
> s/pick/edit/), I do not think that would fly -- it is the advertised way
> to split a commit into two, if I am not mistaken.

Right, you don't want to block commit if we stopped for an edit.

But if we stopped because merge-recursive failed due to merge
conflicts we want the user to fix up the tree, stage the changes,
and call `git rebase --continue` to let rebase continue further.

If further means finish the commit and then immediately stop (as
we had failed while picking an edit) , rebase will stop and let
the user edit.

We don't need a special flag for rebase to pass to commit, it can
just delete the state flag that prevents commits just before it
calls commit.

-- 
Shawn.
