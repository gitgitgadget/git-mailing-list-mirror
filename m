From: Dirk Koopman <djk@tobit.co.uk>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sun, 17 Jun 2007 10:10:51 +0100
Message-ID: <4674FA9B.10806@tobit.co.uk>
References: <11820198064114-git-send-email-djk@tobit.co.uk> <20070617081959.GD1828@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 11:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzqmh-0006kj-Mz
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 11:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbXFQJKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 05:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXFQJKz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 05:10:55 -0400
Received: from post.tobit.co.uk ([82.68.205.2]:45211 "EHLO post.tobit.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607AbXFQJKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 05:10:55 -0400
Received: from dmzgate.tobit.co.uk ([82.68.205.1] helo=[192.168.1.15])
	by post.tobit.co.uk with esmtp (Exim 4.60)
	(envelope-from <djk@tobit.co.uk>)
	id 1HzqmZ-0001OR-PN; Sun, 17 Jun 2007 10:10:51 +0100
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070617081959.GD1828@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50343>

Frank Lichtenheld wrote:
> Hi.
> 
> On Sat, Jun 16, 2007 at 07:50:06PM +0100, Dirk Koopman wrote:
>> Early cvs clients don't cause state->{args} to be initialised,
>> so force this to occur.
>> Some revision checking code assumes that revisions will be
>> recognisably numeric to perl, Branches are not, because they
>> have more decimal points (eg 1.2.3.4 instead of just 1.2). 

<snip>

> 
> Hmm, I don't see how you could have a problem with that since cvsserver
> doesn't support branches and never generates any revision numbers in
> that format?
> 
> There is probably much more code out there in cvsserver that does assume
> that revision is always a simple integer.
> 
> And again that comment is a but much IMHO.
> 

The specific issue that I was trying to solve is that I have (in CVS 
terms) a main line (git head: master) and an active CVS development 
branch and git head (called SR [for the sake of argument]).

I have imported both into git using cvsimport. For compatibility (and 
windows users) I need a anonymous, read only, :pserver: CVS 
implementation that can serve either head.

The version numbers in the CVS import on branch SR are standard CVS 
single level branch 1.2.3.4. Doing a 'cvs update' on this branch was 
causing all sorts of warnings about 1.2.3.4 not being numeric on that 
test. After changing the test, the warnings have gone away and it all 
still seems to work.

Having said that, I haven't worked out where cvsserver is getting those 
version numbers from in the first place, but it obviously knows that it 
is dealing with a branch sufficient to work well enough for my needs.

Of course, quite what happens when the branch merges back and people 
want to 'cvs update -A', I shall leave for the future...

Groetjes  Dirk
