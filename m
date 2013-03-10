From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Merging submodules - best merge-base
Date: Sun, 10 Mar 2013 18:09:53 +0100
Message-ID: <20130310170953.GA1248@sandbox-ub.fritz.box>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
 <20130306181156.GA4114@sandbox-ub>
 <op.wtklj7e9rbppqq@cicero.linkoping.osa>
 <20130307185906.GA9661@sandbox-ub.fritz.box>
 <513B7554.4020700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bratell <bratell@opera.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 10 18:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjlb-00060t-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 18:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab3CJRJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 13:09:56 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:43633 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab3CJRJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 13:09:55 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjkv-0006xB-Sx; Sun, 10 Mar 2013 18:09:54 +0100
Content-Disposition: inline
In-Reply-To: <513B7554.4020700@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217816>

On Sat, Mar 09, 2013 at 06:45:56PM +0100, Jens Lehmann wrote:
> Am 07.03.2013 19:59, schrieb Heiko Voigt:
> > On Thu, Mar 07, 2013 at 10:49:09AM +0100, Daniel Bratell wrote:
> >> Den 2013-03-06 19:12:05 skrev Heiko Voigt <hvoigt@hvoigt.net>:
> >>> So to summarize what you are requesting: You want a submodule merge be
> >>> two way in the view of the superproject and calculate the merge base
> >>> in the submodule from the two commits that are going to be merged?
> >>>
> >>> It currently sounds logical but I have to think about it further and
> >>> whether that might break other use cases.
> >>
> >> Maybe both could be legal even. The current code can't be all wrong,
> >> and this case also seems to be straightforward.
> > 
> > Ok I have thought about it further and I did not come up with a simple
> > (and stable) enough strategy that would allow your use case to merge
> > cleanly without user interaction.
> > 
> > The problem is that your are actually doing a rewind from base to both
> > tips. The fact that a rewind is there makes git suspicious and we simply
> > give up. IMO, thats the right thing to do in such a situation.
> > 
> > What should a merge strategy do? It infers from two changes what the
> > final intention might be. For submodules we can do that when the changes
> > on both sides point forward. Since thats the typical progress of
> > development. If not there is some reason for it we do not know about. So
> > the merge gives up.
> > 
> > Please see this post about why we need to forbid rewinds from the
> > initial design discussion:
> > 
> > http://article.gmane.org/gmane.comp.version-control.git/149003
> 
> I agree that rewinds are a very good reason not merge two branches using
> a fast-forward strategy, but I believe Daniel's use case is a (and maybe
> the only) valid exception to that rule: both branches contain *exactly*
> the same rewind. In that case I don't see any problem to just do a fast
> forward to S21, as both agree on the commits to rewind.

That is different than using the merge base of the two commits needing
merge. I agree that rewinding to exactly the same commits is probably a
valid exception. Will have a look into extending the submodule merge
strategy to include this case.

Cheers Heiko
