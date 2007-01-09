From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 16:31:17 -0500
Message-ID: <20070109213117.GB25012@fieldses.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:31:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4OZ6-0004OU-4X
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbXAIVbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAIVbU
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:31:20 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40220 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932441AbXAIVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:31:20 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4OYv-00029n-Pf; Tue, 09 Jan 2007 16:31:17 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virffkick.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36404>

On Tue, Jan 09, 2007 at 01:20:27PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > For example, with what's in next now, I can do this:
> >
> >   git checkout v1.4.0
> >   hack hack hack
> >   git commit -m -a 'some changes which will never be seen again'
> >   git checkout v1.2.0
> >
> > I thought the _point_ of the safety valve was not to lose those changes.
> 
> Fair enough.
> 
> We could always do the check upon "git checkout" from a detached
> HEAD state, whether it takes you back on some existing branch or
> leaves your HEAD still detached.

Stupid question: why can't checkout do something like this?

	if we're currently not on a branch, fail if .git/PREV
		doesn't point to the same commit as .git/HEAD.

	if we're checking out a non-branch, store its SHA1 into
		.git/PREV.

So the user gets a warning (overrideable with some kind of --force
option) if they do a checkout when the HEAD isn't exactly what they last
checked out.  Then

	git checkout master
	git checkout v1.4.0
	git checkout v1.2.0
	git checkout master

all works without complaints, but the example above gives a warning at
the "git checkout v1.2.0" point.

--b.
