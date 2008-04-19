From: Johan Herland <johan@herland.net>
Subject: Re: branch description
Date: Sat, 19 Apr 2008 20:09:36 +0200
Message-ID: <200804192009.36243.johan@herland.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <200804191118.50105.johan@herland.net>
 <7v1w51g2q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Matt Graham <mdg149@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:35:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnHWw-0005QG-PC
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 20:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYDSSKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 14:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbYDSSKc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 14:10:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:57988 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYDSSKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 14:10:32 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZL0061J3TJI100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:10:31 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL002Y13S22510@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:09:38 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL0068W3S2GD10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:09:38 +0200 (CEST)
In-reply-to: <7v1w51g2q5.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79915>

On Saturday 19 April 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > The problem with (3) vs. (4) is that in (3) we must make sure that whenever
> > a branch is moved/renamed (e.g. "git clone", "git branch -m", probably more
> > as well), the corresponding description is moved/renamed as well. This is
> > elegantly solved in (4).
> 
> If your "elegently solved" is coming from an assumption that it is enough
> for "git mv" (for example) to just copy whatever is in .git/refs/heads/foo
> to .git/refs/heads/bar without understanding what is contained in it, that
> assumption unfortunately does not hold.
> 
> You must support packed refs, so you need to teach the refs infrastructure
> what per-branch attributes there are other than the commit object name it
> points at anyway.
> 
> And we already do -- when you do "branch -m foo bar", corresponding config
> entries are also renamed.  We also move reflogs.
> 
> A possible approach that would work, which contains elements from (4), is
> to change implementations of loose ref to have this extra info in loose
> ref files (that is what (4) is), *and* introduce another separate
> mechanism to store corresponding information for packed refs elsewhere.
> Propagation needs to deal with both representations, renaming needs to
> deal with both representations, looking up needs to deal with both
> representations, everybody needs to deal with both representations.
> 
> If you are going to invent "another separate mechanism" to support packed
> refs anyway, why not use that same mechanism to record information for
> loose ones as well?  That is the approach suggested by (3).  In either way
> we need to teach relevant parts of the code for propagation, renaming,
> looking up etc about the new mechanism.

You're right. Also, after thinking some more about this, it occured to me
that most code paths will probably _not_ be interested in branch
descriptions at all. It therefore makes sense to keep the descriptions away
from the refs themselves, so that they don't impact performance.

So #3 (keeping descriptions in $GIT_DIR/info/refs_description) is probably
the best solution.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
