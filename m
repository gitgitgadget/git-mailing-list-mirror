From: David Mansfield <centos@dm.cobite.com>
Subject: Re: [RFC] Make dot-counting ignore ".1" at the end
Date: Fri, 24 Mar 2006 09:40:48 -0500
Message-ID: <442404F0.80609@dm.cobite.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org> <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 15:41:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMnTC-0007Kx-BF
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 15:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWCXOkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWCXOkv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 09:40:51 -0500
Received: from iris.cobite.com ([208.222.83.2]:52698 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S1751501AbWCXOku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 09:40:50 -0500
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 7224998304; Fri, 24 Mar 2006 09:40:31 -0500 (EST)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02174-06; Fri, 24 Mar 2006 09:40:31 -0500 (EST)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 4239D987B8; Fri, 24 Mar 2006 09:40:31 -0500 (EST)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 7DDF998304; Fri, 24 Mar 2006 09:40:30 -0500 (EST)
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17920>

Linus Torvalds wrote:
> I'm not 100% sure this is appropriate, but in general, I think "<rev>" and 
> "<rev>.1" should be considered the same thing, no? Which implies that 
> "1.1" and "1.1.1.1" are all the same thing, and collapse to just "1", ie a 
> zero dot-count. They are all the same version, after all, no?


Hmmm.  I'm not sure about this. Given x.y.z.q... the 'odd' nodes 
(starting from x = position 1) represent branches, not revisions, and 
don't refer to actual concrete objects (just tags if you will) in the 
cvs world.

So if <rev> is something like x.y then x.y.z would refer to the 'z' branch.

Furthermore, 'z' better be an even value 2 4 6 etc. because those are 
the only branch id's cvs will create.  The odd values are for 'imported 
source' branches.

The reason 1.1.1.1 exists is some lame-ass crap that CVS delivers to any 
developer who imports his/her initial source code.

It creates 1.1 as a placeholder, and I think in this special case it has 
the same contents.  It also creates a .1 'import branch' then puts the
imported revision onto that 'import' branch.

In a normal situation, you have rev = x.y

You branch, it 'registers' a branch x.y.z where z in {2,4,6...} (and 
uses a special 'magic branch' syntax x.y.0.z in the symbolic tags 
section).

Only when you commit your first change does it create x.y.z.1.

So we have:

x.y != x.y.z.1 for sure, in the general case.

Also x.y.z will never be x.y.1 for a user created branch because z must 
be even number (except for import branches), in any case x.y.z is never 
an actual file revision.  Now, it COULD be the fact there there needs to 
be special handling for x.y.z where z == 1 because that is an import 
branch and something devilish is happening there.

I honestly don't know...

David
