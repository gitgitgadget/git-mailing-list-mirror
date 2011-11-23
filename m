From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 21:09:20 +0100
Message-ID: <20111123200920.GA21004@angband.pl>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 21:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJ8L-0004sV-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab1KWUJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:09:24 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:58222 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1KWUJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:09:23 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.72)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1RTJ8C-0005Z3-83
	for git@vger.kernel.org; Wed, 23 Nov 2011 21:09:20 +0100
Content-Disposition: inline
In-Reply-To: <20111123192329.GA21630@sigill.intra.peff.net>
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185868>

On Wed, Nov 23, 2011 at 02:23:29PM -0500, Jeff King wrote:
> On Wed, Nov 23, 2011 at 11:09:29AM -0800, Junio C Hamano wrote:
> 
> > As to the approach, I suspect that it would be far better if it made
> > workable with cd_to_toplevel at the beginning, instead of saying
> > SUBDIRECTORY_OK.
> > 
> > After all, the current directory may disappear during the course of
> > bisection, upon checking out a revision that did not have the directory
> > you started your bisection from.

No different from git-reset or git-checkout.
> 
> But from what directory would you expect:
> 
>   git bisect run make
> 
> to run from? If you use a GNU-ish layout with all of your code in
> "src/",

In a vast majority of cases the layout remains constant during the whole
bisection.

> then I can see it useful to do something like:
> 
>   cd src
>   git bisect run make
> 
> If we cd_to_toplevel, we can remember the prefix that we started from
> and cd to it before running the user's command, but there is no
> guarantee that it actually exists.

I guess, the best that can be done is going into as many path components as
possible.

> Maybe that commit should be considered indeterminate then?

Why?  If you're running an automated command, then it will probably fail,
yeah.  I guess most people bisect manually though, so even in repositories
that do have this problem, there's someone who can test the given commit
anyway.

> I dunno. I haven't thought that hard about it. But I don't think it's
> quite as simple as just telling bisect it's OK to run from a subdir.

At the very least, generally working with a caveat in corner cases seems to
be better than outright failing.

If you're paranoid, there's an option of having a config setting "yes, I've
read the manual why automated bisection can fail".

-- 
1KB		// Yo momma uses IPv4!
