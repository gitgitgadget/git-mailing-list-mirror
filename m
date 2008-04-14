From: Willy Tarreau <w@1wt.eu>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 06:39:39 +0200
Message-ID: <20080414043939.GA6862@1wt.eu>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org> <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: david@lang.hm
X-From: netdev-owner@vger.kernel.org Mon Apr 14 06:48:56 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlGch-0003OG-Gy
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 06:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYDNEsI (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 00:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYDNEsI
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 00:48:08 -0400
Received: from 1wt.eu ([62.212.114.60]:3076 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYDNEsG (ORCPT <rfc822;netdev@vger.kernel.org>);
	Mon, 14 Apr 2008 00:48:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0804131546370.9318@asgard>
User-Agent: Mutt/1.5.11
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79456>

On Sun, Apr 13, 2008 at 04:51:34PM -0700, david@lang.hm wrote:
> cross-posted to git for the suggestion at the bottom
> 
> On Sun, 13 Apr 2008, Stephen Clark wrote:
> 
> >Evgeniy Polyakov wrote:
> >>On Sun, Apr 13, 2008 at 10:33:49PM +0200, Rafael J. Wysocki (rjw@sisk.pl) 
> >>wrote:
> >>>Things like this are very disappointing and have a very negative impact 
> >>>on bug
> >>>reporters.  We should do our best to avoid them.
> >>
> >>Shit happens. This is a matter of either bug report or those who were in
> >>the copy list. There are different people and different situations, in
> >>which they do not reply.
> >>
> >Well less shit would happen if developers would take the time to at least 
> >test their patches before they were submitted. It like we will just have 
> >the poor user do our testing for us. What kind of testing do developers 
> >do. I been a linux user and have followed the LKML for a number of years 
> >and have yet to see
> >any test plans for any submitted patches.
> 
> I've been reading LKML for 11 years now, I've tested kernels and reported 
> a few bugs along the way.
> 
> the expectation is that the submitter should have tested the patches 
> before submitting them (where hardware allows). but that "where hardware 
> allows" is a big problem. so many issues are dependant on hardwre that 
> it's not possible to test everything.
> 
> there are people who download, compile and test the tree nightly (with 
> farms of machines to test different configs), but they can't catch 
> everything.
> 
> expecting the patches to be tested to the point where there are no bugs is 
> unreasonable.
[...]

Agreed. The difficulty is that only the developer knows how confident
he is in his code. Even the subsystem maintainer does not know, which
is the real issue since as long as the code is not identified, he does
not know whom to ping.

And I think that it might help if we could add a "Trust" rating to the
patches we submit, similarly to "Tested-By" or "Signed-off-by". We could
use 1 to 5. Basically, when the patch was completed at 3am and just builds,
it's more likely 1/5. When it has been stressed for 1 week, it would be
4/5. 5/5 would only be used in backports of known working code, for some
wide-used external patches, or for trivial patches (eg: doc/whitespace
fixes). The goal would clearly not be to just trust patches with a high
rate (since they might break when associated with others), but for the
subsystem maintainer to quickly check if there are some of them the
author does not 100% trust, in which case he could ping the author to
check if his patch *may* cause the reported problem.

What makes this rating system delicate is that the rate cannot be changed
afterwards. But after all, that's not much of a problem. A bug may very
well reveal itself one year after the code was merged, so it's really the
developer's estimation which matters.

For this to be efficiently used, we would need git-commit to accept a
new "-T <rating>" argument with the following possible values :

   0: untested (default)
   1: builds
   2: seems to be working
   3: passed basic non-regression tests
   4: survived stress testing at the developer's
   5: known to be working for a long time somewhere else

I'm sure many people would find this useless (or in fact reject the
idea because it would show that most code will be rated 1 or 2),
but I really think it can help subsystem maintainers make the relation
between a reported bug and a possible submitter.

Willy

