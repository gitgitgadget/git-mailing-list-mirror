From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 11:41:12 +0100
Organization: eudaptics software gmbh
Message-ID: <45B9DAC8.C04C6D3F@eudaptics.com>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
		<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
		<45B9B80E.E2534F97@eudaptics.com>
		<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
		<45B9C836.728F31EC@eudaptics.com>
		<7vzm86yw0q.fsf@assigned-by-dhcp.cox.net>
		<45B9CE56.D16DFC81@eudaptics.com> <7vmz46ytyy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 11:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOUv-0007nT-Ql
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbXAZKjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbXAZKjy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:39:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:16985 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbXAZKjy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:39:54 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 380866D9; Fri, 26 Jan 2007 11:39:53 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37836>

Junio C Hamano wrote:
> 
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > Sure, if I connect my linux repo with a graft to the historical BK tree,
> > then toss the ref that pointed to the historical tree, then git prune:
> > - then currently it won't prune the historical tree
> > - but under my proposal it would. Silly me. Why did I remove that ref?
> 
> [...]
> 
> Thankfully, the real git does not behave that way.  That is why
> fsck/prune _must_ honor grafts.  That makes the locally altered
> view consistent.  To the altered world view, what are stored in
> the object database do not change, but your view of how they are
> connected does.  And if your altered view thinks commit
> v2.6.12-rc2 has one of the commits in the bkcvs history as its
> parent, you do not want to lose that history merely because you
> lost a ref to it -- as long as the commit tagged as v2.6.12-rc2
> is reachable, its (imaginary) parent should be as well.

>From your argument I deduce that grafts are a very important thing (once
they exist in a repo). But the current implementation does not honor
this:

- the grafts file is not part of the objects database
- it is manipulated manually instead of by tools the check for errors
- it is not transferred across clones/pulls/pushes (it's even possible
to create an inconsistent clone)

The way out that I see is to make grafts much, much less important.
Namely that they are obeyed _only_ by tools that _present_ the database
contents. All manipulators must disregard grafts.

Consequently, if I install grafts, I must make sure that I don't prune
away objects that the grafted history needs (i.e. avoid the silliness
mentioned above). If I happen to make the grafted history inconsistent,
I can make it consistent again by removing the grafts file (it was a
local thingy anyway) - no harm done - just the _presentation_ was
altered.

-- Hannes
