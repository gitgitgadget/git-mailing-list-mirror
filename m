From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 09 Nov 2007 10:35:00 -0800
Message-ID: <7vd4ujtgh7.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072255420.4362@racer.site>
	<9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	<Pine.LNX.4.64.0711072309380.4362@racer.site>
	<9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
	<Pine.LNX.4.64.0711080003080.4362@racer.site>
	<9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
	<alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
	<9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
	<alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
	<20071109182248.GD28800@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:35:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYhZ-0000qO-E9
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbXKISfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbXKISfM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:35:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52662 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbXKISfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:35:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DFA5D2F9;
	Fri,  9 Nov 2007 13:35:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 48ACF92FDD;
	Fri,  9 Nov 2007 13:35:24 -0500 (EST)
In-Reply-To: <20071109182248.GD28800@xp.machine.xx> (Peter Baumann's message
	of "Fri, 9 Nov 2007 19:22:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64243>

Peter Baumann <waste.manager@gmx.de> writes:

> Hm. I tried to run your 'git log' and 'git log .' example and a diff
> revealed that the output of those two isn't the same, contrary to what I
> thought.
>
> In the 'git-log .' case, there should be done a history simplification,
> but then only commits which don't change anything are pruned and AFAIR
> 'git commit' doesn't allow this. Using core git, one could create commits
> with the same tree as their parent, but I don't think that all the commits
> which get removed in the '.' case where produced that way. There has to be
> another case I can't figure out.

The answer is "merges".

If a merge does not change the tree from one of the ancestors,
the side branches are pruned out, to give you _one_ explanation
of how you got there.  And by pruning such side branches, you
get the simpler explanation.

Linus gave the example of "log origin/pu ."; there is at least
one merge I am aware of that did not change any path (it is the
one that merges "jc/maint-format-patch-encoding" topic).  With
the path limiter, the merge commit and the two commits that
leads to it on the side branch are hidden away.
