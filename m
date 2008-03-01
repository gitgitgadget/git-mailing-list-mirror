From: David Brown <git@davidb.org>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 12:43:52 -0800
Message-ID: <20080301204352.GA862@old.davidb.org>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <m3tzjrkie4.fsf@localhost.localdomain> <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com> <200803011641.49874.jnareb@gmail.com> <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sat Mar 01 22:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZA5-0001nU-05
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859AbYCAVVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbYCAVVu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:21:50 -0500
Received: from mail.davidb.org ([66.93.32.219]:43996 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759052AbYCAVV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 16:21:26 -0500
X-Greylist: delayed 2251 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Mar 2008 16:21:26 EST
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JVYYi-0000Ov-Jm; Sat, 01 Mar 2008 12:43:52 -0800
Mail-Followup-To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Jakub Narebski <jnareb@gmail.com>,
	eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75703>

On Sat, Mar 01, 2008 at 06:30:13PM +0100, Eyvind Bernhardsen wrote:

> Okay, as a git n00b I'm probably on completely the wrong track, but if you 
> made a git repository out of a kernel tarball (cd linux-2.6.24 && git init 
> && git add .) and then did a shallow fetch from kernel.org into that 
> repository, wouldn't the blobs you added get reused (assuming the tarball 
> you downloaded was fairly recent), thus reducing the amount of data fetch 
> has to transfer?

Git uses the commit history to determine what objects you might already
have.  For normal use cases, this works quite well, however in this
instance it doesn't help at all.  You'll ending up transferring everything,
even for objects you already have.  Git will detect that you already have
the object only after the transfer.

Think about it, though.  In order to do this generally, the client would
have to send the hash of every object it has.  Perhaps this would be a
useful thing to do when git detects that there are no common commits, but
it would only really help the case of pulling from multiple repos that
manage the same files with separate histories.

There are some cases where this happens, such as when changes go through
another revision control system, but probably not normal usage.

David
