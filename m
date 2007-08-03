From: Johan Herland <johan@herland.net>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Fri, 03 Aug 2007 10:20:43 +0200
Message-ID: <200708031020.43492.johan@herland.net>
References: <200708010216.59750.jnareb@gmail.com>
 <86tzrikz5x.fsf@lola.quinscape.zz> <7v3az1samx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 10:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsP7-0004OY-8Y
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbXHCIU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 04:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbXHCIU4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:20:56 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36646 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbXHCIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:20:54 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JM600507V6P4K00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 03 Aug 2007 10:20:49 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JM600295V6K0060@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 03 Aug 2007 10:20:44 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JM6003OSV6JX040@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 03 Aug 2007 10:20:44 +0200 (CEST)
In-reply-to: <7v3az1samx.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54688>

On Friday 03 August 2007, Junio C Hamano wrote:
> David Kastrup <dak@gnu.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>  * With -l, as long as the source repository is healthy, it is
> >>    very likely that the recipient would be, too.  Also it is
> >>    very cheap.  You do not get any back-up benefit.
> >
> > Oh, but one does: an overzealous prune or rm -oopswrongoption in one
> > repo does not hurt the other.
> 
> That's not "back-up" benefit I was thinking about.  It is more
> about protecting your data from hardware failure.

If one is serious about backing up ones repo to protect it from hardware 
failure, there is not much use at all in cloning (by copy, hardlink, or 
otherwise) to a different location on the _same_ filesystem. In order for a 
backup to be at least marginally useful, it should be on a different disk 
drive (which you hint at below), or even better; on a different 
continent...

My point is as follows: One has to clone a repo onto (at least) a different 
filesystem if one is serious about backup. But if one is cloning to a 
different filesystem, hardlinking is no longer an option; git _has_ to make 
a copy of some sort. Therefore we might as well hardlink as long as we're 
on a single filesystem (since the extra copy would not be worth much, 
backup-wise).

> You physically have bits in two places, preferrably on separate disk
> drives.
> And that is what you do not get from hardlinked clone.

If the two copies are on separate disk drives (i.e. separate filesystems), 
you cannot make a hardlink in the first place. If the two copies are on the 
same filesystem, they're not much more worth than a single copy 
(backup-wise).

Given the clone-to-same-filesystem(-with-hardlink-capability) scenario 
(which is the only scenario where we have the option of using hardlinks), 
we have the following pros and cons when using hardlinks instead of 
copying:

Pros:
- Hardlink is _much_ faster (for big repos, we're talking orders of 
magnitude faster)

Cons:
- Hardlink will not leave two copies on the disk. But I'm arguing that the 
additional copy will have pretty much _no_ value from a redundancy POV, 
since the copy is still left on the _same_ filesystem. Some would even go 
as far as to say that the second copy provides a false sense of security as 
long as it is located on the same filesystem.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
