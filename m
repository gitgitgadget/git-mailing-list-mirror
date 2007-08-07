From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line
	when contents are unchanged
Date: Tue, 7 Aug 2007 09:34:58 -0400
Message-ID: <20070807133458.GA19834@fieldses.org>
References: <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708031121000.14781@racer.site> <7vir7wmk84.fsf@assigned-by-dhcp.cox.net> <86bqdkbq59.fsf@lola.quinscape.zz> <vpqr6mgwhsf.fsf@bauges.imag.fr> <7vodhkbdx2.fsf@assigned-by-dhcp.cox.net> <86k5s7am7c.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIPDE-0001f9-KH
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762843AbXHGNfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 09:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762747AbXHGNfA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:35:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56546 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762161AbXHGNfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 09:35:00 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IIPD8-0005Tv-KG; Tue, 07 Aug 2007 09:34:58 -0400
Content-Disposition: inline
In-Reply-To: <86k5s7am7c.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55255>

On Tue, Aug 07, 2007 at 08:32:55AM +0200, David Kastrup wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> >
> >> Unfortunately, the patch solves the "large and irrelevant output"
> >> of git-diff, but not the performance problem (see the rest of the
> >> thread, I failed to convince Junio that updating the index was a
> >> performance improvement while keeping the same user semantics).
> >
> > That's what update-index --refresh (or status if you insist) are
> > for, and the coalmine canary you are so dead set to kill are helping
> > you realize the need for running.
> 
> That does not convince me.  Cache staleness should be a problem of
> git, not of the user.  In particular if the user is just using
> porcelain.  If letting the cache get stale impacts performance, then
> git should clean up its act on its own without barfing when using
> unrelated commands.  If it notices this during diff (presumably by
> overstepping some staleness ratio), then it can set a "regenerate on
> next opportunity" flag on the index, and then the next command wanting
> to process the index from the start can rewrite a refreshed version.

The last time I had a serious problem with "cache staleness", it was
with Beagle, which modifies the files it indexes (by writing some
extended attributes).  I figured out what was happening when I noticed
that the list of touched files was growing each time I did a diff
(implying the something was working on them right then), so I ran top,
noticed beagled, eventually thought to query the extended attributes,
and finally turned off beagled's indexing to solve the problem.

So, in this case:

	- If git had fixed up the problem silently, I probably would
	  have just assumed git was slow and not found the problem.

	- Seeing the actual list of files for which the index was dirty
	  helped me identify the problem.  I probably would have
	  eventually figured it out even if all I'd had was a single
	  "index is stale" message, but I suspect it would have taken
	  longer.

Draw whatever moral you'd like....

--b.
