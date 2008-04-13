From: david@lang.hm
Subject: Re: Reporting bugs and bisection
Date: Sun, 13 Apr 2008 16:51:34 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0804131546370.9318@asgard>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org> <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Stephen Clark <sclark46@earthlink.net>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 01:57:03 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlC4E-0002Ol-3l
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 01:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbYDMX4S (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Sun, 13 Apr 2008 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757309AbYDMX4S
	(ORCPT <rfc822;netdev-outgoing>); Sun, 13 Apr 2008 19:56:18 -0400
Received: from mail.lang.hm ([64.81.33.126]:55919 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbYDMX4Q (ORCPT <rfc822;netdev@vger.kernel.org>);
	Sun, 13 Apr 2008 19:56:16 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m3DNk4xT005974;
	Sun, 13 Apr 2008 16:46:04 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <48028830.6020703@earthlink.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79428>

cross-posted to git for the suggestion at the bottom

On Sun, 13 Apr 2008, Stephen Clark wrote:

> Evgeniy Polyakov wrote:
>> On Sun, Apr 13, 2008 at 10:33:49PM +0200, Rafael J. Wysocki (rjw@sisk.pl) 
>> wrote:
>>> Things like this are very disappointing and have a very negative impact on 
>>> bug
>>> reporters.  We should do our best to avoid them.
>> 
>> Shit happens. This is a matter of either bug report or those who were in
>> the copy list. There are different people and different situations, in
>> which they do not reply.
>> 
> Well less shit would happen if developers would take the time to at least 
> test their patches before they were submitted. It like we will just have the 
> poor user do our testing for us. What kind of testing do developers do. I 
> been a linux user and have followed the LKML for a number of years and have 
> yet to see
> any test plans for any submitted patches.

I've been reading LKML for 11 years now, I've tested kernels and reported 
a few bugs along the way.

the expectation is that the submitter should have tested the patches 
before submitting them (where hardware allows). but that "where hardware 
allows" is a big problem. so many issues are dependant on hardwre that 
it's not possible to test everything.

there are people who download, compile and test the tree nightly (with 
farms of machines to test different configs), but they can't catch 
everything.

expecting the patches to be tested to the point where there are no bugs is 
unreasonable.

bisecting is a very powerful tool, but I do think that sometimes 
developers lean on it a bit much. taking the attitude (as some have) that 
'if the reporter can't be bothered to do a bisection I can't be bothered 
to deal with the bug' is going way too far.

if a bug can be reproduced reliably on a test system then bisecting it may 
reveal the patch that introduced or unmasked the bug (assuming that there 
aren't other problems along the way), but if the bug takes a long time to 
show up after a boot, or only happens under production loads, bisecting it 
may not be possible. that doesn't mean that the bug isn't real, it just 
means that the user is going to have to stick with an old version until 
there is a solution or work-around.

even in the hard-to-test situations, the reporter is usually able to test 
a few fixes, but there's a big difference between going to management and 
saying "the kernel guru's think that this will help, can we test it this 
weekend" 2-3 times and doing a bisection that will take 10-15 cycles to 
find the problem.

it's very reasonable to ask the reporter if they can bisect the problem, 
but if they say that they can't, declaring that they are out of luck is 
not reasonable, it just means that it's going to take more thinking to 
find the problem instead of being able to let the mechanical bisect 
process narrow things down for you. it may mean that the developer will 
need to make a patch to instrament an old (working) kernel that has 
minimal impact on that kernel so that the reporter can run this to gather 
information about what the load is so that the developer can try to 
simulate it on a new (non-working) kernel

in theory everyone has a test environment that lets them simulate 
everything in their production envrionment. in practice this is only true 
at the very low end (where it's easy to do) and the very high end (where 
it's so critical that it's done no matter how much it costs). Everyone 
else has a test environment that can test most things, but not everything. 
As such when they run into a problem they may not be able to do lots of 
essentially random testing.

elsewhere in this thread someone said that the pre-git way was to do a 
manual bisect where the developer would send patches backing out specific 
changes to find the problem. one big difference between tat and bisecting 
the problem is that the manual process was focused on the changes in the 
area that is suspected of causing the problem, while the git bisect 
process goes after all changes. this makes it much more likely that the 
tester will run into unrelated problems along the way.

I wonder if it would be possible to make a variation of git bisect that 
only looked at a subset of the tree when picking bisect points (if you are 
looking for a e1000 bug, testing bisect points that haven't changed that 
driver won't help you for example). If this can be done it would speed up 
the reporters efforts, but will require more assistance from the 
developers (who would need to tell the reporters what subtrees to test) so 
it's a tradeoff of efficiancy vs simplicity.

David Lang
